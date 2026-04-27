//
//  TrainingContent.swift
//  Teks terstruktur: panduan sensorik kopi (bukan salinan hak cipta).
//

import Foundation

struct TrainingContentBlock: Sendable {
    let stageIntro: String
    let lead: String
    let steps: [String]
    let reference: String
}

/// Materi per pasangan (kategori L1, tahap discovery).
enum TrainingContent {
    static func block(category: FlavorCategory, stage: DiscoveryStage) -> TrainingContentBlock {
        switch (category, stage) {
        case (.sweet, .fragrance):
            TrainingContentBlock(
                stageIntro: "Saat biji masih kering, cari karakter manis — karamel, gula aren, madu, atau toffee — sebelum air mengubah profil aromanya.",
                lead: "Manis kering umumnya hadir sebagai gula sangrai atau madu. Bedakan dari aroma roti panggang atau cokelat yang cenderung lebih gurih.",
                steps: [
                    "Hirup 2–3 kali dengan jeda. Jika hidung lelah, istirahat sejenak sebelum mencoba lagi.",
                    "Catat satu deskriptor: karamel, gula aren, vanila, atau toffee. Belum perlu menebak proses pasca-panen."
                ],
                reference: "Pada fase dry, manis sering muncul lebih awal sebelum karakter kacang atau cokelat mendominasi. (SCA Flavor Wheel)"
            )
        case (.sweet, .aroma):
            TrainingContentBlock(
                stageIntro: "Setelah bloom, uap air membawa profil manis yang lebih kompleks. Catat setiap perubahan sensasi yang muncul.",
                lead: "Uap sering menonjolkan brown sugar, vanila, atau santan ringan. Apakah manis di hidung terasa lebih 'mengembang' dibanding saat kering tadi?",
                steps: [
                    "Hirup dari tepi cangkir dahulu, tanpa mencoba menebak profil rasa di lidah.",
                    "Bandingkan: Apakah aroma terasa lebih lega, stabil, atau justru menyempit dibanding saat kering?"
                ],
                reference: "Perbedaan aroma dry vs wet adalah wajar — air membawa senyawa volatil berbeda ke hidung. (SCA)"
            )
        case (.sweet, .taste):
            TrainingContentBlock(
                stageIntro: "Manis pada kopi jarang setajam gula meja. Fokus pada rasa penuh (body) di tengah lidah, atau sisa manis setelah asam memudar.",
                lead: "Seruput keras (slurp), tahan sebentar, lalu hembuskan lewat hidung (retronasal). Cari lapisan manis yang halus — bukan gula yang menempel di permukaan.",
                steps: [
                    "Seruput sedikit, rasakan di tengah lidah, lalu hembuskan retronasal. Catat: manisnya menetap, memudar, atau tertutup pahit?",
                    "Bandingkan rasa di tengah cangkir dengan 10 detik setelah diteguk (finish)."
                ],
                reference: "Keseimbangan rasa tidak harus selalu rata. Dokumentasikan dulu, evaluasi kemudian. (SCA Cupping Protocol)"
            )

        case (.floral, .fragrance):
            TrainingContentBlock(
                stageIntro: "Aroma bunga saat fase kering cenderung halus dan berada di depan hidung, sering tertutup jika aroma sangrai lebih dominan.",
                lead: "Cari aroma melati, mawar, atau pollen. Fokus pada kesan ringan yang muncul lebih awal, bukan karakter buah yang berat.",
                steps: [
                    "Jaga jarak dari cangkir. Jangan tahan napas terlalu lama — hirup singkat, lalu jauh.",
                    "Gunakan deskriptor kiasan: melati, mawar, teh mekar, bergamot — tidak wajib menyebut varietas spesifik."
                ],
                reference: "Floral sering muncul jelas saat biji kering pada washed Arabica. Latih memisahkan floral dari fruity. (SCA)"
            )
        case (.floral, .aroma):
            TrainingContentBlock(
                stageIntro: "Setelah bloom, aroma bunga bisa lebih terbuka, namun bisa juga berubah atau meredup. Perhatikan arah perubahannya.",
                lead: "Uap membawa wangi bunga, teh, atau pollen. Coba hirup dari sisi cangkir untuk persepsi yang berbeda.",
                steps: [
                    "Catat: Apakah aroma meningkat, stabil, atau melemah setelah 30 detik? Pilih satu yang paling dominan.",
                    "Bandingkan aroma dari pusat vs sisi cangkir — posisi hidung memengaruhi persepsi."
                ],
                reference: "Penurunan suhu mengubah profil aroma — normal dalam cupping. Jangan hanya nilai saat cangkir masih terlalu panas. (SCA)"
            )
        case (.floral, .taste):
            TrainingContentBlock(
                stageIntro: "Karakter bunga di mulut biasanya terdeteksi lewat retronasal (rongga belakang hidung), bukan tekstur di depan lidah.",
                lead: "Seruput, tahan, lalu hembuskan perlahan lewat hidung. Floral muncul sebagai nuansa halus, bukan tekstur tebal.",
                steps: [
                    "Lakukan dua hembusan retronasal singkat setelah seruputan pertama.",
                    "Bandingkan: Sensasi bunga halus di belakang vs rasa asam buah di depan lidah."
                ],
                reference: "Retronasal membantu memisahkan floral yang halus di belakang dari fruity/sour yang tajam di depan. (SCA)"
            )

        case (.fruity, .fragrance):
            TrainingContentBlock(
                stageIntro: "Notes sitrus, beri, atau tropis sering muncul cepat — senyawa ester menguap lebih awal sebelum cairan terseduh penuh.",
                lead: "Sitrus atau apel muda sering muncul pertama; tropis mungkin muncul saat biji mulai hangat di tangan.",
                steps: [
                    "Bandingkan hirupan cepat vs tahan — lihat aroma mana yang lebih dulu tertangkap.",
                    "Bedakan 'kulit sitrus' (kering, tajam) dari 'daging buah' (manis, juicy) — tidak perlu menebak varietas."
                ],
                reference: "Fase dry memberi sinyal arah profil buah. Detail muncul lengkap di fase aroma & taste. (SCA)"
            )
        case (.fruity, .aroma):
            TrainingContentBlock(
                stageIntro: "Uap mendorong profil buah tampil lebih penuh. Kadang terjadi pergeseran — dari sitrus tajam menjadi jeruk yang lebih lembut.",
                lead: "Bandingkan aroma saat baru dituang vs setelah 30–50 detik. Penurunan suhu mengubah profil, dan itu wajar.",
                steps: [
                    "Hirup tiga kali dengan jeda. Jika hidung lelah, istirahat sejenak.",
                    "Bandingkan aroma dari pusat vs sisi cangkir untuk menemukan titik intensitas tertinggi."
                ],
                reference: "Pergeseran volatilitas senyawa saat suhu turun adalah normal. Catat tren, bukan satu nilai absolut. (SCA)"
            )
        case (.fruity, .taste):
            TrainingContentBlock(
                stageIntro: "Profil buah berjalan seiring asam: fruity terdeteksi via retronasal, sedangkan asam bekerja di sisi lidah.",
                lead: "Saat diseruput: depan tajam (sitrus), tengah beri, belakang tropis. Fokus pada notes yang paling jelas.",
                steps: [
                    "Seruput keras untuk menciptakan aerosol — jangan tahan napas agar lidah & retronasal bekerja bersamaan.",
                    "Bandingkan: serangan tajam di depan vs kemanisan daging buah di tengah."
                ],
                reference: "'Buah' adalah deskriptor rasa, 'asam' adalah struktur kopi. Keduanya saling melengkapi, bukan saling mengalahkan. (SCA)"
            )

        case (.sourFermented, .fragrance):
            TrainingContentBlock(
                stageIntro: "Aroma winey atau fermentasi sering tajam. Bedakan: asam segar yang menyenangkan (ceri matang, anggur) vs asam cuka yang menusuk hidung?",
                lead: "Hirup singkat. Jika menusuk, klasifikasikan: cuka dapur, atau ceri sangat matang? Catat, lalu verifikasi saat cairan di mulut.",
                steps: [
                    "Jangan hirup terus-menerus lebih dari 5 detik. Istirahatkan indera penciuman.",
                    "Bandingkan: asam pangan cerah (segar) vs asam asetat tajam (mengganggu) jika keduanya muncul bersamaan."
                ],
                reference: "Catat impresi winey terlebih dahulu. Sumber & kualitasnya lebih jelas setelah pola taste terbentuk. (SCA/WCR)"
            )
        case (.sourFermented, .aroma):
            TrainingContentBlock(
                stageIntro: "Uap panas sering mengangkat sisa aroma anggur atau fermentasi. Catat tanpa langsung menyimpulkan prosesnya.",
                lead: "Cium dari sisi lalu tengah. Jika menusuk: asam cuka (tajam, agresif) atau asam sitrus (cerah, bersih)? Yang kasar perlu dicatat, yang cerah adalah ciri khas.",
                steps: [
                    "Amati tren: Apakah aroma yang sempit melebar saat basah, atau tiba-tiba menjadi tajam?",
                    "Beri jeda, lalu hirup kembali setelah 30 detik — ketajaman sering mereda seiring suhu turun."
                ],
                reference: "Volatilitas senyawa saat uap sangat dinamis. Satu hirupan jarang cukup — ulangi dengan tenang. (SCA)"
            )
        case (.sourFermented, .taste):
            TrainingContentBlock(
                stageIntro: "Asam di mulut adalah struktur rasa. Winey berkualitas terasa panjang & bersih, tanpa rasa tidak nyaman di tenggorokan.",
                lead: "Rasakan: asam malat/sitrat (seperti apel/jeruk, mengisi sisi lidah) vs asetat (mengikat tenggorokan, agresif).",
                steps: [
                    "Fokus pada area tengah, samping, dan belakang lidah secara bergantian. Pilih satu yang paling dominan.",
                    "Bandingkan: segar & menyenangkan vs tajam & mengganggu. Catat objek, bukan keputusan."
                ],
                reference: "Asam berkualitas ≠ defek. Defek cenderung destruktif (asetat, phenolic); asam cerah adalah nilai positif. (SCA Flavor Lexicon)"
            )

        case (.greenVegetative, .fragrance):
            TrainingContentBlock(
                stageIntro: "Aroma hijau (rumput, polong, zaitun) terasa tajam di depan hidung, berbeda dengan lemak cokelat yang lebih penuh di tengah.",
                lead: "Hirup pendek: tercium sayur mentah/buncis atau cokelat gurih? Jika hijau dominan, catat sebagai hijau — jangan dipaksakan ke arah cokelat.",
                steps: [
                    "Bandingkan: serat hijau (tajam, sempit) vs gurih panggang (penuh, tengah).",
                    "Hangatkan biji sebentar di telapak tangan untuk membantu pelepasan aroma — bukan untuk mematangkan lebih jauh."
                ],
                reference: "Vegetal & roasted sering tumpang tindih. Catat keduanya; diskusi under-development baru relevan jika intensitas mengganggu. (WCR)"
            )
        case (.greenVegetative, .aroma):
            TrainingContentBlock(
                stageIntro: "Aroma rumput atau buncis pada uap sering tajam di awal lalu luntur. Jangan langsung memvonis sebagai defek.",
                lead: "Apakah aroma hijau ini tipis atau bercampur gandum panggang? Uap sering membawa buncis sekilas lalu hilang.",
                steps: [
                    "Catat tren: aroma tajam di uap ini menetap atau menurun setelah 30 detik?",
                    "Bandingkan fase kering vs basah — di mana karakter hijau pertama kali muncul?"
                ],
                reference: "Senyawa hijau yang muncul lalu luntur membentuk kurva tren. Nilai tren, bukan satu titik. (WCR Lexicon)"
            )
        case (.greenVegetative, .taste):
            TrainingContentBlock(
                stageIntro: "Notes vegetal atau herba biasanya paling jelas di suhu 50–60°C. Jangan terburu-buru mencicipi saat masih terlalu panas.",
                lead: "Saat diseruput: tengah mirip polong, belakang herbal, aftertaste 10 detik mungkin hijau tua ke langit-langit.",
                steps: [
                    "Seruputan ketiga — fokus pada aftertaste. Apakah mulut terasa bersih, halus, atau sepat?",
                    "Bandingkan: ketajaman di depan lidah vs sisa herba di belakang."
                ],
                reference: "Posisi herba & rempah di mulut berbeda. Jujur dengan deskripsi — jangan memaksakan label jika tidak terasa. (SCA)"
            )

        case (.other, .fragrance):
            TrainingContentBlock(
                stageIntro: "Jika tercium aroma kertas, lembab, atau kimiawi, catat sebagai jurnal awal sebelum menarik kesimpulan.",
                lead: "Hirup perlahan. Tandai jika ada kesan kardus, apek, karet, atau cairan pembersih. Catat intensitas & sifatnya — jangan terburu memvonis cacat.",
                steps: [
                    "Beri jeda panjang antar hirupan agar hidung tidak lelah dan penilaian tidak bias.",
                    "Beri skala gangguan 1–10 tanpa perlu memutuskan defek hanya dari hirupan awal."
                ],
                reference: "Dalam cupping, temuan ganjil dideskripsikan dulu — analisis sumber dilakukan setelah pola keseluruhan terbentuk. (SCA)"
            )
        case (.other, .aroma):
            TrainingContentBlock(
                stageIntro: "Uap dapat membawa aroma apek, tanah, atau kimiawi samar. Cium dari sisi lalu tengah untuk memetakan arahnya.",
                lead: "Bandingkan: saat baru dituang vs setelah agak mendingin. Sifat aroma sering berubah seiring suhu turun.",
                steps: [
                    "Setelah 1 menit, hirup kembali — jika aroma tajam mereda atau berpindah, catat trennya.",
                    "Catat intensitas (tajam, datar, menusuk) tanpa memaksakan tebakan sumber."
                ],
                reference: "Uap membawa senyawa yang dinamis. Satu hirupan jarang cukup untuk gambaran lengkap. (SCA)"
            )
        case (.other, .taste):
            TrainingContentBlock(
                stageIntro: "Retronasal mungkin membawa kesan kertas, tanah, atau kimiawi. Catat posisi sensasi di mulut tanpa langsung memvonis defek.",
                lead: "Teguk sedikit, hembuskan. Bedakan apakah rasa asing ada di pinggir atau tengah lidah — ini membantu membedakan intensitas.",
                steps: [
                    "Dua hembusan retronasal pendek setelah seruputan singkat.",
                    "Bandingkan: aftertaste bersih vs tercemar kesan kertas atau tanah."
                ],
                reference: "Taint sering tercampur dengan mouthfeel. Deskripsikan apa yang dirasakan — jangan terburu memberi label defek. (SCA)"
            )

        case (.roasted, .fragrance):
            TrainingContentBlock(
                stageIntro: "Fase kering: gandum panggang, roti, malt, atau asap tipis. Bedakan dari karamel murni yang lebih manis & ronde.",
                lead: "Hirup aroma biji, sereal, atau kulit roti panggang. Jika ada kesan manis, tanyakan: karamel (manis-lemak) atau hangat sangrai (kering-sereal)?",
                steps: [
                    "Bandingkan aroma 'panggang kering' saat fase ini dengan manis yang mungkin muncul di fase basah.",
                    "Catat asap tipis jika ada. Bedakan dari aroma buah atau ferment — jangan terburu memvonis defek."
                ],
                reference: "Roasted sering tumpang tindih dengan nutty/cocoa. Bedakan sereal/asap (kering) dari lemak kacang (bulat). (SCA)"
            )
        case (.roasted, .aroma):
            TrainingContentBlock(
                stageIntro: "Uap mengangkat reaksi Maillard: malt, roti, dark cocoa. Ini berbeda dengan aroma manis buah yang muncul saat cangkir masih sangat panas.",
                lead: "Hirup: hangat sereal di tengah (nyaman), atau tajam 'bakar' di hidung (agresif)? Ketajaman di tenggorokan berbeda dari ketajaman di depan hidung.",
                steps: [
                    "Bandingkan uap awal vs 40 detik kemudian — puncak aroma panggang sering bergeser.",
                    "Bandingkan cokelat sangrai vs cokelat lemak/almond (nutty) jika keduanya menonjol bersamaan."
                ],
                reference: "Profil panggang berubah saat cairan mendingin. Jangan hanya nilai saat suhu masih terlalu panas. (SCA Cupping Protocol)"
            )
        case (.roasted, .taste):
            TrainingContentBlock(
                stageIntro: "Di mulut: sereal, malt, asap ringan, atau kesan aspal. Bedakan pahit sangrai dari pahit buah atau pahit bikarbonat.",
                lead: "Seruput: tengah (malt), belakang (asap/arang), lalu cek sisa 10 detik — panggang menetap atau lenyap?",
                steps: [
                    "Tiga seruputan berurutan — fokus pada serangan (awal), tengah (body), dan aftertaste.",
                    "Bandingkan: pahit sangrai yang tahan lama vs pahit tajam yang cepat hilang."
                ],
                reference: "Pahit punya banyak sumber. Sangrai tajam sering menutupi manis — catat bentuk & posisinya, bukan hanya angka. (SCA)"
            )

        case (.spices, .fragrance):
            TrainingContentBlock(
                stageIntro: "Fase kering: lada hitam, cengkih, pala, atau kapulaga. Terasa tajam & kering di ujung hidung — berbeda dari herba hijau atau cokelat.",
                lead: "Cari rempah kering, bukan daun lebar. Bedakan ketajaman di ujung hidung dari gurih panggang di tengah.",
                steps: [
                    "Dua hirupan: cepat lalu tahan. Cengkih sering muncul di belakang hidung.",
                    "Bandingkan: rempah kering (lada, cengkih) vs jahe/akar (ada hangat basah yang berbeda)."
                ],
                reference: "Spices dry berbeda dengan spices wet. Latih memisahkan rempah dari herbal hijau & roasted. (SCA)"
            )
        case (.spices, .aroma):
            TrainingContentBlock(
                stageIntro: "Uap membawa rempah basah — cengkih, pala, atau kayu manis. Ketajaman sering sempit & bergeser seiring waktu.",
                lead: "Cium dari sisi lalu tengah. Aliran uap memindahkan fokus. Tajam di awal lalu landai, atau sebaliknya?",
                steps: [
                    "Bandingkan uap detik ke-0 vs detik ke-50 — sering ada perubahan profil.",
                    "Beri jeda antar hirupan — senyawa rempah volatil tinggi & mudah membebani indera."
                ],
                reference: "Senyawa rempah volatil tinggi. Hirup berulang dengan jeda membangun profil lebih akurat. (SCA)"
            )
        case (.spices, .taste):
            TrainingContentBlock(
                stageIntro: "Di lidah: lada, cengkih, pala. Tajam di tengah-belakang lidah — biasanya menetap halus, bukan sengatan kasar.",
                lead: "Seruput, tahan, lalu hembus retronasal. Cek: cengkih (tengah, bulat) atau lada (tajam belakang) yang dominan?",
                steps: [
                    "Dua hembusan retronasal setelah satu seruputan — bandingkan rasa tengah vs belakang.",
                    "Catat: sensasi menetap vs mereda dalam 10 detik. Ini pola durasi, bukan skor."
                ],
                reference: "Spices & roasted punya posisi aftertaste berbeda. Spices cenderung lebih belakang & lebih lama. (SCA)"
            )

        case (.nuttyCocoa, .fragrance):
            TrainingContentBlock(
                stageIntro: "Fase kering: kacang, kakao, almond, hazelnut. Aroma lemak biji sering muncul lebih awal dibanding persepsi lemak di mulut.",
                lead: "Cari kacang panggang ringan, kakao, atau biji-bijian. Bedakan dark cocoa (kering, tajam) dari lemak kacang/almond (bulat, penuh).",
                steps: [
                    "Bandingkan 'kacang kering' (nutty, sempit) vs 'biji sereal sangrai' (roasty, lebih kering).",
                    "Catat: bulat di tengah atau tajam sempit? Nutty cenderung penuh di tengah, bukan menusuk."
                ],
                reference: "Nutty/cocoa sering tumpang tindih dengan roasted. Fokus pada karakter lemak biji sebagai pembeda. (SCA)"
            )
        case (.nuttyCocoa, .aroma):
            TrainingContentBlock(
                stageIntro: "Uap membawa cokelat, hazelnut, almond. Lemak biji menjadi fokus setelah cairan tenang — bukan di puncak panas.",
                lead: "Bandingkan: kering (sempit, terbatas) vs basah (penuh, mengembang). Kapan cokelat terasa paling jelas?",
                steps: [
                    "Hirup tengah lalu sisi. Cokelat lemak dominan di tengah, bukan di bibir cangkir.",
                    "Bandingkan basah vs kering: bulat lemak vs tajam buah/ferment jika tumpang tindih."
                ],
                reference: "Lemak volatil naik saat penguapan. Catat tren, bukan hanya satu cicip. (SCA)"
            )
        case (.nuttyCocoa, .taste):
            TrainingContentBlock(
                stageIntro: "Di mulut: kacang, kakao, dark chocolate, almond. Sering dominan di tengah lalu aftertaste. Pahit cokelat berbeda dari pahit buah atau sangrai.",
                lead: "Seruput, tahan, cek tengah & belakang. Pahit cokelat halus (dark chocolate), pahit sangrai kasar, atau sisa asam buah?",
                steps: [
                    "Tiga teguk kecil — fokus tengah, belakang, dan aftertaste 10 detik. Mana yang paling penuh vs paling kering?",
                    "Bandingkan: lemak penuh di tengah (nutty/cocoa) vs seret pahit di ujung (roasted)."
                ],
                reference: "Lemak cokelat bulat di tengah berbeda dari karakter aspal/sereal yang lebih kering & belakang. (SCA Flavor Lexicon)"
            )
        }
    }
}
