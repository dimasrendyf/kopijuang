//
//  TrainingContent.swift
//  Teks terstruktur: parafase prinsip pengecapan (SCA) & kosakata sensorik (WCR), bukan salinan utuh.
//

import Foundation

struct TrainingContentBlock: Sendable {
    let stageIntro: String
    let lead: String
    let steps: [String]
    let reference: String
}

/// Materi per pasangan (kategori L1, tahap discovery). Ringkas; tidak menyalin peta resmi 1:1.
enum TrainingContent {
    static func block(category: FlavorCategory, stage: DiscoveryStage) -> TrainingContentBlock {
        switch (category, stage) {
        case (.sweet, .fragrance):
            TrainingContentBlock(
                stageIntro: "Rujuk aroma kering: cari sinyal gula, karamel, madu sebelum cairan.",
                lead: "Di fase kering, manis tercium sebagai gula, sirop ringan, atau karamel. Bedakan dari cokelat sangrai murni.",
                steps: [
                    "Cium bubuk/beans kering 2–3 kali, jeda biar reseptor reset.",
                    "Tulis satu kata: karamel, gula panggang, atau vanila—tanpa menebak proses biji dulu."
                ],
                reference: "Praktik pengecapan: cium dry sebelum rasa; kelompok manis sering terpisah dari nut/cocoa saat memungkinkan."
            )
        case (.sweet, .aroma):
            TrainingContentBlock(
                stageIntro: "Setelah air, manis penguapan sering tajam; bandingkan dengan fase kering.",
                lead: "Wet: madu, vanila, karamel, brown sugar. Catat apakah manis tampil lebih lebar dari dry.",
                steps: [
                    "Cium di atas cangkir (uap) tanpa menilai penuh di lidah dulu.",
                    "Banding satu kunci: dry tipis vs wet yang menggembang."
                ],
                reference: "Pembedaan dry/wet: latihan naris standar; penguapan panas menonjolkan gula panggang / sirop."
            )
        case (.sweet, .taste):
            TrainingContentBlock(
                stageIntro: "Di mulut, manis = bulat, finish, bukan gula tabel; gunakan retronasal.",
                lead: "Slurry menyebar: perhatikan penuh di tengah, aftertaste manis tipis, sering setelah asam depan.",
                steps: [
                    "Slurp, tahan, hembus retronasal; catat sisa manis di langit-langit.",
                    "Banding: manis yang bertahan vs yang tertutup pahit."
                ],
                reference: "Keseimbangan rasa: dokumentasi dulu, skor kemudian—selaras leksikon sensorik umum."
            )

        case (.floral, .fragrance):
            TrainingContentBlock(
                stageIntro: "Dry: kelopak, serbuk sari, teh floral; hindari sisa wewangian pribadi.",
                lead: "Aroma bunga sering tajam dan tipis di depan; mudah tersapu bila gandum sangrai dominan.",
                steps: [
                    "Cium tipis, jaga jarak jika cangkir panas.",
                    "Cari analogi: melati, mawar, elderflower, tanpa wajib nama botani."
                ],
                reference: "Kelompok floral terpisah dari buah: latihan kering membantu membedakan volatil tipis."
            )
        case (.floral, .aroma):
            TrainingContentBlock(
                stageIntro: "Bloom: floral sering naik lalu mengecil; catat arah perubahan.",
                lead: "Uap: bunga muda, serbuk, teh yang floral; cek sisi samping cangkir.",
                steps: [
                    "Tulis: naik, sama, atau surut setelah ±30 dtk.",
                    "Banding cium tengah cangkir vs sisi, aliran uap beda sering muncul."
                ],
                reference: "Suhu dan waktu mengubah volatil aromatik: normal bila puncak lalu rontok."
            )
        case (.floral, .taste):
            TrainingContentBlock(
                stageIntro: "Lidah: floral dominan retronasal, bukan sisa garam/manis saja.",
                lead: "Setelah teguk, hembus dari hidung belakang: ‘bunga’ muncul sebagai nuansa, bukan tekstur kasar di lidah.",
                steps: [
                    "Slurp kecil, lalu 2 sengatan napas retronasal singkat.",
                    "Satu kata: finish floral vs asam buah di depan."
                ],
                reference: "Retronasal membawa aroma melalui faring; bantu membedah floral vs fruity."
            )

        case (.fruity, .fragrance):
            TrainingContentBlock(
                stageIntro: "Dry: sitrus, berry, tropis sering tajam (ester) sebelum cairan.",
                lead: "Cium jarak sedang: sitrun/apel sering paling dulu, tropis bisa mengikut setelah pemanasan ringan di telapak.",
                steps: [
                    "Dua cium: cepat vs tahan—lihat sinyal mana yang ditarik dulu.",
                    "Catat: kulit sitrus vs daging buah, tanpa wajib varietas."
                ],
                reference: "Segar/ester di dry acuan varietas & proses; cukup catat keberadaan."
            )
        case (.fruity, .aroma):
            TrainingContentBlock(
                stageIntro: "Wet: buah sering lebih jelas, kadang pindah ke sitrus/berry setelah uap naik.",
                lead: "Setelah air, ester cenderung muncul; banding sebelum/ sesudah cairan turun sekitar 50°C bila sempat.",
                steps: [
                    "Cium tiga kali berjeda, catat puncak tajam terakhir sebelum naris lelah (fatigue).",
                    "Banding: uap tengah vs sisi setelah 1 menit."
                ],
                reference: "Suhu cairan memengaruhi profil uap: selaras pengecapan piala, bukan nilai abadi."
            )
        case (.fruity, .taste):
            TrainingContentBlock(
                stageIntro: "Lidah: asam seger + buah sering sejalan; retronasal buah setelah asam depan.",
                lead: "Sip: sitrus depan, berry tengah, tropis sisi belakang—beda sisi, bukan lomba nama.",
                steps: [
                    "Slurp keras sekali; aerosol penuh membantu lidah+hidung belakang.",
                    "Banding: depan tajam vs tengah gula buah."
                ],
                reference: "Buah = deskripsi rasa; asam = struktur—keduanya dipetakan tapi perannya beda."
            )

        case (.sourFermented, .fragrance):
            TrainingContentBlock(
                stageIntro: "Dry: asam volatile ringan, winey, buah terferment; bedakan dari cuka pekat dulu.",
                lead: "Cium singkat: cuka tipis, anggur muda, buah setengah ferment—catat tajam di hidung vs rapi di lidah nanti.",
                steps: [
                    "Hindari menahan cium lama: reset napas antar sniff.",
                    "Banding: asam pangan segar vs asam cuka ‘menusuk’."
                ],
                reference: "Winey/ferment: kelompok tersendiri; dokumentasi dulu, diagnosis proses nanti."
            )
        case (.sourFermented, .aroma):
            TrainingContentBlock(
                stageIntro: "Wet: penguapan naik; winey atau alkohol muda kadang muncul.",
                lead: "Uap panas: cek tajam yang menusuk tenggorok vs tajam segar buah. Yang pertama hati-hati defect asetat, yang kedua ciri ferment/karakter.",
                steps: [
                    "Cium dari sisi, lalu tengah, beda sirkulasi uap.",
                    "Catat: kontras dry (tipis) vs wet (lebar/alkohol) bila muncul."
                ],
                reference: "Banyak senyawa volatil baru saat basah; jangan memvonis per sniff tunggal."
            )
        case (.sourFermented, .taste):
            TrainingContentBlock(
                stageIntro: "Mulut: asam = struktur; ferment = panjang, winey, tanpa sengat tenggorok.",
                lead: "Sip: rasa asam alami (malat/sitrat) vs asetat; sirkulasikan, lalu cek sisa 5 dtk setelah teguk.",
                steps: [
                    "Tengah lidah dulu, baru belakang; tulis cukup satu sisi bila bingung.",
                    "Banding: segar vs cuka; yang menyengat tajam cenderung jebakan defect."
                ],
                reference: "Praktik pengecapan: acidity positif; defect asetat beda ciri bila tajam hancurkan rasa."
            )

        case (.greenVegetative, .fragrance):
            TrainingContentBlock(
                stageIntro: "Dry: polong, rumput, zaitun muda, herba; sering tajam di depan.",
                lead: "Cium pendek: sayuran mentah, daun, snap pea; jangan paksakan cokelat bila sinyal hijau jelas.",
                steps: [
                    "Banding: serat ‘hijau’ vs lemak ‘biji’.",
                    "Bila tersedia, panas ringan di tangan biji hati-hati—opsional, bukan wajib."
                ],
                reference: "Vegetal vs nut: beda cincin; underdeveloped kadang tumpang, catat saja bila bingung."
            )
        case (.greenVegetative, .aroma):
            TrainingContentBlock(
                stageIntro: "Wet: rumput, zaitun, kacang polong; sering tajam tapi sempit.",
                lead: "Penguapan: cek ‘hijau muda’ vs gandum sangrai; gelegas kadang memunculkan herba lalu rontok.",
                steps: [
                    "Catat puncak uap: muncul awal lalu hilang cepat atau tidak.",
                    "Banding wet vs kering, mana yang tajam lebih dulu."
                ],
                reference: "Senyawa ‘hijau’ sering puncak awal, surut—bentuk kurva itu yang berguna didokumentasikan."
            )
        case (.greenVegetative, .taste):
            TrainingContentBlock(
                stageIntro: "Lidah: vegetal, zaitun, retronasal herba; suhu netral ~50–60°C sering membeda rasa sisi pahit.",
                lead: "Sip: tengah (polong) vs belakang (herba, celery); sisa 10 dtk: hijau tua vs segar muda beda sisi pahit.",
                steps: [
                    "Slurp ketiga lebih kecil untuk sisa mouthfeel/finish.",
                    "Banding: brightness depan vs vegetal belakang, tanpa lomba skor."
                ],
                reference: "Retronasal herba tumpang rasa: pisahkan dari rempah tengah bila tercium tajam tersendiri."
            )

        case (.other, .fragrance):
            TrainingContentBlock(
                stageIntro: "Dry: kertas, bumi, lembab, kimia lemah—dokumentasi, bukan cap buruk dulu.",
                lead: "Cium tipis: karton, kertas giling, bau lembab ruang, bukan cokelat/buah/bunga. Yang tidak nempel ciri umum, sementara tampung di sini.",
                steps: [
                    "Jeda panjang antar cium; lelah hidung menyerupai taint bila terburu-buru.",
                    "Tulis intensitas 1–10 bila mau, tanpa menebak sumber fasilitas."
                ],
                reference: "Taint ringan: beda tajam vs landai; pengecapan fokus deskriptif, bukan gugatan."
            )
        case (.other, .aroma):
            TrainingContentBlock(
                stageIntro: "Wet: uap bawa lembab, kardus basah, bumi, kimia ringan; catat mengganggu vs hampir netral.",
                lead: "Banding: ‘damp’ naik atau tajam kimia/lem plastik tipis. Satu sisi cukup bila pusing.",
                steps: [
                    "Cium sisi lalu tengah, beda sirkulasi uap di ceruk cangkir.",
                    "Setelah 1 menit, cek apakah tajam tenggelam—bentuk tren penting, bukan nilai tunggal."
                ],
                reference: "Aroma taint/asing: cukup catat; menebak sumber fasilitas bukan tujuan latihan awal."
            )
        case (.other, .taste):
            TrainingContentBlock(
                stageIntro: "Lidah: retronasal asing, kertas, bumi, kimia; sisa tajam vs datar.",
                lead: "Sip: beda sisa ‘asing’ (pinggir) vs tengah. Catat sisa, bukan solusi blend.",
                steps: [
                    "Slurp kecil, lalu 2x hembusan retronasal singkat.",
                    "Banding: aftertaste bersih vs dempul kertas bila tercium."
                ],
                reference: "Mouthfeel + retronasal: pengalaman taint sering tercampur, tidak wajib masuk papan satu label."
            )

        case (.roasted, .fragrance):
            TrainingContentBlock(
                stageIntro: "Dry: malt, sereal, gandum sangrai; asap tipis; beda cokelat panggang vs karamel murni.",
                lead: "Cium: biji panggang, roti, cokelat panggang ringan—bukan gula tajam murni.",
                steps: [
                    "Banding: ‘panggang biji’ vs nanti manis cair bila muncul di wet.",
                    "Catat: asap tipis; bila aspek sangrai tajam, bedakan dari tumpukan buah/ferment."
                ],
                reference: "Roasted vs nut/cocoa sering tumpang; pilah sereal/aspal vs biji/almond/cokelat lemak."
            )
        case (.roasted, .aroma):
            TrainingContentBlock(
                stageIntro: "Uap: reaksi Maillard, malt, cokelat panggang; banding tajam vs manis cair uap buah.",
                lead: "Cek: ‘bakar’ tajam di hidung, atau hangat tengah sereal. Tajam tenggorok vs tajam depan wajar—catat sisi, bukan label defect sekali cium.",
                steps: [
                    "Banding awal uap vs setelah 40 dtk, puncak panggang sering pindah.",
                    "Banding: cokelat panggang vs cokelat lemak/almond (nut)."
                ],
                reference: "Suhu cairan turun: profil panggang berubah; jangan memvonis hanya saat panas."
            )
        case (.roasted, .taste):
            TrainingContentBlock(
                stageIntro: "Mulut: cita panggang, sereal, aspal, asap ringan; beda pahit sangrai vs pahit buah/alkali.",
                lead: "Sip: tengah (malt) vs belakang (asap tipis) vs tengah pahit. Aftertaste: panggang tahan vs pudar bantu mencerahkan.",
                steps: [
                    "Tiga slurp: pertama struktur, kedua tengah, ketiga sisa 10 dtk setelah teguk.",
                    "Banding: pahit tengah tajam vs cokelat tengah tahan; tulis cukup satu sisi tumpang."
                ],
                reference: "Pahit: banyak sumber; sangrai tajam tumpang manis—fokus pada bentuk, bukan angka ajaib."
            )

        case (.spices, .fragrance):
            TrainingContentBlock(
                stageIntro: "Dry: lada, cengkih, pala, bumbu kering; sering tajam sempit di ujung hidung.",
                lead: "Cium: rempah tajam, bukan herba rimbun (hijau) dan bukan cokelat tumpuk (kakao) saja—beda tajam ujung vs belakang lemak.",
                steps: [
                    "Dua cium: cepat (depan) vs panjang (cengkih di belakang) bila muncul.",
                    "Banding: bumbu kering vs jahe/akar (beda tajam)."
                ],
                reference: "Rempah vs herbal: beda tajam; leksikon umum memisah rempah kering/ panas bila memungkinkan."
            )
        case (.spices, .aroma):
            TrainingContentBlock(
                stageIntro: "Wet: rempah basah, cengkih, pala; uap sering mendorong tajam sempit tengah waktu.",
                lead: "Penguapan panas: cengkih, pala, lada—beda cengkih depan vs hangat tengah, catat tren naik-turun.",
                steps: [
                    "Cium sisi, lalu tengah; sirkulasi uap memindahkan fokus retronasal ke ceruk cangkir.",
                    "Banding: uap minit 0 vs setelah 50 dtk, sering tajam rempah landai lalu tajam lagi."
                ],
                reference: "Uap panas memunculkan bumbu volatil; waktu cium penting, bukan sekali cicip."
            )
        case (.spices, .taste):
            TrainingContentBlock(
                stageIntro: "Lidah: lada, cengkih, tajam belakang; beda tengah retronasal vs belakang panjang pedas rempah.",
                lead: "Sip: rempah di tengah-belakang, sering tahan lalu sisa pedas halus, bukan sengat tenggorok.",
                steps: [
                    "Slurp, tahan, 2x hembusan retronasal; banding cengkih vs lada bila keduanya muncul.",
                    "Banding: sensasi tahan lalu pudar di 10 dtk; catat tren, bukan nilai sempurna."
                ],
                reference: "Rempah vs pahit sangrai: posisi sisa dan tajam beda; dokumentasi membantu nanti."
            )

        case (.nuttyCocoa, .fragrance):
            TrainingContentBlock(
                stageIntro: "Dry: kacang, biji, bubuk cokelat, almond—tanpa cairan penuh kesan ‘lemak’ biji mungkin muncul dulu lewat aroma.",
                lead: "Cium: kacang panggang ringan, kakao, biji, tanpa wajib kopi cair dulu. Bedakan dari cokelat panggang (roasted) vs lemak/almond.",
                steps: [
                    "Banding: ‘kacang kering’ vs ‘biji sangrai sereal’ (sering cenderung roasted, bukan nut).",
                    "Catat: bulat tajam vs tajam sempit; nut/cocoa cenderung bulat tengah."
                ],
                reference: "Nut/cocoa vs roasted: tumpang umum; peta latihan fokus kacang/lemak vs sereal/aspal."
            )
        case (.nuttyCocoa, .aroma):
            TrainingContentBlock(
                stageIntro: "Wet: cokelat, hazelnut, almond, sering mid-body aromatik; uap bantu ‘lemak’ kacang naik.",
                lead: "Uap: cokelat, susu kacang, almond—banding dry sempit vs wet yang lebih bulat, mid cenderung muncul setelah cairan stabil.",
                steps: [
                    "Cium tengah, lalu sisi; cokelat lemak sering tengah cangkir.",
                    "Banding: wet vs dry; bulat lemak vs sinyal buah/ferment yang mungkin tumpang."
                ],
                reference: "Lemak volatil naik saat penguapan: nut/cocoa sering puncak lalu rontok—catat tren, bukan sekali cicip."
            )
        case (.nuttyCocoa, .taste):
            TrainingContentBlock(
                stageIntro: "Mulut: kacang, kakao, cokelat, almond; mid/after, beda pahit cokelat vs pahit buah/alkali.",
                lead: "Sip: tengah, belakang, aftertaste; banding pahit cokelat vs pahit sangrai vs asam depan bila tercium tumpang.",
                steps: [
                    "3 slurp: tengah, belakang, sisa 10 dtk; tulis tengah lemak vs belakang cokelat.",
                    "Banding: bulat mid vs kering/seret di akhir—catat, bukan skor sempurna."
                ],
                reference: "Nut/cocoa vs roasted: tumpang umum; fokus pada rasa penuh lemak vs sereal/aspal."
            )
        }
    }
}
