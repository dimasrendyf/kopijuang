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
                stageIntro: "Saat biji masih kering, fokuslah mencari karakter manis—seperti karamel, gula aren, atau madu—sebelum air mengubah profil aromanya.",
                lead: "Manis kering umumnya hadir dengan kesan gula sangrai atau madu. Bedakan ini dari aroma roti panggang atau cokelat yang cenderung lebih gurih.",
                steps: [
                    "Hirup aroma 2–3 kali, beri jeda. Jika hidung terasa lelah, istirahat sejenak sebelum mencoba kembali.",
                    "Catat satu kata kunci: misal karamel, gula aren, atau vanila. Belum perlu menebak proses pasca-panen biji."
                ],
                reference: "Pada tahap awal (dry), kelompok rasa manis sering muncul sebelum karakter kacang atau cokelat mendominasi."
            )
        case (.sweet, .aroma):
            TrainingContentBlock(
                stageIntro: "Setelah seduhan, uap air akan membawa profil manis yang lebih kompleks. Catat setiap perubahan sensasi yang muncul.",
                lead: "Uap air sering menonjolkan notes brown sugar, vanila, atau santan ringan. Apakah rasa manis di hidung terasa lebih 'mengembang' dibandingkan saat kering tadi?",
                steps: [
                    "Hirup aroma dari tepi cangkir terlebih dahulu, tanpa mencoba menebak profil rasa di lidah.",
                    "Bandingkan: Apakah aromanya terasa lebih lega, stabil, atau justru menyempit dibandingkan saat kering?"
                ],
                reference: "Perbedaan aroma antara fase kering dan basah adalah wajar karena air membawa senyawa volatil berbeda ke hidung."
            )
        case (.sweet, .taste):
            TrainingContentBlock(
                stageIntro: "Manis pada kopi jarang bersifat tajam seperti gula meja. Fokuslah pada rasa penuh (body) di tengah lidah atau sisa rasa manis setelah asam memudar.",
                lead: "Lakukan *slurp*, tahan sebentar, lalu hembuskan lewat hidung (retronasal). Cari lapisan manis yang halus, bukan sekadar rasa gula yang menempel.",
                steps: [
                    "Seruput sedikit, rasakan di bagian tengah lidah, lalu hembuskan secara retronasal. Catat apakah manisnya menetap, memudar, atau tertutup rasa pahit.",
                    "Bandingkan: Rasa saat di tengah cangkir dengan 10 detik setelah diteguk (*finish*)."
                ],
                reference: "Keseimbangan rasa tidak harus selalu rata. Dokumentasikan temuan Anda terlebih dahulu sebelum memberikan penilaian."
            )

        case (.floral, .fragrance):
            TrainingContentBlock(
                stageIntro: "Aroma bunga saat fase kering cenderung halus dan berada di depan hidung, seringkali tertutup jika aroma *roasty* lebih dominan.",
                lead: "Cari aroma seperti melati, mawar, atau *pollen*. Fokus pada kesan tajam yang ringan, bukan karakter buah yang berat.",
                steps: [
                    "Jaga jarak aman dari cangkir. Jangan menahan napas terlalu lama di atas cangkir.",
                    "Gunakan deskripsi kiasan jika perlu: melati, mawar, atau 'teh mekar'—tidak wajib menggunakan nama varietas spesifik."
                ],
                reference: "Gugus bunga sering muncul jelas saat biji kering. Latih diri untuk memisahkan karakter floral dari notes buah."
            )
        case (.floral, .aroma):
            TrainingContentBlock(
                stageIntro: "Setelah *bloom*, aroma bunga seringkali lebih terekspos, namun bisa juga berubah atau meredup. Perhatikan arah perubahannya.",
                lead: "Uap air membawa wangi bunga, teh, atau serbuk sari. Coba hirup dari sisi cangkir untuk mendapatkan persepsi yang berbeda.",
                steps: [
                    "Catat perubahannya: Apakah aromanya meningkat, stabil, atau melemah setelah 30 detik? Pilih satu yang paling dominan.",
                    "Bandingkan aroma dari pusat cangkir dan sisi cangkir agar persepsi retronasal tidak bias oleh posisi."
                ],
                reference: "Penurunan suhu cairan akan mengubah profil aroma; ini adalah hal normal dalam proses cupping."
            )
        case (.floral, .taste):
            TrainingContentBlock(
                stageIntro: "Karakter bunga di mulut biasanya terdeteksi lewat *retronasal* (rongga belakang), bukan melalui tekstur di depan lidah.",
                lead: "Seruput, tahan, dan hembuskan perlahan. Bunga seringkali muncul sebagai nuansa halus, bukan tekstur yang tebal.",
                steps: [
                    "Lakukan dua hembusan *retronasal* singkat setelah seruputan pertama.",
                    "Bandingkan: Sensasi bunga yang lembut di belakang dengan rasa asam buah di depan lidah."
                ],
                reference: "Teknik *retronasal* membantu memisahkan karakter bunga yang halus di belakang dengan rasa tajam buah di depan."
            )

        case (.fruity, .fragrance):
            TrainingContentBlock(
                stageIntro: "Notes sitrus, beri, atau tropis sering muncul cepat, mirip ester yang menguap sebelum cairan terseduh penuh.",
                lead: "Hirup dari jarak yang cukup. Sitrus atau apel muda sering muncul lebih awal, sementara karakter tropis mungkin muncul saat cangkir mulai hangat.",
                steps: [
                    "Bandingkan: Hirupan cepat vs tahan, untuk melihat aroma mana yang lebih dulu tertangkap.",
                    "Bedakan antara 'kulit sitrus' dengan 'daging buah'—tidak perlu menebak varietas spesifik saat ini."
                ],
                reference: "Sinyal pada fase kering membantu menentukan arah profil, bukan laporan lengkap dari kebun kopi."
            )
        case (.fruity, .aroma):
            TrainingContentBlock(
                stageIntro: "Uap air mendorong profil buah tampil lebih penuh. Kadang terjadi pergeseran, misalnya dari sitrus tajam menjadi jeruk yang lebih lembut.",
                lead: "Bandingkan aroma saat baru dituang dengan setelah 30–50 detik. Suhu turun akan mengubah profil, dan itu wajar.",
                steps: [
                    "Hirup tiga kali dengan jeda. Jika hidung lelah, berhentilah sejenak.",
                    "Bandingkan aroma pusat cangkir vs samping untuk mencari titik intensitas tertinggi."
                ],
                reference: "Suhu yang turun menyebabkan pergeseran volatilitas senyawa. Cukup catat perjalanannya, tidak perlu mencari satu nilai absolut."
            )
        case (.fruity, .taste):
            TrainingContentBlock(
                stageIntro: "Profil buah sering berjalan seiring dengan asam: buah terdeteksi lewat *retronasal*, sedangkan asam bekerja di sisi lidah.",
                lead: "Saat diseruput: depan terasa tajam (sitrus), tengah beri, dan belakang tropis. Fokuslah pada notes yang paling jelas.",
                steps: [
                    "Lakukan *slurp* yang rapi untuk menciptakan aerosol; jangan menahan napas agar lidah dan hidung belakang saling bekerja.",
                    "Bandingkan: Serangan rasa tajam di depan vs kemanisan daging buah di tengah."
                ],
                reference: "Anggap 'buah' sebagai deskriptor rasa, dan 'asam' sebagai struktur jaringan kopi. Keduanya saling melengkapi."
            )

        case (.sourFermented, .fragrance):
            TrainingContentBlock(
                stageIntro: "Aroma *winey* atau fermentasi sering tajam. Bedakan: apakah ini asam segar yang menyenangkan, atau asam cuka yang menusuk tenggorokan?",
                lead: "Hirup singkat. Jika terasa menusuk, klasifikasikan: apakah seperti cuka dapur, atau seperti ceri yang sangat matang? Catat, lalu verifikasi saat cairan di mulut.",
                steps: [
                    "Jangan hirup terus-menerus selama 10 detik. Istirahatkan indra penciuman Anda.",
                    "Bandingkan: Asam pangan yang segar vs asam cuka yang tajam jika keduanya muncul bersamaan."
                ],
                reference: "Catat impresi *winey* terlebih dahulu. Sumbernya akan lebih jelas didiskusikan setelah pola rasa keseluruhan terbentuk."
            )
        case (.sourFermented, .aroma):
            TrainingContentBlock(
                stageIntro: "Uap panas sering mengangkat sisa aroma anggur atau fermentasi. Catat sensasinya tanpa langsung membuat kesimpulan mengenai proses.",
                lead: "Cium dari sisi lalu tengah. Jika terasa menusuk, bedakan: apakah itu asam cuka atau asam sitrun yang tajam? Yang kasar perlu diwaspadai, yang cerah adalah ciri khas.",
                steps: [
                    "Amati tren: Apakah aroma yang tadinya sempit melebar saat basah, atau tiba-tiba menjadi tajam?",
                    "Beri jeda, lalu hirup kembali setelah 30 detik—seringkali ketajaman akan mereda."
                ],
                reference: "Volatilitas senyawa saat uap air sangat dinamis; ulangi proses hirup dengan tenang."
            )
        case (.sourFermented, .taste):
            TrainingContentBlock(
                stageIntro: "Asam di mulut adalah struktur rasa. Fermentasi atau *winey* yang baik seharusnya panjang, tanpa meninggalkan rasa tidak nyaman di tenggorokan.",
                lead: "Rasakan: asam alami (seperti apel/jeruk) vs asetat yang mengikat tenggorokan. Asam asetat cenderung menusuk, asam alami lebih mengisi sisi lidah.",
                steps: [
                    "Fokus pada area tengah, samping, dan belakang lidah. Pilih satu yang paling dominan.",
                    "Bandingkan: Segar yang menyenangkan vs tajam yang mengganggu. Evaluasi ulang jika rasa tajamnya tidak wajar."
                ],
                reference: "Asam yang berkualitas berbeda dengan defek; defek cenderung tajam destruktif, bukan tajam ceria."
            )

        case (.greenVegetative, .fragrance):
            TrainingContentBlock(
                stageIntro: "Aroma hijau (rumput, polong, zaitun) terasa tajam di depan, berbeda dengan lemak cokelat yang lebih penuh di tengah.",
                lead: "Hirup pendek: apakah tercium sayur mentah/buncis atau tumpukan cokelat? Jika hijau dominan, akui sebagai hijau, jangan dipaksakan ke arah cokelat.",
                steps: [
                    "Bandingkan: Karakter serat hijau vs gurih panggang.",
                    "Boleh hangatkan biji sebentar di tangan untuk membantu pelepasan aroma, bukan untuk menyangrai lebih jauh."
                ],
                reference: "Vegetal dan panggang seringkali tumpang tindih. Cukup catat; bahasan mengenai *underdevelopment* baru dilakukan jika rasa tajamnya mengganggu."
            )
        case (.greenVegetative, .aroma):
            TrainingContentBlock(
                stageIntro: "Aroma rumput atau buncis pada uap air seringkali tajam di awal lalu luntur. Jangan langsung memvonisnya sebagai defek.",
                lead: "Perhatikan: Apakah aroma hijau ini sangat tipis atau bercampur dengan bau gandum panggang? Uap sering membawa buncis yang muncul sekilas lalu hilang.",
                steps: [
                    "Catat tren: Apakah aroma tajam di uap ini menetap atau menurun?",
                    "Bandingkan aroma fase kering vs basah untuk melihat di mana karakter tajam pertama kali muncul."
                ],
                reference: "Senyawa hijau yang muncul lalu luntur membentuk kurva tren, bukan sekadar nilai angka."
            )
        case (.greenVegetative, .taste):
            TrainingContentBlock(
                stageIntro: "Notes sayur atau herba sering tercerna dengan baik pada suhu 50–60°C. Jangan terlalu terburu-buru saat mencicipi.",
                lead: "Saat diseruput: tengah mirip polong, belakang herbal, sisa rasa 10 detik mungkin hijau tua ke langit-langit. Perhatikan posisi rasa di mulut.",
                steps: [
                    "Lakukan seruputan ketiga, fokus pada *aftertaste*. Apakah mulut terasa bersih, halus, atau sepat?",
                    "Bandingkan: Ketajaman di depan vs sisa herba di belakang."
                ],
                reference: "Posisi *herb* dan rempah di mulut berbeda. Jujurlah dengan deskripsi, jangan memaksakan label jika tidak ada."
            )

        case (.other, .fragrance):
            TrainingContentBlock(
                stageIntro: "Jika tercium aroma kertas, lembab, atau kimia, catat sebagai jurnal awal sebelum menarik kesimpulan.",
                lead: "Hirup perlahan. Tandai jika ada kesan kardus, lembab, karet, atau cairan pembersih. Cukup catat intensitas dan sifatnya, jangan terburu-buru memvonis cacat.",
                steps: [
                    "Beri jeda panjang antar hirupan agar hidung tidak kelelahan dan memberikan penilaian bias.",
                    "Boleh beri skala gangguan 1-10, tanpa perlu memutuskan defek hanya dari hirupan awal."
                ],
                reference: "Dalam pengecapan, temuan yang ganjil dideskripsikan terlebih dahulu; analisis sumber dilakukan setelah pola jelas."
            )
        case (.other, .aroma):
            TrainingContentBlock(
                stageIntro: "Uap air dapat membawa aroma apek, tanah, atau kimia samar. Cium dari samping lalu tengah untuk memetakan arah aroma.",
                lead: "Bandingkan: Saat baru dituang vs setelah agak mendingin. Sifat aroma sering berubah seiring penurunan suhu.",
                steps: [
                    "Setelah 1 menit, hirup kembali: jika aroma tajam mereda atau berpindah, catat trennya.",
                    "Catat intensitas (tajam, datar, atau menusuk) tanpa perlu memaksakan tebakan sumber."
                ],
                reference: "Uap membawa senyawa yang dinamis; satu kali hirup jarang cukup untuk mendapatkan gambaran lengkap."
            )
        case (.other, .taste):
            TrainingContentBlock(
                stageIntro: "Sensasi retronasal mungkin membawa kesan kertas, tanah, atau kimia. Catat posisi sensasi di mulut tanpa langsung memvonis defek.",
                lead: "Teguk sedikit, hembuskan. Bedakan apakah sisa rasa asing di pinggir lidah atau tengah—ini membantu membedakan kasar/halus.",
                steps: [
                    "Lakukan dua hembusan retronasal pendek setelah seruputan singkat.",
                    "Bandingkan: *Aftertaste* yang bersih vs yang tercemar kesan kertas atau tanah."
                ],
                reference: "Seringkali kesan *taint* tercampur dengan *mouthfeel*. Deskripsikan apa yang dirasakan, jangan terburu memberikan label."
            )

        case (.roasted, .fragrance):
            TrainingContentBlock(
                stageIntro: "Fase kering: gandum panggang, roti, malt, atau asap tipis. Bedakan ini dengan karakter karamel murni.",
                lead: "Hirup aroma biji, sereal, atau kulit roti. Jika muncul rasa manis, tanyakan: apakah manis karamel, atau hanya rasa hangat sangrai?",
                steps: [
                    "Bandingkan 'panggang biji' dengan rasa manis yang mungkin muncul di fase basah.",
                    "Catat jika ada asap tipis. Jika menusuk, bedakan dengan aroma buah atau ferment; jangan terburu-buru menuduh defek."
                ],
                reference: "Karakter sangrai sering tumpang tindih dengan kacang atau cokelat. Bedakan antara sereal/aspal dengan lemak kacang."
            )
        case (.roasted, .aroma):
            TrainingContentBlock(
                stageIntro: "Uap mengangkat aroma reaksi Maillard: malt, roti, cokelat sangrai. Ini berbeda dengan aroma manis buah saat kopi masih panas.",
                lead: "Hirup: Apakah hangat sereal di tengah, atau tajam 'bakar' di hidung? Ketajaman tenggorokan berbeda dengan tajam di depan.",
                steps: [
                    "Bandingkan awal uap vs 40 detik kemudian; puncak aroma panggang sering bergeser.",
                    "Bandingkan: Cokelat sangrai dengan cokelat lemak atau almond (*nut*) jika keduanya menonjol."
                ],
                reference: "Saat cairan mendingin, profil panggang akan berubah. Jangan menilai hanya pada saat suhu masih terlalu panas."
            )
        case (.roasted, .taste):
            TrainingContentBlock(
                stageIntro: "Di mulut: sereal, malt, asap ringan, atau aspal. Bedakan pahit sangrai dengan pahit buah atau pahit bikarbonat.",
                lead: "Seruput: tengah (malt) vs belakang (asap) vs tengah (pahit). Perhatikan sisa rasa 10 detik: panggang menetap atau lenyap?",
                steps: [
                    "Lakukan tiga seruputan berurutan: fokus pada bentuk rasa, tengah, dan sisa.",
                    "Bandingkan: Pahit tengah yang tajam vs cokelat panggang yang tahan lama."
                ],
                reference: "Pahit memiliki banyak sumber. Sangrai tajam sering menutupi rasa manis; catat bentuk rasanya, bukan sekadar angka."
            )

        case (.spices, .fragrance):
            TrainingContentBlock(
                stageIntro: "Fase kering: lada, cengkih, pala. Terasa tajam di ujung hidung, berbeda dengan herba rimbun (hijau) atau cokelat.",
                lead: "Hirup: Rempah tajam, bukan daun lebar. Bedakan ketajaman di ujung hidung dengan gurih panggang di tengah.",
                steps: [
                    "Dua hirupan: cepat lalu tahan. Cengkih sering muncul di belakang.",
                    "Bandingkan: Rempah kering vs jahe atau akar (tajamnya berbeda)."
                ],
                reference: "Aroma rempah saat kering akan berbeda dengan saat uap. Latih diri memisahkan rempah dari herbal hijau."
            )
        case (.spices, .aroma):
            TrainingContentBlock(
                stageIntro: "Uap: rempah basah, cengkih, pala. Ketajaman seringkali sempit dan bergeser seiring waktu.",
                lead: "Cium sisi lalu tengah. Aliran uap memindahkan fokus. Catat: Apakah tajam di awal lalu landai, atau sebaliknya?",
                steps: [
                    "Bandingkan: Uap detik ke-0 vs detik ke-50—seringkali ada perubahan.",
                    "Beri jeda antar hirupan agar indra tidak lelah."
                ],
                reference: "Senyawa rempah memiliki volatilitas tinggi. Proses hirup yang berulang membantu membangun profil aroma."
            )
        case (.spices, .taste):
            TrainingContentBlock(
                stageIntro: "Lidah: lada, cengkih. Tajam di tengah-belakang lidah, seringkali menetap lalu menyisakan rasa rempah halus, bukan sengatan kasar.",
                lead: "Seruput, tahan, hembus retronasal. Cek: apakah cengkih (tengah) atau lada (tajam belakang) yang dominan?",
                steps: [
                    "Dua hembusan retronasal setelah satu seruputan, bandingkan rasa tengah vs belakang.",
                    "Catat: Sensasi yang menetap vs mereda dalam 10 detik. Ini adalah pola, bukan skor."
                ],
                reference: "Rempah vs pahit sangrai memiliki posisi *aftertaste* yang berbeda. Keduanya layak dideskripsikan."
            )

        case (.nuttyCocoa, .fragrance):
            TrainingContentBlock(
                stageIntro: "Fase kering: kacang, biji, kakao, almond. Aroma sering muncul lebih awal dibandingkan persepsi lemak di mulut.",
                lead: "Hirup: Kacang panggang ringan, kakao, biji. Bedakan cokelat sangrai (panggang) dengan lemak kacang atau almond (nut).",
                steps: [
                    "Bandingkan 'kacang kering' dengan 'biji sereal sangrai' (lebih ke arah sangrai).",
                    "Catat: Apakah bulat di tengah atau tajam sempit? Kacang cenderung penuh di tengah, bukan menusuk."
                ],
                reference: "Kacang dan cokelat sering tumpang tindih dengan sangrai. Fokuslah pada lemak biji."
            )
        case (.nuttyCocoa, .aroma):
            TrainingContentBlock(
                stageIntro: "Uap: cokelat, hazelnut, almond. Seringkali muncul di tengah, setelah cairan tenang, lemak biji menjadi fokus.",
                lead: "Bandingkan: Kering (sempit) vs basah (penuh). Kapan cokelat terasa paling jelas?",
                steps: [
                    "Hirup tengah lalu sisi. Cokelat lemak seringkali dominan di tengah, bukan hanya di bibir cangkir.",
                    "Bandingkan basah vs kering: bulat lemak vs tajam buah atau ferment jika tumpang tindih."
                ],
                reference: "Lemak volatil naik saat penguapan; catat tren perubahannya, bukan hanya sekali cicip."
            )
        case (.nuttyCocoa, .taste):
            TrainingContentBlock(
                stageIntro: "Di mulut: kacang, kakao, cokelat, almond. Sering muncul di tengah lalu sisa. Pahit cokelat berbeda dengan pahit buah atau sangrai.",
                lead: "Seruput, tahan, cek tengah dan belakang. Tanya: apakah pahit cokelat halus, pahit sangrai kasar, atau sisa asam buah?",
                steps: [
                    "Tiga teguk kecil, fokus tengah, belakang, dan sisa 10 detik. Catat mana yang paling penuh vs paling kering.",
                    "Bandingkan: Penuh lemak di tengah vs seret pahit di ujung."
                ],
                reference: "Lemak cokelat yang bulat di tengah berbeda dengan karakter aspal atau sereal."
            )
        }
    }
}
