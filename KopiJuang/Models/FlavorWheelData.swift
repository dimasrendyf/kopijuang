//
//  FlavorWheelData.swift
//  KopiJuang
//
//  Hierarki cita rasa terinspirasi struktur cangkang luar cita rasa (SCA / WCR).
//  Deskripsi ditulis di-app; bukan replika 1:1 peta bercetak.
//

import Foundation

// MARK: - L1: Sweet
private let sweet = FlavorWheelNode(
    id: FlavorCategory.sweet.rawValue,
    name: "Manis",
    description: "Rasa manis alami: madu, karamel, vanila, dan gula tebu—manis yang muncul tanpa tambahan pemanis.",
    layer: 1, parent: nil, children: [
        FlavorWheelNode(
            id: "brown_sugar", name: "Gula cokelat", description: "Pemanis hangat dengan aksen molase dan gula karamel.",
            layer: 2, parent: FlavorCategory.sweet.rawValue, children: [
                FlavorWheelNode(id: "honey", name: "Madu", description: "Madu dengan tekstur manis yang khas.", layer: 3, parent: "brown_sugar", children: []),
                FlavorWheelNode(id: "caramel", name: "Karamel", description: "Karamel dengan nuansa manis panggang yang kaya.", layer: 3, parent: "brown_sugar", children: []),
                FlavorWheelNode(id: "maple_syrup", name: "Maple", description: "Sirup maple dengan sentuhan manis kayu yang lembut.", layer: 3, parent: "brown_sugar", children: []),
                FlavorWheelNode(id: "molasses", name: "Melase", description: "Molase pekat dengan profil manis-pahit yang elegan.", layer: 3, parent: "brown_sugar", children: [])
            ]
        ),
        FlavorWheelNode(
            id: "vanilla", name: "Vanila", description: "Aroma vanila yang lembut, aromatik, dan menenangkan.",
            layer: 2, parent: FlavorCategory.sweet.rawValue, children: [
                FlavorWheelNode(id: "vanilla_bean", name: "Polong vanila", description: "Polong vanila asli dengan wangi hangat.", layer: 3, parent: "vanilla", children: []),
                FlavorWheelNode(id: "vanillin", name: "Vanilin", description: "Kesan vanilin yang ringan dan manis.", layer: 3, parent: "vanilla", children: [])
            ]
        ),
        FlavorWheelNode(
            id: "sweetaromatic", name: "Aromatik manis", description: "Kemanisan yang bulat di retronasal; nuansa lembut yang tidak dominan.",
            layer: 2, parent: FlavorCategory.sweet.rawValue, children: [
                FlavorWheelNode(id: "marshmallow", name: "Marshmallow", description: "Manis lembut dan empuk.", layer: 3, parent: "sweetaromatic", children: []),
                FlavorWheelNode(id: "cotton_candy", name: "Gula arum manis", description: "Manis yang sangat ringan seperti gula kapas.", layer: 3, parent: "sweetaromatic", children: [])
            ]
        )
    ]
)

// MARK: - L1: Floral
private let floral = FlavorWheelNode(
    id: FlavorCategory.floral.rawValue,
    name: "Floral / bunga",
    description: "Wangi kelopak bunga, teh floral, dan nuansa taman yang halus namun berkesan.",
    layer: 1, parent: nil, children: [
        FlavorWheelNode(
            id: "flowery", name: "Bunga potong", description: "Nuansa kelopak bunga segar yang aromatik.",
            layer: 2, parent: FlavorCategory.floral.rawValue, children: [
                FlavorWheelNode(id: "jasmine", name: "Melati", description: "Melati dengan wangi lembut namun tajam.", layer: 3, parent: "flowery", children: []),
                FlavorWheelNode(id: "rose", name: "Mawar", description: "Mawar dengan profil floral manis.", layer: 3, parent: "flowery", children: []),
                FlavorWheelNode(id: "elderflower", name: "Elderflower", description: "Bunga elder dengan aksen floral sitrus ringan.", layer: 3, parent: "flowery", children: []),
                FlavorWheelNode(id: "chamomile", name: "Kamomil", description: "Teh kamomil dengan profil herbal lembut.", layer: 3, parent: "flowery", children: [])
            ]
        ),
        FlavorWheelNode(
            id: "tea", name: "Teh", description: "Karakter teh dengan aroma dedaunan yang lembut.",
            layer: 2, parent: FlavorCategory.floral.rawValue, children: [
                FlavorWheelNode(id: "black_tea", name: "Teh hitam", description: "Teh hitam dengan tanin yang lembut.", layer: 3, parent: "tea", children: []),
                FlavorWheelNode(id: "green_tea", name: "Teh hijau", description: "Teh hijau yang segar dengan sedikit profil sayur.", layer: 3, parent: "tea", children: []),
                FlavorWheelNode(id: "earl_grey", name: "Bergamot / Earl", description: "Teh dengan sentuhan sitrus seperti Earl Grey.", layer: 3, parent: "tea", children: [])
            ]
        )
    ]
)

// MARK: - L1: Fruity
private let fruity = FlavorWheelNode(
    id: FlavorCategory.fruity.rawValue,
    name: "Buah",
    description: "Spektrum buah: sitrus, beri, hingga buah tropis dengan tingkat keasaman yang cerah.",
    layer: 1, parent: nil, children: [
        FlavorWheelNode(
            id: "berry", name: "Beri", description: "Kategori beri dengan profil asam-manis yang khas.",
            layer: 2, parent: FlavorCategory.fruity.rawValue, children: [
                FlavorWheelNode(id: "blackberry", name: "Blackberry", description: "Blackberry dengan karakter buah gelap dan asam kental.", layer: 3, parent: "berry", children: []),
                FlavorWheelNode(id: "raspberry", name: "Frambos", description: "Frambos dengan keasaman segar yang terang.", layer: 3, parent: "berry", children: []),
                FlavorWheelNode(id: "blueberry", name: "Bluberi", description: "Bluberi dengan rasa manis yang bulat.", layer: 3, parent: "berry", children: []),
                FlavorWheelNode(id: "strawberry", name: "Stroberi", description: "Stroberi dengan profil asam-manis muda.", layer: 3, parent: "berry", children: [])
            ]
        ),
        FlavorWheelNode(
            id: "citrus", name: "Sitrun", description: "Sitrus dan kerabatnya dengan profil rasa yang cerah.",
            layer: 2, parent: FlavorCategory.fruity.rawValue, children: [
                FlavorWheelNode(id: "lemon", name: "Lemon", description: "Lemon dengan asam tajam yang segar.", layer: 3, parent: "citrus", children: []),
                FlavorWheelNode(id: "lime", name: "Jeruk nipis", description: "Jeruk nipis dengan asam tajam yang hijau.", layer: 3, parent: "citrus", children: []),
                FlavorWheelNode(id: "grapefruit", name: "Jeruk bali", description: "Jeruk bali dengan pahit-asam yang khas.", layer: 3, parent: "citrus", children: []),
                FlavorWheelNode(id: "orange", name: "Jeruk", description: "Jeruk dengan profil manis-sitrus yang lembut.", layer: 3, parent: "citrus", children: [])
            ]
        ),
        FlavorWheelNode(
            id: "dried_fruit", name: "Buah kering", description: "Buah kering dengan intensitas rasa yang pekat dan manis.",
            layer: 2, parent: FlavorCategory.fruity.rawValue, children: [
                FlavorWheelNode(id: "raisin", name: "Kismis", description: "Kismis dengan manis yang kental.", layer: 3, parent: "dried_fruit", children: []),
                FlavorWheelNode(id: "prune", name: "Plum kering", description: "Plum kering dengan profil asam-manis pekat.", layer: 3, parent: "dried_fruit", children: []),
                FlavorWheelNode(id: "fig", name: "Ara kering", description: "Buah ara kering dengan tekstur manis yang halus.", layer: 3, parent: "dried_fruit", children: [])
            ]
        ),
        FlavorWheelNode(
            id: "tropical", name: "Tropis", description: "Buah tropis eksotis seperti mangga, nanas, atau pepaya.",
            layer: 2, parent: FlavorCategory.fruity.rawValue, children: [
                FlavorWheelNode(id: "mango", name: "Mangga", description: "Mangga dengan manis tropis yang penuh.", layer: 3, parent: "tropical", children: []),
                FlavorWheelNode(id: "pineapple", name: "Nanas", description: "Nanas dengan asam-manis yang cerah.", layer: 3, parent: "tropical", children: []),
                FlavorWheelNode(id: "papaya", name: "Pepaya", description: "Pepaya dengan rasa manis yang lembut.", layer: 3, parent: "tropical", children: []),
                FlavorWheelNode(id: "coconut", name: "Kelapa", description: "Kelapa dengan profil lemak dan rasa panggang lembut.", layer: 3, parent: "tropical", children: [])
            ]
        )
    ]
)

// MARK: - L1: Sour / Fermented
private let sourFermented = FlavorWheelNode(
    id: FlavorCategory.sourFermented.rawValue,
    name: "Asam / fermentasi",
    description: "Asam yang terdefinisi dengan nuansa fermentasi, winey, dan alkoholik yang lembut.",
    layer: 1, parent: nil, children: [
        FlavorWheelNode(
            id: "sour", name: "Asam", description: "Asam yang bersih dan terdefinisi.",
            layer: 2, parent: FlavorCategory.sourFermented.rawValue, children: [
                FlavorWheelNode(id: "acetic", name: "Asetat", description: "Cuka ringan, sering terasa tajam di uap.", layer: 3, parent: "sour", children: []),
                FlavorWheelNode(id: "malic", name: "Apel (malat)", description: "Asam apel yang terasa renyah.", layer: 3, parent: "sour", children: []),
                FlavorWheelNode(id: "citric", name: "Sitrat", description: "Asam sitrun dengan profil segar.", layer: 3, parent: "sour", children: []),
                FlavorWheelNode(id: "tartaric", name: "Tartarat", description: "Profil tajam mirip anggur.", layer: 3, parent: "sour", children: [])
            ]
        ),
        FlavorWheelNode(
            id: "fermented", name: "Fermentasi", description: "Buah matang, winey, atau kesan fermentasi yang kompleks.",
            layer: 2, parent: FlavorCategory.sourFermented.rawValue, children: [
                FlavorWheelNode(id: "overripe", name: "Terlalu matang", description: "Sangat matang, mendekati fermentasi alami.", layer: 3, parent: "fermented", children: []),
                FlavorWheelNode(id: "winey", name: "Anggur (winey)", description: "Kesan anggur atau kulit buah anggur.", layer: 3, parent: "fermented", children: []),
                FlavorWheelNode(id: "fermented_berry", name: "Buah ferment", description: "Kesan beri fermentasi mirip lambik.", layer: 3, parent: "fermented", children: [])
            ]
        ),
        FlavorWheelNode(
            id: "alcohol", name: "Alkohol", description: "Ester buah dan likur yang elegan, tanpa kesan alkohol tajam.",
            layer: 2, parent: FlavorCategory.sourFermented.rawValue, children: [
                FlavorWheelNode(id: "cherry_liqueur", name: "Likur ceri", description: "Ester ceri yang menyerupai kirsch ringan.", layer: 3, parent: "alcohol", children: []),
                FlavorWheelNode(id: "whisky", name: "Wiski", description: "Ester kayu dan alkohol dengan intensitas sangat ringan.", layer: 3, parent: "alcohol", children: [])
            ]
        )
    ]
)

// MARK: - L1: Green / Vegetative
private let greenVegetative = FlavorWheelNode(
    id: FlavorCategory.greenVegetative.rawValue,
    name: "Hijau / sayur",
    description: "Profil hijau, herbal, dan sayuran segar; sering menjadi indikator tingkat sangrai.",
    layer: 1, parent: nil, children: [
        FlavorWheelNode(
            id: "olive_oil", name: "Minyak zaitun", description: "Nuansa minyak zaitun dengan profil lemak nabati.",
            layer: 2, parent: FlavorCategory.greenVegetative.rawValue, children: [
                FlavorWheelNode(id: "olive", name: "Zaitun", description: "Zaitun dengan karakter buah lemak hijau.", layer: 3, parent: "olive_oil", children: []),
                FlavorWheelNode(id: "green_olive", name: "Zaitun muda", description: "Zaitun muda dengan kesan getir dan asin ringan.", layer: 3, parent: "olive_oil", children: [])
            ]
        ),
        FlavorWheelNode(
            id: "herbaceous", name: "Herba", description: "Aroma herbal segar, rumput, atau dedaunan.",
            layer: 2, parent: FlavorCategory.greenVegetative.rawValue, children: [
                FlavorWheelNode(id: "grass", name: "Rumput", description: "Rumput segar dengan jerami ringan.", layer: 3, parent: "herbaceous", children: []),
                FlavorWheelNode(id: "dill", name: "Dill / adas", description: "Adas dengan karakter herbal lembut.", layer: 3, parent: "herbaceous", children: []),
                FlavorWheelNode(id: "sage", name: "Sage", description: "Sage dengan karakter herbal tajam pekat.", layer: 3, parent: "herbaceous", children: [])
            ]
        ),
        FlavorWheelNode(
            id: "raw_beany", name: "Mentah / kacang", description: "Karakter mentah seperti kacang polong (sering dikaitkan dengan under-development).",
            layer: 2, parent: FlavorCategory.greenVegetative.rawValue, children: [
                FlavorWheelNode(id: "pea", name: "Kacang polong", description: "Kacang polong mentah dengan manis sayur.", layer: 3, parent: "raw_beany", children: []),
                FlavorWheelNode(id: "peapod", name: "Buncis muda", description: "Buncis dengan profil hijau muda yang belum matang panggang.", layer: 3, parent: "raw_beany", children: [])
            ]
        )
    ]
)

// MARK: - L1: Other
private let other = FlavorWheelNode(
    id: FlavorCategory.other.rawValue,
    name: "Lain-lain / asing",
    description: "Catatan deskriptif untuk aroma anomali seperti kertas, tanah, atau kimia ringan (objektif).",
    layer: 1, parent: nil, children: [
        FlavorWheelNode(
            id: "chemical", name: "Kimia", description: "Aroma sintetis seperti pelarut atau obat (kimiawi).",
            layer: 2, parent: FlavorCategory.other.rawValue, children: [
                FlavorWheelNode(id: "medicinal", name: "Obat", description: "Kesan terpentin atau herba obat ringan.", layer: 3, parent: "chemical", children: []),
                FlavorWheelNode(id: "rubber", name: "Karet", description: "Karet atau sisa panggang aldehida.", layer: 3, parent: "chemical", children: []),
                FlavorWheelNode(id: "petroleum", name: "Minyak bumi", description: "Aroma hidrokarbon; catat seberapa kuat intensitasnya.", layer: 3, parent: "chemical", children: [])
            ]
        ),
        FlavorWheelNode(
            id: "musty_earthy", name: "Apek / tanah", description: "Kesan bumi, lembap, atau tanah.",
            layer: 2, parent: FlavorCategory.other.rawValue, children: [
                FlavorWheelNode(id: "mushroom", name: "Jamur", description: "Jamur dengan profil gurih tanah lembut.", layer: 3, parent: "musty_earthy", children: []),
                FlavorWheelNode(id: "moldy", name: "Berjamur", description: "Bau jamur; catat intensitasnya tanpa berasumsi.", layer: 3, parent: "musty_earthy", children: []),
                FlavorWheelNode(id: "peat", name: "Gambut", description: "Tanah gambut dengan bau dapur lembap.", layer: 3, parent: "musty_earthy", children: [])
            ]
        ),
        FlavorWheelNode(
            id: "paper_pulp", name: "Kertas / serpihan", description: "Tekstur kertas, karton, atau serat selulosa.",
            layer: 2, parent: FlavorCategory.other.rawValue, children: [
                FlavorWheelNode(id: "cardboard", name: "Kardus", description: "Kardus dengan profil kertas yang datar.", layer: 3, parent: "paper_pulp", children: []),
                FlavorWheelNode(id: "woody", name: "Kertas-kayu", description: "Serat kasar, mirip kertas basah.", layer: 3, parent: "paper_pulp", children: [])
            ]
        )
    ]
)

// MARK: - L1: Roasted
private let roasted = FlavorWheelNode(
    id: FlavorCategory.roasted.rawValue,
    name: "Panggang / sangrai",
    description: "Profil panggang, sereal, malt, hingga sentuhan asap dan tembakau.",
    layer: 1, parent: nil, children: [
        FlavorWheelNode(
            id: "cereal", name: "Sereal", description: "Biji-bijian, malt, dan sereal panggang.",
            layer: 2, parent: FlavorCategory.roasted.rawValue, children: [
                FlavorWheelNode(id: "malt", name: "Malt", description: "Malt dengan profil kering dan krispi.", layer: 3, parent: "cereal", children: []),
                FlavorWheelNode(id: "granola", name: "Granola", description: "Oat panggang dengan manis gandum.", layer: 3, parent: "cereal", children: []),
                FlavorWheelNode(id: "graham", name: "Graham", description: "Biskuit graham dengan manis cokelat panggang.", layer: 3, parent: "cereal", children: [])
            ]
        ),
        FlavorWheelNode(
            id: "tobacco_pipe", name: "Tembakau / aspal", description: "Karakter tembakau, aspal, dan aroma tungku tua.",
            layer: 2, parent: FlavorCategory.roasted.rawValue, children: [
                FlavorWheelNode(id: "ash", name: "Abu", description: "Abu tungku dengan profil panggang sangat tajam.", layer: 3, parent: "tobacco_pipe", children: []),
                FlavorWheelNode(id: "pipe_tobacco", name: "Tembakau pipa", description: "Tembakau pipa dengan manis tua.", layer: 3, parent: "tobacco_pipe", children: []),
                FlavorWheelNode(id: "smoke", name: "Asap", description: "Asap ringan, bukan asap menyengat (defek).", layer: 3, parent: "tobacco_pipe", children: [])
            ]
        ),
        FlavorWheelNode(
            id: "roasted_malt", name: "Gosong-kering", description: "Roti panggang atau kerak gandum dengan profil sangrai.",
            layer: 2, parent: FlavorCategory.roasted.rawValue, children: [
                FlavorWheelNode(id: "burnt", name: "Gosong", description: "Kesan karbon; deskripsikan dengan jujur.", layer: 3, parent: "roasted_malt", children: []),
                FlavorWheelNode(id: "acrid", name: "Akrid", description: "Panggang tajam yang menusuk dan getir.", layer: 3, parent: "roasted_malt", children: [])
            ]
        )
    ]
)

// MARK: - L1: Spices
private let spices = FlavorWheelNode(
    id: FlavorCategory.spices.rawValue,
    name: "Rempah",
    description: "Profil rempah-rempah yang aromatik, hangat, dan memberikan aksen pada cangkir.",
    layer: 1, parent: nil, children: [
        FlavorWheelNode(
            id: "baking_spice", name: "Rempah panggang", description: "Rempah hangat seperti kayu manis, cengkih, dan pala.",
            layer: 2, parent: FlavorCategory.spices.rawValue, children: [
                FlavorWheelNode(id: "cinnamon", name: "Kayu manis", description: "Kayu manis dengan profil hangat.", layer: 3, parent: "baking_spice", children: []),
                FlavorWheelNode(id: "clove", name: "Cengkih", description: "Cengkih dengan karakter tajam khas.", layer: 3, parent: "baking_spice", children: []),
                FlavorWheelNode(id: "nutmeg", name: "Pala", description: "Pala dengan karakter hangat tajam.", layer: 3, parent: "baking_spice", children: []),
                FlavorWheelNode(id: "anise", name: "Pekak", description: "Pekak atau adas manis.", layer: 3, parent: "baking_spice", children: [])
            ]
        ),
        FlavorWheelNode(
            id: "pepper", name: "Lada", description: "Nuansa lada dengan sensasi tajam di retronasal.",
            layer: 2, parent: FlavorCategory.spices.rawValue, children: [
                FlavorWheelNode(id: "black_pepper", name: "Lada hitam", description: "Lada hitam dengan profil pedas tajam.", layer: 3, parent: "pepper", children: []),
                FlavorWheelNode(id: "white_pepper", name: "Lada putih", description: "Lada putih dengan karakter tajam yang bersih.", layer: 3, parent: "pepper", children: []),
                FlavorWheelNode(id: "piperine", name: "Panas lada", description: "Sensasi hangat lada di retronasal.", layer: 3, parent: "pepper", children: [])
            ]
        ),
        FlavorWheelNode(
            id: "brownspice", name: "Rempah tajam-manis", description: "Rempah aromatik dengan profil manis-pedas.",
            layer: 2, parent: FlavorCategory.spices.rawValue, children: [
                FlavorWheelNode(id: "allspice", name: "Bunga pala campuran (allspice)", description: "Perpaduan aroma pala dan cengkih.", layer: 3, parent: "brownspice", children: []),
                FlavorWheelNode(id: "curry", name: "Kari lembut", description: "Bumbu kari sangat lembut.", layer: 3, parent: "brownspice", children: [])
            ]
        )
    ]
)

// MARK: - L1: Nutty / Cocoa
private let nuttyCocoa = FlavorWheelNode(
    id: FlavorCategory.nuttyCocoa.rawValue,
    name: "Kacang / kakao",
    description: "Profil gurih kacang-kacangan, biji-bijian, hingga intensitas cokelat.",
    layer: 1, parent: nil, children: [
        FlavorWheelNode(
            id: "nut", name: "Kacang", description: "Karakter kacang seperti almond, hazelnut, atau pecan.",
            layer: 2, parent: FlavorCategory.nuttyCocoa.rawValue, children: [
                FlavorWheelNode(id: "almond", name: "Almond", description: "Almond dengan profil lembut seperti marzipan.", layer: 3, parent: "nut", children: []),
                FlavorWheelNode(id: "hazelnut", name: "Hazelnut", description: "Hazelnut dengan manis panggang lembut.", layer: 3, parent: "nut", children: []),
                FlavorWheelNode(id: "peanuts", name: "Kacang tanah", description: "Kacang tanah dengan profil gurih.", layer: 3, parent: "nut", children: []),
                FlavorWheelNode(id: "pecan", name: "Pecan", description: "Pecan dengan rasa kacang panggang karamel.", layer: 3, parent: "nut", children: [])
            ]
        ),
        FlavorWheelNode(
            id: "cocoa", name: "Kakao / cokelat", description: "Profil cokelat mulai dari susu, hitam, hingga bubuk kakao.",
            layer: 2, parent: FlavorCategory.nuttyCocoa.rawValue, children: [
                FlavorWheelNode(id: "milk_chocolate", name: "Cokelat susu", description: "Cokelat susu dengan profil manis gurih.", layer: 3, parent: "cocoa", children: []),
                FlavorWheelNode(id: "dark_chocolate", name: "Cokelat hitam", description: "Cokelat hitam dengan rasa pahit-manis yang pekat.", layer: 3, parent: "cocoa", children: []),
                FlavorWheelNode(id: "cocoa_powder", name: "Bubuk kakao", description: "Bubuk kakao dengan profil kue cokelat lembut.", layer: 3, parent: "cocoa", children: []),
                FlavorWheelNode(id: "mocha", name: "Moka", description: "Perpaduan cokelat dan kopi yang lembut.", layer: 3, parent: "cocoa", children: [])
            ]
        )
    ]
)

// MARK: - Public bundle
enum FlavorWheelData {
    static let wheel: [FlavorWheelNode] = [
        sweet, floral, fruity, sourFermented, greenVegetative, other, roasted, spices, nuttyCocoa
    ]
}
