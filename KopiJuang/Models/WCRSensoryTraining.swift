//
//  WCRSensoryTraining.swift
//  KopiJuang
//
//  Praktik latihan indera berbasis World Coffee Research Sensory Lexicon.
//

import Foundation

struct SensoryTrainingGuide: Sendable {
    let nodeId: String
    let smellTraining: String
    let tasteTraining: String
    let mouthTraining: String
    let dailyDrill: String
}

enum WCRSensoryTrainingData {
    static func guide(for nodeId: String) -> SensoryTrainingGuide {
        guides[nodeId] ?? generatedGuide(for: nodeId)
    }

    static func specificGuide(for nodeId: String) -> SensoryTrainingGuide? {
        guide(for: nodeId)
    }

    private static func generatedGuide(for nodeId: String) -> SensoryTrainingGuide {
        let nodeName = FlavorWheelNode.findNode(by: nodeId)?.name ?? nodeId
        let nodeDescription = FlavorWheelNode.findNode(by: nodeId)?.description ?? "Catatan rasa yang kamu pilih."
        return SensoryTrainingGuide(
            nodeId: nodeId,
            smellTraining: "Cium kopinya pendek-pendek. Cari kesan \(nodeName.lowercased()) di aroma pertama. \(nodeDescription)",
            tasteTraining: "Seruput sedikit lalu hembuskan lewat hidung. Kalau kesan \(nodeName.lowercased()) muncul, catat sebagai kandidat kuat.",
            mouthTraining: "Tunggu 10–15 detik setelah menelan. Perhatikan apakah finish terasa bersih, kering, tebal, pahit, sepet, atau berminyak.",
            dailyDrill: "Cari bahan dari dapur yang mirip, lalu bandingkan langsung dengan kopimu. Tidak harus sama persis — yang penting kamu melatih memori baunya."
        )
    }

    private static let guides: [String: SensoryTrainingGuide] = [

        // MARK: - Sweet
        "Sweet": .make(
            "Sweet",
            smell: "Cium kopinya pelan. Kalau tercium manis hangat seperti madu atau karamel — bukan manis gula pasir — kamu sedang mencium sweet.",
            taste: "Di mulut, manis ini terasa lembut dan bikin rasa keseluruhan terasa bulat dan nyaman. Tidak tajam, tidak mencolok.",
            mouth: "Setelah ditelan, mulut terasa bersih dan tidak kering. Ini tanda sweet yang bagus.",
            drill: "Cium madu, brown sugar, dan vanila satu per satu. Hafalkan mana yang paling 'hangat' dan mana yang paling 'ringan'."
        ),
        "brown_sugar": .make(
            "brown_sugar",
            smell: "Cium kopinya. Kalau tercium manis gelap seperti gula merah atau molase — lebih berat dari madu biasa — ini brown sugar.",
            taste: "Manisnya terasa di tengah lidah, hangat dan sedikit karamel. Bukan manis tipis yang langsung hilang.",
            mouth: "Finish bisa terasa sedikit pekat atau seperti karamel. Kalau ada kesan 'manis gelap', kamu di jalur yang benar.",
            drill: "Cium gula merah, molase, dan karamel. Bedakan mana yang lebih ringan dan mana yang lebih gelap."
        ),
        "honey": .make(
            "honey",
            smell: "Cari manis madu: ringan, sedikit floral, hangat. Lebih halus dari karamel.",
            taste: "Kalau manisnya terasa cair dan lembut — bukan pekat seperti karamel — pilih honey.",
            mouth: "Finish halus, kadang ada sedikit wangi bunga di belakang. Tidak berat.",
            drill: "Cicip madu encer sedikit. Cari rasa manis lembutnya di kopi hangat."
        ),
        "caramel": .make(
            "caramel",
            smell: "Cari gula yang dimasak: manis hangat, sedikit panggang. Berbeda dari madu yang lebih floral.",
            taste: "Kalau manisnya terasa seperti gula leleh atau permen karamel tipis, ini dia.",
            mouth: "Finish hangat dan bulat. Kadang ada kesan sedikit lengket di lidah.",
            drill: "Cium atau cicip karamel. Bedakan dari gula terbakar (burnt) — karamel masih enak, burnt sudah pahit."
        ),
        "maple_syrup": .make(
            "maple_syrup",
            smell: "Cari manis dengan sentuhan kayu: hangat, sedikit brown, seperti sirup maple.",
            taste: "Maple terasa manis tapi lebih kering dan kayu dibanding madu.",
            mouth: "Finish manis-kayu, ringan, tidak terlalu pekat.",
            drill: "Cicip maple syrup encer, lalu bandingkan dengan madu. Bedanya: maple lebih 'kayu', madu lebih 'bunga'."
        ),
        "molasses": .make(
            "molasses",
            smell: "Cari manis yang pekat dan gelap, ada sedikit tajam di hidung.",
            taste: "Kalau manisnya berat dan ada kesan pahit-manis di belakang lidah, ini molasses.",
            mouth: "Finish panjang, gelap, sedikit lengket. Lebih intens dari brown sugar.",
            drill: "Cium gula merah tua atau tetes tebu. Fokus ke sisi 'gelapnya', bukan cuma manisnya."
        ),
        "vanilla": .make(
            "vanilla",
            smell: "Cari aroma vanila: manis lembut, sedikit kayu, kadang ada sentuhan bunga.",
            taste: "Vanila biasanya muncul lewat hidung bagian dalam setelah menelan, bukan langsung di lidah depan. Seruput lalu hembuskan lewat hidung.",
            mouth: "Finish lembut dan harum, tidak tebal seperti karamel.",
            drill: "Cium vanilla extract atau biji vanila. Cari aromanya di aftertaste kopi."
        ),
        "vanilla_bean": .make(
            "vanilla_bean",
            smell: "Cari vanila asli dari biji: hangat, kayu, sedikit bunga. Lebih kompleks dari vanila botolan.",
            taste: "Kalau rasanya lebih kaya dan natural dibanding vanila biasa, pilih vanilla bean.",
            mouth: "Finish harum-kayu, lembut, bersih.",
            drill: "Cium biji vanila atau vanilla paste kalau ada. Bandingkan dengan vanilla extract biasa."
        ),
        "vanillin": .make(
            "vanillin",
            smell: "Cari vanila yang simpel dan bersih, seperti essence vanila atau marshmallow.",
            taste: "Kalau aromanya familiar dan ringan — seperti kue vanila — pilih vanillin.",
            mouth: "Finish manis-harum, ringan, tidak kompleks.",
            drill: "Bandingkan vanilla extract dengan marshmallow. Vanillin terasa lebih simpel."
        ),
        "sweetaromatic": .make(
            "sweetaromatic",
            smell: "Cari manis yang tercium di hidung, bukan manis di lidah: seperti permen kapas atau marshmallow dari jauh.",
            taste: "Seruput lalu hembuskan lewat hidung. Kalau muncul kesan manis airy di hidung belakang, ini sweet aromatic.",
            mouth: "Finish ringan dan 'airy', tidak berat atau lengket.",
            drill: "Cium marshmallow dan permen kapas. Fokus ke aroma manisnya, bukan rasanya."
        ),
        "marshmallow": .make(
            "marshmallow",
            smell: "Cari manis lembut, vanila tipis, sedikit creamy.",
            taste: "Kalau manisnya terasa empuk dan ringan lewat hidung setelah menelan, pilih marshmallow.",
            mouth: "Finish halus, sedikit creamy, bersih.",
            drill: "Cium marshmallow, lalu cari kesan empuk-manisnya di kopi."
        ),
        "cotton_candy": .make(
            "cotton_candy",
            smell: "Cari manis sangat ringan seperti bau gula kapas dari kejauhan.",
            taste: "Kalau manisnya terasa 'airy' dan cepat hilang begitu ditelan, pilih cotton candy.",
            mouth: "Finish tipis, hampir tidak berbekas.",
            drill: "Cium permen kapas atau gula halus. Cari manis yang tidak punya 'berat'."
        ),

        // MARK: - Floral
        "Floral": .make(
            "Floral",
            smell: "Cium kopinya. Kalau ada wangi bunga — seperti mawar, melati, atau teh bunga — itu floral. Biasanya naik ke hidung duluan sebelum terasa di lidah.",
            taste: "Seruput dan hembuskan lewat hidung. Floral sering muncul di sini, bukan di ujung lidah.",
            mouth: "Finish bisa halus dan wangi, kadang sedikit kering seperti teh.",
            drill: "Cium teh bunga, mawar, melati, chamomile. Cari mana yang paling mirip dengan kopimu."
        ),
        "flowery": .make(
            "flowery",
            smell: "Cari kelopak bunga segar: ringan, harum, sedikit manis. Bukan parfum yang tajam.",
            taste: "Kalau wangi bunga tetap terasa setelah menelan, pilih flowery.",
            mouth: "Finish bersih dan wangi. Berbeda dari tanin teh yang sedikit sepet.",
            drill: "Cium bunga segar atau teh bunga. Bedakan dari parfum — flowery di kopi lebih halus."
        ),
        "jasmine": .make(
            "jasmine",
            smell: "Cari melati: wangi bunga yang agak tajam dan manis, sedikit 'hijau'.",
            taste: "Melati biasanya terasa kuat di hidung belakang setelah menelan.",
            mouth: "Finish wangi, bisa sedikit intens.",
            drill: "Cium teh melati. Ingat wangi tajam-manisnya."
        ),
        "rose": .make(
            "rose",
            smell: "Cari mawar: floral manis, lembut, sedikit 'berdebu'.",
            taste: "Kalau floralnya lebih lembut dari melati dan terasa manis, pilih rose.",
            mouth: "Finish lembut dan harum.",
            drill: "Cium rose water atau kelopak mawar segar yang bersih."
        ),
        "elderflower": .make(
            "elderflower",
            smell: "Cari bunga yang ringan dengan sedikit sentuhan sitrus di belakangnya.",
            taste: "Kalau floralnya terasa airy dan ada sedikit rasa seperti lemon tipis, pilih elderflower.",
            mouth: "Finish ringan, segar, tidak tajam.",
            drill: "Cicip minuman elderflower kalau ada, atau bandingkan dengan lemon tea ringan."
        ),
        "chamomile": .make(
            "chamomile",
            smell: "Cari bunga yang juga terasa seperti herba: chamomile, teh kering, sedikit kayu.",
            taste: "Kalau floralnya terasa lebih seperti teh herbal daripada bunga potong, pilih chamomile.",
            mouth: "Finish ringan, sedikit kering.",
            drill: "Seduh chamomile tea. Cium dulu sebelum diminum, lalu cicip."
        ),
        "tea": .make(
            "tea",
            smell: "Cari daun teh: kering, floral tipis, sedikit kayu.",
            taste: "Teh muncul sebagai tanin ringan dan aftertaste kering — seperti setelah minum teh tawar.",
            mouth: "Cari sensasi mulut sedikit kesat, tapi bukan pahit yang kasar.",
            drill: "Bandingkan teh hitam, teh hijau, dan earl grey. Masing-masing punya karakter berbeda."
        ),
        "black_tea": .make(
            "black_tea",
            smell: "Cari teh hitam: daun kering, sedikit brown, ada kesan 'tua'.",
            taste: "Kalau ada tanin seperti teh seduh kental, pilih black tea.",
            mouth: "Finish kering dan sedikit sepet di lidah.",
            drill: "Seduh black tea ringan. Perhatikan rasa sepet-keringnya."
        ),
        "green_tea": .make(
            "green_tea",
            smell: "Cari teh hijau: segar, daun, sedikit sayur. Lebih ringan dari teh hitam.",
            taste: "Kalau terasa hijau tapi halus — seperti teh, bukan rumput mentah — pilih green tea.",
            mouth: "Finish bersih, sedikit kering.",
            drill: "Seduh green tea ringan. Bandingkan dengan rumput segar untuk merasakan bedanya."
        ),
        "earl_grey": .make(
            "earl_grey",
            smell: "Cari teh dengan sentuhan sitrus bergamot.",
            taste: "Kalau teh dan sitrus muncul bersamaan di hidung belakang setelah menelan, pilih earl grey.",
            mouth: "Finish teh-kering dengan sentuhan aroma sitrus.",
            drill: "Cium earl grey. Fokus ke aroma bergamot-nya — itu yang bikin beda dari teh biasa."
        ),

        // MARK: - Fruity
        "Fruity": .make(
            "Fruity",
            smell: "Cium kopinya pendek. Kalau tercium buah — cerah seperti jeruk, merah seperti berry, atau pekat seperti kismis — kamu sedang mencium fruity.",
            taste: "Seruput saat panas, lalu ulangi saat kopi mulai hangat. Fruity sering lebih jelas saat suhu turun.",
            mouth: "Bedakan fruity dari sekadar asam. Fruity punya rasa juicy atau manis buah — bukan cuma tusukan asam.",
            drill: "Sebelum nyeruput, cium dulu buah asli: jeruk, berry, nanas, atau kismis. Lalu cari kesamaannya di kopi."
        ),
        "berry": .make(
            "berry",
            smell: "Cari buah merah atau gelap. Strawberry lebih ringan, raspberry lebih tajam, blueberry lebih bulat, blackberry paling pekat.",
            taste: "Berry terasa asam-manis, bukan setajam lemon. Kalau mirip selai buah gelap, kamu di jalur yang benar.",
            mouth: "Cari sepet ringan seperti kulit buah. Berry gelap biasanya meninggalkan aftertaste lebih panjang.",
            drill: "Bandingkan stroberi segar, bluberi, dan selai blackberry. Hafalkan beda 'terang' vs 'gelap'."
        ),
        "strawberry": .make(
            "strawberry",
            smell: "Cari buah merah muda, manis, sedikit asam. Lebih ringan dari berry gelap.",
            taste: "Kalau asam-manis muncul cepat dan finish terasa bersih, pikir strawberry.",
            mouth: "Body ringan. Aftertaste lembut, tidak pekat seperti selai.",
            drill: "Cium strawberry segar, lalu strawberry jam. Bedakan 'segar' vs 'matang dimasak'."
        ),
        "raspberry": .make(
            "raspberry",
            smell: "Cari berry yang paling cerah dan tajam. Lebih ringan dari blackberry tapi lebih menusuk dari strawberry.",
            taste: "Asamnya naik cepat. Kalau terasa seperti frambos atau permen raspberry tipis, pilih ini.",
            mouth: "Finish sedang, sedikit kering, tidak berat.",
            drill: "Bandingkan raspberry dengan strawberry langsung. Raspberry lebih tajam dan cerah."
        ),
        "blueberry": .make(
            "blueberry",
            smell: "Cari berry manis yang bulat dan agak gelap — tidak setajam raspberry.",
            taste: "Kalau rasanya lembut seperti blueberry syrup dan tidak menusuk, pilih blueberry.",
            mouth: "Aftertaste manis gelap, lebih lembut dari blackberry.",
            drill: "Cium bluberi segar dan bluberi kalengan. Ingat karakter 'bulat' dan 'gelap'nya."
        ),
        "blackberry": .make(
            "blackberry",
            smell: "Cari berry paling gelap. Ada manis pekat, sedikit bunga, kadang ada sentuhan kayu.",
            taste: "Kalau mirip selai buah gelap dan lebih berat dari blueberry, pilih blackberry.",
            mouth: "Finish bisa sepet dan kayu. Tidak secerah raspberry.",
            drill: "Cicip blackberry jam tipis. Cari rasa 'gelapnya', bukan cuma manisnya."
        ),
        "dried_fruit": .make(
            "dried_fruit",
            smell: "Cari buah gelap yang sudah tidak segar: kismis, plum kering, kurma.",
            taste: "Kalau manisnya pekat dan berat — bukan segar dan juicy — pilih dried fruit.",
            mouth: "Body cenderung lebih tebal. Aftertaste gelap dan tahan lama.",
            drill: "Cium kismis dan prune sebelum nyeruput. Hafalkan rasa 'pekat matang'nya."
        ),
        "raisin": .make(
            "raisin",
            smell: "Cari manis kental seperti anggur yang dikeringkan.",
            taste: "Kalau ada manis kismis seperti di roti dan sedikit asam anggur di belakangnya, pilih raisin.",
            mouth: "Aftertaste manis pekat, tapi lebih bersih dari prune.",
            drill: "Kunyah satu kismis pelan-pelan. Ingat manis asamnya."
        ),
        "prune": .make(
            "prune",
            smell: "Cari buah gelap, tua, sedikit melewati kematangan.",
            taste: "Kalau asam-manisnya mirip plum tua dan lebih berat dari kismis, pilih prune.",
            mouth: "Body lebih berat. Aftertaste gelap dan agak lembap.",
            drill: "Cium plum kering atau prune. Fokus ke sisi 'gelap' dan 'lewat matang'nya."
        ),
        "fig": .make(
            "fig",
            smell: "Cari buah kering yang lembut, manis, tidak terlalu asam.",
            taste: "Kalau dried fruit terasa halus dan sedikit seperti madu — bukan kismis yang tajam — pilih fig.",
            mouth: "Finish lembut, manis, sedikit tebal.",
            drill: "Cicip ara kering. Bandingkan dengan kismis — ara lebih lembut dan manis."
        ),
        "citrus": .make(
            "Citrus",
            smell: "Cium kulit jeruk: segar, tajam, sedikit bunga. Ini aroma sitrus yang kamu cari.",
            taste: "Sitrus terasa cepat di depan dan sisi lidah. Lemon/lime lebih tajam, orange lebih manis, grapefruit ada pahit bersihnya.",
            mouth: "Cari sepet ringan seperti kulit jeruk. Finish harus bersih dan cerah.",
            drill: "Kupas jeruk, lemon, atau jeruk nipis. Cium kulitnya, lalu cari sensasi itu di kopimu."
        ),
        "lemon": .make(
            "lemon",
            smell: "Cari asam kuning yang bersih. Lemon lebih 'terang' dari jeruk nipis.",
            taste: "Kalau asam terasa tajam tapi tidak pahit, pilih lemon.",
            mouth: "Finish cerah, ringan, bersih.",
            drill: "Cium kulit lemon. Cicip air lemon yang sangat encer."
        ),
        "lime": .make(
            "lime",
            smell: "Cari asam hijau, tajam, sedikit pahit. Seperti jeruk nipis.",
            taste: "Kalau terasa seperti jeruk nipis dan lebih 'hijau' dari lemon, pilih lime.",
            mouth: "Finish tajam dan bersih. Bisa sedikit sepet.",
            drill: "Cium kulit jeruk nipis. Bandingkan langsung dengan lemon."
        ),
        "grapefruit": .make(
            "grapefruit",
            smell: "Cari sitrus dengan pahit yang bersih di belakangnya.",
            taste: "Kalau asamnya diikuti pahit yang elegan — bukan pahit gosong — pilih grapefruit.",
            mouth: "Aftertaste pahit-segar, lebih jelas dari orange.",
            drill: "Cicip grapefruit atau jeruk bali. Ingat rasa pahit segar di akhirnya."
        ),
        "orange": .make(
            "orange",
            smell: "Cari sitrus yang manis dan bulat. Tidak setajam lemon.",
            taste: "Kalau asamnya lembut dan ada manis jeruk yang jelas, pilih orange.",
            mouth: "Finish manis-sitrus, tidak setajam lemon atau lime.",
            drill: "Cium kulit jeruk manis. Bandingkan dengan lemon — orange lebih bulat dan manis."
        ),
        "tropical": .make(
            "tropical",
            smell: "Cari buah yang penuh, hangat, dan juicy: nanas cerah, mangga/pepaya lebih lembut, kelapa creamy.",
            taste: "Tropis terasa lebih penuh dan berat dari sitrus. Kalau bright, pikir nanas. Kalau lembut-manis, pikir mangga.",
            mouth: "Cari body yang juicy atau creamy — tidak tipis.",
            drill: "Cium nanas, mangga, dan kelapa satu per satu. Latih beda 'cerah' vs 'creamy'."
        ),
        "pineapple": .make(
            "pineapple",
            smell: "Cari tropis yang cerah dan agak tajam.",
            taste: "Kalau juicy, manis-asam, dan tidak creamy, pilih pineapple.",
            mouth: "Finish segar. Bisa ada sepet ringan.",
            drill: "Cium nanas segar. Ingat tusukan asamnya yang cerah."
        ),
        "coconut": .make(
            "coconut",
            smell: "Cari manis ringan, gurih, sedikit kayu. Seperti kelapa parut.",
            taste: "Kalau buahnya creamy dan tidak asam, dan ada rasa kelapa, pilih coconut.",
            mouth: "Cari kesan creamy atau sedikit berlemak di mulut.",
            drill: "Cium kelapa parut atau santan. Fokus ke rasa lemak manisnya."
        ),
        "mango": .make(
            "mango",
            smell: "Cari buah tropis yang manis, matang, penuh.",
            taste: "Kalau rasa buahnya bulat dan tidak setajam nanas, pilih mango.",
            mouth: "Finish juicy, manis, agak tebal.",
            drill: "Cium mangga matang. Bedakan dari nanas yang lebih tajam."
        ),
        "papaya": .make(
            "papaya",
            smell: "Cari tropis yang lembut, manis, tidak terlalu tajam.",
            taste: "Kalau buahnya halus dan tidak menusuk — sedikit 'musky' — pilih papaya.",
            mouth: "Finish lembut, body sedang.",
            drill: "Cicip pepaya matang. Fokus ke manis lembutnya yang tidak mencolok."
        ),

        // MARK: - Sour / Fermented
        "Sour / Fermented": .make(
            "Sour / Fermented",
            smell: "Cari asam bersih, buah matang, seperti wine, atau fermentasi lembut.",
            taste: "Asam bersih terasa menyegarkan. Fermentasi terasa lebih kompleks — seperti buah terlalu matang atau wine.",
            mouth: "Cek apakah finish terasa menyegarkan, sepat, atau sedikit hangat seperti fermentasi.",
            drill: "Bandingkan apel hijau, lemon, cuka encer, dan buah yang lewat matang."
        ),
        "sour": .make(
            "sour",
            smell: "Cari asam bersih tanpa bau tidak sedap: sitrus, apel, atau cuka tipis.",
            taste: "Asam terasa di sisi lidah. Ada tiga jenis: citric (seperti jeruk), malic (seperti apel), acetic (seperti cuka). Masing-masing punya 'karakter' berbeda.",
            mouth: "Finish bisa bikin air liur naik — itu normal dan tidak selalu berarti cacat.",
            drill: "Cicip air lemon encer dan apel hijau. Bandingkan rasa asamnya — mana yang lebih 'menusuk' dan mana yang lebih 'renyah'."
        ),
        "acetic": .make(
            "acetic",
            smell: "Cari cuka tipis: asam yang sedikit menusuk di hidung.",
            taste: "Kalau asamnya terasa seperti cuka ringan — bukan jeruk atau apel — pilih acetic.",
            mouth: "Finish tajam, bisa sedikit kering.",
            drill: "Cium cuka yang sudah sangat diencerkan dari jauh. Jangan terlalu dekat."
        ),
        "malic": .make(
            "malic",
            smell: "Cari asam apel hijau: segar dan renyah.",
            taste: "Kalau asamnya terasa seperti menggigit apel hijau — segar, bukan menusuk — pilih malic.",
            mouth: "Finish bersih, bikin mulut terasa segar.",
            drill: "Cicip apel hijau. Ingat rasa asam renyahnya."
        ),
        "citric": .make(
            "citric",
            smell: "Cari asam sitrus: lemon, jeruk, atau jeruk nipis.",
            taste: "Kalau asamnya cerah dan ringan seperti sitrus, pilih citric.",
            mouth: "Finish bersih, bikin air liur naik.",
            drill: "Cicip air lemon yang sangat encer."
        ),
        "tartaric": .make(
            "tartaric",
            smell: "Cari asam anggur: lebih berat dan 'berat' dari lemon.",
            taste: "Kalau asam terasa seperti anggur atau wine dan ada sedikit sepat, pilih tartaric.",
            mouth: "Finish bisa sedikit kering seperti kulit anggur.",
            drill: "Cicip anggur hijau atau jus anggur yang diencerkan."
        ),
        "fermented": .make(
            "fermented",
            smell: "Cari buah matang, ada sedikit ragi, seperti wine atau bir buah yang ringan.",
            taste: "Fermentasi bukan selalu cacat. Kalau kompleks seperti wine atau kombucha buah, pilih fermented.",
            mouth: "Finish bisa panjang, sedikit hangat, atau sepat.",
            drill: "Bandingkan buah matang, kombucha ringan, dan aroma wine."
        ),
        "overripe": .make(
            "overripe",
            smell: "Cari buah yang sudah lewat matang: manis, sedikit lembap, ada sedikit asam.",
            taste: "Kalau rasa buahnya terasa 'lewat matang' tapi belum busuk, pilih overripe.",
            mouth: "Finish berat dan sedikit lembap.",
            drill: "Cium pisang yang sudah sangat matang. Fokus ke manis yang 'berlebihan'."
        ),
        "winey": .make(
            "winey",
            smell: "Cari wine: ada buah, sedikit alkohol, sedikit tanin.",
            taste: "Kalau kompleks seperti anggur merah atau ada rasa kulit anggur, pilih winey.",
            mouth: "Finish bisa sedikit sepat halus.",
            drill: "Cium wine atau jus anggur pekat. Cari sisi 'kulit buah'nya."
        ),
        "fermented_berry": .make(
            "fermented_berry",
            smell: "Cari berry yang asam-kompleks, seperti minuman cider atau bir buah ringan.",
            taste: "Kalau berry terasa ada fermentasinya dan tidak segar murni, pilih fermented berry.",
            mouth: "Finish panjang, asam, sedikit unik.",
            drill: "Bandingkan berry segar dengan kombucha rasa berry."
        ),
        "alcohol": .make(
            "alcohol",
            smell: "Cari alkohol yang sangat ringan: seperti wine, spirit, atau whiskey dari jauh.",
            taste: "Kalau ada kehangatan tipis di tenggorokan — tapi tidak menyengat — pilih alcohol.",
            mouth: "Finish hangat ringan di belakang, bukan pedas atau kasar.",
            drill: "Cium whiskey atau wine dari jauh. Fokus ke aroma hangatnya, bukan alkoholnya."
        ),
        "cherry_liqueur": .make(
            "cherry_liqueur",
            smell: "Cari ceri manis dengan sentuhan minuman keras ringan.",
            taste: "Kalau rasa ceri terasa hangat dan seperti sirup, pilih cherry liqueur.",
            mouth: "Finish manis-hangat.",
            drill: "Cium cherry syrup atau maraschino cherry."
        ),
        "whisky": .make(
            "whisky",
            smell: "Cari kayu oak, grain, vanila, dan alkohol yang lembut.",
            taste: "Kalau ada kesan kayu-hangat seperti whiskey yang diencerkan, pilih whisky.",
            mouth: "Finish hangat dan kayu.",
            drill: "Cium whiskey dari jauh, atau cium kayu oak dan vanila."
        ),

        // MARK: - Green / Vegetative
        "Green / Vegetative": .make(
            "Green / Vegetative",
            smell: "Cari aroma hijau: rumput, daun, polong, zaitun, atau sayuran.",
            taste: "Kalau terasa seperti tanaman segar atau mentah, pilih green vegetative.",
            mouth: "Finish bisa segar, sedikit pahit, atau seperti biji mentah.",
            drill: "Cium rumput segar, parsley, kacang polong, dan zaitun. Perhatikan perbedaannya."
        ),
        "olive_oil": .make(
            "olive_oil",
            smell: "Cari minyak zaitun: hijau, sedikit berlemak, ada sentuhan lada.",
            taste: "Kalau aroma hijaunya terasa berlemak atau oily, pilih olive oil.",
            mouth: "Cari lapisan minyak tipis di mulut.",
            drill: "Cicip olive oil extra virgin sedikit. Fokus ke rasa hijau-lemaknya."
        ),
        "olive": .make(
            "olive",
            smell: "Cari zaitun matang: buah, hijau, sedikit asin.",
            taste: "Kalau hijaunya terasa berlemak-buah dan tidak terlalu tajam, pilih olive.",
            mouth: "Finish sedikit oily dan ringan.",
            drill: "Cicip zaitun matang."
        ),
        "green_olive": .make(
            "green_olive",
            smell: "Cari zaitun muda: hijau, pahit, tajam.",
            taste: "Kalau ada pahit hijau seperti zaitun muda, pilih green olive.",
            mouth: "Finish pahit dan sedikit asin.",
            drill: "Cicip green olive, lalu bandingkan dengan olive oil."
        ),
        "herbaceous": .make(
            "herbaceous",
            smell: "Cari daun atau herba segar: rumput, dill, sage, parsley.",
            taste: "Kalau hijaunya terasa aromatik seperti herba dapur — bukan sayur kaleng — pilih herbaceous.",
            mouth: "Finish segar, kadang sedikit pahit.",
            drill: "Cium parsley, basil, sage, dan dill satu per satu."
        ),
        "grass": .make(
            "grass",
            smell: "Cari rumput baru dipotong: segar, hijau, bersih.",
            taste: "Kalau hijaunya ringan dan segar, pilih grass.",
            mouth: "Finish bersih, sedikit kering.",
            drill: "Cium rumput segar yang bersih. Jangan yang sudah layu."
        ),
        "dill": .make(
            "dill",
            smell: "Cari dill atau adas: herbal, manis tipis, sedikit seperti anise.",
            taste: "Kalau herbanya mengarah ke adas, pilih dill.",
            mouth: "Finish herbal ringan.",
            drill: "Cium dill segar atau adas."
        ),
        "sage": .make(
            "sage",
            smell: "Cari sage: herbal tajam, sedikit medicinal.",
            taste: "Kalau herbanya kuat dan agak kering, pilih sage.",
            mouth: "Finish tajam dan cukup panjang.",
            drill: "Cium daun sage kering."
        ),
        "raw_beany": .make(
            "raw_beany",
            smell: "Cari aroma biji mentah: hijau, seperti kacang-kacangan, sedikit bertepung.",
            taste: "Kalau terasa seperti biji belum matang atau kopi yang kurang ter-roast, pilih raw beany.",
            mouth: "Finish bisa kering dan kurang manis.",
            drill: "Cium kacang polong atau buncis mentah."
        ),
        "pea": .make(
            "pea",
            smell: "Cari kacang polong: hijau, manis sayur.",
            taste: "Kalau hijaunya ada manis sayur, pilih pea.",
            mouth: "Finish hijau-lembut.",
            drill: "Cicip kacang polong yang baru direbus sebentar."
        ),
        "peapod": .make(
            "peapod",
            smell: "Cari kulit polong muda: mentah, hijau, sedikit lembap.",
            taste: "Kalau lebih mentah dan tajam dari kacang polong, pilih peapod.",
            mouth: "Finish kering-hijau.",
            drill: "Cium buncis muda atau kulit polong kacang."
        ),

        // MARK: - Other
        "Other": .make(
            "Other",
            smell: "Cari aroma yang tidak masuk kategori enak: kimia, tanah, jamur, kertas, atau kardus.",
            taste: "Kalau tidak bisa dikaitkan ke buah, bunga, kacang, atau rempah — catat saja di other secara jujur.",
            mouth: "Perhatikan apakah finish terasa datar, kering, lembap, atau mengganggu.",
            drill: "Cium kardus bersih, tanah pot basah, karet. Latih mengenali — bukan menilai — dulu."
        ),
        "chemical": .make(
            "chemical",
            smell: "Cari aroma kimia: obat, karet, minyak bumi, atau pelarut.",
            taste: "Kalau terasa asing dan sintetis — tidak ada kemiripan dengan buah atau biji — pilih chemical.",
            mouth: "Finish bisa tajam atau menusuk di hidung belakang.",
            drill: "Latih dengan aman: cium plester, karet, atau petroleum jelly dari jauh."
        ),
        "medicinal": .make(
            "medicinal",
            smell: "Cari aroma obat atau plester: antiseptik, iodine.",
            taste: "Kalau retronasal terasa seperti obat atau plester rumah sakit, pilih medicinal.",
            mouth: "Finish terasa 'steril', tajam, kadang pahit.",
            drill: "Cium plester bersih dari jauh."
        ),
        "rubber": .make(
            "rubber",
            smell: "Cari karet: ban, karet gelang, latex.",
            taste: "Kalau aroma industri karet muncul di hidung belakang setelah menelan, pilih rubber.",
            mouth: "Finish tajam dan asing.",
            drill: "Cium karet gelang dari jauh."
        ),
        "petroleum": .make(
            "petroleum",
            smell: "Cari minyak bumi: vaseline, solar, atau bahan kimia berminyak.",
            taste: "Kalau terasa seperti minyak dan sangat asing, pilih petroleum.",
            mouth: "Finish berminyak-kimia, tidak nyaman.",
            drill: "Cium petroleum jelly tipis dari jauh."
        ),
        "musty_earthy": .make(
            "musty_earthy",
            smell: "Cari tanah lembap, berdebu, berjamur, atau gambut.",
            taste: "Kalau rasa seperti ruangan lembap atau tanah basah, pilih musty earthy.",
            mouth: "Finish bisa berat, lembap, atau kering berdebu.",
            drill: "Cium tanah pot basah, jamur kering, dan gudang kering secara terpisah."
        ),
        "mushroom": .make(
            "mushroom",
            smell: "Cari jamur: tanah, umami, lembap.",
            taste: "Kalau earthynya terasa gurih seperti jamur — bukan sekadar tanah — pilih mushroom.",
            mouth: "Finish umami-earthy. Tidak selalu buruk.",
            drill: "Cium jamur segar dan jamur kering. Perhatikan bedanya."
        ),
        "moldy": .make(
            "moldy",
            smell: "Cari berjamur: lembap, seperti ruang bawah tanah, tajam.",
            taste: "Kalau earthynya terasa mengganggu — seperti benda yang lama tersimpan lembap — pilih moldy.",
            mouth: "Finish lembap dan tidak bersih.",
            drill: "Ingat bau ruangan yang lembap. Jangan pakai bahan yang benar-benar berjamur untuk latihan."
        ),
        "peat": .make(
            "peat",
            smell: "Cari gambut: tanah basah dalam, organik, sedikit smoky.",
            taste: "Kalau earthynya berat dan basah seperti tanah dalam, pilih peat.",
            mouth: "Finish panjang, earthy, lembap.",
            drill: "Cium tanah pot yang basah dari jauh."
        ),
        "paper_pulp": .make(
            "paper_pulp",
            smell: "Cari kertas, kardus, atau kayu basah.",
            taste: "Kalau rasa terasa datar seperti kertas basah atau kardus, pilih paper pulp.",
            mouth: "Finish kering, kosong, datar.",
            drill: "Cium paper filter kering dan kardus bersih. Bedakan satu sama lain."
        ),
        "cardboard": .make(
            "cardboard",
            smell: "Cari kardus: papery, basi, datar.",
            taste: "Kalau kopi terasa seperti kertas atau kardus lama, pilih cardboard.",
            mouth: "Finish kering dan kosong.",
            drill: "Cium kardus bersih. Bedakan dari woody yang ada sentuhan kayunya."
        ),
        "woody": .make(
            "woody",
            smell: "Cari kayu: kulit kayu, stik es krim, kulit walnut.",
            taste: "Kalau ada rasa kayu kering atau basah — bukan kardus yang datar — pilih woody.",
            mouth: "Finish kering dan sedikit kasar.",
            drill: "Cium stik es krim kayu atau walnut."
        ),

        // MARK: - Roasted
        "Roasted": .make(
            "Roasted",
            smell: "Cari aroma panggang: sereal, malt, kacang panggang, asap, atau gosong.",
            taste: "Roasted bisa nyaman atau tajam. Bedakan roti panggang yang enak dari yang gosong.",
            mouth: "Finish bisa kering, pahit, atau smoky tergantung seberapa 'gelap'.",
            drill: "Bandingkan roti tawar, sereal, kacang panggang, dan roti gosong. Hafalkan gradasinya."
        ),
        "cereal": .make(
            "cereal",
            smell: "Cari grain, malt, oat, atau sereal kering.",
            taste: "Kalau panggangnya terasa seperti biji-bijian atau sereal — bukan asap — pilih cereal.",
            mouth: "Finish kering ringan, kadang ada manis gandum tipis.",
            drill: "Cium oats, sereal, dan malt."
        ),
        "malt": .make(
            "malt",
            smell: "Cari malt: grain kering, sedikit manis-asam, sedikit fermentasi.",
            taste: "Kalau panggangnya terasa seperti sereal malt, pilih malt.",
            mouth: "Finish kering, grainy.",
            drill: "Cicip sereal malt atau minum teh malt."
        ),
        "granola": .make(
            "granola",
            smell: "Cari oat panggang dengan sedikit manis.",
            taste: "Kalau cerealnya terasa lebih manis dan toasted, pilih granola.",
            mouth: "Finish oat-manis, tidak smoky.",
            drill: "Cium granola plain tanpa topping."
        ),
        "graham": .make(
            "graham",
            smell: "Cari biskuit graham: grain manis, sedikit brown.",
            taste: "Kalau panggangnya terasa seperti cracker manis, pilih graham.",
            mouth: "Finish kering-manis.",
            drill: "Cicip graham cracker atau biskuit gandum."
        ),
        "tobacco_pipe": .make(
            "tobacco_pipe",
            smell: "Cari aroma gelap: tembakau, asap, abu, atau tar.",
            taste: "Kalau panggangnya terasa tua, kering, dan smoky, pilih tobacco.",
            mouth: "Finish panjang, kering, bisa pahit.",
            drill: "Cium tembakau pipa dari jauh atau teh smoky."
        ),
        "ash": .make(
            "ash",
            smell: "Cari abu: kering, berdebu, smoky, kotor.",
            taste: "Kalau finish terasa seperti asbak atau abu dingin, pilih ash.",
            mouth: "Finish sangat kering dan pahit.",
            drill: "Ingat bau abu kertas dari jauh — jangan terlalu dekat."
        ),
        "pipe_tobacco": .make(
            "pipe_tobacco",
            smell: "Cari tembakau pipa: brown, sedikit manis, sedikit rempah, sedikit bunga.",
            taste: "Kalau gelapnya masih ada sisi manis tua yang nyaman, pilih pipe tobacco.",
            mouth: "Finish kering, hangat, brown.",
            drill: "Cium tembakau pipa dari jauh kalau aman."
        ),
        "smoke": .make(
            "smoke",
            smell: "Cari asap bersih: asap kayu, almond asap, atau api unggun.",
            taste: "Kalau ada asap bersih — bukan gosong yang agresif — pilih smoke.",
            mouth: "Finish smoky, kering, bisa cukup panjang.",
            drill: "Cium smoked almond atau teh lapsang souchong."
        ),
        "roasted_malt": .make(
            "roasted_malt",
            smell: "Cari panggang gelap: burnt, pedas, seperti dark roast.",
            taste: "Kalau panggangnya terasa tajam dan mendekati gosong, pilih roasted malt.",
            mouth: "Finish pahit-kering, bisa agresif.",
            drill: "Bandingkan roti panggang cokelat dengan roti gosong."
        ),
        "burnt": .make(
            "burnt",
            smell: "Cari gosong: over-roasted, karbon, cokelat gelap.",
            taste: "Kalau rasa seperti roti gosong atau kacang gosong, pilih burnt.",
            mouth: "Finish pahit karbon dan kering.",
            drill: "Cium roti gosong dari jauh. Bedakan dari smoky yang lebih bersih."
        ),
        "acrid": .make(
            "acrid",
            smell: "Cari panggang yang tajam dan menusuk: sharp, pungent, pahit.",
            taste: "Kalau gosongnya menyerang hidung atau tenggorokan, pilih acrid.",
            mouth: "Finish pahit, tajam, tidak nyaman.",
            drill: "Ingat bau makanan yang terlalu gosong — bukan sekadar toasted."
        ),

        // MARK: - Spices
        "Spices": .make(
            "Spices",
            smell: "Cari rempah: lada, kayu manis, cengkih, pala, atau adas manis.",
            taste: "Rempah sering muncul di hidung belakang dan belakang lidah setelah menelan.",
            mouth: "Finish bisa hangat, tajam, atau sedikit mati rasa.",
            drill: "Cium kayu manis, cengkih, pala, dan lada satu per satu."
        ),
        "baking_spice": .make(
            "baking_spice",
            smell: "Cari rempah kue: kayu manis, cengkih, pala, adas manis.",
            taste: "Kalau hangat-manisnya seperti kue rempah, pilih baking spice.",
            mouth: "Finish hangat dan aromatik.",
            drill: "Bandingkan kayu manis, cengkih, dan pala satu per satu."
        ),
        "cinnamon": .make(
            "cinnamon",
            smell: "Cari kayu manis: manis, brown, kayu, hangat.",
            taste: "Kalau rempahnya terasa manis-hangat dan familiar, pilih cinnamon.",
            mouth: "Finish hangat, sedikit kering.",
            drill: "Cium kayu manis batang atau bubuknya."
        ),
        "clove": .make(
            "clove",
            smell: "Cari cengkih: rempah tajam, sedikit bunga, sedikit seperti obat.",
            taste: "Kalau ada rasa tajam dan sedikit mati rasa di lidah, pilih clove.",
            mouth: "Finish hangat, sedikit mati rasa.",
            drill: "Cium cengkih utuh."
        ),
        "nutmeg": .make(
            "nutmeg",
            smell: "Cari pala: brown, kayu, tajam, sedikit seperti lemon.",
            taste: "Kalau rempahnya lebih kayu dan berat dari kayu manis, pilih nutmeg.",
            mouth: "Finish hangat-kayu.",
            drill: "Cium pala yang baru diparut."
        ),
        "anise": .make(
            "anise",
            smell: "Cari adas manis: manis, tajam, seperti licorice.",
            taste: "Kalau rempahnya terasa seperti adas manis atau licorice, pilih anise.",
            mouth: "Finish manis-aromatik, cukup panjang.",
            drill: "Cium star anise atau biji fennel."
        ),
        "pepper": .make(
            "pepper",
            smell: "Cari lada: tajam, kayu, sedikit earthy.",
            taste: "Kalau terasa tajam di hidung belakang atau belakang lidah, pilih pepper.",
            mouth: "Finish hangat-pedas ringan.",
            drill: "Cium lada hitam dan lada putih. Bedakan karakter tajamnya."
        ),
        "black_pepper": .make(
            "black_pepper",
            smell: "Cari lada hitam: tajam, kayu, earthy.",
            taste: "Kalau pedas aromatiknya terasa kuat dan bold, pilih black pepper.",
            mouth: "Finish hangat dan sedikit kasar.",
            drill: "Cium lada hitam yang baru digiling."
        ),
        "white_pepper": .make(
            "white_pepper",
            smell: "Cari lada putih: tajam, bersih, sedikit earthy.",
            taste: "Kalau lada terasa lebih bersih dan lebih ringan dari lada hitam, pilih white pepper.",
            mouth: "Finish hangat dan bersih.",
            drill: "Bandingkan lada putih dengan lada hitam langsung."
        ),
        "piperine": .make(
            "piperine",
            smell: "Cari sensasi lada — tapi tanpa aroma lada yang kuat.",
            taste: "Kalau yang lebih terasa adalah 'panas' atau 'tingle' di lidah daripada rasa ladanya, pilih piperine.",
            mouth: "Finish hangat di bagian belakang lidah.",
            drill: "Cicip air lada yang sangat encer. Fokus ke sensasi panasnya, bukan rasanya."
        ),
        "brownspice": .make(
            "brownspice",
            smell: "Cari campuran rempah brown: kayu manis, cengkih, pala, allspice.",
            taste: "Kalau rempahnya terasa seperti campuran hangat-manis, pilih brown spice.",
            mouth: "Finish hangat dan aromatik.",
            drill: "Cium campuran kayu manis + cengkih + pala sekaligus."
        ),
        "allspice": .make(
            "allspice",
            smell: "Cari allspice: seperti kayu manis, cengkih, dan pala yang menyatu.",
            taste: "Kalau rempahnya terasa kompleks tapi nyaman dan tidak mencolok, pilih allspice.",
            mouth: "Finish hangat-manis.",
            drill: "Cium allspice atau campuran spice kue."
        ),
        "curry": .make(
            "curry",
            smell: "Cari bumbu kari yang lembut: hangat, gurih, seperti kunyit.",
            taste: "Kalau rempahnya terasa gurih dan eksotis — bukan manis atau pedas saja — pilih curry.",
            mouth: "Finish hangat dan gurih.",
            drill: "Cium bubuk kari sedikit dari jauh."
        ),

        // MARK: - Nutty / Cocoa
        "Nutty / Cocoa": .make(
            "Nutty / Cocoa",
            smell: "Cari kacang atau cokelat: almond, hazelnut, kacang tanah, cocoa, dark chocolate.",
            taste: "Nutty lebih gurih dan bulat. Cocoa lebih pahit-cokelat.",
            mouth: "Finish bisa creamy, berminyak, pahit-manis, atau kering.",
            drill: "Bandingkan almond, kacang tanah, hazelnut, cocoa powder, dan dark chocolate satu per satu."
        ),
        "nut": .make(
            "nut",
            smell: "Cari kacang panggang: almond, hazelnut, kacang tanah, walnut.",
            taste: "Kalau terasa gurih-panggang tanpa pahit cokelat yang kuat, pilih nut.",
            mouth: "Finish bulat, kadang sedikit berminyak.",
            drill: "Cicip almond, hazelnut, dan kacang tanah panggang. Perhatikan perbedaannya."
        ),
        "almond": .make(
            "almond",
            smell: "Cari almond: manis ringan, sedikit brown, kayu, sedikit bunga.",
            taste: "Kalau nuttynya ringan dan ada sentuhan marzipan tipis, pilih almond.",
            mouth: "Finish halus, sedikit sepet ringan.",
            drill: "Cium almond panggang atau setetes almond extract yang diencerkan."
        ),
        "hazelnut": .make(
            "hazelnut",
            smell: "Cari hazelnut: kayu, brown, manis, sedikit earthy.",
            taste: "Kalau nuttynya penuh dan ada sentuhan praline, pilih hazelnut.",
            mouth: "Finish bulat, sedikit berminyak.",
            drill: "Cium hazelnut panggang."
        ),
        "peanuts": .make(
            "peanuts",
            smell: "Cari kacang tanah: manis ringan, berminyak, sedikit seperti biji.",
            taste: "Kalau nuttynya terasa jelas seperti kacang tanah, pilih peanuts.",
            mouth: "Finish berminyak, gurih, sedikit kering.",
            drill: "Cicip kacang tanah panggang tawar."
        ),
        "pecan": .make(
            "pecan",
            smell: "Cari kacang yang manis-karamel, lebih berat dari almond.",
            taste: "Kalau nuttynya terasa seperti pecan pie yang tipis, pilih pecan.",
            mouth: "Finish berminyak-manis, bulat.",
            drill: "Cicip pecan atau walnut manis."
        ),
        "cocoa": .make(
            "cocoa",
            smell: "Cari cocoa: brown, manis, berdebu, sedikit pahit.",
            taste: "Kalau cokelatnya terasa kering dan pahit — bukan manis susu — pilih cocoa.",
            mouth: "Finish pahit-kering. Berbeda dari milk chocolate yang creamy.",
            drill: "Cium cocoa powder dan dark chocolate. Perhatikan bedanya."
        ),
        "milk_chocolate": .make(
            "milk_chocolate",
            smell: "Cari cokelat susu: cocoa ringan, manis, creamy.",
            taste: "Kalau cokelatnya manis-creamy dan tidak terlalu pahit, pilih milk chocolate.",
            mouth: "Finish lembut dan creamy.",
            drill: "Cicip milk chocolate, lalu langsung cicip cocoa powder. Bedanya jelas."
        ),
        "dark_chocolate": .make(
            "dark_chocolate",
            smell: "Cari dark chocolate: cocoa intens, pahit, panggang, sedikit rempah.",
            taste: "Kalau cokelatnya pahit-manis dan pekat, pilih dark chocolate.",
            mouth: "Finish panjang, pahit elegan, sedikit sepet.",
            drill: "Cicip dark chocolate 70% ke atas."
        ),
        "cocoa_powder": .make(
            "cocoa_powder",
            smell: "Cari bubuk kakao: berdebu, pahit, brown.",
            taste: "Kalau cokelatnya terasa kering seperti powder — bukan lemak cokelat bar — pilih cocoa powder.",
            mouth: "Finish kering dan pahit.",
            drill: "Cium cocoa powder tanpa gula."
        ),
        "mocha": .make(
            "mocha",
            smell: "Cari cokelat bercampur kopi panggang.",
            taste: "Kalau cokelat dan panggang kopi terasa menyatu, pilih mocha.",
            mouth: "Finish cocoa-panggang, bulat.",
            drill: "Cicip mocha tanpa gula berlebih."
        )
    ]
}

private extension SensoryTrainingGuide {
    static func make(
        _ nodeId: String,
        smell: String,
        taste: String,
        mouth: String,
        drill: String
    ) -> SensoryTrainingGuide {
        SensoryTrainingGuide(
            nodeId: nodeId,
            smellTraining: smell,
            tasteTraining: taste,
            mouthTraining: mouth,
            dailyDrill: drill
        )
    }
}
