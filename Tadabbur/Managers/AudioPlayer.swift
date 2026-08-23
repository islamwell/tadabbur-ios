import Foundation
import AVFoundation
import Combine

// MARK: - AudioPlayer

/// Wraps AVAudioPlayer for ayah recitation playback.
/// Injected as @EnvironmentObject throughout the view tree.
final class AudioPlayer: NSObject, ObservableObject, AVAudioPlayerDelegate {

    @Published private(set) var isPlaying: Bool = false
    @Published private(set) var audioAvailable: Bool = false

    private var player: AVAudioPlayer?
    private var deactivationWorkItem: DispatchWorkItem?

    // MARK: Load

    /// Loads the audio file for the given ayah. Call before playing.
    func load(ayah: Ayah) {
        stop()
        guard let fileName = ayah.audioFileName else {
            audioAvailable = false
            return
        }

        // Strip extension for Bundle.url(forResource:withExtension:)
        let nameWithoutExt = (fileName as NSString).deletingPathExtension
        let ext = (fileName as NSString).pathExtension

        guard let url = Bundle.main.url(forResource: nameWithoutExt, withExtension: ext) else {
            audioAvailable = false
            return
        }

        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.delegate = self
            player?.prepareToPlay()
            audioAvailable = true
        } catch {
            print("[AudioPlayer] Failed to load \(fileName): \(error.localizedDescription)")
            audioAvailable = false
        }
    }

    // MARK: Playback

    func play() {
        guard let player = player, audioAvailable else { return }

        cancelDeactivation()
        activateSession()
        player.play()
        isPlaying = true
    }

    func pause() {
        player?.pause()
        isPlaying = false
        scheduleSessionDeactivation()
    }

    func stop() {
        player?.stop()
        player?.currentTime = 0
        isPlaying = false
        scheduleSessionDeactivation()
    }

    func togglePlayback() {
        if isPlaying {
            pause()
        } else {
            play()
        }
    }

    // MARK: AVAudioPlayerDelegate

    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        DispatchQueue.main.async { [weak self] in
            self?.isPlaying = false
            self?.scheduleSessionDeactivation()
        }
    }

    func audioPlayerDecodeErrorDidOccur(_ player: AVAudioPlayer, error: Error?) {
        DispatchQueue.main.async { [weak self] in
            self?.isPlaying = false
            self?.audioAvailable = false
        }
    }

    // MARK: AVAudioSession Lifecycle

    private func activateSession() {
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            print("[AudioPlayer] Session activation failed: \(error.localizedDescription)")
        }
    }

    private func scheduleSessionDeactivation() {
        cancelDeactivation()
        let item = DispatchWorkItem { [weak self] in
            self?.deactivateSession()
        }
        deactivationWorkItem = item
        // Deactivate 1 second after playback stops to allow audio to fade
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
            print("[AudioPlayer] Session deactivation failed: \(error.localizedDescription)")
        }
    }
}
