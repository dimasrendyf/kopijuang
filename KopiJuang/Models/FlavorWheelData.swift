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
    name: "Sweet",
    description: "Kesan manis: gula, madu, karamel, vanila, tanpa menambah gula.",
    layer: 1, parent: nil, children: [
        FlavorWheelNode(
            id: "brown_sugar", name: "Brown Sugar", description: "Gula cokelat, melase, pemanis hangat",
            layer: 2, parent: FlavorCategory.sweet.rawValue, children: [
                FlavorWheelNode(id: "honey", name: "Honey", description: "Madu, lengket manis alami", layer: 3, parent: "brown_sugar", children: []),
                FlavorWheelNode(id: "caramel", name: "Caramel", description: "Karamel/candy", layer: 3, parent: "brown_sugar", children: []),
                FlavorWheelNode(id: "maple_syrup", name: "Maple", description: "Sirup maple", layer: 3, parent: "brown_sugar", children: []),
                FlavorWheelNode(id: "molasses", name: "Molasses", description: "Melase pekat", layer: 3, parent: "brown_sugar", children: [])
            ]
        ),
        FlavorWheelNode(
            id: "vanilla", name: "Vanilla", description: "Vanili, creamy sweet aromatik", layer: 2, parent: FlavorCategory.sweet.rawValue, children: [
                FlavorWheelNode(id: "vanilla_bean", name: "Vanilla Bean", description: "Polong vanili", layer: 3, parent: "vanilla", children: []),
                FlavorWheelNode(id: "vanillin", name: "Vanillin", description: "Kesan vanilin ringan", layer: 3, parent: "vanilla", children: [])
            ]
        ),
        FlavorWheelNode(
            id: "sweetaromatic", name: "Sweet Aromatic", description: "Manis retronasal bulat, tanpa nut yang tegas", layer: 2, parent: FlavorCategory.sweet.rawValue, children: [
                FlavorWheelNode(id: "marshmallow", name: "Marshmallow", description: "Lembut manis (fluffy)", layer: 3, parent: "sweetaromatic", children: []),
                FlavorWheelNode(id: "cotton_candy", name: "Cotton Candy", description: "Manis kapas, ringan", layer: 3, parent: "sweetaromatic", children: [])
            ]
        )
    ]
)

// MARK: - L1: Floral
private let floral = FlavorWheelNode(
    id: FlavorCategory.floral.rawValue,
    name: "Floral",
    description: "Bunga, teh floral, wangi taman.",
    layer: 1, parent: nil, children: [
        FlavorWheelNode(
            id: "flowery", name: "Flowery", description: "Aroma kelopak / bunga potong",
            layer: 2, parent: FlavorCategory.floral.rawValue, children: [
                FlavorWheelNode(id: "jasmine", name: "Jasmine", description: "Melati", layer: 3, parent: "flowery", children: []),
                FlavorWheelNode(id: "rose", name: "Rose", description: "Mawar", layer: 3, parent: "flowery", children: []),
                FlavorWheelNode(id: "elderflower", name: "Elderflower", description: "Elderflower", layer: 3, parent: "flowery", children: []),
                FlavorWheelNode(id: "chamomile", name: "Chamomile", description: "Kamomil", layer: 3, parent: "flowery", children: [])
            ]
        ),
        FlavorWheelNode(
            id: "tea", name: "Tea", description: "Teh, aromatik rami",
            layer: 2, parent: FlavorCategory.floral.rawValue, children: [
                FlavorWheelNode(id: "black_tea", name: "Black Tea", description: "Teh hitam, tannin lembut", layer: 3, parent: "tea", children: []),
                FlavorWheelNode(id: "green_tea", name: "Green Tea", description: "Teh hijau, vegetal lembut", layer: 3, parent: "tea", children: []),
                FlavorWheelNode(id: "earl_grey", name: "Bergamot/Earl", description: "Aroma sitrus di teh", layer: 3, parent: "tea", children: [])
            ]
        )
    ]
)

// MARK: - L1: Fruity
private let fruity = FlavorWheelNode(
    id: FlavorCategory.fruity.rawValue,
    name: "Fruity",
    description: "Buah segar, buah kering, hingga buah ekstrem tropis.",
    layer: 1, parent: nil, children: [
        FlavorWheelNode(
            id: "berry", name: "Berry", description: "Keluarga berry",
            layer: 2, parent: FlavorCategory.fruity.rawValue, children: [
                FlavorWheelNode(id: "blackberry", name: "Blackberry", description: "Blackberry, gelap asam", layer: 3, parent: "berry", children: []),
                FlavorWheelNode(id: "raspberry", name: "Raspberry", description: "Raspberry, asam terang", layer: 3, parent: "berry", children: []),
                FlavorWheelNode(id: "blueberry", name: "Blueberry", description: "Blueberry, manis", layer: 3, parent: "berry", children: []),
                FlavorWheelNode(id: "strawberry", name: "Strawberry", description: "Stroberi", layer: 3, parent: "berry", children: [])
            ]
        ),
        FlavorWheelNode(
            id: "citrus", name: "Citrus", description: "Sitrun & kerabat",
            layer: 2, parent: FlavorCategory.fruity.rawValue, children: [
                FlavorWheelNode(id: "lemon", name: "Lemon", description: "Lemon, asam tajam", layer: 3, parent: "citrus", children: []),
                FlavorWheelNode(id: "lime", name: "Lime", description: "Jeruk nipis", layer: 3, parent: "citrus", children: []),
                FlavorWheelNode(id: "grapefruit", name: "Grapefruit", description: "Jeruk bali", layer: 3, parent: "citrus", children: []),
                FlavorWheelNode(id: "orange", name: "Orange", description: "Jeruk manis", layer: 3, parent: "citrus", children: [])
            ]
        ),
        FlavorWheelNode(
            id: "dried_fruit", name: "Dried Fruit", description: "Kismis, kuru, konsetrat buah kering",
            layer: 2, parent: FlavorCategory.fruity.rawValue, children: [
                FlavorWheelNode(id: "raisin", name: "Raisin", description: "Kismis", layer: 3, parent: "dried_fruit", children: []),
                FlavorWheelNode(id: "prune", name: "Prune", description: "Plum kering", layer: 3, parent: "dried_fruit", children: []),
                FlavorWheelNode(id: "fig", name: "Fig", description: "Buah ara kering", layer: 3, parent: "dried_fruit", children: [])
            ]
        ),
        FlavorWheelNode(
            id: "tropical", name: "Tropical", description: "Mangga, nenas, pisan, dsb.",
            layer: 2, parent: FlavorCategory.fruity.rawValue, children: [
                FlavorWheelNode(id: "mango", name: "Mango", description: "Mangga", layer: 3, parent: "tropical", children: []),
                FlavorWheelNode(id: "pineapple", name: "Pineapple", description: "Nanas", layer: 3, parent: "tropical", children: []),
                FlavorWheelNode(id: "papaya", name: "Papaya", description: "Pepaya", layer: 3, parent: "tropical", children: []),
                FlavorWheelNode(id: "coconut", name: "Coconut", description: "Kelapa", layer: 3, parent: "tropical", children: [])
            ]
        )
    ]
)

// MARK: - L1: Sour / Fermented
private let sourFermented = FlavorWheelNode(
    id: FlavorCategory.sourFermented.rawValue,
    name: "Sour / Fermented",
    description: "Asam, fermentasi terkontrol, winey, alkohol lembut.",
    layer: 1, parent: nil, children: [
        FlavorWheelNode(
            id: "sour", name: "Sour", description: "Asam sensorik, bukan cukup “dingin”",
            layer: 2, parent: FlavorCategory.sourFermented.rawValue, children: [
                FlavorWheelNode(id: "acetic", name: "Acetic", description: "Cuka ringan (sering tipe volatile)", layer: 3, parent: "sour", children: []),
                FlavorWheelNode(id: "malic", name: "Malic/Apple", description: "Asam apel, renyah", layer: 3, parent: "sour", children: []),
                FlavorWheelNode(id: "citric", name: "Citric", description: "Asam sitrus, cerah", layer: 3, parent: "sour", children: []),
                FlavorWheelNode(id: "tartaric", name: "Tartaric", description: "Tajam anggur", layer: 3, parent: "sour", children: [])
            ]
        ),
        FlavorWheelNode(
            id: "fermented", name: "Fermented", description: "Karakter proses/ferment buah, winey, overripe",
            layer: 2, parent: FlavorCategory.sourFermented.rawValue, children: [
                FlavorWheelNode(id: "overripe", name: "Overripe", description: "Sangat matang, buah terfermentasi", layer: 3, parent: "fermented", children: []),
                FlavorWheelNode(id: "winey", name: "Winey", description: "Kesan anggur/kulit buah", layer: 3, parent: "fermented", children: []),
                FlavorWheelNode(id: "fermented_berry", name: "Fermented fruit", description: "Buah hampir lambik", layer: 3, parent: "fermented", children: [])
            ]
        ),
        FlavorWheelNode(
            id: "alcohol", name: "Alcohol", description: "Ester ringan, likur buah, bukan etanol mentah",
            layer: 2, parent: FlavorCategory.sourFermented.rawValue, children: [
                FlavorWheelNode(id: "cherry_liqueur", name: "Cherry liqueur", description: "Ester kirsch ringan", layer: 3, parent: "alcohol", children: []),
                FlavorWheelNode(id: "whisky", name: "Whisky", description: "Ester kayu-alkohol (ringan)", layer: 3, parent: "alcohol", children: [])
            ]
        )
    ]
)

// MARK: - L1: Green / Vegetative
private let greenVegetative = FlavorWheelNode(
    id: FlavorCategory.greenVegetative.rawValue,
    name: "Green / Vegetative",
    description: "Hijau, herbaceous, sayuran, minyak zaitun, belum panggang cukup.",
    layer: 1, parent: nil, children: [
        FlavorWheelNode(
            id: "olive_oil", name: "Olive Oil", description: "Olive oil, rasa minyak zaitun",
            layer: 2, parent: FlavorCategory.greenVegetative.rawValue, children: [
                FlavorWheelNode(id: "olive", name: "Olive", description: "Zaitun, fruity hijau", layer: 3, parent: "olive_oil", children: []),
                FlavorWheelNode(id: "green_olive", name: "Green olive", description: "Zaitun muda, getir", layer: 3, parent: "olive_oil", children: [])
            ]
        ),
        FlavorWheelNode(
            id: "herbaceous", name: "Herbaceous", description: "Herba, rumput, fennel",
            layer: 2, parent: FlavorCategory.greenVegetative.rawValue, children: [
                FlavorWheelNode(id: "grass", name: "Grass", description: "Rumput segar, hay ringan", layer: 3, parent: "herbaceous", children: []),
                FlavorWheelNode(id: "dill", name: "Dill", description: "Rasa dill/fennel lembut", layer: 3, parent: "herbaceous", children: []),
                FlavorWheelNode(id: "sage", name: "Sage", description: "Sage, herbal pekat", layer: 3, parent: "herbaceous", children: [])
            ]
        ),
        FlavorWheelNode(
            id: "raw_beany", name: "Raw / Beany", description: "Kacang mentah, edamame, underdeveloped",
            layer: 2, parent: FlavorCategory.greenVegetative.rawValue, children: [
                FlavorWheelNode(id: "pea", name: "Pea/Edamame", description: "Kacang polong mentah", layer: 3, parent: "raw_beany", children: []),
                FlavorWheelNode(id: "peapod", name: "Peapod", description: "Buncis polong, hijau muda", layer: 3, parent: "raw_beany", children: [])
            ]
        )
    ]
)

// MARK: - L1: Other
private let other = FlavorWheelNode(
    id: FlavorCategory.other.rawValue,
    name: "Other",
    description: "Defek/asing ringan, kimia pelarut, bau kertas, bau tanah, dsb. (bukan tuduhan, hanya cita rasa).",
    layer: 1, parent: nil, children: [
        FlavorWheelNode(
            id: "chemical", name: "Chemical", description: "Kimia, obat, pelarut",
            layer: 2, parent: FlavorCategory.other.rawValue, children: [
                FlavorWheelNode(id: "medicinal", name: "Medicinal", description: "Terpentin, herba obat (ringan)", layer: 3, parent: "chemical", children: []),
                FlavorWheelNode(id: "rubber", name: "Rubber", description: "Karet/aldehida sisa sangrai", layer: 3, parent: "chemical", children: []),
                FlavorWheelNode(id: "petroleum", name: "Petroleum", description: "Bau hidrokarbon (defek, ringan jika dicatat)", layer: 3, parent: "chemical", children: [])
            ]
        ),
        FlavorWheelNode(
            id: "musty_earthy", name: "Musty / Earthy", description: "Lembab, bau bawah tanah, jamur",
            layer: 2, parent: FlavorCategory.other.rawValue, children: [
                FlavorWheelNode(id: "mushroom", name: "Mushroom", description: "Jamur, umami tanah", layer: 3, parent: "musty_earthy", children: []),
                FlavorWheelNode(id: "moldy", name: "Moldy", description: "Bau lembab/jamur (hati-hati catat level)", layer: 3, parent: "musty_earthy", children: []),
                FlavorWheelNode(id: "peat", name: "Peaty", description: "Tanah gambut, bau dapur basah", layer: 3, parent: "musty_earthy", children: [])
            ]
        ),
        FlavorWheelNode(
            id: "paper_pulp", name: "Papery / Pulp", description: "Kertas, lembab pulp, tungku basah (defek/asing)",
            layer: 2, parent: FlavorCategory.other.rawValue, children: [
                FlavorWheelNode(id: "cardboard", name: "Cardboard", description: "Kardus, paper flat", layer: 3, parent: "paper_pulp", children: []),
                FlavorWheelNode(id: "woody", name: "Woody papery", description: "Kertas kayu, bulir kasar", layer: 3, parent: "paper_pulp", children: [])
            ]
        )
    ]
)

// MARK: - L1: Roasted
private let roasted = FlavorWheelNode(
    id: FlavorCategory.roasted.rawValue,
    name: "Roasted",
    description: "Panggang, biji panggang, sereal, aspal, beras sangrai.",
    layer: 1, parent: nil, children: [
        FlavorWheelNode(
            id: "cereal", name: "Cereal", description: "Sereal sereal, beras sangrai, malt",
            layer: 2, parent: FlavorCategory.roasted.rawValue, children: [
                FlavorWheelNode(id: "malt", name: "Malt", description: "Malt, krispi sereal", layer: 3, parent: "cereal", children: []),
                FlavorWheelNode(id: "granola", name: "Granola", description: "Oat panggang", layer: 3, parent: "cereal", children: []),
                FlavorWheelNode(id: "graham", name: "Graham", description: "Biskuit graham", layer: 3, parent: "cereal", children: [])
            ]
        ),
        FlavorWheelNode(
            id: "tobacco_pipe", name: "Tobacco", description: "Tembakau, aspal, tembakau panggang",
            layer: 2, parent: FlavorCategory.roasted.rawValue, children: [
                FlavorWheelNode(id: "ash", name: "Ash", description: "Abu, tungku, sangrai tajam", layer: 3, parent: "tobacco_pipe", children: []),
                FlavorWheelNode(id: "pipe_tobacco", name: "Pipe tobacco", description: "Tembakau pipa", layer: 3, parent: "tobacco_pipe", children: []),
                FlavorWheelNode(id: "smoke", name: "Smoke", description: "Asap ringan, bukan off-flavor tajam", layer: 3, parent: "tobacco_pipe", children: [])
            ]
        ),
        FlavorWheelNode(
            id: "roasted_malt", name: "Toasted", description: "Roti panggang, gandum sangrai, crust",
            layer: 2, parent: FlavorCategory.roasted.rawValue, children: [
                FlavorWheelNode(id: "burnt", name: "Burnt", description: "Gosong, karbon (batasi pengecap)", layer: 3, parent: "roasted_malt", children: []),
                FlavorWheelNode(id: "acrid", name: "Acrid", description: "Bau tajam panggang tajam", layer: 3, parent: "roasted_malt", children: [])
            ]
        )
    ]
)

// MARK: - L1: Spices
private let spices = FlavorWheelNode(
    id: FlavorCategory.spices.rawValue,
    name: "Spices",
    description: "Rempah panggang, lada, cengkih, pala, pungent aromatik.",
    layer: 1, parent: nil, children: [
        FlavorWheelNode(
            id: "baking_spice", name: "Baking Spices", description: "Pala, cengkih, kayu manis, spekoek",
            layer: 2, parent: FlavorCategory.spices.rawValue, children: [
                FlavorWheelNode(id: "cinnamon", name: "Cinnamon", description: "Kayu manis, hangat", layer: 3, parent: "baking_spice", children: []),
                FlavorWheelNode(id: "clove", name: "Clove", description: "Cengkih", layer: 3, parent: "baking_spice", children: []),
                FlavorWheelNode(id: "nutmeg", name: "Nutmeg", description: "Pala, hangat tajam", layer: 3, parent: "baking_spice", children: []),
                FlavorWheelNode(id: "anise", name: "Anise", description: "Pekak, lici", layer: 3, parent: "baking_spice", children: [])
            ]
        ),
        FlavorWheelNode(
            id: "pepper", name: "Pepper", description: "Lada hitam, putih, makhwerk",
            layer: 2, parent: FlavorCategory.spices.rawValue, children: [
                FlavorWheelNode(id: "black_pepper", name: "Black pepper", description: "Lada hitam", layer: 3, parent: "pepper", children: []),
                FlavorWheelNode(id: "white_pepper", name: "White pepper", description: "Lada putih", layer: 3, parent: "pepper", children: []),
                FlavorWheelNode(id: "piperine", name: "Peppery burn", description: "Sensasi panas lada retronasal", layer: 3, parent: "pepper", children: [])
            ]
        ),
        FlavorWheelNode(
            id: "brownspice", name: "Pungent sweet spice", description: "Rempah tajam manis, serupa spekoek, bukan cengkih saja",
            layer: 2, parent: FlavorCategory.spices.rawValue, children: [
                FlavorWheelNode(id: "allspice", name: "Allspice", description: "Bunga lawang campuran", layer: 3, parent: "brownspice", children: []),
                FlavorWheelNode(id: "curry", name: "Curry soft", description: "Bumbu kari sangat lembut (bukan makanan)", layer: 3, parent: "brownspice", children: [])
            ]
        )
    ]
)

// MARK: - L1: Nutty / Cocoa
private let nuttyCocoa = FlavorWheelNode(
    id: FlavorCategory.nuttyCocoa.rawValue,
    name: "Nutty / Cocoa",
    description: "Kacang, biji-bijian, kakao, cokelat, almond.",
    layer: 1, parent: nil, children: [
        FlavorWheelNode(
            id: "nut", name: "Nut", description: "Kacang: almond, hazel, tanah, pecan",
            layer: 2, parent: FlavorCategory.nuttyCocoa.rawValue, children: [
                FlavorWheelNode(id: "almond", name: "Almond", description: "Almond, marzipan lembut", layer: 3, parent: "nut", children: []),
                FlavorWheelNode(id: "hazelnut", name: "Hazelnut", description: "Hazelnut, Ferrero lembut", layer: 3, parent: "nut", children: []),
                FlavorWheelNode(id: "peanuts", name: "Peanut", description: "Kacang tanah, selai kacang", layer: 3, parent: "nut", children: []),
                FlavorWheelNode(id: "pecan", name: "Pecan", description: "Pecan, maple-nut", layer: 3, parent: "nut", children: [])
            ]
        ),
        FlavorWheelNode(
            id: "cocoa", name: "Cocoa", description: "Bubuk kakao, cokelat susu, dark chocolate, malted cocoa",
            layer: 2, parent: FlavorCategory.nuttyCocoa.rawValue, children: [
                FlavorWheelNode(id: "milk_chocolate", name: "Milk chocolate", description: "Cokelat susu, manis gurih", layer: 3, parent: "cocoa", children: []),
                FlavorWheelNode(id: "dark_chocolate", name: "Dark chocolate", description: "Cokelat hitam, pahit manis", layer: 3, parent: "cocoa", children: []),
                FlavorWheelNode(id: "cocoa_powder", name: "Cocoa powder", description: "Bubuk kakao, brownie lembut", layer: 3, parent: "cocoa", children: []),
                FlavorWheelNode(id: "mocha", name: "Mocha", description: "Cokelat + kopi lembut", layer: 3, parent: "cocoa", children: [])
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
