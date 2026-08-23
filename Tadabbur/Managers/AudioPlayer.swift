import Foundation
import AVFoundation
import Combine

// MARK: - AudioPlayer

/// Robust audio player for Quranic recitation by Sheikh Nasser Al-Qatami.
/// Handles local bundled audio, asynchronous network downloading, on-disk caching,
/// and smooth AVAudioPlayer playback with progress updates.
final class AudioPlayer: NSObject, ObservableObject, AVAudioPlayerDelegate {

    // MARK: - Published State
    @Published private(set) var isPlaying: Bool = false
    @Published private(set) var isLoading: Bool = false
    @Published private(set) var audioAvailable: Bool = true
    @Published private(set) var isCachedLocally: Bool = false
    @Published private(set) var currentTime: TimeInterval = 0
    @Published private(set) var duration: TimeInterval = 0
    @Published private(set) var playbackProgress: Double = 0 // 0.0 to 1.0
    @Published private(set) var currentAyah: Ayah? = nil

    // MARK: - Private Properties
    private var player: AVAudioPlayer?
    private var progressTimer: Timer?
    private var currentDownloadTask: URLSessionDownloadTask?
    private var deactivationWorkItem: DispatchWorkItem?
    private let cacheDirectory: URL

    // MARK: - Init
    override init() {
        let cachesDir = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)[0]
        self.cacheDirectory = cachesDir.appendingPathComponent("AyahAudioCache", isDirectory: true)

        super.init()

        // Create cache folder if needed
        if !FileManager.default.fileExists(atPath: cacheDirectory.path) {
            try? FileManager.default.createDirectory(at: cacheDirectory, withIntermediateDirectories: true)
        }
    }

    deinit {
        stopProgressTimer()
        player?.stop()
    }

    // MARK: - Cache Helpers

    private func localCachedURL(for ayah: Ayah) -> URL {
        cacheDirectory.appendingPathComponent(ayah.audioCacheKey)
    }

    private func isAyahCached(ayah: Ayah) -> Bool {
        // Check bundled file first
        if let fileName = ayah.audioFileName {
            let nameWithoutExt = (fileName as NSString).deletingPathExtension
            let ext = (fileName as NSString).pathExtension
            if Bundle.main.url(forResource: nameWithoutExt, withExtension: ext) != nil {
                return true
            }
        }
        // Check local disk cache
        return FileManager.default.fileExists(atPath: localCachedURL(for: ayah).path)
    }

    // MARK: - Load & Pre-cache

    /// Loads the audio file for the specified Ayah.
    /// If cached locally, loads into AVAudioPlayer immediately.
    /// If not cached, marks as available and ready to stream on demand.
    func load(ayah: Ayah, autoPlay: Bool = false) {
        stop()
        self.currentAyah = ayah
        self.audioAvailable = true

        let localURL = localCachedURL(for: ayah)

        // 1. Check if bundled in app assets
        if let fileName = ayah.audioFileName {
            let nameWithoutExt = (fileName as NSString).deletingPathExtension
            let ext = (fileName as NSString).pathExtension
            if let bundleURL = Bundle.main.url(forResource: nameWithoutExt, withExtension: ext) {
                setupPlayer(with: bundleURL, autoPlay: autoPlay)
                self.isCachedLocally = true
                return
            }
        }

        // 2. Check if cached on disk
        if FileManager.default.fileExists(atPath: localURL.path) {
            setupPlayer(with: localURL, autoPlay: autoPlay)
            self.isCachedLocally = true
            return
        }

        // 3. Not cached yet: pre-download or prepare
        self.isCachedLocally = false
        if autoPlay {
            downloadAndPlay(ayah: ayah)
        } else {
            // Silently pre-cache in the background so tap-to-play is instant
            prefetch(ayah: ayah)
        }
    }

    /// Prefetches and caches audio in the background without auto-playing.
    func prefetch(ayah: Ayah) {
        let localURL = localCachedURL(for: ayah)
        guard !FileManager.default.fileExists(atPath: localURL.path),
              let remoteURL = ayah.audioURL else { return }

        let task = URLSession.shared.downloadTask(with: remoteURL) { [weak self] tempURL, _, error in
            guard let self = self, let tempURL = tempURL, error == nil else { return }
            do {
                if !FileManager.default.fileExists(atPath: self.cacheDirectory.path) {
                    try FileManager.default.createDirectory(at: self.cacheDirectory, withIntermediateDirectories: true)
                }
                if FileManager.default.fileExists(atPath: localURL.path) {
                    try? FileManager.default.removeItem(at: localURL)
                }
                try FileManager.default.moveItem(at: tempURL, to: localURL)
                DispatchQueue.main.async {
                    if self.currentAyah?.id == ayah.id {
                        self.isCachedLocally = true
                        if self.player == nil {
                            self.setupPlayer(with: localURL, autoPlay: false)
                        }
                    }
                }
            } catch {
                print("[AudioPlayer] Prefetch caching error: \(error.localizedDescription)")
            }
        }
        task.resume()
    }

    // MARK: - Download & Play

    private func downloadAndPlay(ayah: Ayah) {
        guard let remoteURL = ayah.audioURL else { return }

        isLoading = true
        currentDownloadTask?.cancel()

        let localURL = localCachedURL(for: ayah)

        currentDownloadTask = URLSession.shared.downloadTask(with: remoteURL) { [weak self] tempURL, response, error in
            guard let self = self else { return }

            DispatchQueue.main.async {
                self.isLoading = false
            }

            if let error = error {
                print("[AudioPlayer] Download failed: \(error.localizedDescription)")
                return
            }

            guard let tempURL = tempURL else { return }

            do {
                if !FileManager.default.fileExists(atPath: self.cacheDirectory.path) {
                    try FileManager.default.createDirectory(at: self.cacheDirectory, withIntermediateDirectories: true)
                }
                if FileManager.default.fileExists(atPath: localURL.path) {
                    try? FileManager.default.removeItem(at: localURL)
                }
                try FileManager.default.moveItem(at: tempURL, to: localURL)

                DispatchQueue.main.async {
                    self.isCachedLocally = true
                    if self.currentAyah?.id == ayah.id {
                        self.setupPlayer(with: localURL, autoPlay: true)
                    }
                }
            } catch {
                print("[AudioPlayer] Cache save failed: \(error.localizedDescription)")
            }
        }
        currentDownloadTask?.resume()
    }

    private func setupPlayer(with url: URL, autoPlay: Bool) {
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.delegate = self
            player?.prepareToPlay()
            duration = player?.duration ?? 0
            audioAvailable = true

            if autoPlay {
                play()
            }
        } catch {
            print("[AudioPlayer] Failed to initialize AVAudioPlayer: \(error.localizedDescription)")
            audioAvailable = false
        }
    }

    // MARK: - Playback Controls

    func play() {
        guard let ayah = currentAyah else { return }

        // If player already initialized
        if let player = player {
            cancelDeactivation()
            activateSession()
            player.play()
            isPlaying = true
            startProgressTimer()
            return
        }

        // If not initialized, download and play
        downloadAndPlay(ayah: ayah)
    }

    func pause() {
        player?.pause()
        isPlaying = false
        stopProgressTimer()
        scheduleSessionDeactivation()
    }

    func stop() {
        currentDownloadTask?.cancel()
        currentDownloadTask = nil
        player?.stop()
        player?.currentTime = 0
        isPlaying = false
        isLoading = false
        currentTime = 0
        playbackProgress = 0
        stopProgressTimer()
        scheduleSessionDeactivation()
    }

    func togglePlayback() {
        if isPlaying {
            pause()
        } else {
            play()
        }
    }

    // MARK: - Progress Tracking

    private func startProgressTimer() {
        stopProgressTimer()
        progressTimer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { [weak self] _ in
            guard let self = self, let player = self.player else { return }
            self.currentTime = player.currentTime
            if player.duration > 0 {
                self.playbackProgress = player.currentTime / player.duration
            }
        }
    }

    private func stopProgressTimer() {
        progressTimer?.invalidate()
        progressTimer = nil
    }

    // MARK: - AVAudioPlayerDelegate

    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        DispatchQueue.main.async { [weak self] in
            self?.isPlaying = false
            self?.currentTime = 0
            self?.playbackProgress = 0
            self?.stopProgressTimer()
            self?.scheduleSessionDeactivation()
        }
    }

    func audioPlayerDecodeErrorDidOccur(_ player: AVAudioPlayer, error: Error?) {
        DispatchQueue.main.async { [weak self] in
            self?.isPlaying = false
            self?.isLoading = false
            self?.stopProgressTimer()
        }
    }

    // MARK: - Audio Session

    private func activateSession() {
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            print("[AudioPlayer] Audio session activation error: \(error.localizedDescription)")
        }
    }

    private func scheduleSessionDeactivation() {
        cancelDeactivation()
        let item = DispatchWorkItem { [weak self] in
            self?.deactivateSession()
        }
        deactivationWorkItem = item
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: item)
    }

    private func cancelDeactivation() {
        deactivationWorkItem?.cancel()
        deactivationWorkItem = nil
    }

    private func deactivateSession() {
        do {
            try AVAudioSession.sharedInstance().setActive(false, options: .notifyOthersOnDeactivation)
        } catch {
            print("[AudioPlayer] Audio session deactivation error: \(error.localizedDescription)")
        }
    }
}
