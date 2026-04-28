//
//  FlavorNodeGuidance.swift
//  KopiJuang
//
//  Panduan membedakan pilihan rasa di tiap node, selaras SCA/WCR Flavor Wheel.
//  Target: newbie barista — bahasa sederhana, konkret, berbasis indera.
//

import Foundation

// MARK: - Model

struct FlavorChildHint: Identifiable, Sendable {
    var id: String { nodeId }
    let nodeId: String
    let sensoryHint: String
}

struct FlavorNodeGuidance: Sendable {
    let parentNodeId: String
    let intro: String
    let hints: [FlavorChildHint]
}

// MARK: - Lookup

enum FlavorGuidanceData {
    static func guidance(for nodeId: String) -> FlavorNodeGuidance? {
        all[nodeId]
    }

    // swiftlint:disable function_body_length
    private static let all: [String: FlavorNodeGuidance] = {
        var d: [String: FlavorNodeGuidance] = [:]

        // ─── L1: Sweet ────────────────────────────────────────────
        d["Sweet"] = FlavorNodeGuidance(
            parentNodeId: "Sweet",
            intro: "Ketiganya manis, tapi beda berat & posisi. Brown sugar paling berat di tengah lidah; vanila muncul lebih di retronasal; sweet aromatic paling tipis & ringan.",
            hints: [
                .init(nodeId: "brown_sugar",   sensoryHint: "Manis berat & hangat — ada bayangan karamel atau gula jawa. Terasa penuh di tengah lidah, bukan tipis."),
                .init(nodeId: "vanilla",        sensoryHint: "Manis ringan & harum. Lebih terasa di retronasal (hembus lewat hidung). Tidak ada berat karamel."),
                .init(nodeId: "sweetaromatic",  sensoryHint: "Manis sangat tipis & bersih — seperti bau kapas gula dari jauh. Biasanya muncul di akhir, bukan serangan.")
            ]
        )

        // ─── L1: Floral ───────────────────────────────────────────
        d["Floral"] = FlavorNodeGuidance(
            parentNodeId: "Floral",
            intro: "Floral bisa muncul sebagai bunga segar atau dedaunan teh. Kunci bedanya: bunga potong muncul tajam di depan hidung; teh lebih 'kering' dengan sedikit tanin.",
            hints: [
                .init(nodeId: "flowery", sensoryHint: "Bunga segar & wangi. Muncul tajam di depan hidung — melati, mawar, elderflower, chamomile."),
                .init(nodeId: "tea",     sensoryHint: "Seperti teh — ada sedikit tanin ringan & rasa 'kering' di belakang mulut. Tidak seharum bunga potong.")
            ]
        )

        // ─── L1: Fruity ───────────────────────────────────────────
        d["Fruity"] = FlavorNodeGuidance(
            parentNodeId: "Fruity",
            intro: "Empat kategori buah dibedakan dari tingkat ketajaman asam & berat rasa: sitrus paling tajam, beri asam-manis gelap, tropis penuh bulat, buah kering pekat manis.",
            hints: [
                .init(nodeId: "berry",       sensoryHint: "Asam-manis dengan karakter 'merah/gelap' — blackberry, raspberry, blueberry. Tidak secerah & setajam sitrus."),
                .init(nodeId: "citrus",      sensoryHint: "Paling tajam & cerah di depan lidah. Seperti memegang kulit lemon atau jeruk nipis segar."),
                .init(nodeId: "dried_fruit", sensoryHint: "Manis pekat & sedikit berat — tidak segar seperti sitrus. Lebih seperti kismis, plum, atau ara kering."),
                .init(nodeId: "tropical",    sensoryHint: "Penuh & bulat. Manis tropis tanpa ketajaman sitrus — mangga, nanas, atau kelapa.")
            ]
        )

        // ─── L1: Sour / Fermented ─────────────────────────────────
        d["Sour / Fermented"] = FlavorNodeGuidance(
            parentNodeId: "Sour / Fermented",
            intro: "Sour = asam bersih tanpa bau tambahan. Fermented = asam + kompleksitas buah matang/wine. Alcohol = ester elegan, kehangatan sangat ringan.",
            hints: [
                .init(nodeId: "sour",       sensoryHint: "Asam bersih di sisi lidah — tidak ada bau fermentasi. Seperti cuka tipis, jeruk, atau apel hijau."),
                .init(nodeId: "fermented",  sensoryHint: "Ada kompleksitas buah matang atau wine. Seperti ceri sangat matang, kimchi, atau lambic ringan."),
                .init(nodeId: "alcohol",    sensoryHint: "Ester elegan — seperti rasa buah tapi ada kehangatan alkohol sangat ringan di belakang. Tidak menyengat.")
            ]
        )

        // ─── L1: Green / Vegetative ───────────────────────────────
        d["Green / Vegetative"] = FlavorNodeGuidance(
            parentNodeId: "Green / Vegetative",
            intro: "Tiga karakter hijau: minyak zaitun = lemak nabati hijau; herba = daun segar; mentah/kacang = polong belum matang. Intensitasnya yang membedakan kualitas.",
            hints: [
                .init(nodeId: "olive_oil",    sensoryHint: "Lemak nabati hijau — ada kesan berminyak ringan. Bukan sayuran segar, lebih seperti minyak zaitun."),
                .init(nodeId: "herbaceous",   sensoryHint: "Daun & herba segar — rumput baru dipotong, adas, atau sage. Lebih segar & bersih dari polong mentah."),
                .init(nodeId: "raw_beany",    sensoryHint: "Polong atau kacang mentah yang belum matang — kacang polong, buncis muda. Sering kurang nyaman jika kuat.")
            ]
        )

        // ─── L1: Other ────────────────────────────────────────────
        d["Other"] = FlavorNodeGuidance(
            parentNodeId: "Other",
            intro: "Tiga jenis anomali. Kimia = sintetis & tajam; apek/tanah = organik & lembap; kertas = datar & kering tanpa karakter. Catat dulu, nilai belakangan.",
            hints: [
                .init(nodeId: "chemical",     sensoryHint: "Tajam & sintetis — seperti obat, karet, atau pelarut. Terasa di hidung sebelum di lidah."),
                .init(nodeId: "musty_earthy", sensoryHint: "Bau tanah lembap atau jamur — lebih 'organik'. Seperti dapur lembap, gambut, atau jamur kering."),
                .init(nodeId: "paper_pulp",   sensoryHint: "Datar & kering — seperti kardus atau kertas basah. Tidak ada ketajaman kimia, hanya 'kosong'.")
            ]
        )

        // ─── L1: Roasted ──────────────────────────────────────────
        d["Roasted"] = FlavorNodeGuidance(
            parentNodeId: "Roasted",
            intro: "Tiga tingkat 'kehitaman' sangrai: sereal = paling terang (masih ada manis biji), tembakau/aspal = lebih gelap, gosong-kering = paling gelap & kering.",
            hints: [
                .init(nodeId: "cereal",        sensoryHint: "Paling terang — seperti oat panggang, biskuit, atau roti tawar. Masih ada sedikit manis biji di sini."),
                .init(nodeId: "tobacco_pipe",  sensoryHint: "Lebih gelap. Ada tembakau, asap, atau aspal. Tidak ada manis sereal — lebih tua & kering."),
                .init(nodeId: "roasted_malt",  sensoryHint: "Paling gelap & kering — seperti roti yang sangat matang atau kerak arang. Bisa terasa agresif.")
            ]
        )

        // ─── L1: Spices ───────────────────────────────────────────
        d["Spices"] = FlavorNodeGuidance(
            parentNodeId: "Spices",
            intro: "Rempah dibagi: baking spice = hangat-manis (kayu manis, cengkih, pala); lada = tajam-pedas di retronasal; rempah tajam-manis = campuran aromatik.",
            hints: [
                .init(nodeId: "baking_spice", sensoryHint: "Hangat & sedikit manis — kayu manis, cengkih, pala. Seperti aroma kue natal yang nyaman."),
                .init(nodeId: "pepper",       sensoryHint: "Tajam & sedikit pedas di ujung lidah dan retronasal. Tidak ada manis — murni ketajaman lada."),
                .init(nodeId: "brownspice",   sensoryHint: "Campuran aromatik — seperti allspice atau kari sangat ringan. Lebih kompleks dari baking spice.")
            ]
        )

        // ─── L1: Nutty / Cocoa ────────────────────────────────────
        d["Nutty / Cocoa"] = FlavorNodeGuidance(
            parentNodeId: "Nutty / Cocoa",
            intro: "Nutty = lemak biji kering tanpa pahit; cocoa = lemak cokelat dengan pahit. Kunci bedanya: ada tidaknya pahit cokelat di finish.",
            hints: [
                .init(nodeId: "nut",   sensoryHint: "Kacang panggang — bulat, gurih, tidak pahit. Seperti almond panggang atau hazelnut. Finish bersih."),
                .init(nodeId: "cocoa", sensoryHint: "Ada pahit cokelat yang khas. Seperti dark chocolate atau bubuk kakao — lebih gelap dari kacang.")
            ]
        )

        // ═══════════════════════════════════════════════════════
        // L2 NODES — pilih di antara L3 (spesifik)
        // ═══════════════════════════════════════════════════════

        // ─── Sweet > Brown Sugar ──────────────────────────────────
        d["brown_sugar"] = FlavorNodeGuidance(
            parentNodeId: "brown_sugar",
            intro: "Keempat 'manis cokelat' dibedakan dari berat & sisa rasa. Madu paling ringan & sedikit floral; karamel paling 'panggang'; maple lebih kayu; molases paling pekat & gelap.",
            hints: [
                .init(nodeId: "honey",       sensoryHint: "Manis cair dengan sedikit floral di belakang. Paling ringan di grup ini — tidak ada berat karamel."),
                .init(nodeId: "caramel",     sensoryHint: "Manis kering-hangat dengan hint panggang ringan di akhir. Lebih 'berat' dari madu, lebih bersih dari molases."),
                .init(nodeId: "maple_syrup", sensoryHint: "Manis kayu & sedikit smoky. Lebih 'kering' dan 'berbisik' dari madu — seperti sirup maple botol."),
                .init(nodeId: "molasses",    sensoryHint: "Paling pekat & gelap. Ada pahit-manis di akhir — seperti gula merah tua. Tidak ringan sama sekali.")
            ]
        )

        // ─── Sweet > Vanilla ──────────────────────────────────────
        d["vanilla"] = FlavorNodeGuidance(
            parentNodeId: "vanilla",
            intro: "Dua nuansa vanila: polong segar lebih kompleks & kayu; vanilin lebih ringan & bersih seperti extract.",
            hints: [
                .init(nodeId: "vanilla_bean", sensoryHint: "Hangat, sedikit kayu, ada hint floral manis. Seperti polong vanila baru dibelah."),
                .init(nodeId: "vanillin",     sensoryHint: "Lebih ringan & bersih — seperti extract vanila botol. Tidak sekompleks polong, tapi lebih familiar.")
            ]
        )

        // ─── Sweet > Sweet Aromatic ───────────────────────────────
        d["sweetaromatic"] = FlavorNodeGuidance(
            parentNodeId: "sweetaromatic",
            intro: "Keduanya manis sangat ringan & airy. Marshmallow sedikit creamy; gula arum manis paling tipis & ringan.",
            hints: [
                .init(nodeId: "marshmallow",   sensoryHint: "Ada sedikit tekstur creamy lembut di retronasal — manis empuk, bukan tajam."),
                .init(nodeId: "cotton_candy",  sensoryHint: "Paling tipis & airy. Manis yang hampir tanpa bobot — seperti bau permen kapas dari jauh.")
            ]
        )

        // ─── Floral > Flowery ─────────────────────────────────────
        d["flowery"] = FlavorNodeGuidance(
            parentNodeId: "flowery",
            intro: "Empat bunga berbeda intensitas & karakter. Melati paling tajam; mawar lebih manis-lembut; elderflower ada sitrus ringan; chamomile paling herbal.",
            hints: [
                .init(nodeId: "jasmine",     sensoryHint: "Tajam & langsung dikenali — wangi melati yang kuat. Paling 'frontal' di antara bunga potong."),
                .init(nodeId: "rose",        sensoryHint: "Lebih manis & lembut dari melati. Seperti petali mawar merah — tidak setajam melati."),
                .init(nodeId: "elderflower", sensoryHint: "Ada sedikit sitrus di belakang floral-nya. Lebih ringan dari melati — sedikit 'embun pagi'."),
                .init(nodeId: "chamomile",   sensoryHint: "Paling herbal di antara bunga — seperti teh kamomil. Ada sedikit kering & earthy di belakang.")
            ]
        )

        // ─── Floral > Tea ─────────────────────────────────────────
        d["tea"] = FlavorNodeGuidance(
            parentNodeId: "tea",
            intro: "Tiga profil teh berbeda dari astringency & aroma tambahan. Teh hitam paling tanin; teh hijau paling segar; earl grey unik karena ada sitrus bergamot.",
            hints: [
                .init(nodeId: "black_tea",  sensoryHint: "Ada tanin ringan — sedikit 'kering' atau 'mengkerutkan' di belakang mulut setelah teguk."),
                .init(nodeId: "green_tea",  sensoryHint: "Paling segar & hijau. Tidak ada tanin tebal — kadang ada sedikit karakter sayuran ringan."),
                .init(nodeId: "earl_grey",  sensoryHint: "Ada sitrus bergamot yang jelas di balik teh. Kombinasi floral + sitrus = ciri khas earl grey.")
            ]
        )

        // ─── Fruity > Berry ───────────────────────────────────────
        d["berry"] = FlavorNodeGuidance(
            parentNodeId: "berry",
            intro: "Empat beri dibedakan dari tingkat asam & 'kehitaman' rasa. Blackberry paling gelap-berat; raspberry paling tajam-cerah; blueberry manis-bulat; stroberi paling ringan.",
            hints: [
                .init(nodeId: "blackberry",  sensoryHint: "Paling gelap & berat. Asam kental dengan buah gelap yang pekat — tidak cerah seperti raspberry."),
                .init(nodeId: "raspberry",   sensoryHint: "Asam cerah & segar — paling tajam di antara beri. Seperti frambos yang baru dipetik."),
                .init(nodeId: "blueberry",   sensoryHint: "Manis-bulat, tidak terlalu tajam. Ada sedikit 'musty' khas blueberry di belakang."),
                .init(nodeId: "strawberry",  sensoryHint: "Paling ringan & muda. Manis-asam segar seperti stroberi muda — tidak ada berat blackberry.")
            ]
        )

        // ─── Fruity > Citrus ──────────────────────────────────────
        d["citrus"] = FlavorNodeGuidance(
            parentNodeId: "citrus",
            intro: "Empat sitrus dibedakan dari ketajaman asam & ada tidaknya pahit. Lemon & nipis paling tajam; grapefruit ada pahit khas; jeruk paling manis.",
            hints: [
                .init(nodeId: "lemon",       sensoryHint: "Asam tajam & bersih. Tidak ada pahit — hanya kecerahan sitrus yang klasik."),
                .init(nodeId: "lime",        sensoryHint: "Lebih 'hijau' dari lemon. Asam tajam dengan sentuhan herba-getir. Seperti perasan jeruk nipis."),
                .init(nodeId: "grapefruit",  sensoryHint: "Ada pahit yang khas di akhir asam. Sitrus tapi tidak murni asam — ada lapisan pahit elegan."),
                .init(nodeId: "orange",      sensoryHint: "Paling manis di antara sitrus. Asam ringan dengan kemanisan jeruk yang lembut & bulat.")
            ]
        )

        // ─── Fruity > Dried Fruit ─────────────────────────────────
        d["dried_fruit"] = FlavorNodeGuidance(
            parentNodeId: "dried_fruit",
            intro: "Tiga buah kering berbeda berat & manisnya. Kismis paling 'anggur'; plum kering lebih gelap-asam; ara kering paling lembut.",
            hints: [
                .init(nodeId: "raisin", sensoryHint: "Manis kental dengan sedikit kesan anggur. Paling umum dikenali — seperti kismis dalam roti."),
                .init(nodeId: "prune",  sensoryHint: "Lebih gelap & asam dari kismis. Ada sedikit ferment alami — plum yang sangat matang dikeringkan."),
                .init(nodeId: "fig",    sensoryHint: "Paling lembut di antara buah kering. Manis halus tanpa asam tajam — seperti ara kering matang.")
            ]
        )

        // ─── Fruity > Tropical ────────────────────────────────────
        d["tropical"] = FlavorNodeGuidance(
            parentNodeId: "tropical",
            intro: "Empat buah tropis: mangga & pepaya lebih manis-bulat; nanas paling asam-cerah; kelapa unik karena ada lemak.",
            hints: [
                .init(nodeId: "mango",     sensoryHint: "Manis tropis yang penuh & bulat. Tidak ada asam tajam — seperti mangga harum matang."),
                .init(nodeId: "pineapple", sensoryHint: "Paling asam-cerah di antara tropis. Ada ketajaman yang menyegarkan — seperti nanas segar."),
                .init(nodeId: "papaya",    sensoryHint: "Lembut & manis mellow. Tidak ada ketajaman — pepaya matang yang tenang & penuh."),
                .init(nodeId: "coconut",   sensoryHint: "Ada komponen lemak & sedikit panggang. Berbeda dari buah segar lain — lebih 'kaya' dan gurih.")
            ]
        )

        // ─── Sour > Sour ──────────────────────────────────────────
        d["sour"] = FlavorNodeGuidance(
            parentNodeId: "sour",
            intro: "Empat jenis asam dibedakan dari sumber & karakter. Asetat terdeteksi di uap (cuka); malat seperti apel; sitrat seperti jeruk; tartarat lebih berat seperti anggur.",
            hints: [
                .init(nodeId: "acetic",   sensoryHint: "Asam cuka — terasa di uap & hidung lebih dulu dari lidah. Ada kesan menusuk yang khas."),
                .init(nodeId: "malic",    sensoryHint: "Asam apel — renyah & bersih. Seperti menggigit apel hijau. Tidak ada bau fermentasi."),
                .init(nodeId: "citric",   sensoryHint: "Asam sitrus — cerah & segar. Lebih ringan dari malat, tidak ada berat cuka."),
                .init(nodeId: "tartaric", sensoryHint: "Lebih berat dari citric. Ada kesan wine ringan — seperti asam anggur yang menggigit sisi lidah.")
            ]
        )

        // ─── Sour > Fermented ─────────────────────────────────────
        d["fermented"] = FlavorNodeGuidance(
            parentNodeId: "fermented",
            intro: "Tiga karakter fermentasi dari 'terlalu matang' ke 'wine' ke 'lambik beri'. Bedanya di tingkat kompleksitas & jenis ferment.",
            hints: [
                .init(nodeId: "overripe",        sensoryHint: "Sangat matang hampir busuk — seperti buah yang dibiarkan terlalu lama. Ada sedikit rasa 'lewat'."),
                .init(nodeId: "winey",           sensoryHint: "Seperti anggur merah — kompleks, elegan, tidak defek. Ada lapisan tannin buah yang halus."),
                .init(nodeId: "fermented_berry", sensoryHint: "Seperti lambic atau cider — ada beri fermentasi yang asam-kompleks. Lebih 'beer-like' dari winey.")
            ]
        )

        // ─── Sour > Alcohol ───────────────────────────────────────
        d["alcohol"] = FlavorNodeGuidance(
            parentNodeId: "alcohol",
            intro: "Dua ester elegan — bukan rasa minuman keras, hanya kesan sangat ringan. Ceri kirsch vs kehangatan oak whisky.",
            hints: [
                .init(nodeId: "cherry_liqueur", sensoryHint: "Ester ceri — seperti kirsch atau maraschino yang sangat encer. Manis buah dengan hangat ringan."),
                .init(nodeId: "whisky",         sensoryHint: "Ada kehangatan oak atau kayu tipis. Seperti whisky yang sangat tereduksi — bukan alkohol menyengat.")
            ]
        )

        // ─── Green > Olive Oil ────────────────────────────────────
        d["olive_oil"] = FlavorNodeGuidance(
            parentNodeId: "olive_oil",
            intro: "Dua nuansa zaitun: matang lebih lemak-bulat; muda lebih getir-tajam. Intensitasnya yang membedakan kenyamanan.",
            hints: [
                .init(nodeId: "olive",       sensoryHint: "Zaitun matang — lemak buah yang lebih bulat & sedikit manis. Tidak getir seperti zaitun muda."),
                .init(nodeId: "green_olive", sensoryHint: "Zaitun muda — ada getir & sedikit asin-tajam. Lebih 'agresif' dari zaitun matang.")
            ]
        )

        // ─── Green > Herbaceous ───────────────────────────────────
        d["herbaceous"] = FlavorNodeGuidance(
            parentNodeId: "herbaceous",
            intro: "Tiga herba berbeda intensitas & arah. Rumput paling familiar; dill ada anise lembut; sage paling tajam & kuat.",
            hints: [
                .init(nodeId: "grass", sensoryHint: "Rumput segar baru dipotong — paling familiar & ringan. Sering terasa di kopi yang masih segar roast-nya."),
                .init(nodeId: "dill",  sensoryHint: "Adas — ada karakter anise yang lembut di balik herba. Tidak setajam sage, tidak sesederhana rumput."),
                .init(nodeId: "sage",  sensoryHint: "Paling tajam & intens. Ada sedikit menthol-herba. Jika muncul kuat, ini yang paling mudah dikenali.")
            ]
        )

        // ─── Green > Raw/Beany ────────────────────────────────────
        d["raw_beany"] = FlavorNodeGuidance(
            parentNodeId: "raw_beany",
            intro: "Dua polong mentah — kacang polong ada sedikit manis sayur; buncis muda lebih hijau-kering. Keduanya bisa muncul di kopi under-developed.",
            hints: [
                .init(nodeId: "pea",     sensoryHint: "Kacang polong mentah — ada sedikit manis sayur di balik karakter hijau. Lebih 'manis' dari buncis."),
                .init(nodeId: "peapod",  sensoryHint: "Buncis muda yang belum matang — lebih kering & tajam hijau. Tidak ada manis sayur seperti pea.")
            ]
        )

        // ─── Other > Chemical ─────────────────────────────────────
        d["chemical"] = FlavorNodeGuidance(
            parentNodeId: "chemical",
            intro: "Tiga jenis anomali kimia dibedakan dari 'jenis bau'-nya. Obat lebih organik-herba; karet lebih industri; minyak bumi paling asing.",
            hints: [
                .init(nodeId: "medicinal",  sensoryHint: "Seperti obat herba atau terpentin — ada sedikit organik di balik bau kimia. Kadang mirip plastik panas."),
                .init(nodeId: "rubber",     sensoryHint: "Seperti ban atau karet — lebih 'industri'. Tidak ada sisi organik seperti obat."),
                .init(nodeId: "petroleum",  sensoryHint: "Seperti bensin atau minyak — sangat asing & spesifik. Jika ini yang terasa, langsung catat.")
            ]
        )

        // ─── Other > Musty / Earthy ───────────────────────────────
        d["musty_earthy"] = FlavorNodeGuidance(
            parentNodeId: "musty_earthy",
            intro: "Tiga 'bau bumi' berbeda karakter organiknya. Jamur ada hint umami; berjamur lebih tidak nyaman; gambut paling 'dalam' & basah.",
            hints: [
                .init(nodeId: "mushroom", sensoryHint: "Seperti jamur segar atau kering — ada sedikit 'umami' gurih di balik earthy. Tidak selalu tidak nyaman."),
                .init(nodeId: "moldy",    sensoryHint: "Seperti benda yang berjamur — biasanya mengganggu. Berbeda dari jamur segar yang ada gurihnya."),
                .init(nodeId: "peat",     sensoryHint: "Seperti tanah gambut atau dapur lembap — earthy yang dalam. Ada kesan 'basah organik' yang pekat.")
            ]
        )

        // ─── Other > Paper / Pulp ─────────────────────────────────
        d["paper_pulp"] = FlavorNodeGuidance(
            parentNodeId: "paper_pulp",
            intro: "Dua karakter kertas — kardus lebih datar-kering; kertas-kayu ada sedikit serat basah.",
            hints: [
                .init(nodeId: "cardboard", sensoryHint: "Seperti kardus kering — datar tanpa karakter lain. Paling sering terdeteksi di kopi simpan lama."),
                .init(nodeId: "woody",     sensoryHint: "Seperti kertas kayu atau serat basah — ada sedikit 'kayu' di balik kertas. Lebih dari sekedar kardus.")
            ]
        )

        // ─── Roasted > Cereal ─────────────────────────────────────
        d["cereal"] = FlavorNodeGuidance(
            parentNodeId: "cereal",
            intro: "Tiga sereal panggang dari yang paling 'biji kering' ke paling 'roti manis'. Malt paling kering; granola ada manis gandum; graham paling mirip biskuit.",
            hints: [
                .init(nodeId: "malt",    sensoryHint: "Paling kering & biji — seperti jelai malt kering. Tidak ada manis roti, hanya biji panggang bersih."),
                .init(nodeId: "granola", sensoryHint: "Seperti oat panggang — ada sedikit manis gandum. Lebih 'manis' dari malt, kurang 'kering'."),
                .init(nodeId: "graham",  sensoryHint: "Paling manis di grup sereal — seperti biskuit graham tipis. Ada hint manis cokelat panggang ringan.")
            ]
        )

        // ─── Roasted > Tobacco / Aspal ────────────────────────────
        d["tobacco_pipe"] = FlavorNodeGuidance(
            parentNodeId: "tobacco_pipe",
            intro: "Tiga karakter gelap — abu paling tajam-kering; tembakau pipa ada sedikit manis tua; asap paling lembut & tidak mengganggu.",
            hints: [
                .init(nodeId: "ash",          sensoryHint: "Paling tajam & kering — seperti abu tungku atau ashtray. Tidak ada manis sama sekali."),
                .init(nodeId: "pipe_tobacco", sensoryHint: "Ada sedikit manis tua di balik tembakau — seperti tembakau pipa lama. Lebih nyaman dari abu."),
                .init(nodeId: "smoke",        sensoryHint: "Asap ringan & bersih — seperti asap kayu bakar yang tidak menyengat. Paling 'nyaman' di grup ini.")
            ]
        )

        // ─── Roasted > Gosong-kering ──────────────────────────────
        d["roasted_malt"] = FlavorNodeGuidance(
            parentNodeId: "roasted_malt",
            intro: "Dua karakter gosong — burnt lebih 'karbon diam'; acrid lebih 'menusuk agresif'. Keduanya intensitas tinggi.",
            hints: [
                .init(nodeId: "burnt", sensoryHint: "Seperti roti gosong — ada kerak hitam yang kering. Tidak ada hal lain selain kesan karbon."),
                .init(nodeId: "acrid", sensoryHint: "Gosong yang menusuk & getir agresif. Lebih 'menyerang' dari burnt — bisa terasa di tenggorokan.")
            ]
        )

        // ─── Spices > Baking Spice ────────────────────────────────
        d["baking_spice"] = FlavorNodeGuidance(
            parentNodeId: "baking_spice",
            intro: "Empat rempah hangat-manis. Kayu manis paling manis & familiar; cengkih paling tajam (ada efek numbing); pala lebih kayu; pekak paling unik (seperti biji hitam).",
            hints: [
                .init(nodeId: "cinnamon", sensoryHint: "Paling manis & hangat — kayu manis bubuk yang familiar. Nyaman & tidak agresif."),
                .init(nodeId: "clove",    sensoryHint: "Paling tajam di baking spice. Ada efek mati rasa (numbing) ringan di ujung lidah — cengkih yang khas."),
                .init(nodeId: "nutmeg",   sensoryHint: "Hangat & sedikit kayu — di antara kayu manis & cengkih. Tidak semanis kayu manis, tidak setajam cengkih."),
                .init(nodeId: "anise",    sensoryHint: "Karakter pekak atau adas manis — unik & tidak bisa dikira-kira. Ada manis tapi dengan 'biji hitam' di belakang.")
            ]
        )

        // ─── Spices > Pepper ──────────────────────────────────────
        d["pepper"] = FlavorNodeGuidance(
            parentNodeId: "pepper",
            intro: "Tiga nuansa lada — hitam paling bold; putih lebih bersih; piperine lebih ke sensasi hangat daripada rasa lada yang jelas.",
            hints: [
                .init(nodeId: "black_pepper", sensoryHint: "Lada hitam yang bold — tajam, ada sedikit karakter tanah & kayu di belakang. Paling familiar."),
                .init(nodeId: "white_pepper", sensoryHint: "Lebih bersih dari lada hitam — tajam tapi tidak ada 'kotor' atau tanah. Lebih murni lada-nya."),
                .init(nodeId: "piperine",     sensoryHint: "Lebih ke sensasi hangat-pedas ringan di retronasal daripada rasa lada yang jelas. Lebih subtle.")
            ]
        )

        // ─── Spices > Brown Spice ─────────────────────────────────
        d["brownspice"] = FlavorNodeGuidance(
            parentNodeId: "brownspice",
            intro: "Dua campuran rempah aromatik — allspice lebih manis-familiar; kari lebih gurih-eksotis.",
            hints: [
                .init(nodeId: "allspice", sensoryHint: "Perpaduan pala + cengkih + kayu manis dalam satu. Kompleks tapi nyaman — seperti bumbu kue natal campuran."),
                .init(nodeId: "curry",    sensoryHint: "Sangat ringan — ada hint kurkuma atau bumbu hangat yang samar. Jika muncul, biasanya tipis.")
            ]
        )

        // ─── Nutty > Nut ──────────────────────────────────────────
        d["nut"] = FlavorNodeGuidance(
            parentNodeId: "nut",
            intro: "Empat kacang berbeda dari berat & sisi manis-gurih. Almond paling ringan; hazelnut lebih 'penuh'; kacang tanah paling gurih; pecan ada karamel.",
            hints: [
                .init(nodeId: "almond",   sensoryHint: "Paling ringan & sedikit marzipan — ada sedikit manis di balik gurih. Bersih & elegan."),
                .init(nodeId: "hazelnut", sensoryHint: "Lebih 'penuh' dari almond. Ada sedikit panggang yang menyenangkan — seperti hazelnut di praline."),
                .init(nodeId: "peanuts",  sensoryHint: "Paling gurih & 'berat' di antara kacang. Tidak ada manis — murni kacang tanah panggang."),
                .init(nodeId: "pecan",    sensoryHint: "Ada karamel kacang — lebih manis dari hazelnut, lebih berat dari almond. Seperti pecan pie ringan.")
            ]
        )

        // ─── Nutty > Cocoa ────────────────────────────────────────
        d["cocoa"] = FlavorNodeGuidance(
            parentNodeId: "cocoa",
            intro: "Empat profil cokelat dari yang paling manis ke paling pahit. Cokelat susu paling creamy; dark chocolate seimbang; bubuk kakao paling pahit-kering; mocha ada kopi.",
            hints: [
                .init(nodeId: "milk_chocolate", sensoryHint: "Paling manis & creamy — ada susu di balik cokelat. Tidak ada pahit yang tegas."),
                .init(nodeId: "dark_chocolate", sensoryHint: "Pahit-manis yang seimbang. Tidak ada creamy susu — lebih 'dewasa' dan intens."),
                .init(nodeId: "cocoa_powder",   sensoryHint: "Seperti bubuk kakao murni — pahit kering, tidak ada lemak cokelat. Paling 'kering' di grup ini."),
                .init(nodeId: "mocha",          sensoryHint: "Ada kesan kopi di balik cokelat. Ini adalah kombinasi — seperti cokelat yang 'punya rasa kopi'.")
            ]
        )

        return d
    }()
    // swiftlint:enable function_body_length
}
