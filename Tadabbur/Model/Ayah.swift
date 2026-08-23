import Foundation

// MARK: - Ayah Model

struct Ayah: Identifiable, Equatable {
    let id: Int                     // 1-based, matches audio filename ayah{id}.mp3
    let surahName: String           // English transliteration e.g. "Al-Baqarah"
    let surahNameArabic: String     // Arabic script e.g. "البقرة"
    let ayahNumber: Int
    let arabicText: String
    let translation: String
    let audioFileName: String?      // nil = no audio file bundled

    /// English reference: "Al-Baqarah · 152"
    var reference: String {
        "\(surahName) · \(ayahNumber)"
    }

    /// Arabic reference with Arabic-Indic digits
    var arabicReference: String {
        let arabicDigits = String(ayahNumber).map { char -> Character in
            guard let digit = char.wholeNumberValue else { return char }
            let arabicIndic: [Character] = ["٠","١","٢","٣","٤","٥","٦","٧","٨","٩"]
            return arabicIndic[digit]
        }
        return "\(surahNameArabic) · \(String(arabicDigits))"
    }
}

// MARK: - Curated Ayah Catalog (200 Impactful Verses)

extension Ayah {
    static let catalog: [Ayah] = [
        Ayah(
            id: 1,
            surahName: "Al-Fatiha",
            surahNameArabic: "الفاتحة",
            ayahNumber: 1,
            arabicText: "﻿بِسْمِ ٱللَّهِ ٱلرَّحْمَٰنِ ٱلرَّحِيمِ",
            translation: "In the name of Allah, the Entirely Merciful, the Especially Merciful.",
            audioFileName: "ayah1.mp3"
        ),
        Ayah(
            id: 2,
            surahName: "Al-Fatiha",
            surahNameArabic: "الفاتحة",
            ayahNumber: 2,
            arabicText: "ٱلْحَمْدُ لِلَّهِ رَبِّ ٱلْعَٰلَمِينَ",
            translation: "[All] praise is [due] to Allah, Lord of the worlds -",
            audioFileName: "ayah2.mp3"
        ),
        Ayah(
            id: 3,
            surahName: "Al-Fatiha",
            surahNameArabic: "الفاتحة",
            ayahNumber: 5,
            arabicText: "إِيَّاكَ نَعْبُدُ وَإِيَّاكَ نَسْتَعِينُ",
            translation: "It is You we worship and You we ask for help.",
            audioFileName: "ayah3.mp3"
        ),
        Ayah(
            id: 4,
            surahName: "Al-Fatiha",
            surahNameArabic: "الفاتحة",
            ayahNumber: 6,
            arabicText: "ٱهْدِنَا ٱلصِّرَٰطَ ٱلْمُسْتَقِيمَ",
            translation: "Guide us to the straight path -",
            audioFileName: "ayah4.mp3"
        ),
        Ayah(
            id: 5,
            surahName: "Al-Baqarah",
            surahNameArabic: "البقرة",
            ayahNumber: 2,
            arabicText: "ذَٰلِكَ ٱلْكِتَٰبُ لَا رَيْبَ ۛ فِيهِ ۛ هُدًۭى لِّلْمُتَّقِينَ",
            translation: "This is the Book about which there is no doubt, a guidance for those conscious of Allah -",
            audioFileName: "ayah5.mp3"
        ),
        Ayah(
            id: 6,
            surahName: "Al-Baqarah",
            surahNameArabic: "البقرة",
            ayahNumber: 21,
            arabicText: "يَٰٓأَيُّهَا ٱلنَّاسُ ٱعْبُدُوا۟ رَبَّكُمُ ٱلَّذِى خَلَقَكُمْ وَٱلَّذِينَ مِن قَبْلِكُمْ لَعَلَّكُمْ تَتَّقُونَ",
            translation: "O mankind, worship your Lord, who created you and those before you, that you may become righteous -",
            audioFileName: "ayah6.mp3"
        ),
        Ayah(
            id: 7,
            surahName: "Al-Baqarah",
            surahNameArabic: "البقرة",
            ayahNumber: 25,
            arabicText: "وَبَشِّرِ ٱلَّذِينَ ءَامَنُوا۟ وَعَمِلُوا۟ ٱلصَّٰلِحَٰتِ أَنَّ لَهُمْ جَنَّٰتٍۢ تَجْرِى مِن تَحْتِهَا ٱلْأَنْهَٰرُ ۖ كُلَّمَا رُزِقُوا۟ مِنْهَا مِن ثَمَرَةٍۢ رِّزْقًۭا ۙ قَالُوا۟ هَٰذَا ٱلَّذِى رُزِقْنَا مِن قَبْلُ ۖ وَأُتُوا۟ بِهِۦ مُتَشَٰبِهًۭا ۖ وَلَهُمْ فِيهَآ أَزْوَٰجٌۭ مُّطَهَّرَةٌۭ ۖ وَهُمْ فِيهَا خَٰلِدُونَ",
            translation: "And give good tidings to those who believe and do righteous deeds that they will have gardens [in Paradise] beneath which rivers flow. Whenever they are provided with a provision of fruit therefrom, they will say, \"This is what we were provided with before.\" And it is given to them in likeness. And they will have therein purified spouses, and they will abide therein eternally.",
            audioFileName: "ayah7.mp3"
        ),
        Ayah(
            id: 8,
            surahName: "Al-Baqarah",
            surahNameArabic: "البقرة",
            ayahNumber: 45,
            arabicText: "وَٱسْتَعِينُوا۟ بِٱلصَّبْرِ وَٱلصَّلَوٰةِ ۚ وَإِنَّهَا لَكَبِيرَةٌ إِلَّا عَلَى ٱلْخَٰشِعِينَ",
            translation: "And seek help through patience and prayer, and indeed, it is difficult except for the humbly submissive [to Allah]",
            audioFileName: "ayah8.mp3"
        ),
        Ayah(
            id: 9,
            surahName: "Al-Baqarah",
            surahNameArabic: "البقرة",
            ayahNumber: 83,
            arabicText: "وَإِذْ أَخَذْنَا مِيثَٰقَ بَنِىٓ إِسْرَٰٓءِيلَ لَا تَعْبُدُونَ إِلَّا ٱللَّهَ وَبِٱلْوَٰلِدَيْنِ إِحْسَانًۭا وَذِى ٱلْقُرْبَىٰ وَٱلْيَتَٰمَىٰ وَٱلْمَسَٰكِينِ وَقُولُوا۟ لِلنَّاسِ حُسْنًۭا وَأَقِيمُوا۟ ٱلصَّلَوٰةَ وَءَاتُوا۟ ٱلزَّكَوٰةَ ثُمَّ تَوَلَّيْتُمْ إِلَّا قَلِيلًۭا مِّنكُمْ وَأَنتُم مُّعْرِضُونَ",
            translation: "And [recall] when We took the covenant from the Children of Israel, [enjoining upon them], \"Do not worship except Allah; and to parents do good and to relatives, orphans, and the needy. And speak to people good [words] and establish prayer and give zakah.\" Then you turned away, except a few of you, and you were refusing.",
            audioFileName: "ayah9.mp3"
        ),
        Ayah(
            id: 10,
            surahName: "Al-Baqarah",
            surahNameArabic: "البقرة",
            ayahNumber: 112,
            arabicText: "بَلَىٰ مَنْ أَسْلَمَ وَجْهَهُۥ لِلَّهِ وَهُوَ مُحْسِنٌۭ فَلَهُۥٓ أَجْرُهُۥ عِندَ رَبِّهِۦ وَلَا خَوْفٌ عَلَيْهِمْ وَلَا هُمْ يَحْزَنُونَ",
            translation: "Yes [on the contrary], whoever submits his face in Islam to Allah while being a doer of good will have his reward with his Lord. And no fear will there be concerning them, nor will they grieve.",
            audioFileName: nil
        ),
        Ayah(
            id: 11,
            surahName: "Al-Baqarah",
            surahNameArabic: "البقرة",
            ayahNumber: 115,
            arabicText: "وَلِلَّهِ ٱلْمَشْرِقُ وَٱلْمَغْرِبُ ۚ فَأَيْنَمَا تُوَلُّوا۟ فَثَمَّ وَجْهُ ٱللَّهِ ۚ إِنَّ ٱللَّهَ وَٰسِعٌ عَلِيمٌۭ",
            translation: "And to Allah belongs the east and the west. So wherever you [might] turn, there is the Face of Allah. Indeed, Allah is all-Encompassing and Knowing.",
            audioFileName: nil
        ),
        Ayah(
            id: 12,
            surahName: "Al-Baqarah",
            surahNameArabic: "البقرة",
            ayahNumber: 117,
            arabicText: "بَدِيعُ ٱلسَّمَٰوَٰتِ وَٱلْأَرْضِ ۖ وَإِذَا قَضَىٰٓ أَمْرًۭا فَإِنَّمَا يَقُولُ لَهُۥ كُن فَيَكُونُ",
            translation: "Originator of the heavens and the earth. When He decrees a matter, He only says to it, \"Be,\" and it is.",
            audioFileName: nil
        ),
        Ayah(
            id: 13,
            surahName: "Al-Baqarah",
            surahNameArabic: "البقرة",
            ayahNumber: 152,
            arabicText: "فَٱذْكُرُونِىٓ أَذْكُرْكُمْ وَٱشْكُرُوا۟ لِى وَلَا تَكْفُرُونِ",
            translation: "So remember Me; I will remember you. And be grateful to Me and do not deny Me.",
            audioFileName: nil
        ),
        Ayah(
            id: 14,
            surahName: "Al-Baqarah",
            surahNameArabic: "البقرة",
            ayahNumber: 153,
            arabicText: "يَٰٓأَيُّهَا ٱلَّذِينَ ءَامَنُوا۟ ٱسْتَعِينُوا۟ بِٱلصَّبْرِ وَٱلصَّلَوٰةِ ۚ إِنَّ ٱللَّهَ مَعَ ٱلصَّٰبِرِينَ",
            translation: "O you who have believed, seek help through patience and prayer. Indeed, Allah is with the patient.",
            audioFileName: nil
        ),
        Ayah(
            id: 15,
            surahName: "Al-Baqarah",
            surahNameArabic: "البقرة",
            ayahNumber: 155,
            arabicText: "وَلَنَبْلُوَنَّكُم بِشَىْءٍۢ مِّنَ ٱلْخَوْفِ وَٱلْجُوعِ وَنَقْصٍۢ مِّنَ ٱلْأَمْوَٰلِ وَٱلْأَنفُسِ وَٱلثَّمَرَٰتِ ۗ وَبَشِّرِ ٱلصَّٰبِرِينَ",
            translation: "And We will surely test you with something of fear and hunger and a loss of wealth and lives and fruits, but give good tidings to the patient,",
            audioFileName: nil
        ),
        Ayah(
            id: 16,
            surahName: "Al-Baqarah",
            surahNameArabic: "البقرة",
            ayahNumber: 156,
            arabicText: "ٱلَّذِينَ إِذَآ أَصَٰبَتْهُم مُّصِيبَةٌۭ قَالُوٓا۟ إِنَّا لِلَّهِ وَإِنَّآ إِلَيْهِ رَٰجِعُونَ",
            translation: "Who, when disaster strikes them, say, \"Indeed we belong to Allah, and indeed to Him we will return.\"",
            audioFileName: nil
        ),
        Ayah(
            id: 17,
            surahName: "Al-Baqarah",
            surahNameArabic: "البقرة",
            ayahNumber: 157,
            arabicText: "أُو۟لَٰٓئِكَ عَلَيْهِمْ صَلَوَٰتٌۭ مِّن رَّبِّهِمْ وَرَحْمَةٌۭ ۖ وَأُو۟لَٰٓئِكَ هُمُ ٱلْمُهْتَدُونَ",
            translation: "Those are the ones upon whom are blessings from their Lord and mercy. And it is those who are the [rightly] guided.",
            audioFileName: nil
        ),
        Ayah(
            id: 18,
            surahName: "Al-Baqarah",
            surahNameArabic: "البقرة",
            ayahNumber: 163,
            arabicText: "وَإِلَٰهُكُمْ إِلَٰهٌۭ وَٰحِدٌۭ ۖ لَّآ إِلَٰهَ إِلَّا هُوَ ٱلرَّحْمَٰنُ ٱلرَّحِيمُ",
            translation: "And your god is one God. There is no deity [worthy of worship] except Him, the Entirely Merciful, the Especially Merciful.",
            audioFileName: nil
        ),
        Ayah(
            id: 19,
            surahName: "Al-Baqarah",
            surahNameArabic: "البقرة",
            ayahNumber: 165,
            arabicText: "وَمِنَ ٱلنَّاسِ مَن يَتَّخِذُ مِن دُونِ ٱللَّهِ أَندَادًۭا يُحِبُّونَهُمْ كَحُبِّ ٱللَّهِ ۖ وَٱلَّذِينَ ءَامَنُوٓا۟ أَشَدُّ حُبًّۭا لِّلَّهِ ۗ وَلَوْ يَرَى ٱلَّذِينَ ظَلَمُوٓا۟ إِذْ يَرَوْنَ ٱلْعَذَابَ أَنَّ ٱلْقُوَّةَ لِلَّهِ جَمِيعًۭا وَأَنَّ ٱللَّهَ شَدِيدُ ٱلْعَذَابِ",
            translation: "And [yet], among the people are those who take other than Allah as equals [to Him]. They love them as they [should] love Allah. But those who believe are stronger in love for Allah. And if only they who have wronged would consider [that] when they see the punishment, [they will be certain] that all power belongs to Allah and that Allah is severe in punishment.",
            audioFileName: nil
        ),
        Ayah(
            id: 20,
            surahName: "Al-Baqarah",
            surahNameArabic: "البقرة",
            ayahNumber: 186,
            arabicText: "وَإِذَا سَأَلَكَ عِبَادِى عَنِّى فَإِنِّى قَرِيبٌ ۖ أُجِيبُ دَعْوَةَ ٱلدَّاعِ إِذَا دَعَانِ ۖ فَلْيَسْتَجِيبُوا۟ لِى وَلْيُؤْمِنُوا۟ بِى لَعَلَّهُمْ يَرْشُدُونَ",
            translation: "And when My servants ask you, [O Muhammad], concerning Me - indeed I am near. I respond to the invocation of the supplicant when he calls upon Me. So let them respond to Me [by obedience] and believe in Me that they may be [rightly] guided.",
            audioFileName: nil
        ),
        Ayah(
            id: 21,
            surahName: "Al-Baqarah",
            surahNameArabic: "البقرة",
            ayahNumber: 201,
            arabicText: "وَمِنْهُم مَّن يَقُولُ رَبَّنَآ ءَاتِنَا فِى ٱلدُّنْيَا حَسَنَةًۭ وَفِى ٱلْءَاخِرَةِ حَسَنَةًۭ وَقِنَا عَذَابَ ٱلنَّارِ",
            translation: "But among them is he who says, \"Our Lord, give us in this world [that which is] good and in the Hereafter [that which is] good and protect us from the punishment of the Fire.\"",
            audioFileName: nil
        ),
        Ayah(
            id: 22,
            surahName: "Al-Baqarah",
            surahNameArabic: "البقرة",
            ayahNumber: 207,
            arabicText: "وَمِنَ ٱلنَّاسِ مَن يَشْرِى نَفْسَهُ ٱبْتِغَآءَ مَرْضَاتِ ٱللَّهِ ۗ وَٱللَّهُ رَءُوفٌۢ بِٱلْعِبَادِ",
            translation: "And of the people is he who sells himself, seeking means to the approval of Allah. And Allah is kind to [His] servants.",
            audioFileName: nil
        ),
        Ayah(
            id: 23,
            surahName: "Al-Baqarah",
            surahNameArabic: "البقرة",
            ayahNumber: 214,
            arabicText: "أَمْ حَسِبْتُمْ أَن تَدْخُلُوا۟ ٱلْجَنَّةَ وَلَمَّا يَأْتِكُم مَّثَلُ ٱلَّذِينَ خَلَوْا۟ مِن قَبْلِكُم ۖ مَّسَّتْهُمُ ٱلْبَأْسَآءُ وَٱلضَّرَّآءُ وَزُلْزِلُوا۟ حَتَّىٰ يَقُولَ ٱلرَّسُولُ وَٱلَّذِينَ ءَامَنُوا۟ مَعَهُۥ مَتَىٰ نَصْرُ ٱللَّهِ ۗ أَلَآ إِنَّ نَصْرَ ٱللَّهِ قَرِيبٌۭ",
            translation: "Or do you think that you will enter Paradise while such [trial] has not yet come to you as came to those who passed on before you? They were touched by poverty and hardship and were shaken until [even their] messenger and those who believed with him said, \"When is the help of Allah?\" Unquestionably, the help of Allah is near.",
            audioFileName: nil
        ),
        Ayah(
            id: 24,
            surahName: "Al-Baqarah",
            surahNameArabic: "البقرة",
            ayahNumber: 216,
            arabicText: "كُتِبَ عَلَيْكُمُ ٱلْقِتَالُ وَهُوَ كُرْهٌۭ لَّكُمْ ۖ وَعَسَىٰٓ أَن تَكْرَهُوا۟ شَيْـًۭٔا وَهُوَ خَيْرٌۭ لَّكُمْ ۖ وَعَسَىٰٓ أَن تُحِبُّوا۟ شَيْـًۭٔا وَهُوَ شَرٌّۭ لَّكُمْ ۗ وَٱللَّهُ يَعْلَمُ وَأَنتُمْ لَا تَعْلَمُونَ",
            translation: "Fighting has been enjoined upon you while it is hateful to you. But perhaps you hate a thing and it is good for you; and perhaps you love a thing and it is bad for you. And Allah Knows, while you know not.",
            audioFileName: nil
        ),
        Ayah(
            id: 25,
            surahName: "Al-Baqarah",
            surahNameArabic: "البقرة",
            ayahNumber: 255,
            arabicText: "ٱللَّهُ لَآ إِلَٰهَ إِلَّا هُوَ ٱلْحَىُّ ٱلْقَيُّومُ ۚ لَا تَأْخُذُهُۥ سِنَةٌۭ وَلَا نَوْمٌۭ ۚ لَّهُۥ مَا فِى ٱلسَّمَٰوَٰتِ وَمَا فِى ٱلْأَرْضِ ۗ مَن ذَا ٱلَّذِى يَشْفَعُ عِندَهُۥٓ إِلَّا بِإِذْنِهِۦ ۚ يَعْلَمُ مَا بَيْنَ أَيْدِيهِمْ وَمَا خَلْفَهُمْ ۖ وَلَا يُحِيطُونَ بِشَىْءٍۢ مِّنْ عِلْمِهِۦٓ إِلَّا بِمَا شَآءَ ۚ وَسِعَ كُرْسِيُّهُ ٱلسَّمَٰوَٰتِ وَٱلْأَرْضَ ۖ وَلَا يَـُٔودُهُۥ حِفْظُهُمَا ۚ وَهُوَ ٱلْعَلِىُّ ٱلْعَظِيمُ",
            translation: "Allah - there is no deity except Him, the Ever-Living, the Sustainer of [all] existence. Neither drowsiness overtakes Him nor sleep. To Him belongs whatever is in the heavens and whatever is on the earth. Who is it that can intercede with Him except by His permission? He knows what is [presently] before them and what will be after them, and they encompass not a thing of His knowledge except for what He wills. His Kursi extends over the heavens and the earth, and their preservation tires Him not. And He is the Most High, the Most Great.",
            audioFileName: nil
        ),
        Ayah(
            id: 26,
            surahName: "Al-Baqarah",
            surahNameArabic: "البقرة",
            ayahNumber: 256,
            arabicText: "لَآ إِكْرَاهَ فِى ٱلدِّينِ ۖ قَد تَّبَيَّنَ ٱلرُّشْدُ مِنَ ٱلْغَىِّ ۚ فَمَن يَكْفُرْ بِٱلطَّٰغُوتِ وَيُؤْمِنۢ بِٱللَّهِ فَقَدِ ٱسْتَمْسَكَ بِٱلْعُرْوَةِ ٱلْوُثْقَىٰ لَا ٱنفِصَامَ لَهَا ۗ وَٱللَّهُ سَمِيعٌ عَلِيمٌ",
            translation: "There shall be no compulsion in [acceptance of] the religion. The right course has become clear from the wrong. So whoever disbelieves in Taghut and believes in Allah has grasped the most trustworthy handhold with no break in it. And Allah is Hearing and Knowing.",
            audioFileName: nil
        ),
        Ayah(
            id: 27,
            surahName: "Al-Baqarah",
            surahNameArabic: "البقرة",
            ayahNumber: 257,
            arabicText: "ٱللَّهُ وَلِىُّ ٱلَّذِينَ ءَامَنُوا۟ يُخْرِجُهُم مِّنَ ٱلظُّلُمَٰتِ إِلَى ٱلنُّورِ ۖ وَٱلَّذِينَ كَفَرُوٓا۟ أَوْلِيَآؤُهُمُ ٱلطَّٰغُوتُ يُخْرِجُونَهُم مِّنَ ٱلنُّورِ إِلَى ٱلظُّلُمَٰتِ ۗ أُو۟لَٰٓئِكَ أَصْحَٰبُ ٱلنَّارِ ۖ هُمْ فِيهَا خَٰلِدُونَ",
            translation: "Allah is the ally of those who believe. He brings them out from darknesses into the light. And those who disbelieve - their allies are Taghut. They take them out of the light into darknesses. Those are the companions of the Fire; they will abide eternally therein.",
            audioFileName: nil
        ),
        Ayah(
            id: 28,
            surahName: "Al-Baqarah",
            surahNameArabic: "البقرة",
            ayahNumber: 261,
            arabicText: "مَّثَلُ ٱلَّذِينَ يُنفِقُونَ أَمْوَٰلَهُمْ فِى سَبِيلِ ٱللَّهِ كَمَثَلِ حَبَّةٍ أَنۢبَتَتْ سَبْعَ سَنَابِلَ فِى كُلِّ سُنۢبُلَةٍۢ مِّا۟ئَةُ حَبَّةٍۢ ۗ وَٱللَّهُ يُضَٰعِفُ لِمَن يَشَآءُ ۗ وَٱللَّهُ وَٰسِعٌ عَلِيمٌ",
            translation: "The example of those who spend their wealth in the way of Allah is like a seed [of grain] which grows seven spikes; in each spike is a hundred grains. And Allah multiplies [His reward] for whom He wills. And Allah is all-Encompassing and Knowing.",
            audioFileName: nil
        ),
        Ayah(
            id: 29,
            surahName: "Al-Baqarah",
            surahNameArabic: "البقرة",
            ayahNumber: 267,
            arabicText: "يَٰٓأَيُّهَا ٱلَّذِينَ ءَامَنُوٓا۟ أَنفِقُوا۟ مِن طَيِّبَٰتِ مَا كَسَبْتُمْ وَمِمَّآ أَخْرَجْنَا لَكُم مِّنَ ٱلْأَرْضِ ۖ وَلَا تَيَمَّمُوا۟ ٱلْخَبِيثَ مِنْهُ تُنفِقُونَ وَلَسْتُم بِـَٔاخِذِيهِ إِلَّآ أَن تُغْمِضُوا۟ فِيهِ ۚ وَٱعْلَمُوٓا۟ أَنَّ ٱللَّهَ غَنِىٌّ حَمِيدٌ",
            translation: "O you who have believed, spend from the good things which you have earned and from that which We have produced for you from the earth. And do not aim toward the defective therefrom, spending [from that] while you would not take it [yourself] except with closed eyes. And know that Allah is Free of need and Praiseworthy.",
            audioFileName: nil
        ),
        Ayah(
            id: 30,
            surahName: "Al-Baqarah",
            surahNameArabic: "البقرة",
            ayahNumber: 268,
            arabicText: "ٱلشَّيْطَٰنُ يَعِدُكُمُ ٱلْفَقْرَ وَيَأْمُرُكُم بِٱلْفَحْشَآءِ ۖ وَٱللَّهُ يَعِدُكُم مَّغْفِرَةًۭ مِّنْهُ وَفَضْلًۭا ۗ وَٱللَّهُ وَٰسِعٌ عَلِيمٌۭ",
            translation: "Satan threatens you with poverty and orders you to immorality, while Allah promises you forgiveness from Him and bounty. And Allah is all-Encompassing and Knowing.",
            audioFileName: nil
        ),
        Ayah(
            id: 31,
            surahName: "Al-Baqarah",
            surahNameArabic: "البقرة",
            ayahNumber: 277,
            arabicText: "إِنَّ ٱلَّذِينَ ءَامَنُوا۟ وَعَمِلُوا۟ ٱلصَّٰلِحَٰتِ وَأَقَامُوا۟ ٱلصَّلَوٰةَ وَءَاتَوُا۟ ٱلزَّكَوٰةَ لَهُمْ أَجْرُهُمْ عِندَ رَبِّهِمْ وَلَا خَوْفٌ عَلَيْهِمْ وَلَا هُمْ يَحْزَنُونَ",
            translation: "Indeed, those who believe and do righteous deeds and establish prayer and give zakah will have their reward with their Lord, and there will be no fear concerning them, nor will they grieve.",
            audioFileName: nil
        ),
        Ayah(
            id: 32,
            surahName: "Al-Baqarah",
            surahNameArabic: "البقرة",
            ayahNumber: 285,
            arabicText: "ءَامَنَ ٱلرَّسُولُ بِمَآ أُنزِلَ إِلَيْهِ مِن رَّبِّهِۦ وَٱلْمُؤْمِنُونَ ۚ كُلٌّ ءَامَنَ بِٱللَّهِ وَمَلَٰٓئِكَتِهِۦ وَكُتُبِهِۦ وَرُسُلِهِۦ لَا نُفَرِّقُ بَيْنَ أَحَدٍۢ مِّن رُّسُلِهِۦ ۚ وَقَالُوا۟ سَمِعْنَا وَأَطَعْنَا ۖ غُفْرَانَكَ رَبَّنَا وَإِلَيْكَ ٱلْمَصِيرُ",
            translation: "The Messenger has believed in what was revealed to him from his Lord, and [so have] the believers. All of them have believed in Allah and His angels and His books and His messengers, [saying], \"We make no distinction between any of His messengers.\" And they say, \"We hear and we obey. [We seek] Your forgiveness, our Lord, and to You is the [final] destination.\"",
            audioFileName: nil
        ),
        Ayah(
            id: 33,
            surahName: "Al-Baqarah",
            surahNameArabic: "البقرة",
            ayahNumber: 286,
            arabicText: "لَا يُكَلِّفُ ٱللَّهُ نَفْسًا إِلَّا وُسْعَهَا ۚ لَهَا مَا كَسَبَتْ وَعَلَيْهَا مَا ٱكْتَسَبَتْ ۗ رَبَّنَا لَا تُؤَاخِذْنَآ إِن نَّسِينَآ أَوْ أَخْطَأْنَا ۚ رَبَّنَا وَلَا تَحْمِلْ عَلَيْنَآ إِصْرًۭا كَمَا حَمَلْتَهُۥ عَلَى ٱلَّذِينَ مِن قَبْلِنَا ۚ رَبَّنَا وَلَا تُحَمِّلْنَا مَا لَا طَاقَةَ لَنَا بِهِۦ ۖ وَٱعْفُ عَنَّا وَٱغْفِرْ لَنَا وَٱرْحَمْنَآ ۚ أَنتَ مَوْلَىٰنَا فَٱنصُرْنَا عَلَى ٱلْقَوْمِ ٱلْكَٰفِرِينَ",
            translation: "Allah does not charge a soul except [with that within] its capacity. It will have [the consequence of] what [good] it has gained, and it will bear [the consequence of] what [evil] it has earned. \"Our Lord, do not impose blame upon us if we have forgotten or erred. Our Lord, and lay not upon us a burden like that which You laid upon those before us. Our Lord, and burden us not with that which we have no ability to bear. And pardon us; and forgive us; and have mercy upon us. You are our protector, so give us victory over the disbelieving people.\"",
            audioFileName: nil
        ),
        Ayah(
            id: 34,
            surahName: "Ali 'Imran",
            surahNameArabic: "آل عمران",
            ayahNumber: 8,
            arabicText: "رَبَّنَا لَا تُزِغْ قُلُوبَنَا بَعْدَ إِذْ هَدَيْتَنَا وَهَبْ لَنَا مِن لَّدُنكَ رَحْمَةً ۚ إِنَّكَ أَنتَ ٱلْوَهَّابُ",
            translation: "[Who say], \"Our Lord, let not our hearts deviate after You have guided us and grant us from Yourself mercy. Indeed, You are the Bestower.",
            audioFileName: nil
        ),
        Ayah(
            id: 35,
            surahName: "Ali 'Imran",
            surahNameArabic: "آل عمران",
            ayahNumber: 9,
            arabicText: "رَبَّنَآ إِنَّكَ جَامِعُ ٱلنَّاسِ لِيَوْمٍۢ لَّا رَيْبَ فِيهِ ۚ إِنَّ ٱللَّهَ لَا يُخْلِفُ ٱلْمِيعَادَ",
            translation: "Our Lord, surely You will gather the people for a Day about which there is no doubt. Indeed, Allah does not fail in His promise.\"",
            audioFileName: nil
        ),
        Ayah(
            id: 36,
            surahName: "Ali 'Imran",
            surahNameArabic: "آل عمران",
            ayahNumber: 16,
            arabicText: "ٱلَّذِينَ يَقُولُونَ رَبَّنَآ إِنَّنَآ ءَامَنَّا فَٱغْفِرْ لَنَا ذُنُوبَنَا وَقِنَا عَذَابَ ٱلنَّارِ",
            translation: "Those who say, \"Our Lord, indeed we have believed, so forgive us our sins and protect us from the punishment of the Fire,\"",
            audioFileName: nil
        ),
        Ayah(
            id: 37,
            surahName: "Ali 'Imran",
            surahNameArabic: "آل عمران",
            ayahNumber: 18,
            arabicText: "شَهِدَ ٱللَّهُ أَنَّهُۥ لَآ إِلَٰهَ إِلَّا هُوَ وَٱلْمَلَٰٓئِكَةُ وَأُو۟لُوا۟ ٱلْعِلْمِ قَآئِمًۢا بِٱلْقِسْطِ ۚ لَآ إِلَٰهَ إِلَّا هُوَ ٱلْعَزِيزُ ٱلْحَكِيمُ",
            translation: "Allah witnesses that there is no deity except Him, and [so do] the angels and those of knowledge - [that He is] maintaining [creation] in justice. There is no deity except Him, the Exalted in Might, the Wise.",
            audioFileName: nil
        ),
        Ayah(
            id: 38,
            surahName: "Ali 'Imran",
            surahNameArabic: "آل عمران",
            ayahNumber: 26,
            arabicText: "قُلِ ٱللَّهُمَّ مَٰلِكَ ٱلْمُلْكِ تُؤْتِى ٱلْمُلْكَ مَن تَشَآءُ وَتَنزِعُ ٱلْمُلْكَ مِمَّن تَشَآءُ وَتُعِزُّ مَن تَشَآءُ وَتُذِلُّ مَن تَشَآءُ ۖ بِيَدِكَ ٱلْخَيْرُ ۖ إِنَّكَ عَلَىٰ كُلِّ شَىْءٍۢ قَدِيرٌۭ",
            translation: "Say, \"O Allah, Owner of Sovereignty, You give sovereignty to whom You will and You take sovereignty away from whom You will. You honor whom You will and You humble whom You will. In Your hand is [all] good. Indeed, You are over all things competent.",
            audioFileName: nil
        ),
        Ayah(
            id: 39,
            surahName: "Ali 'Imran",
            surahNameArabic: "آل عمران",
            ayahNumber: 27,
            arabicText: "تُولِجُ ٱلَّيْلَ فِى ٱلنَّهَارِ وَتُولِجُ ٱلنَّهَارَ فِى ٱلَّيْلِ ۖ وَتُخْرِجُ ٱلْحَىَّ مِنَ ٱلْمَيِّتِ وَتُخْرِجُ ٱلْمَيِّتَ مِنَ ٱلْحَىِّ ۖ وَتَرْزُقُ مَن تَشَآءُ بِغَيْرِ حِسَابٍۢ",
            translation: "You cause the night to enter the day, and You cause the day to enter the night; and You bring the living out of the dead, and You bring the dead out of the living. And You give provision to whom You will without account.\"",
            audioFileName: nil
        ),
        Ayah(
            id: 40,
            surahName: "Ali 'Imran",
            surahNameArabic: "آل عمران",
            ayahNumber: 31,
            arabicText: "قُلْ إِن كُنتُمْ تُحِبُّونَ ٱللَّهَ فَٱتَّبِعُونِى يُحْبِبْكُمُ ٱللَّهُ وَيَغْفِرْ لَكُمْ ذُنُوبَكُمْ ۗ وَٱللَّهُ غَفُورٌۭ رَّحِيمٌۭ",
            translation: "Say, [O Muhammad], \"If you should love Allah, then follow me, [so] Allah will love you and forgive you your sins. And Allah is Forgiving and Merciful.\"",
            audioFileName: nil
        ),
        Ayah(
            id: 41,
            surahName: "Ali 'Imran",
            surahNameArabic: "آل عمران",
            ayahNumber: 102,
            arabicText: "يَٰٓأَيُّهَا ٱلَّذِينَ ءَامَنُوا۟ ٱتَّقُوا۟ ٱللَّهَ حَقَّ تُقَاتِهِۦ وَلَا تَمُوتُنَّ إِلَّا وَأَنتُم مُّسْلِمُونَ",
            translation: "O you who have believed, fear Allah as He should be feared and do not die except as Muslims [in submission to Him].",
            audioFileName: nil
        ),
        Ayah(
            id: 42,
            surahName: "Ali 'Imran",
            surahNameArabic: "آل عمران",
            ayahNumber: 103,
            arabicText: "وَٱعْتَصِمُوا۟ بِحَبْلِ ٱللَّهِ جَمِيعًۭا وَلَا تَفَرَّقُوا۟ ۚ وَٱذْكُرُوا۟ نِعْمَتَ ٱللَّهِ عَلَيْكُمْ إِذْ كُنتُمْ أَعْدَآءًۭ فَأَلَّفَ بَيْنَ قُلُوبِكُمْ فَأَصْبَحْتُم بِنِعْمَتِهِۦٓ إِخْوَٰنًۭا وَكُنتُمْ عَلَىٰ شَفَا حُفْرَةٍۢ مِّنَ ٱلنَّارِ فَأَنقَذَكُم مِّنْهَا ۗ كَذَٰلِكَ يُبَيِّنُ ٱللَّهُ لَكُمْ ءَايَٰتِهِۦ لَعَلَّكُمْ تَهْتَدُونَ",
            translation: "And hold firmly to the rope of Allah all together and do not become divided. And remember the favor of Allah upon you - when you were enemies and He brought your hearts together and you became, by His favor, brothers. And you were on the edge of a pit of the Fire, and He saved you from it. Thus does Allah make clear to you His verses that you may be guided.",
            audioFileName: nil
        ),
        Ayah(
            id: 43,
            surahName: "Ali 'Imran",
            surahNameArabic: "آل عمران",
            ayahNumber: 104,
            arabicText: "وَلْتَكُن مِّنكُمْ أُمَّةٌۭ يَدْعُونَ إِلَى ٱلْخَيْرِ وَيَأْمُرُونَ بِٱلْمَعْرُوفِ وَيَنْهَوْنَ عَنِ ٱلْمُنكَرِ ۚ وَأُو۟لَٰٓئِكَ هُمُ ٱلْمُفْلِحُونَ",
            translation: "And let there be [arising] from you a nation inviting to [all that is] good, enjoining what is right and forbidding what is wrong, and those will be the successful.",
            audioFileName: nil
        ),
        Ayah(
            id: 44,
            surahName: "Ali 'Imran",
            surahNameArabic: "آل عمران",
            ayahNumber: 133,
            arabicText: "۞ وَسَارِعُوٓا۟ إِلَىٰ مَغْفِرَةٍۢ مِّن رَّبِّكُمْ وَجَنَّةٍ عَرْضُهَا ٱلسَّمَٰوَٰتُ وَٱلْأَرْضُ أُعِدَّتْ لِلْمُتَّقِينَ",
            translation: "And hasten to forgiveness from your Lord and a garden as wide as the heavens and earth, prepared for the righteous",
            audioFileName: nil
        ),
        Ayah(
            id: 45,
            surahName: "Ali 'Imran",
            surahNameArabic: "آل عمران",
            ayahNumber: 134,
            arabicText: "ٱلَّذِينَ يُنفِقُونَ فِى ٱلسَّرَّآءِ وَٱلضَّرَّآءِ وَٱلْكَٰظِمِينَ ٱلْغَيْظَ وَٱلْعَافِينَ عَنِ ٱلنَّاسِ ۗ وَٱللَّهُ يُحِبُّ ٱلْمُحْسِنِينَ",
            translation: "Who spend [in the cause of Allah] during ease and hardship and who restrain anger and who pardon the people - and Allah loves the doers of good;",
            audioFileName: nil
        ),
        Ayah(
            id: 46,
            surahName: "Ali 'Imran",
            surahNameArabic: "آل عمران",
            ayahNumber: 135,
            arabicText: "وَٱلَّذِينَ إِذَا فَعَلُوا۟ فَٰحِشَةً أَوْ ظَلَمُوٓا۟ أَنفُسَهُمْ ذَكَرُوا۟ ٱللَّهَ فَٱسْتَغْفَرُوا۟ لِذُنُوبِهِمْ وَمَن يَغْفِرُ ٱلذُّنُوبَ إِلَّا ٱللَّهُ وَلَمْ يُصِرُّوا۟ عَلَىٰ مَا فَعَلُوا۟ وَهُمْ يَعْلَمُونَ",
            translation: "And those who, when they commit an immorality or wrong themselves [by transgression], remember Allah and seek forgiveness for their sins - and who can forgive sins except Allah? - and [who] do not persist in what they have done while they know.",
            audioFileName: nil
        ),
        Ayah(
            id: 47,
            surahName: "Ali 'Imran",
            surahNameArabic: "آل عمران",
            ayahNumber: 139,
            arabicText: "وَلَا تَهِنُوا۟ وَلَا تَحْزَنُوا۟ وَأَنتُمُ ٱلْأَعْلَوْنَ إِن كُنتُم مُّؤْمِنِينَ",
            translation: "So do not weaken and do not grieve, and you will be superior if you are [true] believers.",
            audioFileName: nil
        ),
        Ayah(
            id: 48,
            surahName: "Ali 'Imran",
            surahNameArabic: "آل عمران",
            ayahNumber: 144,
            arabicText: "وَمَا مُحَمَّدٌ إِلَّا رَسُولٌۭ قَدْ خَلَتْ مِن قَبْلِهِ ٱلرُّسُلُ ۚ أَفَإِي۟ن مَّاتَ أَوْ قُتِلَ ٱنقَلَبْتُمْ عَلَىٰٓ أَعْقَٰبِكُمْ ۚ وَمَن يَنقَلِبْ عَلَىٰ عَقِبَيْهِ فَلَن يَضُرَّ ٱللَّهَ شَيْـًۭٔا ۗ وَسَيَجْزِى ٱللَّهُ ٱلشَّٰكِرِينَ",
            translation: "Muhammad is not but a messenger. [Other] messengers have passed on before him. So if he was to die or be killed, would you turn back on your heels [to unbelief]? And he who turns back on his heels will never harm Allah at all; but Allah will reward the grateful.",
            audioFileName: nil
        ),
        Ayah(
            id: 49,
            surahName: "Ali 'Imran",
            surahNameArabic: "آل عمران",
            ayahNumber: 159,
            arabicText: "فَبِمَا رَحْمَةٍۢ مِّنَ ٱللَّهِ لِنتَ لَهُمْ ۖ وَلَوْ كُنتَ فَظًّا غَلِيظَ ٱلْقَلْبِ لَٱنفَضُّوا۟ مِنْ حَوْلِكَ ۖ فَٱعْفُ عَنْهُمْ وَٱسْتَغْفِرْ لَهُمْ وَشَاوِرْهُمْ فِى ٱلْأَمْرِ ۖ فَإِذَا عَزَمْتَ فَتَوَكَّلْ عَلَى ٱللَّهِ ۚ إِنَّ ٱللَّهَ يُحِبُّ ٱلْمُتَوَكِّلِينَ",
            translation: "So by mercy from Allah, [O Muhammad], you were lenient with them. And if you had been rude [in speech] and harsh in heart, they would have disbanded from about you. So pardon them and ask forgiveness for them and consult them in the matter. And when you have decided, then rely upon Allah. Indeed, Allah loves those who rely [upon Him].",
            audioFileName: nil
        ),
        Ayah(
            id: 50,
            surahName: "Ali 'Imran",
            surahNameArabic: "آل عمران",
            ayahNumber: 160,
            arabicText: "إِن يَنصُرْكُمُ ٱللَّهُ فَلَا غَالِبَ لَكُمْ ۖ وَإِن يَخْذُلْكُمْ فَمَن ذَا ٱلَّذِى يَنصُرُكُم مِّنۢ بَعْدِهِۦ ۗ وَعَلَى ٱللَّهِ فَلْيَتَوَكَّلِ ٱلْمُؤْمِنُونَ",
            translation: "If Allah should aid you, no one can overcome you; but if He should forsake you, who is there that can aid you after Him? And upon Allah let the believers rely.",
            audioFileName: nil
        ),
        Ayah(
            id: 51,
            surahName: "Ali 'Imran",
            surahNameArabic: "آل عمران",
            ayahNumber: 173,
            arabicText: "ٱلَّذِينَ قَالَ لَهُمُ ٱلنَّاسُ إِنَّ ٱلنَّاسَ قَدْ جَمَعُوا۟ لَكُمْ فَٱخْشَوْهُمْ فَزَادَهُمْ إِيمَٰنًۭا وَقَالُوا۟ حَسْبُنَا ٱللَّهُ وَنِعْمَ ٱلْوَكِيلُ",
            translation: "Those to whom hypocrites said, \"Indeed, the people have gathered against you, so fear them.\" But it [merely] increased them in faith, and they said, \"Sufficient for us is Allah, and [He is] the best Disposer of affairs.\"",
            audioFileName: nil
        ),
        Ayah(
            id: 52,
            surahName: "Ali 'Imran",
            surahNameArabic: "آل عمران",
            ayahNumber: 185,
            arabicText: "كُلُّ نَفْسٍۢ ذَآئِقَةُ ٱلْمَوْتِ ۗ وَإِنَّمَا تُوَفَّوْنَ أُجُورَكُمْ يَوْمَ ٱلْقِيَٰمَةِ ۖ فَمَن زُحْزِحَ عَنِ ٱلنَّارِ وَأُدْخِلَ ٱلْجَنَّةَ فَقَدْ فَازَ ۗ وَمَا ٱلْحَيَوٰةُ ٱلدُّنْيَآ إِلَّا مَتَٰعُ ٱلْغُرُورِ",
            translation: "Every soul will taste death, and you will only be given your [full] compensation on the Day of Resurrection. So he who is drawn away from the Fire and admitted to Paradise has attained [his desire]. And what is the life of this world except the enjoyment of delusion.",
            audioFileName: nil
        ),
        Ayah(
            id: 53,
            surahName: "Ali 'Imran",
            surahNameArabic: "آل عمران",
            ayahNumber: 191,
            arabicText: "ٱلَّذِينَ يَذْكُرُونَ ٱللَّهَ قِيَٰمًۭا وَقُعُودًۭا وَعَلَىٰ جُنُوبِهِمْ وَيَتَفَكَّرُونَ فِى خَلْقِ ٱلسَّمَٰوَٰتِ وَٱلْأَرْضِ رَبَّنَا مَا خَلَقْتَ هَٰذَا بَٰطِلًۭا سُبْحَٰنَكَ فَقِنَا عَذَابَ ٱلنَّارِ",
            translation: "Who remember Allah while standing or sitting or [lying] on their sides and give thought to the creation of the heavens and the earth, [saying], \"Our Lord, You did not create this aimlessly; exalted are You [above such a thing]; then protect us from the punishment of the Fire.",
            audioFileName: nil
        ),
        Ayah(
            id: 54,
            surahName: "Ali 'Imran",
            surahNameArabic: "آل عمران",
            ayahNumber: 193,
            arabicText: "رَّبَّنَآ إِنَّنَا سَمِعْنَا مُنَادِيًۭا يُنَادِى لِلْإِيمَٰنِ أَنْ ءَامِنُوا۟ بِرَبِّكُمْ فَـَٔامَنَّا ۚ رَبَّنَا فَٱغْفِرْ لَنَا ذُنُوبَنَا وَكَفِّرْ عَنَّا سَيِّـَٔاتِنَا وَتَوَفَّنَا مَعَ ٱلْأَبْرَارِ",
            translation: "Our Lord, indeed we have heard a caller calling to faith, [saying], 'Believe in your Lord,' and we have believed. Our Lord, so forgive us our sins and remove from us our misdeeds and cause us to die with the righteous.",
            audioFileName: nil
        ),
        Ayah(
            id: 55,
            surahName: "Ali 'Imran",
            surahNameArabic: "آل عمران",
            ayahNumber: 194,
            arabicText: "رَبَّنَا وَءَاتِنَا مَا وَعَدتَّنَا عَلَىٰ رُسُلِكَ وَلَا تُخْزِنَا يَوْمَ ٱلْقِيَٰمَةِ ۗ إِنَّكَ لَا تُخْلِفُ ٱلْمِيعَادَ",
            translation: "Our Lord, and grant us what You promised us through Your messengers and do not disgrace us on the Day of Resurrection. Indeed, You do not fail in [Your] promise.\"",
            audioFileName: nil
        ),
        Ayah(
            id: 56,
            surahName: "Ali 'Imran",
            surahNameArabic: "آل عمران",
            ayahNumber: 200,
            arabicText: "يَٰٓأَيُّهَا ٱلَّذِينَ ءَامَنُوا۟ ٱصْبِرُوا۟ وَصَابِرُوا۟ وَرَابِطُوا۟ وَٱتَّقُوا۟ ٱللَّهَ لَعَلَّكُمْ تُفْلِحُونَ",
            translation: "O you who have believed, persevere and endure and remain stationed and fear Allah that you may be successful.",
            audioFileName: nil
        ),
        Ayah(
            id: 57,
            surahName: "An-Nisa",
            surahNameArabic: "النساء",
            ayahNumber: 1,
            arabicText: "يَٰٓأَيُّهَا ٱلنَّاسُ ٱتَّقُوا۟ رَبَّكُمُ ٱلَّذِى خَلَقَكُم مِّن نَّفْسٍۢ وَٰحِدَةٍۢ وَخَلَقَ مِنْهَا زَوْجَهَا وَبَثَّ مِنْهُمَا رِجَالًۭا كَثِيرًۭا وَنِسَآءًۭ ۚ وَٱتَّقُوا۟ ٱللَّهَ ٱلَّذِى تَسَآءَلُونَ بِهِۦ وَٱلْأَرْحَامَ ۚ إِنَّ ٱللَّهَ كَانَ عَلَيْكُمْ رَقِيبًۭا",
            translation: "O mankind, fear your Lord, who created you from one soul and created from it its mate and dispersed from both of them many men and women. And fear Allah, through whom you ask one another, and the wombs. Indeed Allah is ever, over you, an Observer.",
            audioFileName: nil
        ),
        Ayah(
            id: 58,
            surahName: "An-Nisa",
            surahNameArabic: "النساء",
            ayahNumber: 28,
            arabicText: "يُرِيدُ ٱللَّهُ أَن يُخَفِّفَ عَنكُمْ ۚ وَخُلِقَ ٱلْإِنسَٰنُ ضَعِيفًۭا",
            translation: "And Allah wants to lighten for you [your difficulties]; and mankind was created weak.",
            audioFileName: nil
        ),
        Ayah(
            id: 59,
            surahName: "An-Nisa",
            surahNameArabic: "النساء",
            ayahNumber: 36,
            arabicText: "۞ وَٱعْبُدُوا۟ ٱللَّهَ وَلَا تُشْرِكُوا۟ بِهِۦ شَيْـًۭٔا ۖ وَبِٱلْوَٰلِدَيْنِ إِحْسَٰنًۭا وَبِذِى ٱلْقُرْبَىٰ وَٱلْيَتَٰمَىٰ وَٱلْمَسَٰكِينِ وَٱلْجَارِ ذِى ٱلْقُرْبَىٰ وَٱلْجَارِ ٱلْجُنُبِ وَٱلصَّاحِبِ بِٱلْجَنۢبِ وَٱبْنِ ٱلسَّبِيلِ وَمَا مَلَكَتْ أَيْمَٰنُكُمْ ۗ إِنَّ ٱللَّهَ لَا يُحِبُّ مَن كَانَ مُخْتَالًۭا فَخُورًا",
            translation: "Worship Allah and associate nothing with Him, and to parents do good, and to relatives, orphans, the needy, the near neighbor, the neighbor farther away, the companion at your side, the traveler, and those whom your right hands possess. Indeed, Allah does not like those who are self-deluding and boastful.",
            audioFileName: nil
        ),
        Ayah(
            id: 60,
            surahName: "An-Nisa",
            surahNameArabic: "النساء",
            ayahNumber: 40,
            arabicText: "إِنَّ ٱللَّهَ لَا يَظْلِمُ مِثْقَالَ ذَرَّةٍۢ ۖ وَإِن تَكُ حَسَنَةًۭ يُضَٰعِفْهَا وَيُؤْتِ مِن لَّدُنْهُ أَجْرًا عَظِيمًۭا",
            translation: "Indeed, Allah does not do injustice, [even] as much as an atom's weight; while if there is a good deed, He multiplies it and gives from Himself a great reward.",
            audioFileName: nil
        ),
        Ayah(
            id: 61,
            surahName: "An-Nisa",
            surahNameArabic: "النساء",
            ayahNumber: 58,
            arabicText: "۞ إِنَّ ٱللَّهَ يَأْمُرُكُمْ أَن تُؤَدُّوا۟ ٱلْأَمَٰنَٰتِ إِلَىٰٓ أَهْلِهَا وَإِذَا حَكَمْتُم بَيْنَ ٱلنَّاسِ أَن تَحْكُمُوا۟ بِٱلْعَدْلِ ۚ إِنَّ ٱللَّهَ نِعِمَّا يَعِظُكُم بِهِۦٓ ۗ إِنَّ ٱللَّهَ كَانَ سَمِيعًۢا بَصِيرًۭا",
            translation: "Indeed, Allah commands you to render trusts to whom they are due and when you judge between people to judge with justice. Excellent is that which Allah instructs you. Indeed, Allah is ever Hearing and Seeing.",
            audioFileName: nil
        ),
        Ayah(
            id: 62,
            surahName: "An-Nisa",
            surahNameArabic: "النساء",
            ayahNumber: 86,
            arabicText: "وَإِذَا حُيِّيتُم بِتَحِيَّةٍۢ فَحَيُّوا۟ بِأَحْسَنَ مِنْهَآ أَوْ رُدُّوهَآ ۗ إِنَّ ٱللَّهَ كَانَ عَلَىٰ كُلِّ شَىْءٍ حَسِيبًا",
            translation: "And when you are greeted with a greeting, greet [in return] with one better than it or [at least] return it [in a like manner]. Indeed, Allah is ever, over all things, an Accountant.",
            audioFileName: nil
        ),
        Ayah(
            id: 63,
            surahName: "An-Nisa",
            surahNameArabic: "النساء",
            ayahNumber: 110,
            arabicText: "وَمَن يَعْمَلْ سُوٓءًا أَوْ يَظْلِمْ نَفْسَهُۥ ثُمَّ يَسْتَغْفِرِ ٱللَّهَ يَجِدِ ٱللَّهَ غَفُورًۭا رَّحِيمًۭا",
            translation: "And whoever does a wrong or wrongs himself but then seeks forgiveness of Allah will find Allah Forgiving and Merciful.",
            audioFileName: nil
        ),
        Ayah(
            id: 64,
            surahName: "An-Nisa",
            surahNameArabic: "النساء",
            ayahNumber: 135,
            arabicText: "۞ يَٰٓأَيُّهَا ٱلَّذِينَ ءَامَنُوا۟ كُونُوا۟ قَوَّٰمِينَ بِٱلْقِسْطِ شُهَدَآءَ لِلَّهِ وَلَوْ عَلَىٰٓ أَنفُسِكُمْ أَوِ ٱلْوَٰلِدَيْنِ وَٱلْأَقْرَبِينَ ۚ إِن يَكُنْ غَنِيًّا أَوْ فَقِيرًۭا فَٱللَّهُ أَوْلَىٰ بِهِمَا ۖ فَلَا تَتَّبِعُوا۟ ٱلْهَوَىٰٓ أَن تَعْدِلُوا۟ ۚ وَإِن تَلْوُۥٓا۟ أَوْ تُعْرِضُوا۟ فَإِنَّ ٱللَّهَ كَانَ بِمَا تَعْمَلُونَ خَبِيرًۭا",
            translation: "O you who have believed, be persistently standing firm in justice, witnesses for Allah, even if it be against yourselves or parents and relatives. Whether one is rich or poor, Allah is more worthy of both. So follow not [personal] inclination, lest you not be just. And if you distort [your testimony] or refuse [to give it], then indeed Allah is ever, with what you do, Acquainted.",
            audioFileName: nil
        ),
        Ayah(
            id: 65,
            surahName: "An-Nisa",
            surahNameArabic: "النساء",
            ayahNumber: 147,
            arabicText: "مَّا يَفْعَلُ ٱللَّهُ بِعَذَابِكُمْ إِن شَكَرْتُمْ وَءَامَنتُمْ ۚ وَكَانَ ٱللَّهُ شَاكِرًا عَلِيمًۭا",
            translation: "What would Allah do with your punishment if you are grateful and believe? And ever is Allah Appreciative and Knowing.",
            audioFileName: nil
        ),
        Ayah(
            id: 66,
            surahName: "Al-Ma'idah",
            surahNameArabic: "المائدة",
            ayahNumber: 2,
            arabicText: "يَٰٓأَيُّهَا ٱلَّذِينَ ءَامَنُوا۟ لَا تُحِلُّوا۟ شَعَٰٓئِرَ ٱللَّهِ وَلَا ٱلشَّهْرَ ٱلْحَرَامَ وَلَا ٱلْهَدْىَ وَلَا ٱلْقَلَٰٓئِدَ وَلَآ ءَآمِّينَ ٱلْبَيْتَ ٱلْحَرَامَ يَبْتَغُونَ فَضْلًۭا مِّن رَّبِّهِمْ وَرِضْوَٰنًۭا ۚ وَإِذَا حَلَلْتُمْ فَٱصْطَادُوا۟ ۚ وَلَا يَجْرِمَنَّكُمْ شَنَـَٔانُ قَوْمٍ أَن صَدُّوكُمْ عَنِ ٱلْمَسْجِدِ ٱلْحَرَامِ أَن تَعْتَدُوا۟ ۘ وَتَعَاوَنُوا۟ عَلَى ٱلْبِرِّ وَٱلتَّقْوَىٰ ۖ وَلَا تَعَاوَنُوا۟ عَلَى ٱلْإِثْمِ وَٱلْعُدْوَٰنِ ۚ وَٱتَّقُوا۟ ٱللَّهَ ۖ إِنَّ ٱللَّهَ شَدِيدُ ٱلْعِقَابِ",
            translation: "O you who have believed, do not violate the rites of Allah or [the sanctity of] the sacred month or [neglect the marking of] the sacrificial animals and garlanding [them] or [violate the safety of] those coming to the Sacred House seeking bounty from their Lord and [His] approval. But when you come out of ihram, then [you may] hunt. And do not let the hatred of a people for having obstructed you from al-Masjid al-Haram lead you to transgress. And cooperate in righteousness and piety, but do not cooperate in sin and aggression. And fear Allah; indeed, Allah is severe in penalty.",
            audioFileName: nil
        ),
        Ayah(
            id: 67,
            surahName: "Al-Ma'idah",
            surahNameArabic: "المائدة",
            ayahNumber: 8,
            arabicText: "يَٰٓأَيُّهَا ٱلَّذِينَ ءَامَنُوا۟ كُونُوا۟ قَوَّٰمِينَ لِلَّهِ شُهَدَآءَ بِٱلْقِسْطِ ۖ وَلَا يَجْرِمَنَّكُمْ شَنَـَٔانُ قَوْمٍ عَلَىٰٓ أَلَّا تَعْدِلُوا۟ ۚ ٱعْدِلُوا۟ هُوَ أَقْرَبُ لِلتَّقْوَىٰ ۖ وَٱتَّقُوا۟ ٱللَّهَ ۚ إِنَّ ٱللَّهَ خَبِيرٌۢ بِمَا تَعْمَلُونَ",
            translation: "O you who have believed, be persistently standing firm for Allah, witnesses in justice, and do not let the hatred of a people prevent you from being just. Be just; that is nearer to righteousness. And fear Allah; indeed, Allah is Acquainted with what you do.",
            audioFileName: nil
        ),
        Ayah(
            id: 68,
            surahName: "Al-Ma'idah",
            surahNameArabic: "المائدة",
            ayahNumber: 16,
            arabicText: "يَهْدِى بِهِ ٱللَّهُ مَنِ ٱتَّبَعَ رِضْوَٰنَهُۥ سُبُلَ ٱلسَّلَٰمِ وَيُخْرِجُهُم مِّنَ ٱلظُّلُمَٰتِ إِلَى ٱلنُّورِ بِإِذْنِهِۦ وَيَهْدِيهِمْ إِلَىٰ صِرَٰطٍۢ مُّسْتَقِيمٍۢ",
            translation: "By which Allah guides those who pursue His pleasure to the ways of peace and brings them out from darknesses into the light, by His permission, and guides them to a straight path.",
            audioFileName: nil
        ),
        Ayah(
            id: 69,
            surahName: "Al-Ma'idah",
            surahNameArabic: "المائدة",
            ayahNumber: 32,
            arabicText: "مِنْ أَجْلِ ذَٰلِكَ كَتَبْنَا عَلَىٰ بَنِىٓ إِسْرَٰٓءِيلَ أَنَّهُۥ مَن قَتَلَ نَفْسًۢا بِغَيْرِ نَفْسٍ أَوْ فَسَادٍۢ فِى ٱلْأَرْضِ فَكَأَنَّمَا قَتَلَ ٱلنَّاسَ جَمِيعًۭا وَمَنْ أَحْيَاهَا فَكَأَنَّمَآ أَحْيَا ٱلنَّاسَ جَمِيعًۭا ۚ وَلَقَدْ جَآءَتْهُمْ رُسُلُنَا بِٱلْبَيِّنَٰتِ ثُمَّ إِنَّ كَثِيرًۭا مِّنْهُم بَعْدَ ذَٰلِكَ فِى ٱلْأَرْضِ لَمُسْرِفُونَ",
            translation: "Because of that, We decreed upon the Children of Israel that whoever kills a soul unless for a soul or for corruption [done] in the land - it is as if he had slain mankind entirely. And whoever saves one - it is as if he had saved mankind entirely. And our messengers had certainly come to them with clear proofs. Then indeed many of them, [even] after that, throughout the land, were transgressors.",
            audioFileName: nil
        ),
        Ayah(
            id: 70,
            surahName: "Al-Ma'idah",
            surahNameArabic: "المائدة",
            ayahNumber: 35,
            arabicText: "يَٰٓأَيُّهَا ٱلَّذِينَ ءَامَنُوا۟ ٱتَّقُوا۟ ٱللَّهَ وَٱبْتَغُوٓا۟ إِلَيْهِ ٱلْوَسِيلَةَ وَجَٰهِدُوا۟ فِى سَبِيلِهِۦ لَعَلَّكُمْ تُفْلِحُونَ",
            translation: "O you who have believed, fear Allah and seek the means [of nearness] to Him and strive in His cause that you may succeed.",
            audioFileName: nil
        ),
        Ayah(
            id: 71,
            surahName: "Al-Ma'idah",
            surahNameArabic: "المائدة",
            ayahNumber: 119,
            arabicText: "قَالَ ٱللَّهُ هَٰذَا يَوْمُ يَنفَعُ ٱلصَّٰدِقِينَ صِدْقُهُمْ ۚ لَهُمْ جَنَّٰتٌۭ تَجْرِى مِن تَحْتِهَا ٱلْأَنْهَٰرُ خَٰلِدِينَ فِيهَآ أَبَدًۭا ۚ رَّضِىَ ٱللَّهُ عَنْهُمْ وَرَضُوا۟ عَنْهُ ۚ ذَٰلِكَ ٱلْفَوْزُ ٱلْعَظِيمُ",
            translation: "Allah will say, \"This is the Day when the truthful will benefit from their truthfulness.\" For them are gardens [in Paradise] beneath which rivers flow, wherein they will abide forever, Allah being pleased with them, and they with Him. That is the great attainment.",
            audioFileName: nil
        ),
        Ayah(
            id: 72,
            surahName: "Al-An'am",
            surahNameArabic: "الأنعام",
            ayahNumber: 17,
            arabicText: "وَإِن يَمْسَسْكَ ٱللَّهُ بِضُرٍّۢ فَلَا كَاشِفَ لَهُۥٓ إِلَّا هُوَ ۖ وَإِن يَمْسَسْكَ بِخَيْرٍۢ فَهُوَ عَلَىٰ كُلِّ شَىْءٍۢ قَدِيرٌۭ",
            translation: "And if Allah should touch you with adversity, there is no remover of it except Him. And if He touches you with good - then He is over all things competent.",
            audioFileName: nil
        ),
        Ayah(
            id: 73,
            surahName: "Al-An'am",
            surahNameArabic: "الأنعام",
            ayahNumber: 32,
            arabicText: "وَمَا ٱلْحَيَوٰةُ ٱلدُّنْيَآ إِلَّا لَعِبٌۭ وَلَهْوٌۭ ۖ وَلَلدَّارُ ٱلْءَاخِرَةُ خَيْرٌۭ لِّلَّذِينَ يَتَّقُونَ ۗ أَفَلَا تَعْقِلُونَ",
            translation: "And the worldly life is not but amusement and diversion; but the home of the Hereafter is best for those who fear Allah, so will you not reason?",
            audioFileName: nil
        ),
        Ayah(
            id: 74,
            surahName: "Al-An'am",
            surahNameArabic: "الأنعام",
            ayahNumber: 54,
            arabicText: "وَإِذَا جَآءَكَ ٱلَّذِينَ يُؤْمِنُونَ بِـَٔايَٰتِنَا فَقُلْ سَلَٰمٌ عَلَيْكُمْ ۖ كَتَبَ رَبُّكُمْ عَلَىٰ نَفْسِهِ ٱلرَّحْمَةَ ۖ أَنَّهُۥ مَنْ عَمِلَ مِنكُمْ سُوٓءًۢا بِجَهَٰلَةٍۢ ثُمَّ تَابَ مِنۢ بَعْدِهِۦ وَأَصْلَحَ فَأَنَّهُۥ غَفُورٌۭ رَّحِيمٌۭ",
            translation: "And when those come to you who believe in Our verses, say, \"Peace be upon you. Your Lord has decreed upon Himself mercy: that any of you who does wrong out of ignorance and then repents after that and corrects himself - indeed, He is Forgiving and Merciful.\"",
            audioFileName: nil
        ),
        Ayah(
            id: 75,
            surahName: "Al-An'am",
            surahNameArabic: "الأنعام",
            ayahNumber: 59,
            arabicText: "۞ وَعِندَهُۥ مَفَاتِحُ ٱلْغَيْبِ لَا يَعْلَمُهَآ إِلَّا هُوَ ۚ وَيَعْلَمُ مَا فِى ٱلْبَرِّ وَٱلْبَحْرِ ۚ وَمَا تَسْقُطُ مِن وَرَقَةٍ إِلَّا يَعْلَمُهَا وَلَا حَبَّةٍۢ فِى ظُلُمَٰتِ ٱلْأَرْضِ وَلَا رَطْبٍۢ وَلَا يَابِسٍ إِلَّا فِى كِتَٰبٍۢ مُّبِينٍۢ",
            translation: "And with Him are the keys of the unseen; none knows them except Him. And He knows what is on the land and in the sea. Not a leaf falls but that He knows it. And no grain is there within the darknesses of the earth and no moist or dry [thing] but that it is [written] in a clear record.",
            audioFileName: nil
        ),
        Ayah(
            id: 76,
            surahName: "Al-An'am",
            surahNameArabic: "الأنعام",
            ayahNumber: 162,
            arabicText: "قُلْ إِنَّ صَلَاتِى وَنُسُكِى وَمَحْيَاىَ وَمَمَاتِى لِلَّهِ رَبِّ ٱلْعَٰلَمِينَ",
            translation: "Say, \"Indeed, my prayer, my rites of sacrifice, my living and my dying are for Allah, Lord of the worlds.",
            audioFileName: nil
        ),
        Ayah(
            id: 77,
            surahName: "Al-A'raf",
            surahNameArabic: "الأعراف",
            ayahNumber: 23,
            arabicText: "قَالَا رَبَّنَا ظَلَمْنَآ أَنفُسَنَا وَإِن لَّمْ تَغْفِرْ لَنَا وَتَرْحَمْنَا لَنَكُونَنَّ مِنَ ٱلْخَٰسِرِينَ",
            translation: "They said, \"Our Lord, we have wronged ourselves, and if You do not forgive us and have mercy upon us, we will surely be among the losers.\"",
            audioFileName: nil
        ),
        Ayah(
            id: 78,
            surahName: "Al-A'raf",
            surahNameArabic: "الأعراف",
            ayahNumber: 43,
            arabicText: "وَنَزَعْنَا مَا فِى صُدُورِهِم مِّنْ غِلٍّۢ تَجْرِى مِن تَحْتِهِمُ ٱلْأَنْهَٰرُ ۖ وَقَالُوا۟ ٱلْحَمْدُ لِلَّهِ ٱلَّذِى هَدَىٰنَا لِهَٰذَا وَمَا كُنَّا لِنَهْتَدِىَ لَوْلَآ أَنْ هَدَىٰنَا ٱللَّهُ ۖ لَقَدْ جَآءَتْ رُسُلُ رَبِّنَا بِٱلْحَقِّ ۖ وَنُودُوٓا۟ أَن تِلْكُمُ ٱلْجَنَّةُ أُورِثْتُمُوهَا بِمَا كُنتُمْ تَعْمَلُونَ",
            translation: "And We will have removed whatever is within their breasts of resentment, [while] flowing beneath them are rivers. And they will say, \"Praise to Allah, who has guided us to this; and we would never have been guided if Allah had not guided us. Certainly the messengers of our Lord had come with the truth.\" And they will be called, \"This is Paradise, which you have been made to inherit for what you used to do.\"",
            audioFileName: nil
        ),
        Ayah(
            id: 79,
            surahName: "Al-A'raf",
            surahNameArabic: "الأعراف",
            ayahNumber: 54,
            arabicText: "إِنَّ رَبَّكُمُ ٱللَّهُ ٱلَّذِى خَلَقَ ٱلسَّمَٰوَٰتِ وَٱلْأَرْضَ فِى سِتَّةِ أَيَّامٍۢ ثُمَّ ٱسْتَوَىٰ عَلَى ٱلْعَرْشِ يُغْشِى ٱلَّيْلَ ٱلنَّهَارَ يَطْلُبُهُۥ حَثِيثًۭا وَٱلشَّمْسَ وَٱلْقَمَرَ وَٱلنُّجُومَ مُسَخَّرَٰتٍۭ بِأَمْرِهِۦٓ ۗ أَلَا لَهُ ٱلْخَلْقُ وَٱلْأَمْرُ ۗ تَبَارَكَ ٱللَّهُ رَبُّ ٱلْعَٰلَمِينَ",
            translation: "Indeed, your Lord is Allah, who created the heavens and earth in six days and then established Himself above the Throne. He covers the night with the day, [another night] chasing it rapidly; and [He created] the sun, the moon, and the stars, subjected by His command. Unquestionably, His is the creation and the command; blessed is Allah, Lord of the worlds.",
            audioFileName: nil
        ),
        Ayah(
            id: 80,
            surahName: "Al-A'raf",
            surahNameArabic: "الأعراف",
            ayahNumber: 56,
            arabicText: "وَلَا تُفْسِدُوا۟ فِى ٱلْأَرْضِ بَعْدَ إِصْلَٰحِهَا وَٱدْعُوهُ خَوْفًۭا وَطَمَعًا ۚ إِنَّ رَحْمَتَ ٱللَّهِ قَرِيبٌۭ مِّنَ ٱلْمُحْسِنِينَ",
            translation: "And cause not corruption upon the earth after its reformation. And invoke Him in fear and aspiration. Indeed, the mercy of Allah is near to the doers of good.",
            audioFileName: nil
        ),
        Ayah(
            id: 81,
            surahName: "Al-A'raf",
            surahNameArabic: "الأعراف",
            ayahNumber: 156,
            arabicText: "۞ وَٱكْتُبْ لَنَا فِى هَٰذِهِ ٱلدُّنْيَا حَسَنَةًۭ وَفِى ٱلْءَاخِرَةِ إِنَّا هُدْنَآ إِلَيْكَ ۚ قَالَ عَذَابِىٓ أُصِيبُ بِهِۦ مَنْ أَشَآءُ ۖ وَرَحْمَتِى وَسِعَتْ كُلَّ شَىْءٍۢ ۚ فَسَأَكْتُبُهَا لِلَّذِينَ يَتَّقُونَ وَيُؤْتُونَ ٱلزَّكَوٰةَ وَٱلَّذِينَ هُم بِـَٔايَٰتِنَا يُؤْمِنُونَ",
            translation: "And decree for us in this world [that which is] good and [also] in the Hereafter; indeed, we have turned back to You.\" [Allah] said, \"My punishment - I afflict with it whom I will, but My mercy encompasses all things.\" So I will decree it [especially] for those who fear Me and give zakah and those who believe in Our verses -",
            audioFileName: nil
        ),
        Ayah(
            id: 82,
            surahName: "Al-A'raf",
            surahNameArabic: "الأعراف",
            ayahNumber: 180,
            arabicText: "وَلِلَّهِ ٱلْأَسْمَآءُ ٱلْحُسْنَىٰ فَٱدْعُوهُ بِهَا ۖ وَذَرُوا۟ ٱلَّذِينَ يُلْحِدُونَ فِىٓ أَسْمَٰٓئِهِۦ ۚ سَيُجْزَوْنَ مَا كَانُوا۟ يَعْمَلُونَ",
            translation: "And to Allah belong the best names, so invoke Him by them. And leave [the company of] those who practice deviation concerning His names. They will be recompensed for what they have been doing.",
            audioFileName: nil
        ),
        Ayah(
            id: 83,
            surahName: "Al-A'raf",
            surahNameArabic: "الأعراف",
            ayahNumber: 199,
            arabicText: "خُذِ ٱلْعَفْوَ وَأْمُرْ بِٱلْعُرْفِ وَأَعْرِضْ عَنِ ٱلْجَٰهِلِينَ",
            translation: "Take what is given freely, enjoin what is good, and turn away from the ignorant.",
            audioFileName: nil
        ),
        Ayah(
            id: 84,
            surahName: "Al-A'raf",
            surahNameArabic: "الأعراف",
            ayahNumber: 205,
            arabicText: "وَٱذْكُر رَّبَّكَ فِى نَفْسِكَ تَضَرُّعًۭا وَخِيفَةًۭ وَدُونَ ٱلْجَهْرِ مِنَ ٱلْقَوْلِ بِٱلْغُدُوِّ وَٱلْءَاصَالِ وَلَا تَكُن مِّنَ ٱلْغَٰفِلِينَ",
            translation: "And remember your Lord within yourself in humility and in fear without being apparent in speech - in the mornings and the evenings. And do not be among the heedless.",
            audioFileName: nil
        ),
        Ayah(
            id: 85,
            surahName: "Al-Anfal",
            surahNameArabic: "الأنفال",
            ayahNumber: 2,
            arabicText: "إِنَّمَا ٱلْمُؤْمِنُونَ ٱلَّذِينَ إِذَا ذُكِرَ ٱللَّهُ وَجِلَتْ قُلُوبُهُمْ وَإِذَا تُلِيَتْ عَلَيْهِمْ ءَايَٰتُهُۥ زَادَتْهُمْ إِيمَٰنًۭا وَعَلَىٰ رَبِّهِمْ يَتَوَكَّلُونَ",
            translation: "The believers are only those who, when Allah is mentioned, their hearts become fearful, and when His verses are recited to them, it increases them in faith; and upon their Lord they rely -",
            audioFileName: nil
        ),
        Ayah(
            id: 86,
            surahName: "Al-Anfal",
            surahNameArabic: "الأنفال",
            ayahNumber: 46,
            arabicText: "وَأَطِيعُوا۟ ٱللَّهَ وَرَسُولَهُۥ وَلَا تَنَٰزَعُوا۟ فَتَفْشَلُوا۟ وَتَذْهَبَ رِيحُكُمْ ۖ وَٱصْبِرُوٓا۟ ۚ إِنَّ ٱللَّهَ مَعَ ٱلصَّٰبِرِينَ",
            translation: "And obey Allah and His Messenger, and do not dispute and [thus] lose courage and [then] your strength would depart; and be patient. Indeed, Allah is with the patient.",
            audioFileName: nil
        ),
        Ayah(
            id: 87,
            surahName: "At-Tawbah",
            surahNameArabic: "التوبة",
            ayahNumber: 40,
            arabicText: "إِلَّا تَنصُرُوهُ فَقَدْ نَصَرَهُ ٱللَّهُ إِذْ أَخْرَجَهُ ٱلَّذِينَ كَفَرُوا۟ ثَانِىَ ٱثْنَيْنِ إِذْ هُمَا فِى ٱلْغَارِ إِذْ يَقُولُ لِصَٰحِبِهِۦ لَا تَحْزَنْ إِنَّ ٱللَّهَ مَعَنَا ۖ فَأَنزَلَ ٱللَّهُ سَكِينَتَهُۥ عَلَيْهِ وَأَيَّدَهُۥ بِجُنُودٍۢ لَّمْ تَرَوْهَا وَجَعَلَ كَلِمَةَ ٱلَّذِينَ كَفَرُوا۟ ٱلسُّفْلَىٰ ۗ وَكَلِمَةُ ٱللَّهِ هِىَ ٱلْعُلْيَا ۗ وَٱللَّهُ عَزِيزٌ حَكِيمٌ",
            translation: "If you do not aid the Prophet - Allah has already aided him when those who disbelieved had driven him out [of Makkah] as one of two, when they were in the cave and he said to his companion, \"Do not grieve; indeed Allah is with us.\" And Allah sent down his tranquillity upon him and supported him with angels you did not see and made the word of those who disbelieved the lowest, while the word of Allah - that is the highest. And Allah is Exalted in Might and Wise.",
            audioFileName: nil
        ),
        Ayah(
            id: 88,
            surahName: "At-Tawbah",
            surahNameArabic: "التوبة",
            ayahNumber: 51,
            arabicText: "قُل لَّن يُصِيبَنَآ إِلَّا مَا كَتَبَ ٱللَّهُ لَنَا هُوَ مَوْلَىٰنَا ۚ وَعَلَى ٱللَّهِ فَلْيَتَوَكَّلِ ٱلْمُؤْمِنُونَ",
            translation: "Say, \"Never will we be struck except by what Allah has decreed for us; He is our protector.\" And upon Allah let the believers rely.",
            audioFileName: nil
        ),
        Ayah(
            id: 89,
            surahName: "At-Tawbah",
            surahNameArabic: "التوبة",
            ayahNumber: 119,
            arabicText: "يَٰٓأَيُّهَا ٱلَّذِينَ ءَامَنُوا۟ ٱتَّقُوا۟ ٱللَّهَ وَكُونُوا۟ مَعَ ٱلصَّٰدِقِينَ",
            translation: "O you who have believed, fear Allah and be with those who are true.",
            audioFileName: nil
        ),
        Ayah(
            id: 90,
            surahName: "At-Tawbah",
            surahNameArabic: "التوبة",
            ayahNumber: 128,
            arabicText: "لَقَدْ جَآءَكُمْ رَسُولٌۭ مِّنْ أَنفُسِكُمْ عَزِيزٌ عَلَيْهِ مَا عَنِتُّمْ حَرِيصٌ عَلَيْكُم بِٱلْمُؤْمِنِينَ رَءُوفٌۭ رَّحِيمٌۭ",
            translation: "There has certainly come to you a Messenger from among yourselves. Grievous to him is what you suffer; [he is] concerned over you and to the believers is kind and merciful.",
            audioFileName: nil
        ),
        Ayah(
            id: 91,
            surahName: "At-Tawbah",
            surahNameArabic: "التوبة",
            ayahNumber: 129,
            arabicText: "فَإِن تَوَلَّوْا۟ فَقُلْ حَسْبِىَ ٱللَّهُ لَآ إِلَٰهَ إِلَّا هُوَ ۖ عَلَيْهِ تَوَكَّلْتُ ۖ وَهُوَ رَبُّ ٱلْعَرْشِ ٱلْعَظِيمِ",
            translation: "But if they turn away, [O Muhammad], say, \"Sufficient for me is Allah; there is no deity except Him. On Him I have relied, and He is the Lord of the Great Throne.\"",
            audioFileName: nil
        ),
        Ayah(
            id: 92,
            surahName: "Yunus",
            surahNameArabic: "يونس",
            ayahNumber: 57,
            arabicText: "يَٰٓأَيُّهَا ٱلنَّاسُ قَدْ جَآءَتْكُم مَّوْعِظَةٌۭ مِّن رَّبِّكُمْ وَشِفَآءٌۭ لِّمَا فِى ٱلصُّدُورِ وَهُدًۭى وَرَحْمَةٌۭ لِّلْمُؤْمِنِينَ",
            translation: "O mankind, there has to come to you instruction from your Lord and healing for what is in the breasts and guidance and mercy for the believers.",
            audioFileName: nil
        ),
        Ayah(
            id: 93,
            surahName: "Yunus",
            surahNameArabic: "يونس",
            ayahNumber: 62,
            arabicText: "أَلَآ إِنَّ أَوْلِيَآءَ ٱللَّهِ لَا خَوْفٌ عَلَيْهِمْ وَلَا هُمْ يَحْزَنُونَ",
            translation: "Unquestionably, [for] the allies of Allah there will be no fear concerning them, nor will they grieve",
            audioFileName: nil
        ),
        Ayah(
            id: 94,
            surahName: "Yunus",
            surahNameArabic: "يونس",
            ayahNumber: 107,
            arabicText: "وَإِن يَمْسَسْكَ ٱللَّهُ بِضُرٍّۢ فَلَا كَاشِفَ لَهُۥٓ إِلَّا هُوَ ۖ وَإِن يُرِدْكَ بِخَيْرٍۢ فَلَا رَآدَّ لِفَضْلِهِۦ ۚ يُصِيبُ بِهِۦ مَن يَشَآءُ مِنْ عِبَادِهِۦ ۚ وَهُوَ ٱلْغَفُورُ ٱلرَّحِيمُ",
            translation: "And if Allah should touch you with adversity, there is no remover of it except Him; and if He intends for you good, then there is no repeller of His bounty. He causes it to reach whom He wills of His servants. And He is the Forgiving, the Merciful",
            audioFileName: nil
        ),
        Ayah(
            id: 95,
            surahName: "Hud",
            surahNameArabic: "هود",
            ayahNumber: 88,
            arabicText: "قَالَ يَٰقَوْمِ أَرَءَيْتُمْ إِن كُنتُ عَلَىٰ بَيِّنَةٍۢ مِّن رَّبِّى وَرَزَقَنِى مِنْهُ رِزْقًا حَسَنًۭا ۚ وَمَآ أُرِيدُ أَنْ أُخَالِفَكُمْ إِلَىٰ مَآ أَنْهَىٰكُمْ عَنْهُ ۚ إِنْ أُرِيدُ إِلَّا ٱلْإِصْلَٰحَ مَا ٱسْتَطَعْتُ ۚ وَمَا تَوْفِيقِىٓ إِلَّا بِٱللَّهِ ۚ عَلَيْهِ تَوَكَّلْتُ وَإِلَيْهِ أُنِيبُ",
            translation: "He said, \"O my people, have you considered: if I am upon clear evidence from my Lord and He has provided me with a good provision from Him...? And I do not intend to differ from you in that which I have forbidden you; I only intend reform as much as I am able. And my success is not but through Allah. Upon him I have relied, and to Him I return.",
            audioFileName: nil
        ),
        Ayah(
            id: 96,
            surahName: "Hud",
            surahNameArabic: "هود",
            ayahNumber: 114,
            arabicText: "وَأَقِمِ ٱلصَّلَوٰةَ طَرَفَىِ ٱلنَّهَارِ وَزُلَفًۭا مِّنَ ٱلَّيْلِ ۚ إِنَّ ٱلْحَسَنَٰتِ يُذْهِبْنَ ٱلسَّيِّـَٔاتِ ۚ ذَٰلِكَ ذِكْرَىٰ لِلذَّٰكِرِينَ",
            translation: "And establish prayer at the two ends of the day and at the approach of the night. Indeed, good deeds do away with misdeeds. That is a reminder for those who remember.",
            audioFileName: nil
        ),
        Ayah(
            id: 97,
            surahName: "Yusuf",
            surahNameArabic: "يوسف",
            ayahNumber: 18,
            arabicText: "وَجَآءُو عَلَىٰ قَمِيصِهِۦ بِدَمٍۢ كَذِبٍۢ ۚ قَالَ بَلْ سَوَّلَتْ لَكُمْ أَنفُسُكُمْ أَمْرًۭا ۖ فَصَبْرٌۭ جَمِيلٌۭ ۖ وَٱللَّهُ ٱلْمُسْتَعَانُ عَلَىٰ مَا تَصِفُونَ",
            translation: "And they brought upon his shirt false blood. [Jacob] said, \"Rather, your souls have enticed you to something, so patience is most fitting. And Allah is the one sought for help against that which you describe.\"",
            audioFileName: nil
        ),
        Ayah(
            id: 98,
            surahName: "Yusuf",
            surahNameArabic: "يوسف",
            ayahNumber: 64,
            arabicText: "قَالَ هَلْ ءَامَنُكُمْ عَلَيْهِ إِلَّا كَمَآ أَمِنتُكُمْ عَلَىٰٓ أَخِيهِ مِن قَبْلُ ۖ فَٱللَّهُ خَيْرٌ حَٰفِظًۭا ۖ وَهُوَ أَرْحَمُ ٱلرَّٰحِمِينَ",
            translation: "He said, \"Should I entrust you with him except [under coercion] as I entrusted you with his brother before? But Allah is the best guardian, and He is the most merciful of the merciful.\"",
            audioFileName: nil
        ),
        Ayah(
            id: 99,
            surahName: "Yusuf",
            surahNameArabic: "يوسف",
            ayahNumber: 86,
            arabicText: "قَالَ إِنَّمَآ أَشْكُوا۟ بَثِّى وَحُزْنِىٓ إِلَى ٱللَّهِ وَأَعْلَمُ مِنَ ٱللَّهِ مَا لَا تَعْلَمُونَ",
            translation: "He said, \"I only complain of my suffering and my grief to Allah, and I know from Allah that which you do not know.",
            audioFileName: nil
        ),
        Ayah(
            id: 100,
            surahName: "Yusuf",
            surahNameArabic: "يوسف",
            ayahNumber: 87,
            arabicText: "يَٰبَنِىَّ ٱذْهَبُوا۟ فَتَحَسَّسُوا۟ مِن يُوسُفَ وَأَخِيهِ وَلَا تَا۟يْـَٔسُوا۟ مِن رَّوْحِ ٱللَّهِ ۖ إِنَّهُۥ لَا يَا۟يْـَٔسُ مِن رَّوْحِ ٱللَّهِ إِلَّا ٱلْقَوْمُ ٱلْكَٰفِرُونَ",
            translation: "O my sons, go and find out about Joseph and his brother and despair not of relief from Allah. Indeed, no one despairs of relief from Allah except the disbelieving people.\"",
            audioFileName: nil
        ),
        Ayah(
            id: 101,
            surahName: "Yusuf",
            surahNameArabic: "يوسف",
            ayahNumber: 101,
            arabicText: "۞ رَبِّ قَدْ ءَاتَيْتَنِى مِنَ ٱلْمُلْكِ وَعَلَّمْتَنِى مِن تَأْوِيلِ ٱلْأَحَادِيثِ ۚ فَاطِرَ ٱلسَّمَٰوَٰتِ وَٱلْأَرْضِ أَنتَ وَلِىِّۦ فِى ٱلدُّنْيَا وَٱلْءَاخِرَةِ ۖ تَوَفَّنِى مُسْلِمًۭا وَأَلْحِقْنِى بِٱلصَّٰلِحِينَ",
            translation: "My Lord, You have given me [something] of sovereignty and taught me of the interpretation of dreams. Creator of the heavens and earth, You are my protector in this world and in the Hereafter. Cause me to die a Muslim and join me with the righteous.\"",
            audioFileName: nil
        ),
        Ayah(
            id: 102,
            surahName: "Ar-Ra'd",
            surahNameArabic: "الرعد",
            ayahNumber: 11,
            arabicText: "لَهُۥ مُعَقِّبَٰتٌۭ مِّنۢ بَيْنِ يَدَيْهِ وَمِنْ خَلْفِهِۦ يَحْفَظُونَهُۥ مِنْ أَمْرِ ٱللَّهِ ۗ إِنَّ ٱللَّهَ لَا يُغَيِّرُ مَا بِقَوْمٍ حَتَّىٰ يُغَيِّرُوا۟ مَا بِأَنفُسِهِمْ ۗ وَإِذَآ أَرَادَ ٱللَّهُ بِقَوْمٍۢ سُوٓءًۭا فَلَا مَرَدَّ لَهُۥ ۚ وَمَا لَهُم مِّن دُونِهِۦ مِن وَالٍ",
            translation: "For each one are successive [angels] before and behind him who protect him by the decree of Allah. Indeed, Allah will not change the condition of a people until they change what is in themselves. And when Allah intends for a people ill, there is no repelling it. And there is not for them besides Him any patron.",
            audioFileName: nil
        ),
        Ayah(
            id: 103,
            surahName: "Ar-Ra'd",
            surahNameArabic: "الرعد",
            ayahNumber: 28,
            arabicText: "ٱلَّذِينَ ءَامَنُوا۟ وَتَطْمَئِنُّ قُلُوبُهُم بِذِكْرِ ٱللَّهِ ۗ أَلَا بِذِكْرِ ٱللَّهِ تَطْمَئِنُّ ٱلْقُلُوبُ",
            translation: "Those who have believed and whose hearts are assured by the remembrance of Allah. Unquestionably, by the remembrance of Allah hearts are assured.\"",
            audioFileName: nil
        ),
        Ayah(
            id: 104,
            surahName: "Ibrahim",
            surahNameArabic: "إبراهيم",
            ayahNumber: 7,
            arabicText: "وَإِذْ تَأَذَّنَ رَبُّكُمْ لَئِن شَكَرْتُمْ لَأَزِيدَنَّكُمْ ۖ وَلَئِن كَفَرْتُمْ إِنَّ عَذَابِى لَشَدِيدٌۭ",
            translation: "And [remember] when your Lord proclaimed, 'If you are grateful, I will surely increase you [in favor]; but if you deny, indeed, My punishment is severe.' \"",
            audioFileName: nil
        ),
        Ayah(
            id: 105,
            surahName: "Ibrahim",
            surahNameArabic: "إبراهيم",
            ayahNumber: 27,
            arabicText: "يُثَبِّتُ ٱللَّهُ ٱلَّذِينَ ءَامَنُوا۟ بِٱلْقَوْلِ ٱلثَّابِتِ فِى ٱلْحَيَوٰةِ ٱلدُّنْيَا وَفِى ٱلْءَاخِرَةِ ۖ وَيُضِلُّ ٱللَّهُ ٱلظَّٰلِمِينَ ۚ وَيَفْعَلُ ٱللَّهُ مَا يَشَآءُ",
            translation: "Allah keeps firm those who believe, with the firm word, in worldly life and in the Hereafter. And Allah sends astray the wrongdoers. And Allah does what He wills.",
            audioFileName: nil
        ),
        Ayah(
            id: 106,
            surahName: "Ibrahim",
            surahNameArabic: "إبراهيم",
            ayahNumber: 40,
            arabicText: "رَبِّ ٱجْعَلْنِى مُقِيمَ ٱلصَّلَوٰةِ وَمِن ذُرِّيَّتِى ۚ رَبَّنَا وَتَقَبَّلْ دُعَآءِ",
            translation: "My Lord, make me an establisher of prayer, and [many] from my descendants. Our Lord, and accept my supplication.",
            audioFileName: nil
        ),
        Ayah(
            id: 107,
            surahName: "Ibrahim",
            surahNameArabic: "إبراهيم",
            ayahNumber: 41,
            arabicText: "رَبَّنَا ٱغْفِرْ لِى وَلِوَٰلِدَىَّ وَلِلْمُؤْمِنِينَ يَوْمَ يَقُومُ ٱلْحِسَابُ",
            translation: "Our Lord, forgive me and my parents and the believers the Day the account is established.\"",
            audioFileName: nil
        ),
        Ayah(
            id: 108,
            surahName: "Al-Hijr",
            surahNameArabic: "الحجر",
            ayahNumber: 9,
            arabicText: "إِنَّا نَحْنُ نَزَّلْنَا ٱلذِّكْرَ وَإِنَّا لَهُۥ لَحَٰفِظُونَ",
            translation: "Indeed, it is We who sent down the Qur'an and indeed, We will be its guardian.",
            audioFileName: nil
        ),
        Ayah(
            id: 109,
            surahName: "Al-Hijr",
            surahNameArabic: "الحجر",
            ayahNumber: 49,
            arabicText: "۞ نَبِّئْ عِبَادِىٓ أَنِّىٓ أَنَا ٱلْغَفُورُ ٱلرَّحِيمُ",
            translation: "[O Muhammad], inform My servants that it is I who am the Forgiving, the Merciful.",
            audioFileName: nil
        ),
        Ayah(
            id: 110,
            surahName: "Al-Hijr",
            surahNameArabic: "الحجر",
            ayahNumber: 98,
            arabicText: "فَسَبِّحْ بِحَمْدِ رَبِّكَ وَكُن مِّنَ ٱلسَّٰجِدِينَ",
            translation: "So exalt [Allah] with praise of your Lord and be of those who prostrate [to Him].",
            audioFileName: nil
        ),
        Ayah(
            id: 111,
            surahName: "Al-Hijr",
            surahNameArabic: "الحجر",
            ayahNumber: 99,
            arabicText: "وَٱعْبُدْ رَبَّكَ حَتَّىٰ يَأْتِيَكَ ٱلْيَقِينُ",
            translation: "And worship your Lord until there comes to you the certainty (death).",
            audioFileName: nil
        ),
        Ayah(
            id: 112,
            surahName: "An-Nahl",
            surahNameArabic: "النحل",
            ayahNumber: 90,
            arabicText: "۞ إِنَّ ٱللَّهَ يَأْمُرُ بِٱلْعَدْلِ وَٱلْإِحْسَٰنِ وَإِيتَآئِ ذِى ٱلْقُرْبَىٰ وَيَنْهَىٰ عَنِ ٱلْفَحْشَآءِ وَٱلْمُنكَرِ وَٱلْبَغْىِ ۚ يَعِظُكُمْ لَعَلَّكُمْ تَذَكَّرُونَ",
            translation: "Indeed, Allah orders justice and good conduct and giving to relatives and forbids immorality and bad conduct and oppression. He admonishes you that perhaps you will be reminded.",
            audioFileName: nil
        ),
        Ayah(
            id: 113,
            surahName: "An-Nahl",
            surahNameArabic: "النحل",
            ayahNumber: 96,
            arabicText: "مَا عِندَكُمْ يَنفَدُ ۖ وَمَا عِندَ ٱللَّهِ بَاقٍۢ ۗ وَلَنَجْزِيَنَّ ٱلَّذِينَ صَبَرُوٓا۟ أَجْرَهُم بِأَحْسَنِ مَا كَانُوا۟ يَعْمَلُونَ",
            translation: "Whatever you have will end, but what Allah has is lasting. And We will surely give those who were patient their reward according to the best of what they used to do.",
            audioFileName: nil
        ),
        Ayah(
            id: 114,
            surahName: "An-Nahl",
            surahNameArabic: "النحل",
            ayahNumber: 97,
            arabicText: "مَنْ عَمِلَ صَٰلِحًۭا مِّن ذَكَرٍ أَوْ أُنثَىٰ وَهُوَ مُؤْمِنٌۭ فَلَنُحْيِيَنَّهُۥ حَيَوٰةًۭ طَيِّبَةًۭ ۖ وَلَنَجْزِيَنَّهُمْ أَجْرَهُم بِأَحْسَنِ مَا كَانُوا۟ يَعْمَلُونَ",
            translation: "Whoever does righteousness, whether male or female, while he is a believer - We will surely cause him to live a good life, and We will surely give them their reward [in the Hereafter] according to the best of what they used to do.",
            audioFileName: nil
        ),
        Ayah(
            id: 115,
            surahName: "An-Nahl",
            surahNameArabic: "النحل",
            ayahNumber: 128,
            arabicText: "إِنَّ ٱللَّهَ مَعَ ٱلَّذِينَ ٱتَّقَوا۟ وَّٱلَّذِينَ هُم مُّحْسِنُونَ",
            translation: "Indeed, Allah is with those who fear Him and those who are doers of good.",
            audioFileName: nil
        ),
        Ayah(
            id: 116,
            surahName: "Al-Isra",
            surahNameArabic: "الإسراء",
            ayahNumber: 23,
            arabicText: "۞ وَقَضَىٰ رَبُّكَ أَلَّا تَعْبُدُوٓا۟ إِلَّآ إِيَّاهُ وَبِٱلْوَٰلِدَيْنِ إِحْسَٰنًا ۚ إِمَّا يَبْلُغَنَّ عِندَكَ ٱلْكِبَرَ أَحَدُهُمَآ أَوْ كِلَاهُمَا فَلَا تَقُل لَّهُمَآ أُفٍّۢ وَلَا تَنْهَرْهُمَا وَقُل لَّهُمَا قَوْلًۭا كَرِيمًۭا",
            translation: "And your Lord has decreed that you not worship except Him, and to parents, good treatment. Whether one or both of them reach old age [while] with you, say not to them [so much as], \"uff,\" and do not repel them but speak to them a noble word.",
            audioFileName: nil
        ),
        Ayah(
            id: 117,
            surahName: "Al-Isra",
            surahNameArabic: "الإسراء",
            ayahNumber: 24,
            arabicText: "وَٱخْفِضْ لَهُمَا جَنَاحَ ٱلذُّلِّ مِنَ ٱلرَّحْمَةِ وَقُل رَّبِّ ٱرْحَمْهُمَا كَمَا رَبَّيَانِى صَغِيرًۭا",
            translation: "And lower to them the wing of humility out of mercy and say, \"My Lord, have mercy upon them as they brought me up [when I was] small.\"",
            audioFileName: nil
        ),
        Ayah(
            id: 118,
            surahName: "Al-Isra",
            surahNameArabic: "الإسراء",
            ayahNumber: 70,
            arabicText: "۞ وَلَقَدْ كَرَّمْنَا بَنِىٓ ءَادَمَ وَحَمَلْنَٰهُمْ فِى ٱلْبَرِّ وَٱلْبَحْرِ وَرَزَقْنَٰهُم مِّنَ ٱلطَّيِّبَٰتِ وَفَضَّلْنَٰهُمْ عَلَىٰ كَثِيرٍۢ مِّمَّنْ خَلَقْنَا تَفْضِيلًۭا",
            translation: "And We have certainly honored the children of Adam and carried them on the land and sea and provided for them of the good things and preferred them over much of what We have created, with [definite] preference.",
            audioFileName: nil
        ),
        Ayah(
            id: 119,
            surahName: "Al-Isra",
            surahNameArabic: "الإسراء",
            ayahNumber: 82,
            arabicText: "وَنُنَزِّلُ مِنَ ٱلْقُرْءَانِ مَا هُوَ شِفَآءٌۭ وَرَحْمَةٌۭ لِّلْمُؤْمِنِينَ ۙ وَلَا يَزِيدُ ٱلظَّٰلِمِينَ إِلَّا خَسَارًۭا",
            translation: "And We send down of the Qur'an that which is healing and mercy for the believers, but it does not increase the wrongdoers except in loss.",
            audioFileName: nil
        ),
        Ayah(
            id: 120,
            surahName: "Al-Kahf",
            surahNameArabic: "الكهف",
            ayahNumber: 10,
            arabicText: "إِذْ أَوَى ٱلْفِتْيَةُ إِلَى ٱلْكَهْفِ فَقَالُوا۟ رَبَّنَآ ءَاتِنَا مِن لَّدُنكَ رَحْمَةًۭ وَهَيِّئْ لَنَا مِنْ أَمْرِنَا رَشَدًۭا",
            translation: "[Mention] when the youths retreated to the cave and said, \"Our Lord, grant us from Yourself mercy and prepare for us from our affair right guidance.\"",
            audioFileName: nil
        ),
        Ayah(
            id: 121,
            surahName: "Al-Kahf",
            surahNameArabic: "الكهف",
            ayahNumber: 23,
            arabicText: "وَلَا تَقُولَنَّ لِشَا۟ىْءٍ إِنِّى فَاعِلٌۭ ذَٰلِكَ غَدًا",
            translation: "And never say of anything, \"Indeed, I will do that tomorrow,\"",
            audioFileName: nil
        ),
        Ayah(
            id: 122,
            surahName: "Al-Kahf",
            surahNameArabic: "الكهف",
            ayahNumber: 24,
            arabicText: "إِلَّآ أَن يَشَآءَ ٱللَّهُ ۚ وَٱذْكُر رَّبَّكَ إِذَا نَسِيتَ وَقُلْ عَسَىٰٓ أَن يَهْدِيَنِ رَبِّى لِأَقْرَبَ مِنْ هَٰذَا رَشَدًۭا",
            translation: "Except [when adding], \"If Allah wills.\" And remember your Lord when you forget [it] and say, \"Perhaps my Lord will guide me to what is nearer than this to right conduct.\"",
            audioFileName: nil
        ),
        Ayah(
            id: 123,
            surahName: "Al-Kahf",
            surahNameArabic: "الكهف",
            ayahNumber: 46,
            arabicText: "ٱلْمَالُ وَٱلْبَنُونَ زِينَةُ ٱلْحَيَوٰةِ ٱلدُّنْيَا ۖ وَٱلْبَٰقِيَٰتُ ٱلصَّٰلِحَٰتُ خَيْرٌ عِندَ رَبِّكَ ثَوَابًۭا وَخَيْرٌ أَمَلًۭا",
            translation: "Wealth and children are [but] adornment of the worldly life. But the enduring good deeds are better to your Lord for reward and better for [one's] hope.",
            audioFileName: nil
        ),
        Ayah(
            id: 124,
            surahName: "Al-Kahf",
            surahNameArabic: "الكهف",
            ayahNumber: 109,
            arabicText: "قُل لَّوْ كَانَ ٱلْبَحْرُ مِدَادًۭا لِّكَلِمَٰتِ رَبِّى لَنَفِدَ ٱلْبَحْرُ قَبْلَ أَن تَنفَدَ كَلِمَٰتُ رَبِّى وَلَوْ جِئْنَا بِمِثْلِهِۦ مَدَدًۭا",
            translation: "Say, \"If the sea were ink for [writing] the words of my Lord, the sea would be exhausted before the words of my Lord were exhausted, even if We brought the like of it as a supplement.\"",
            audioFileName: nil
        ),
        Ayah(
            id: 125,
            surahName: "Al-Kahf",
            surahNameArabic: "الكهف",
            ayahNumber: 110,
            arabicText: "قُلْ إِنَّمَآ أَنَا۠ بَشَرٌۭ مِّثْلُكُمْ يُوحَىٰٓ إِلَىَّ أَنَّمَآ إِلَٰهُكُمْ إِلَٰهٌۭ وَٰحِدٌۭ ۖ فَمَن كَانَ يَرْجُوا۟ لِقَآءَ رَبِّهِۦ فَلْيَعْمَلْ عَمَلًۭا صَٰلِحًۭا وَلَا يُشْرِكْ بِعِبَادَةِ رَبِّهِۦٓ أَحَدًۢا",
            translation: "Say, \"I am only a man like you, to whom has been revealed that your god is one God. So whoever would hope for the meeting with his Lord - let him do righteous work and not associate in the worship of his Lord anyone.\"",
            audioFileName: nil
        ),
        Ayah(
            id: 126,
            surahName: "Maryam",
            surahNameArabic: "مريم",
            ayahNumber: 96,
            arabicText: "إِنَّ ٱلَّذِينَ ءَامَنُوا۟ وَعَمِلُوا۟ ٱلصَّٰلِحَٰتِ سَيَجْعَلُ لَهُمُ ٱلرَّحْمَٰنُ وُدًّۭا",
            translation: "Indeed, those who have believed and done righteous deeds - the Most Merciful will appoint for them affection.",
            audioFileName: nil
        ),
        Ayah(
            id: 127,
            surahName: "Ta-Ha",
            surahNameArabic: "طه",
            ayahNumber: 14,
            arabicText: "إِنَّنِىٓ أَنَا ٱللَّهُ لَآ إِلَٰهَ إِلَّآ أَنَا۠ فَٱعْبُدْنِى وَأَقِمِ ٱلصَّلَوٰةَ لِذِكْرِىٓ",
            translation: "Indeed, I am Allah. There is no deity except Me, so worship Me and establish prayer for My remembrance.",
            audioFileName: nil
        ),
        Ayah(
            id: 128,
            surahName: "Ta-Ha",
            surahNameArabic: "طه",
            ayahNumber: 25,
            arabicText: "قَالَ رَبِّ ٱشْرَحْ لِى صَدْرِى",
            translation: "[Moses] said, \"My Lord, expand for me my breast [with assurance]",
            audioFileName: nil
        ),
        Ayah(
            id: 129,
            surahName: "Ta-Ha",
            surahNameArabic: "طه",
            ayahNumber: 26,
            arabicText: "وَيَسِّرْ لِىٓ أَمْرِى",
            translation: "And ease for me my task",
            audioFileName: nil
        ),
        Ayah(
            id: 130,
            surahName: "Ta-Ha",
            surahNameArabic: "طه",
            ayahNumber: 46,
            arabicText: "قَالَ لَا تَخَافَآ ۖ إِنَّنِى مَعَكُمَآ أَسْمَعُ وَأَرَىٰ",
            translation: "[Allah] said, \"Fear not. Indeed, I am with you both; I hear and I see.",
            audioFileName: nil
        ),
        Ayah(
            id: 131,
            surahName: "Ta-Ha",
            surahNameArabic: "طه",
            ayahNumber: 114,
            arabicText: "فَتَعَٰلَى ٱللَّهُ ٱلْمَلِكُ ٱلْحَقُّ ۗ وَلَا تَعْجَلْ بِٱلْقُرْءَانِ مِن قَبْلِ أَن يُقْضَىٰٓ إِلَيْكَ وَحْيُهُۥ ۖ وَقُل رَّبِّ زِدْنِى عِلْمًۭا",
            translation: "So high [above all] is Allah, the Sovereign, the Truth. And, [O Muhammad], do not hasten with [recitation of] the Qur'an before its revelation is completed to you, and say, \"My Lord, increase me in knowledge.\"",
            audioFileName: nil
        ),
        Ayah(
            id: 132,
            surahName: "Ta-Ha",
            surahNameArabic: "طه",
            ayahNumber: 130,
            arabicText: "فَٱصْبِرْ عَلَىٰ مَا يَقُولُونَ وَسَبِّحْ بِحَمْدِ رَبِّكَ قَبْلَ طُلُوعِ ٱلشَّمْسِ وَقَبْلَ غُرُوبِهَا ۖ وَمِنْ ءَانَآئِ ٱلَّيْلِ فَسَبِّحْ وَأَطْرَافَ ٱلنَّهَارِ لَعَلَّكَ تَرْضَىٰ",
            translation: "So be patient over what they say and exalt [Allah] with praise of your Lord before the rising of the sun and before its setting; and during periods of the night [exalt Him] and at the ends of the day, that you may be satisfied.",
            audioFileName: nil
        ),
        Ayah(
            id: 133,
            surahName: "Ta-Ha",
            surahNameArabic: "طه",
            ayahNumber: 132,
            arabicText: "وَأْمُرْ أَهْلَكَ بِٱلصَّلَوٰةِ وَٱصْطَبِرْ عَلَيْهَا ۖ لَا نَسْـَٔلُكَ رِزْقًۭا ۖ نَّحْنُ نَرْزُقُكَ ۗ وَٱلْعَٰقِبَةُ لِلتَّقْوَىٰ",
            translation: "And enjoin prayer upon your family [and people] and be steadfast therein. We ask you not for provision; We provide for you, and the [best] outcome is for [those of] righteousness.",
            audioFileName: nil
        ),
        Ayah(
            id: 134,
            surahName: "Al-Anbiya",
            surahNameArabic: "الأنبياء",
            ayahNumber: 35,
            arabicText: "كُلُّ نَفْسٍۢ ذَآئِقَةُ ٱلْمَوْتِ ۗ وَنَبْلُوكُم بِٱلشَّرِّ وَٱلْخَيْرِ فِتْنَةًۭ ۖ وَإِلَيْنَا تُرْجَعُونَ",
            translation: "Every soul will taste death. And We test you with evil and with good as trial; and to Us you will be returned.",
            audioFileName: nil
        ),
        Ayah(
            id: 135,
            surahName: "Al-Anbiya",
            surahNameArabic: "الأنبياء",
            ayahNumber: 87,
            arabicText: "وَذَا ٱلنُّونِ إِذ ذَّهَبَ مُغَٰضِبًۭا فَظَنَّ أَن لَّن نَّقْدِرَ عَلَيْهِ فَنَادَىٰ فِى ٱلظُّلُمَٰتِ أَن لَّآ إِلَٰهَ إِلَّآ أَنتَ سُبْحَٰنَكَ إِنِّى كُنتُ مِنَ ٱلظَّٰلِمِينَ",
            translation: "And [mention] the man of the fish, when he went off in anger and thought that We would not decree [anything] upon him. And he called out within the darknesses, \"There is no deity except You; exalted are You. Indeed, I have been of the wrongdoers.\"",
            audioFileName: nil
        ),
        Ayah(
            id: 136,
            surahName: "Al-Anbiya",
            surahNameArabic: "الأنبياء",
            ayahNumber: 88,
            arabicText: "فَٱسْتَجَبْنَا لَهُۥ وَنَجَّيْنَٰهُ مِنَ ٱلْغَمِّ ۚ وَكَذَٰلِكَ نُۨجِى ٱلْمُؤْمِنِينَ",
            translation: "So We responded to him and saved him from the distress. And thus do We save the believers.",
            audioFileName: nil
        ),
        Ayah(
            id: 137,
            surahName: "Al-Anbiya",
            surahNameArabic: "الأنبياء",
            ayahNumber: 89,
            arabicText: "وَزَكَرِيَّآ إِذْ نَادَىٰ رَبَّهُۥ رَبِّ لَا تَذَرْنِى فَرْدًۭا وَأَنتَ خَيْرُ ٱلْوَٰرِثِينَ",
            translation: "And [mention] Zechariah, when he called to his Lord, \"My Lord, do not leave me alone [with no heir], while you are the best of inheritors.\"",
            audioFileName: nil
        ),
        Ayah(
            id: 138,
            surahName: "Al-Anbiya",
            surahNameArabic: "الأنبياء",
            ayahNumber: 107,
            arabicText: "وَمَآ أَرْسَلْنَٰكَ إِلَّا رَحْمَةًۭ لِّلْعَٰلَمِينَ",
            translation: "And We have not sent you, [O Muhammad], except as a mercy to the worlds.",
            audioFileName: nil
        ),
        Ayah(
            id: 139,
            surahName: "Al-Hajj",
            surahNameArabic: "الحج",
            ayahNumber: 77,
            arabicText: "يَٰٓأَيُّهَا ٱلَّذِينَ ءَامَنُوا۟ ٱرْكَعُوا۟ وَٱسْجُدُوا۟ وَٱعْبُدُوا۟ رَبَّكُمْ وَٱفْعَلُوا۟ ٱلْخَيْرَ لَعَلَّكُمْ تُفْلِحُونَ ۩",
            translation: "O you who have believed, bow and prostrate and worship your Lord and do good - that you may succeed.",
            audioFileName: nil
        ),
        Ayah(
            id: 140,
            surahName: "Al-Mu'minun",
            surahNameArabic: "المؤمنون",
            ayahNumber: 1,
            arabicText: "قَدْ أَفْلَحَ ٱلْمُؤْمِنُونَ",
            translation: "Certainly will the believers have succeeded:",
            audioFileName: nil
        ),
        Ayah(
            id: 141,
            surahName: "Al-Mu'minun",
            surahNameArabic: "المؤمنون",
            ayahNumber: 2,
            arabicText: "ٱلَّذِينَ هُمْ فِى صَلَاتِهِمْ خَٰشِعُونَ",
            translation: "They who are during their prayer humbly submissive",
            audioFileName: nil
        ),
        Ayah(
            id: 142,
            surahName: "Al-Mu'minun",
            surahNameArabic: "المؤمنون",
            ayahNumber: 97,
            arabicText: "وَقُل رَّبِّ أَعُوذُ بِكَ مِنْ هَمَزَٰتِ ٱلشَّيَٰطِينِ",
            translation: "And say, \"My Lord, I seek refuge in You from the incitements of the devils,",
            audioFileName: nil
        ),
        Ayah(
            id: 143,
            surahName: "Al-Mu'minun",
            surahNameArabic: "المؤمنون",
            ayahNumber: 98,
            arabicText: "وَأَعُوذُ بِكَ رَبِّ أَن يَحْضُرُونِ",
            translation: "And I seek refuge in You, my Lord, lest they be present with me.\"",
            audioFileName: nil
        ),
        Ayah(
            id: 144,
            surahName: "Al-Mu'minun",
            surahNameArabic: "المؤمنون",
            ayahNumber: 118,
            arabicText: "وَقُل رَّبِّ ٱغْفِرْ وَٱرْحَمْ وَأَنتَ خَيْرُ ٱلرَّٰحِمِينَ",
            translation: "And, [O Muhammad], say, \"My Lord, forgive and have mercy, and You are the best of the merciful.\"",
            audioFileName: nil
        ),
        Ayah(
            id: 145,
            surahName: "An-Nur",
            surahNameArabic: "النور",
            ayahNumber: 21,
            arabicText: "۞ يَٰٓأَيُّهَا ٱلَّذِينَ ءَامَنُوا۟ لَا تَتَّبِعُوا۟ خُطُوَٰتِ ٱلشَّيْطَٰنِ ۚ وَمَن يَتَّبِعْ خُطُوَٰتِ ٱلشَّيْطَٰنِ فَإِنَّهُۥ يَأْمُرُ بِٱلْفَحْشَآءِ وَٱلْمُنكَرِ ۚ وَلَوْلَا فَضْلُ ٱللَّهِ عَلَيْكُمْ وَرَحْمَتُهُۥ مَا زَكَىٰ مِنكُم مِّنْ أَحَدٍ أَبَدًۭا وَلَٰكِنَّ ٱللَّهَ يُزَكِّى مَن يَشَآءُ ۗ وَٱللَّهُ سَمِيعٌ عَلِيمٌۭ",
            translation: "O you who have believed, do not follow the footsteps of Satan. And whoever follows the footsteps of Satan - indeed, he enjoins immorality and wrongdoing. And if not for the favor of Allah upon you and His mercy, not one of you would have been pure, ever, but Allah purifies whom He wills, and Allah is Hearing and Knowing.",
            audioFileName: nil
        ),
        Ayah(
            id: 146,
            surahName: "An-Nur",
            surahNameArabic: "النور",
            ayahNumber: 35,
            arabicText: "۞ ٱللَّهُ نُورُ ٱلسَّمَٰوَٰتِ وَٱلْأَرْضِ ۚ مَثَلُ نُورِهِۦ كَمِشْكَوٰةٍۢ فِيهَا مِصْبَاحٌ ۖ ٱلْمِصْبَاحُ فِى زُجَاجَةٍ ۖ ٱلزُّجَاجَةُ كَأَنَّهَا كَوْكَبٌۭ دُرِّىٌّۭ يُوقَدُ مِن شَجَرَةٍۢ مُّبَٰرَكَةٍۢ زَيْتُونَةٍۢ لَّا شَرْقِيَّةٍۢ وَلَا غَرْبِيَّةٍۢ يَكَادُ زَيْتُهَا يُضِىٓءُ وَلَوْ لَمْ تَمْسَسْهُ نَارٌۭ ۚ نُّورٌ عَلَىٰ نُورٍۢ ۗ يَهْدِى ٱللَّهُ لِنُورِهِۦ مَن يَشَآءُ ۚ وَيَضْرِبُ ٱللَّهُ ٱلْأَمْثَٰلَ لِلنَّاسِ ۗ وَٱللَّهُ بِكُلِّ شَىْءٍ عَلِيمٌۭ",
            translation: "Allah is the Light of the heavens and the earth. The example of His light is like a niche within which is a lamp, the lamp is within glass, the glass as if it were a pearly [white] star lit from [the oil of] a blessed olive tree, neither of the east nor of the west, whose oil would almost glow even if untouched by fire. Light upon light. Allah guides to His light whom He wills. And Allah presents examples for the people, and Allah is Knowing of all things.",
            audioFileName: nil
        ),
        Ayah(
            id: 147,
            surahName: "An-Nur",
            surahNameArabic: "النور",
            ayahNumber: 37,
            arabicText: "رِجَالٌۭ لَّا تُلْهِيهِمْ تِجَٰرَةٌۭ وَلَا بَيْعٌ عَن ذِكْرِ ٱللَّهِ وَإِقَامِ ٱلصَّلَوٰةِ وَإِيتَآءِ ٱلزَّكَوٰةِ ۙ يَخَافُونَ يَوْمًۭا تَتَقَلَّبُ فِيهِ ٱلْقُلُوبُ وَٱلْأَبْصَٰرُ",
            translation: "[Are] men whom neither commerce nor sale distracts from the remembrance of Allah and performance of prayer and giving of zakah. They fear a Day in which the hearts and eyes will [fearfully] turn about -",
            audioFileName: nil
        ),
        Ayah(
            id: 148,
            surahName: "Al-Furqan",
            surahNameArabic: "الفرقان",
            ayahNumber: 58,
            arabicText: "وَتَوَكَّلْ عَلَى ٱلْحَىِّ ٱلَّذِى لَا يَمُوتُ وَسَبِّحْ بِحَمْدِهِۦ ۚ وَكَفَىٰ بِهِۦ بِذُنُوبِ عِبَادِهِۦ خَبِيرًا",
            translation: "And rely upon the Ever-Living who does not die, and exalt [Allah] with His praise. And sufficient is He to be, with the sins of His servants, Acquainted -",
            audioFileName: nil
        ),
        Ayah(
            id: 149,
            surahName: "Al-Furqan",
            surahNameArabic: "الفرقان",
            ayahNumber: 63,
            arabicText: "وَعِبَادُ ٱلرَّحْمَٰنِ ٱلَّذِينَ يَمْشُونَ عَلَى ٱلْأَرْضِ هَوْنًۭا وَإِذَا خَاطَبَهُمُ ٱلْجَٰهِلُونَ قَالُوا۟ سَلَٰمًۭا",
            translation: "And the servants of the Most Merciful are those who walk upon the earth easily, and when the ignorant address them [harshly], they say [words of] peace,",
            audioFileName: nil
        ),
        Ayah(
            id: 150,
            surahName: "Al-Furqan",
            surahNameArabic: "الفرقان",
            ayahNumber: 65,
            arabicText: "وَٱلَّذِينَ يَقُولُونَ رَبَّنَا ٱصْرِفْ عَنَّا عَذَابَ جَهَنَّمَ ۖ إِنَّ عَذَابَهَا كَانَ غَرَامًا",
            translation: "And those who say, \"Our Lord, avert from us the punishment of Hell. Indeed, its punishment is ever adhering;",
            audioFileName: nil
        ),
        Ayah(
            id: 151,
            surahName: "Al-Furqan",
            surahNameArabic: "الفرقان",
            ayahNumber: 70,
            arabicText: "إِلَّا مَن تَابَ وَءَامَنَ وَعَمِلَ عَمَلًۭا صَٰلِحًۭا فَأُو۟لَٰٓئِكَ يُبَدِّلُ ٱللَّهُ سَيِّـَٔاتِهِمْ حَسَنَٰتٍۢ ۗ وَكَانَ ٱللَّهُ غَفُورًۭا رَّحِيمًۭا",
            translation: "Except for those who repent, believe and do righteous work. For them Allah will replace their evil deeds with good. And ever is Allah Forgiving and Merciful.",
            audioFileName: nil
        ),
        Ayah(
            id: 152,
            surahName: "Al-Furqan",
            surahNameArabic: "الفرقان",
            ayahNumber: 74,
            arabicText: "وَٱلَّذِينَ يَقُولُونَ رَبَّنَا هَبْ لَنَا مِنْ أَزْوَٰجِنَا وَذُرِّيَّٰتِنَا قُرَّةَ أَعْيُنٍۢ وَٱجْعَلْنَا لِلْمُتَّقِينَ إِمَامًا",
            translation: "And those who say, \"Our Lord, grant us from among our wives and offspring comfort to our eyes and make us an example for the righteous.\"",
            audioFileName: nil
        ),
        Ayah(
            id: 153,
            surahName: "Ash-Shu'ara",
            surahNameArabic: "الشعراء",
            ayahNumber: 80,
            arabicText: "وَإِذَا مَرِضْتُ فَهُوَ يَشْفِينِ",
            translation: "And when I am ill, it is He who cures me",
            audioFileName: nil
        ),
        Ayah(
            id: 154,
            surahName: "Ash-Shu'ara",
            surahNameArabic: "الشعراء",
            ayahNumber: 83,
            arabicText: "رَبِّ هَبْ لِى حُكْمًۭا وَأَلْحِقْنِى بِٱلصَّٰلِحِينَ",
            translation: "[And he said], \"My Lord, grant me authority and join me with the righteous.",
            audioFileName: nil
        ),
        Ayah(
            id: 155,
            surahName: "Ash-Shu'ara",
            surahNameArabic: "الشعراء",
            ayahNumber: 88,
            arabicText: "يَوْمَ لَا يَنفَعُ مَالٌۭ وَلَا بَنُونَ",
            translation: "The Day when there will not benefit [anyone] wealth or children",
            audioFileName: nil
        ),
        Ayah(
            id: 156,
            surahName: "Ash-Shu'ara",
            surahNameArabic: "الشعراء",
            ayahNumber: 89,
            arabicText: "إِلَّا مَنْ أَتَى ٱللَّهَ بِقَلْبٍۢ سَلِيمٍۢ",
            translation: "But only one who comes to Allah with a sound heart.\"",
            audioFileName: nil
        ),
        Ayah(
            id: 157,
            surahName: "An-Naml",
            surahNameArabic: "النمل",
            ayahNumber: 19,
            arabicText: "فَتَبَسَّمَ ضَاحِكًۭا مِّن قَوْلِهَا وَقَالَ رَبِّ أَوْزِعْنِىٓ أَنْ أَشْكُرَ نِعْمَتَكَ ٱلَّتِىٓ أَنْعَمْتَ عَلَىَّ وَعَلَىٰ وَٰلِدَىَّ وَأَنْ أَعْمَلَ صَٰلِحًۭا تَرْضَىٰهُ وَأَدْخِلْنِى بِرَحْمَتِكَ فِى عِبَادِكَ ٱلصَّٰلِحِينَ",
            translation: "So [Solomon] smiled, amused at her speech, and said, \"My Lord, enable me to be grateful for Your favor which You have bestowed upon me and upon my parents and to do righteousness of which You approve. And admit me by Your mercy into [the ranks of] Your righteous servants.\"",
            audioFileName: nil
        ),
        Ayah(
            id: 158,
            surahName: "Al-Qasas",
            surahNameArabic: "القصص",
            ayahNumber: 24,
            arabicText: "فَسَقَىٰ لَهُمَا ثُمَّ تَوَلَّىٰٓ إِلَى ٱلظِّلِّ فَقَالَ رَبِّ إِنِّى لِمَآ أَنزَلْتَ إِلَىَّ مِنْ خَيْرٍۢ فَقِيرٌۭ",
            translation: "So he watered [their flocks] for them; then he went back to the shade and said, \"My Lord, indeed I am, for whatever good You would send down to me, in need.\"",
            audioFileName: nil
        ),
        Ayah(
            id: 159,
            surahName: "Al-Qasas",
            surahNameArabic: "القصص",
            ayahNumber: 77,
            arabicText: "وَٱبْتَغِ فِيمَآ ءَاتَىٰكَ ٱللَّهُ ٱلدَّارَ ٱلْءَاخِرَةَ ۖ وَلَا تَنسَ نَصِيبَكَ مِنَ ٱلدُّنْيَا ۖ وَأَحْسِن كَمَآ أَحْسَنَ ٱللَّهُ إِلَيْكَ ۖ وَلَا تَبْغِ ٱلْفَسَادَ فِى ٱلْأَرْضِ ۖ إِنَّ ٱللَّهَ لَا يُحِبُّ ٱلْمُفْسِدِينَ",
            translation: "But seek, through that which Allah has given you, the home of the Hereafter; and [yet], do not forget your share of the world. And do good as Allah has done good to you. And desire not corruption in the land. Indeed, Allah does not like corrupters.\"",
            audioFileName: nil
        ),
        Ayah(
            id: 160,
            surahName: "Al-'Ankabut",
            surahNameArabic: "العنكبوت",
            ayahNumber: 45,
            arabicText: "ٱتْلُ مَآ أُوحِىَ إِلَيْكَ مِنَ ٱلْكِتَٰبِ وَأَقِمِ ٱلصَّلَوٰةَ ۖ إِنَّ ٱلصَّلَوٰةَ تَنْهَىٰ عَنِ ٱلْفَحْشَآءِ وَٱلْمُنكَرِ ۗ وَلَذِكْرُ ٱللَّهِ أَكْبَرُ ۗ وَٱللَّهُ يَعْلَمُ مَا تَصْنَعُونَ",
            translation: "Recite, [O Muhammad], what has been revealed to you of the Book and establish prayer. Indeed, prayer prohibits immorality and wrongdoing, and the remembrance of Allah is greater. And Allah knows that which you do.",
            audioFileName: nil
        ),
        Ayah(
            id: 161,
            surahName: "Al-'Ankabut",
            surahNameArabic: "العنكبوت",
            ayahNumber: 69,
            arabicText: "وَٱلَّذِينَ جَٰهَدُوا۟ فِينَا لَنَهْدِيَنَّهُمْ سُبُلَنَا ۚ وَإِنَّ ٱللَّهَ لَمَعَ ٱلْمُحْسِنِينَ",
            translation: "And those who strive for Us - We will surely guide them to Our ways. And indeed, Allah is with the doers of good.",
            audioFileName: nil
        ),
        Ayah(
            id: 162,
            surahName: "Ar-Rum",
            surahNameArabic: "الروم",
            ayahNumber: 21,
            arabicText: "وَمِنْ ءَايَٰتِهِۦٓ أَنْ خَلَقَ لَكُم مِّنْ أَنفُسِكُمْ أَزْوَٰجًۭا لِّتَسْكُنُوٓا۟ إِلَيْهَا وَجَعَلَ بَيْنَكُم مَّوَدَّةًۭ وَرَحْمَةً ۚ إِنَّ فِى ذَٰلِكَ لَءَايَٰتٍۢ لِّقَوْمٍۢ يَتَفَكَّرُونَ",
            translation: "And of His signs is that He created for you from yourselves mates that you may find tranquillity in them; and He placed between you affection and mercy. Indeed in that are signs for a people who give thought.",
            audioFileName: nil
        ),
        Ayah(
            id: 163,
            surahName: "Ar-Rum",
            surahNameArabic: "الروم",
            ayahNumber: 60,
            arabicText: "فَٱصْبِرْ إِنَّ وَعْدَ ٱللَّهِ حَقٌّۭ ۖ وَلَا يَسْتَخِفَّنَّكَ ٱلَّذِينَ لَا يُوقِنُونَ",
            translation: "So be patient. Indeed, the promise of Allah is truth. And let them not disquiet you who are not certain [in faith].",
            audioFileName: nil
        ),
        Ayah(
            id: 164,
            surahName: "Luqman",
            surahNameArabic: "لقمان",
            ayahNumber: 17,
            arabicText: "يَٰبُنَىَّ أَقِمِ ٱلصَّلَوٰةَ وَأْمُرْ بِٱلْمَعْرُوفِ وَٱنْهَ عَنِ ٱلْمُنكَرِ وَٱصْبِرْ عَلَىٰ مَآ أَصَابَكَ ۖ إِنَّ ذَٰلِكَ مِنْ عَزْمِ ٱلْأُمُورِ",
            translation: "O my son, establish prayer, enjoin what is right, forbid what is wrong, and be patient over what befalls you. Indeed, [all] that is of the matters [requiring] determination.",
            audioFileName: nil
        ),
        Ayah(
            id: 165,
            surahName: "Luqman",
            surahNameArabic: "لقمان",
            ayahNumber: 18,
            arabicText: "وَلَا تُصَعِّرْ خَدَّكَ لِلنَّاسِ وَلَا تَمْشِ فِى ٱلْأَرْضِ مَرَحًا ۖ إِنَّ ٱللَّهَ لَا يُحِبُّ كُلَّ مُخْتَالٍۢ فَخُورٍۢ",
            translation: "And do not turn your cheek [in contempt] toward people and do not walk through the earth exultantly. Indeed, Allah does not like everyone self-deluded and boastful.",
            audioFileName: nil
        ),
        Ayah(
            id: 166,
            surahName: "As-Sajdah",
            surahNameArabic: "السجدة",
            ayahNumber: 16,
            arabicText: "تَتَجَافَىٰ جُنُوبُهُمْ عَنِ ٱلْمَضَاجِعِ يَدْعُونَ رَبَّهُمْ خَوْفًۭا وَطَمَعًۭا وَمِمَّا رَزَقْنَٰهُمْ يُنفِقُونَ",
            translation: "They arise from [their] beds; they supplicate their Lord in fear and aspiration, and from what We have provided them, they spend.",
            audioFileName: nil
        ),
        Ayah(
            id: 167,
            surahName: "Al-Ahzab",
            surahNameArabic: "الأحزاب",
            ayahNumber: 35,
            arabicText: "إِنَّ ٱلْمُسْلِمِينَ وَٱلْمُسْلِمَٰتِ وَٱلْمُؤْمِنِينَ وَٱلْمُؤْمِنَٰتِ وَٱلْقَٰنِتِينَ وَٱلْقَٰنِتَٰتِ وَٱلصَّٰدِقِينَ وَٱلصَّٰدِقَٰتِ وَٱلصَّٰبِرِينَ وَٱلصَّٰبِرَٰتِ وَٱلْخَٰشِعِينَ وَٱلْخَٰشِعَٰتِ وَٱلْمُتَصَدِّقِينَ وَٱلْمُتَصَدِّقَٰتِ وَٱلصَّٰٓئِمِينَ وَٱلصَّٰٓئِمَٰتِ وَٱلْحَٰفِظِينَ فُرُوجَهُمْ وَٱلْحَٰفِظَٰتِ وَٱلذَّٰكِرِينَ ٱللَّهَ كَثِيرًۭا وَٱلذَّٰكِرَٰتِ أَعَدَّ ٱللَّهُ لَهُم مَّغْفِرَةًۭ وَأَجْرًا عَظِيمًۭا",
            translation: "Indeed, the Muslim men and Muslim women, the believing men and believing women, the obedient men and obedient women, the truthful men and truthful women, the patient men and patient women, the humble men and humble women, the charitable men and charitable women, the fasting men and fasting women, the men who guard their private parts and the women who do so, and the men who remember Allah often and the women who do so - for them Allah has prepared forgiveness and a great reward.",
            audioFileName: nil
        ),
        Ayah(
            id: 168,
            surahName: "Al-Ahzab",
            surahNameArabic: "الأحزاب",
            ayahNumber: 41,
            arabicText: "يَٰٓأَيُّهَا ٱلَّذِينَ ءَامَنُوا۟ ٱذْكُرُوا۟ ٱللَّهَ ذِكْرًۭا كَثِيرًۭا",
            translation: "O you who have believed, remember Allah with much remembrance",
            audioFileName: nil
        ),
        Ayah(
            id: 169,
            surahName: "Al-Ahzab",
            surahNameArabic: "الأحزاب",
            ayahNumber: 42,
            arabicText: "وَسَبِّحُوهُ بُكْرَةًۭ وَأَصِيلًا",
            translation: "And exalt Him morning and afternoon.",
            audioFileName: nil
        ),
        Ayah(
            id: 170,
            surahName: "Al-Ahzab",
            surahNameArabic: "الأحزاب",
            ayahNumber: 56,
            arabicText: "إِنَّ ٱللَّهَ وَمَلَٰٓئِكَتَهُۥ يُصَلُّونَ عَلَى ٱلنَّبِىِّ ۚ يَٰٓأَيُّهَا ٱلَّذِينَ ءَامَنُوا۟ صَلُّوا۟ عَلَيْهِ وَسَلِّمُوا۟ تَسْلِيمًا",
            translation: "Indeed, Allah confers blessing upon the Prophet, and His angels [ask Him to do so]. O you who have believed, ask [Allah to confer] blessing upon him and ask [Allah to grant him] peace.",
            audioFileName: nil
        ),
        Ayah(
            id: 171,
            surahName: "Al-Ahzab",
            surahNameArabic: "الأحزاب",
            ayahNumber: 70,
            arabicText: "يَٰٓأَيُّهَا ٱلَّذِينَ ءَامَنُوا۟ ٱتَّقُوا۟ ٱللَّهَ وَقُولُوا۟ قَوْلًۭا سَدِيدًۭا",
            translation: "O you who have believed, fear Allah and speak words of appropriate justice.",
            audioFileName: nil
        ),
        Ayah(
            id: 172,
            surahName: "Al-Ahzab",
            surahNameArabic: "الأحزاب",
            ayahNumber: 71,
            arabicText: "يُصْلِحْ لَكُمْ أَعْمَٰلَكُمْ وَيَغْفِرْ لَكُمْ ذُنُوبَكُمْ ۗ وَمَن يُطِعِ ٱللَّهَ وَرَسُولَهُۥ فَقَدْ فَازَ فَوْزًا عَظِيمًا",
            translation: "He will [then] amend for you your deeds and forgive you your sins. And whoever obeys Allah and His Messenger has certainly attained a great attainment.",
            audioFileName: nil
        ),
        Ayah(
            id: 173,
            surahName: "Fatir",
            surahNameArabic: "فاطر",
            ayahNumber: 2,
            arabicText: "مَّا يَفْتَحِ ٱللَّهُ لِلنَّاسِ مِن رَّحْمَةٍۢ فَلَا مُمْسِكَ لَهَا ۖ وَمَا يُمْسِكْ فَلَا مُرْسِلَ لَهُۥ مِنۢ بَعْدِهِۦ ۚ وَهُوَ ٱلْعَزِيزُ ٱلْحَكِيمُ",
            translation: "Whatever Allah grants to people of mercy - none can withhold it; and whatever He withholds - none can release it thereafter. And He is the Exalted in Might, the Wise.",
            audioFileName: nil
        ),
        Ayah(
            id: 174,
            surahName: "Fatir",
            surahNameArabic: "فاطر",
            ayahNumber: 10,
            arabicText: "مَن كَانَ يُرِيدُ ٱلْعِزَّةَ فَلِلَّهِ ٱلْعِزَّةُ جَمِيعًا ۚ إِلَيْهِ يَصْعَدُ ٱلْكَلِمُ ٱلطَّيِّبُ وَٱلْعَمَلُ ٱلصَّٰلِحُ يَرْفَعُهُۥ ۚ وَٱلَّذِينَ يَمْكُرُونَ ٱلسَّيِّـَٔاتِ لَهُمْ عَذَابٌۭ شَدِيدٌۭ ۖ وَمَكْرُ أُو۟لَٰٓئِكَ هُوَ يَبُورُ",
            translation: "Whoever desires honor [through power] - then to Allah belongs all honor. To Him ascends good speech, and righteous work raises it. But they who plot evil deeds will have a severe punishment, and the plotting of those - it will perish.",
            audioFileName: nil
        ),
        Ayah(
            id: 175,
            surahName: "Fatir",
            surahNameArabic: "فاطر",
            ayahNumber: 15,
            arabicText: "۞ يَٰٓأَيُّهَا ٱلنَّاسُ أَنتُمُ ٱلْفُقَرَآءُ إِلَى ٱللَّهِ ۖ وَٱللَّهُ هُوَ ٱلْغَنِىُّ ٱلْحَمِيدُ",
            translation: "O mankind, you are those in need of Allah, while Allah is the Free of need, the Praiseworthy.",
            audioFileName: nil
        ),
        Ayah(
            id: 176,
            surahName: "Ya-Sin",
            surahNameArabic: "يس",
            ayahNumber: 58,
            arabicText: "سَلَٰمٌۭ قَوْلًۭا مِّن رَّبٍّۢ رَّحِيمٍۢ",
            translation: "[And] \"Peace,\" a word from a Merciful Lord.",
            audioFileName: nil
        ),
        Ayah(
            id: 177,
            surahName: "Ya-Sin",
            surahNameArabic: "يس",
            ayahNumber: 82,
            arabicText: "إِنَّمَآ أَمْرُهُۥٓ إِذَآ أَرَادَ شَيْـًٔا أَن يَقُولَ لَهُۥ كُن فَيَكُونُ",
            translation: "His command is only when He intends a thing that He says to it, \"Be,\" and it is.",
            audioFileName: nil
        ),
        Ayah(
            id: 178,
            surahName: "Az-Zumar",
            surahNameArabic: "الزمر",
            ayahNumber: 9,
            arabicText: "أَمَّنْ هُوَ قَٰنِتٌ ءَانَآءَ ٱلَّيْلِ سَاجِدًۭا وَقَآئِمًۭا يَحْذَرُ ٱلْءَاخِرَةَ وَيَرْجُوا۟ رَحْمَةَ رَبِّهِۦ ۗ قُلْ هَلْ يَسْتَوِى ٱلَّذِينَ يَعْلَمُونَ وَٱلَّذِينَ لَا يَعْلَمُونَ ۗ إِنَّمَا يَتَذَكَّرُ أُو۟لُوا۟ ٱلْأَلْبَٰبِ",
            translation: "Is one who is devoutly obedient during periods of the night, prostrating and standing [in prayer], fearing the Hereafter and hoping for the mercy of his Lord, [like one who does not]? Say, \"Are those who know equal to those who do not know?\" Only they will remember [who are] people of understanding.",
            audioFileName: nil
        ),
        Ayah(
            id: 179,
            surahName: "Az-Zumar",
            surahNameArabic: "الزمر",
            ayahNumber: 10,
            arabicText: "قُلْ يَٰعِبَادِ ٱلَّذِينَ ءَامَنُوا۟ ٱتَّقُوا۟ رَبَّكُمْ ۚ لِلَّذِينَ أَحْسَنُوا۟ فِى هَٰذِهِ ٱلدُّنْيَا حَسَنَةٌۭ ۗ وَأَرْضُ ٱللَّهِ وَٰسِعَةٌ ۗ إِنَّمَا يُوَفَّى ٱلصَّٰبِرُونَ أَجْرَهُم بِغَيْرِ حِسَابٍۢ",
            translation: "Say, \"O My servants who have believed, fear your Lord. For those who do good in this world is good, and the earth of Allah is spacious. Indeed, the patient will be given their reward without account.\"",
            audioFileName: nil
        ),
        Ayah(
            id: 180,
            surahName: "Az-Zumar",
            surahNameArabic: "الزمر",
            ayahNumber: 22,
            arabicText: "أَفَمَن شَرَحَ ٱللَّهُ صَدْرَهُۥ لِلْإِسْلَٰمِ فَهُوَ عَلَىٰ نُورٍۢ مِّن رَّبِّهِۦ ۚ فَوَيْلٌۭ لِّلْقَٰسِيَةِ قُلُوبُهُم مِّن ذِكْرِ ٱللَّهِ ۚ أُو۟لَٰٓئِكَ فِى ضَلَٰلٍۢ مُّبِينٍ",
            translation: "So is one whose breast Allah has expanded to [accept] Islam and he is upon a light from his Lord [like one whose heart rejects it]? Then woe to those whose hearts are hardened against the remembrance of Allah. Those are in manifest error.",
            audioFileName: nil
        ),
        Ayah(
            id: 181,
            surahName: "Az-Zumar",
            surahNameArabic: "الزمر",
            ayahNumber: 36,
            arabicText: "أَلَيْسَ ٱللَّهُ بِكَافٍ عَبْدَهُۥ ۖ وَيُخَوِّفُونَكَ بِٱلَّذِينَ مِن دُونِهِۦ ۚ وَمَن يُضْلِلِ ٱللَّهُ فَمَا لَهُۥ مِنْ هَادٍۢ",
            translation: "Is not Allah sufficient for His Servant [Prophet Muhammad]? And [yet], they threaten you with those [they worship] other than Him. And whoever Allah leaves astray - for him there is no guide.",
            audioFileName: nil
        ),
        Ayah(
            id: 182,
            surahName: "Az-Zumar",
            surahNameArabic: "الزمر",
            ayahNumber: 53,
            arabicText: "۞ قُلْ يَٰعِبَادِىَ ٱلَّذِينَ أَسْرَفُوا۟ عَلَىٰٓ أَنفُسِهِمْ لَا تَقْنَطُوا۟ مِن رَّحْمَةِ ٱللَّهِ ۚ إِنَّ ٱللَّهَ يَغْفِرُ ٱلذُّنُوبَ جَمِيعًا ۚ إِنَّهُۥ هُوَ ٱلْغَفُورُ ٱلرَّحِيمُ",
            translation: "Say, \"O My servants who have transgressed against themselves [by sinning], do not despair of the mercy of Allah. Indeed, Allah forgives all sins. Indeed, it is He who is the Forgiving, the Merciful.\"",
            audioFileName: nil
        ),
        Ayah(
            id: 183,
            surahName: "Ghafir",
            surahNameArabic: "غافر",
            ayahNumber: 44,
            arabicText: "فَسَتَذْكُرُونَ مَآ أَقُولُ لَكُمْ ۚ وَأُفَوِّضُ أَمْرِىٓ إِلَى ٱللَّهِ ۚ إِنَّ ٱللَّهَ بَصِيرٌۢ بِٱلْعِبَادِ",
            translation: "And you will remember what I [now] say to you, and I entrust my affair to Allah. Indeed, Allah is Seeing of [His] servants.\"",
            audioFileName: nil
        ),
        Ayah(
            id: 184,
            surahName: "Ghafir",
            surahNameArabic: "غافر",
            ayahNumber: 60,
            arabicText: "وَقَالَ رَبُّكُمُ ٱدْعُونِىٓ أَسْتَجِبْ لَكُمْ ۚ إِنَّ ٱلَّذِينَ يَسْتَكْبِرُونَ عَنْ عِبَادَتِى سَيَدْخُلُونَ جَهَنَّمَ دَاخِرِينَ",
            translation: "And your Lord says, \"Call upon Me; I will respond to you.\" Indeed, those who disdain My worship will enter Hell [rendered] contemptible.",
            audioFileName: nil
        ),
        Ayah(
            id: 185,
            surahName: "Fussilat",
            surahNameArabic: "فصلت",
            ayahNumber: 30,
            arabicText: "إِنَّ ٱلَّذِينَ قَالُوا۟ رَبُّنَا ٱللَّهُ ثُمَّ ٱسْتَقَٰمُوا۟ تَتَنَزَّلُ عَلَيْهِمُ ٱلْمَلَٰٓئِكَةُ أَلَّا تَخَافُوا۟ وَلَا تَحْزَنُوا۟ وَأَبْشِرُوا۟ بِٱلْجَنَّةِ ٱلَّتِى كُنتُمْ تُوعَدُونَ",
            translation: "Indeed, those who have said, \"Our Lord is Allah \" and then remained on a right course - the angels will descend upon them, [saying], \"Do not fear and do not grieve but receive good tidings of Paradise, which you were promised.",
            audioFileName: nil
        ),
        Ayah(
            id: 186,
            surahName: "Fussilat",
            surahNameArabic: "فصلت",
            ayahNumber: 33,
            arabicText: "وَمَنْ أَحْسَنُ قَوْلًۭا مِّمَّن دَعَآ إِلَى ٱللَّهِ وَعَمِلَ صَٰلِحًۭا وَقَالَ إِنَّنِى مِنَ ٱلْمُسْلِمِينَ",
            translation: "And who is better in speech than one who invites to Allah and does righteousness and says, \"Indeed, I am of the Muslims.\"",
            audioFileName: nil
        ),
        Ayah(
            id: 187,
            surahName: "Fussilat",
            surahNameArabic: "فصلت",
            ayahNumber: 34,
            arabicText: "وَلَا تَسْتَوِى ٱلْحَسَنَةُ وَلَا ٱلسَّيِّئَةُ ۚ ٱدْفَعْ بِٱلَّتِى هِىَ أَحْسَنُ فَإِذَا ٱلَّذِى بَيْنَكَ وَبَيْنَهُۥ عَدَٰوَةٌۭ كَأَنَّهُۥ وَلِىٌّ حَمِيمٌۭ",
            translation: "And not equal are the good deed and the bad. Repel [evil] by that [deed] which is better; and thereupon the one whom between you and him is enmity [will become] as though he was a devoted friend.",
            audioFileName: nil
        ),
        Ayah(
            id: 188,
            surahName: "Ash-Shura",
            surahNameArabic: "الشورى",
            ayahNumber: 19,
            arabicText: "ٱللَّهُ لَطِيفٌۢ بِعِبَادِهِۦ يَرْزُقُ مَن يَشَآءُ ۖ وَهُوَ ٱلْقَوِىُّ ٱلْعَزِيزُ",
            translation: "Allah is Subtle with His servants; He gives provisions to whom He wills. And He is the Powerful, the Exalted in Might.",
            audioFileName: nil
        ),
        Ayah(
            id: 189,
            surahName: "Ash-Shura",
            surahNameArabic: "الشورى",
            ayahNumber: 23,
            arabicText: "ذَٰلِكَ ٱلَّذِى يُبَشِّرُ ٱللَّهُ عِبَادَهُ ٱلَّذِينَ ءَامَنُوا۟ وَعَمِلُوا۟ ٱلصَّٰلِحَٰتِ ۗ قُل لَّآ أَسْـَٔلُكُمْ عَلَيْهِ أَجْرًا إِلَّا ٱلْمَوَدَّةَ فِى ٱلْقُرْبَىٰ ۗ وَمَن يَقْتَرِفْ حَسَنَةًۭ نَّزِدْ لَهُۥ فِيهَا حُسْنًا ۚ إِنَّ ٱللَّهَ غَفُورٌۭ شَكُورٌ",
            translation: "It is that of which Allah gives good tidings to His servants who believe and do righteous deeds. Say, [O Muhammad], \"I do not ask you for this message any payment [but] only good will through kinship.\" And whoever commits a good deed - We will increase for him good therein. Indeed, Allah is Forgiving and Appreciative.",
            audioFileName: nil
        ),
        Ayah(
            id: 190,
            surahName: "Ash-Shura",
            surahNameArabic: "الشورى",
            ayahNumber: 28,
            arabicText: "وَهُوَ ٱلَّذِى يُنَزِّلُ ٱلْغَيْثَ مِنۢ بَعْدِ مَا قَنَطُوا۟ وَيَنشُرُ رَحْمَتَهُۥ ۚ وَهُوَ ٱلْوَلِىُّ ٱلْحَمِيدُ",
            translation: "And it is He who sends down the rain after they had despaired and spreads His mercy. And He is the Protector, the Praiseworthy.",
            audioFileName: nil
        ),
        Ayah(
            id: 191,
            surahName: "Al-Ahqaf",
            surahNameArabic: "الأحقاف",
            ayahNumber: 13,
            arabicText: "إِنَّ ٱلَّذِينَ قَالُوا۟ رَبُّنَا ٱللَّهُ ثُمَّ ٱسْتَقَٰمُوا۟ فَلَا خَوْفٌ عَلَيْهِمْ وَلَا هُمْ يَحْزَنُونَ",
            translation: "Indeed, those who have said, \"Our Lord is Allah,\" and then remained on a right course - there will be no fear concerning them, nor will they grieve.",
            audioFileName: nil
        ),
        Ayah(
            id: 192,
            surahName: "Al-Ahqaf",
            surahNameArabic: "الأحقاف",
            ayahNumber: 15,
            arabicText: "وَوَصَّيْنَا ٱلْإِنسَٰنَ بِوَٰلِدَيْهِ إِحْسَٰنًا ۖ حَمَلَتْهُ أُمُّهُۥ كُرْهًۭا وَوَضَعَتْهُ كُرْهًۭا ۖ وَحَمْلُهُۥ وَفِصَٰلُهُۥ ثَلَٰثُونَ شَهْرًا ۚ حَتَّىٰٓ إِذَا بَلَغَ أَشُدَّهُۥ وَبَلَغَ أَرْبَعِينَ سَنَةًۭ قَالَ رَبِّ أَوْزِعْنِىٓ أَنْ أَشْكُرَ نِعْمَتَكَ ٱلَّتِىٓ أَنْعَمْتَ عَلَىَّ وَعَلَىٰ وَٰلِدَىَّ وَأَنْ أَعْمَلَ صَٰلِحًۭا تَرْضَىٰهُ وَأَصْلِحْ لِى فِى ذُرِّيَّتِىٓ ۖ إِنِّى تُبْتُ إِلَيْكَ وَإِنِّى مِنَ ٱلْمُسْلِمِينَ",
            translation: "And We have enjoined upon man, to his parents, good treatment. His mother carried him with hardship and gave birth to him with hardship, and his gestation and weaning [period] is thirty months. [He grows] until, when he reaches maturity and reaches [the age of] forty years, he says, \"My Lord, enable me to be grateful for Your favor which You have bestowed upon me and upon my parents and to work righteousness of which You will approve and make righteous for me my offspring. Indeed, I have repented to You, and indeed, I am of the Muslims.\"",
            audioFileName: nil
        ),
        Ayah(
            id: 193,
            surahName: "Muhammad",
            surahNameArabic: "محمد",
            ayahNumber: 7,
            arabicText: "يَٰٓأَيُّهَا ٱلَّذِينَ ءَامَنُوٓا۟ إِن تَنصُرُوا۟ ٱللَّهَ يَنصُرْكُمْ وَيُثَبِّتْ أَقْدَامَكُمْ",
            translation: "O you who have believed, if you support Allah, He will support you and plant firmly your feet.",
            audioFileName: nil
        ),
        Ayah(
            id: 194,
            surahName: "Al-Fath",
            surahNameArabic: "الفتح",
            ayahNumber: 4,
            arabicText: "هُوَ ٱلَّذِىٓ أَنزَلَ ٱلسَّكِينَةَ فِى قُلُوبِ ٱلْمُؤْمِنِينَ لِيَزْدَادُوٓا۟ إِيمَٰنًۭا مَّعَ إِيمَٰنِهِمْ ۗ وَلِلَّهِ جُنُودُ ٱلسَّمَٰوَٰتِ وَٱلْأَرْضِ ۚ وَكَانَ ٱللَّهُ عَلِيمًا حَكِيمًۭا",
            translation: "It is He who sent down tranquillity into the hearts of the believers that they would increase in faith along with their [present] faith. And to Allah belong the soldiers of the heavens and the earth, and ever is Allah Knowing and Wise.",
            audioFileName: nil
        ),
        Ayah(
            id: 195,
            surahName: "Al-Fath",
            surahNameArabic: "الفتح",
            ayahNumber: 29,
            arabicText: "مُّحَمَّدٌۭ رَّسُولُ ٱللَّهِ ۚ وَٱلَّذِينَ مَعَهُۥٓ أَشِدَّآءُ عَلَى ٱلْكُفَّارِ رُحَمَآءُ بَيْنَهُمْ ۖ تَرَىٰهُمْ رُكَّعًۭا سُجَّدًۭا يَبْتَغُونَ فَضْلًۭا مِّنَ ٱللَّهِ وَرِضْوَٰنًۭا ۖ سِيمَاهُمْ فِى وُجُوهِهِم مِّنْ أَثَرِ ٱلسُّجُودِ ۚ ذَٰلِكَ مَثَلُهُمْ فِى ٱلتَّوْرَىٰةِ ۚ وَمَثَلُهُمْ فِى ٱلْإِنجِيلِ كَزَرْعٍ أَخْرَجَ شَطْـَٔهُۥ فَـَٔازَرَهُۥ فَٱسْتَغْلَظَ فَٱسْتَوَىٰ عَلَىٰ سُوقِهِۦ يُعْجِبُ ٱلزُّرَّاعَ لِيَغِيظَ بِهِمُ ٱلْكُفَّارَ ۗ وَعَدَ ٱللَّهُ ٱلَّذِينَ ءَامَنُوا۟ وَعَمِلُوا۟ ٱلصَّٰلِحَٰتِ مِنْهُم مَّغْفِرَةًۭ وَأَجْرًا عَظِيمًۢا",
            translation: "Muhammad is the Messenger of Allah; and those with him are forceful against the disbelievers, merciful among themselves. You see them bowing and prostrating [in prayer], seeking bounty from Allah and [His] pleasure. Their mark is on their faces from the trace of prostration. That is their description in the Torah. And their description in the Gospel is as a plant which produces its offshoots and strengthens them so they grow firm and stand upon their stalks, delighting the sowers - so that Allah may enrage by them the disbelievers. Allah has promised those who believe and do righteous deeds among them forgiveness and a great reward.",
            audioFileName: nil
        ),
        Ayah(
            id: 196,
            surahName: "Al-Hujurat",
            surahNameArabic: "الحجرات",
            ayahNumber: 10,
            arabicText: "إِنَّمَا ٱلْمُؤْمِنُونَ إِخْوَةٌۭ فَأَصْلِحُوا۟ بَيْنَ أَخَوَيْكُمْ ۚ وَٱتَّقُوا۟ ٱللَّهَ لَعَلَّكُمْ تُرْحَمُونَ",
            translation: "The believers are but brothers, so make settlement between your brothers. And fear Allah that you may receive mercy.",
            audioFileName: nil
        ),
        Ayah(
            id: 197,
            surahName: "Al-Hujurat",
            surahNameArabic: "الحجرات",
            ayahNumber: 12,
            arabicText: "يَٰٓأَيُّهَا ٱلَّذِينَ ءَامَنُوا۟ ٱجْتَنِبُوا۟ كَثِيرًۭا مِّنَ ٱلظَّنِّ إِنَّ بَعْضَ ٱلظَّنِّ إِثْمٌۭ ۖ وَلَا تَجَسَّسُوا۟ وَلَا يَغْتَب بَّعْضُكُم بَعْضًا ۚ أَيُحِبُّ أَحَدُكُمْ أَن يَأْكُلَ لَحْمَ أَخِيهِ مَيْتًۭا فَكَرِهْتُمُوهُ ۚ وَٱتَّقُوا۟ ٱللَّهَ ۚ إِنَّ ٱللَّهَ تَوَّابٌۭ رَّحِيمٌۭ",
            translation: "O you who have believed, avoid much [negative] assumption. Indeed, some assumption is sin. And do not spy or backbite each other. Would one of you like to eat the flesh of his brother when dead? You would detest it. And fear Allah; indeed, Allah is Accepting of repentance and Merciful.",
            audioFileName: nil
        ),
        Ayah(
            id: 198,
            surahName: "Al-Hujurat",
            surahNameArabic: "الحجرات",
            ayahNumber: 13,
            arabicText: "يَٰٓأَيُّهَا ٱلنَّاسُ إِنَّا خَلَقْنَٰكُم مِّن ذَكَرٍۢ وَأُنثَىٰ وَجَعَلْنَٰكُمْ شُعُوبًۭا وَقَبَآئِلَ لِتَعَارَفُوٓا۟ ۚ إِنَّ أَكْرَمَكُمْ عِندَ ٱللَّهِ أَتْقَىٰكُمْ ۚ إِنَّ ٱللَّهَ عَلِيمٌ خَبِيرٌۭ",
            translation: "O mankind, indeed We have created you from male and female and made you peoples and tribes that you may know one another. Indeed, the most noble of you in the sight of Allah is the most righteous of you. Indeed, Allah is Knowing and Acquainted.",
            audioFileName: nil
        ),
        Ayah(
            id: 199,
            surahName: "Qaf",
            surahNameArabic: "ق",
            ayahNumber: 16,
            arabicText: "وَلَقَدْ خَلَقْنَا ٱلْإِنسَٰنَ وَنَعْلَمُ مَا تُوَسْوِسُ بِهِۦ نَفْسُهُۥ ۖ وَنَحْنُ أَقْرَبُ إِلَيْهِ مِنْ حَبْلِ ٱلْوَرِيدِ",
            translation: "And We have already created man and know what his soul whispers to him, and We are closer to him than [his] jugular vein",
            audioFileName: nil
        ),
        Ayah(
            id: 200,
            surahName: "Qaf",
            surahNameArabic: "ق",
            ayahNumber: 39,
            arabicText: "فَٱصْبِرْ عَلَىٰ مَا يَقُولُونَ وَسَبِّحْ بِحَمْدِ رَبِّكَ قَبْلَ طُلُوعِ ٱلشَّمْسِ وَقَبْلَ ٱلْغُرُوبِ",
            translation: "So be patient, [O Muhammad], over what they say and exalt [Allah] with praise of your Lord before the rising of the sun and before its setting,",
            audioFileName: nil
        ),
    ]
}
