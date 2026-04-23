# Project Context: KopiJuang

## Ringkasan Aplikasi

KopiJuang adalah aplikasi iOS berbasis SwiftUI untuk membantu pengguna membangun kemampuan sensory kopi secara bertahap. Fokus utama aplikasi adalah memandu pengguna dari persiapan cupping/seduh, pencatatan karakter beans, evaluasi aroma dan rasa, sampai melihat hasil analisis serta latihan referensi rasa.

Bahasa utama aplikasi adalah Bahasa Indonesia dengan tone edukatif, ringan, dan diarahkan untuk pengguna yang sedang belajar menjadi lebih peka terhadap karakter kopi.

Pengguna yang telah ditentukan adalah newbie Barista.

Core experience aplikasi saat ini:

1. Pengguna baru melihat landing/onboarding.
2. Pengguna membaca panduan persiapan sensory.
3. Setelah onboarding selesai, pengguna masuk ke tab utama.
4. Dari Dashboard, pengguna membuat sesi kopi baru.
5. Pengguna mengisi detail beans.
6. Disini ada masukin proces level dan roast level. kayaknya dikasih tau dibawah button kalau light hasilnya akan kayak gimana, kalau yg lain gimana. masing2 dari kedua input tersebut ya
7. Pengguna melakukan evaluasi sensory dalam 3 tahap: Fragrance, Aroma, Taste.
8. Aplikasi menampilkan hasil analisis.
9. Pengguna menjawab kategori rasa dominan. (PILIH SALAH SATU)
10. Jika salah, pengguna diarahkan ke latihan referensi rasa dari opsi tersebut.
11. Jika benar, maka pengguna mendapatkan badge atas notes yang udah di unlocked yg nantinya bisa diakses lagi dari Flavor Atlas. Selain itu pengguna diberitahu kalau masih ada secondary taste dari kopi berdasarkan flavor wheel. Apakah kamu mau mencoba untuk menebaknya? kalau mau, maka pengguna diberitahu kalau notes secondary itu ada apa aja dari rasa yang telah dipilih contohnya pada kategory dominan pertama adalah fruity, maka secondary taste nya adalah berry, dried fruit, other fruit, citrus fruit. (belum di implement)
12. Jika benar, maka lanjut lagi ke layer paling luar. contohnya pada secondary tadi, user milih itu adalah berry. maka opsi selanjutnya adalah blueberry, black berry, strawberry, raspberry. ditiap opsinya diberikan deskripsi singkat apa itu. (belum di implement)
13. Jika user berhasil menebak semua notes yang ada di flavor wheel, maka pengguna akan mendapatkan badge khusus, juga menampilkan halaman bahwa proses belajar dari notes tersebut selesai dan menampilkan apa saja pencapaiannya. Setelah itu, pengguna bisa melanjutkan ke sesi kopi berikutnya.  (belum di implement)
14. Pengguna juga bisa membuka Flavor Atlas untuk mempelajari notes yang unlocked/locked.
yang isinya adalah deskripsi singkat apa notes tersebut, gambarannya seperti apa, dan contoh kopi yang memiliki notes tersebut. (belum di implement)

## Entry Point dan App State

Entry point aplikasi ada di `KopiJuangApp`.

State onboarding disimpan menggunakan:

```swift
@AppStorage("hasCompletedFirstSession") var hasCompletedFirstSession: Bool = false
```

Perilaku awal:

- Jika `hasCompletedFirstSession == false`, aplikasi membuka `ContentView`.
- Jika `hasCompletedFirstSession == true`, aplikasi langsung membuka `MainTabView`.

Ada juga `CoffeeFeelView` yang memiliki logika serupa:

- Pengguna lama diarahkan ke `MainTabView`.
- Pengguna baru diarahkan ke `MasterPrepGuideView(isFirstRun: true)`.

Namun flow app utama saat ini dikendalikan langsung dari `KopiJuangApp`, bukan `CoffeeFeelView`.

## Flow Besar Aplikasi

### 1. First Run / Landing

File: `ContentView.swift`

`ContentView` adalah halaman pembuka untuk pengguna baru.

Konten utama:

- Gambar `img_coffee`.
- Headline: "Buka rahasia di balik setiap tegukan".
- Subcopy yang mengajak pengguna mengenali karakter unik dari beans.
- Tombol "Mulai".

Navigasi:

- Tombol "Mulai" membuka `MasterPrepGuideView(isFirstRun: true)` melalui `NavigationLink`.

Tujuan layar:

- Memberi konteks awal bahwa aplikasi bukan hanya untuk minum kopi, tapi untuk mengenali karakter kopi.
- Mengarahkan pengguna baru ke panduan persiapan sebelum masuk ke flow utama.

### 2. Master Preparation Guide

File: `MasterPrepGuideView.swift`

`MasterPrepGuideView` adalah panduan persiapan sensory/cupping. Layar ini bisa muncul dalam dua mode:

- `isFirstRun: true`: dipakai saat onboarding pertama.
- `isFirstRun: false`: dipakai dari Dashboard sebagai sheet panduan bantuan.

Isi panduan ditampilkan dalam `TabView` dengan page indicator.

Halaman panduan:

1. `Brewing & Grind`
   - Suhu seduh ideal 92-96°C.
   - Grind medium seperti gula pasir.
   - Terlalu halus berisiko over-extracted/pahit.
   - Terlalu kasar berisiko under-extracted/encer.

2. `Reset Lidah`
   - Pengguna dianjurkan minum air putih sebelum mulai.
   - Tujuannya menghilangkan residu rasa sebelumnya agar lidah netral.

3. `Sensory Window`
   - Waktu terbaik mencicipi adalah saat suhu kopi turun ke 50-60°C.
   - Disebut sebagai window saat reseptor manis dan asam lebih sensitif.

4. `Teknik Slurp`
   - Pengguna diarahkan menyeruput dengan keras/aerasi.
   - Tujuannya menyebarkan kopi ke lidah dan mendorong aroma ke belakang hidung lewat retronasal olfaction.

Perbedaan mode:

- Jika `isFirstRun == true`, ada tombol `Rasain Kopimu`.
- Tombol ini mengubah `hasCompletedFirstSession` menjadi `true`.
- Perubahan AppStorage membuat app berpindah ke `MainTabView`.
- Jika `isFirstRun == false`, layar menampilkan tombol close `xmark` untuk dismiss sheet.

### 3. Main Tab

File: `MainTabView.swift`

Setelah onboarding selesai, aplikasi masuk ke `MainTabView`.

Tab yang tersedia:

1. `DashboardView`
   - Icon: `house.fill`
   - Label: `Dashboard`

2. `AtlasView`
   - Icon: `book.fill`
   - Label: `Atlas`

Accent color tab adalah `.brown`.

## Dashboard Flow

File: `DashboardView.swift`

Dashboard adalah pusat aktivitas pengguna setelah onboarding.

Komponen utama:

1. Greeting
   - "Halo, Future Barista!"
   - Copy motivasional tentang setiap tegukan sebagai langkah menuju keahlian.

2. Sensory Flow Showcase
   - Komponen edukatif berbentuk carousel `TabView`.
   - Menjelaskan 3 tahap sensory:
     - Fragrance: kopi kering.
     - Aroma: kopi basah/bloom.
     - Taste: seruput + retronasal.

3. Pro Tip Card
   - Menampilkan tips tentang sensory window.
   - Menyebut sensitivitas lidah terhadap asam dan manis di suhu 50-60°C.

4. Riwayat Palate
   - Menampilkan daftar `CoffeeSession` yang `isCompleted == true`.
   - Data saat ini masih mock/hardcoded:
     - Kopi Gayo, flavor Fruity.
     - Sumatra Mandailing, flavor Earthy.
   - Jika tidak ada sesi completed, disediakan `EmptyHistoryCard`.

5. Toolbar Help
   - Tombol `questionmark.circle` membuka `MasterPrepGuideView(isFirstRun: false)` sebagai sheet.

6. Floating Action Button
   - Tombol plus di kanan bawah.
   - Navigasi ke `CoffeeSetupView`.

Tujuan Dashboard:

- Memberi ringkasan pembelajaran.
- Mengingatkan prinsip sensory.
- Menjadi titik awal membuat sesi kopi baru.
- Menjadi tempat riwayat palate, meskipun saat ini data belum persisted.

## Flow Membuat Sesi Kopi

### 1. Coffee Setup

File: `CoffeeSetupView.swift`

`CoffeeSetupView` adalah layar input detail beans sebelum mulai sensory.

State lokal:

- `beanName`
- `beanOrigin`
- `roastLevel`
- `processLevel`

Pilihan roast:

- Light
- Medium
- Dark
- Omni

Pilihan process:

- Natural
- Wash
- Honey
- Anaerobic
- Wet Hulled

Field:

- Nama Kopi, contoh: Gayo.
- Origin, contoh: Ethiopia.
- Picker Roast Level.
- Picker Process.

Validasi tombol:

- Tombol `Mulai` disabled jika:
  - `beanName` kosong, atau
  - `roastLevel` kosong, atau
  - `processLevel` kosong.

Catatan:

- `beanOrigin` tidak ikut validasi required saat ini.
- Jika origin kosong, nilai kosong tetap dikirim ke tahap sensory.

Navigasi:

- Toolbar button `Mulai` membuka:

```swift
SensoryInputView(
    beanName: beanName,
    beanOrigin: beanOrigin,
    roastLevel: roastLevel,
    processLevel: processLevel
)
```

### 2. Sensory Input

File: `SensoryInputView.swift`

`SensoryInputView` adalah flow utama evaluasi sensory. Flow ini menggunakan enum lokal `Step`:

- `fragrance`
- `aroma`
- `taste`

Setiap step punya:

- `title`
- `subtitle`
- tampilan input yang berbeda.

Header selalu menampilkan:

- Judul step.
- Subtitle instruksi.
- Step indicator 3 titik.
- Metadata sesi:
  - Nama beans.
  - Origin.
  - Roast level.
  - Process level.

Navigasi internal:

- Tombol back custom `chevron.left`.
- Jika berada di `fragrance`, back akan dismiss layar.
- Jika berada di `aroma`, back kembali ke `fragrance`.
- Jika berada di `taste`, back kembali ke `aroma`.
- Tombol `Lanjut` berpindah ke step berikutnya.
- Pada step terakhir, `Lanjut` membuka `ResultView`.

Scroll behavior:

- Ada `ScrollViewReader`.
- Saat berpindah step, `scrollToTopNonce` bertambah.
- Perubahan nonce membuat scroll kembali ke anchor `top`.

#### Step 1: Fragrance

Fragrance berarti wangi kopi saat masih kering, sebelum dicampur air.

State:

- `fragranceIntensity: Double`, default `6`.
- `fragranceCategory: FlavorCategory`, default `.nutty`.

UI utama:

- `StepIntroCard` menjelaskan bahwa pengguna sedang menilai fragrance.
- Visual `PulseRing` dengan icon `nose.fill`.
- Label "Cium sekarang".
- Tap gesture pada visual dapat toggle animasi sniffing/pulse.

Input:

1. Intensitas fragrance
   - Menggunakan `MetricScale`.
   - Range `1...10`.
   - Step `1`.
   - Label bawah: `Halus` sampai `Tajam`.

2. Kategori notes dominan saat dry
   - Menggunakan `CategoryPickerGrid(stage: .fragrance)`.
   - Pilihan berdasarkan `FlavorCategory`.

Kategori yang tersedia:

- Fruity
- Floral
- Nutty
- Sweet

Descriptor dry:

- Floral: jasmine, rose, chamomile, black tea.
- Fruity: citrus, berry, apple, grape.
- Nutty: hazelnut, almond, cocoa.
- Sweet: honey, vanilla, caramel.

#### Step 2: Aroma

Aroma berarti wangi kopi setelah dicampur air panas saat bloom/wet.

State:

- `aromaContrast: AromaContrast`, default `.unsure`.
- `aromaIntensity: Double`, default `6`.
- `aromaCategory: FlavorCategory`, default `.nutty`.

Relasi dengan fragrance:

- Saat `FragranceStepView` muncul, jika `aromaCategory == .nutty`, `aromaCategory` di-set mengikuti `fragranceCategory`.
- Saat `AromaStepView` muncul, jika `aromaContrast == .same`, `aromaCategory` mengikuti `fragranceCategory`.
- Saat user mengubah contrast menjadi `.same`, `wetCategory` otomatis menjadi `dryCategory`.
- Saat submit ke result, jika `aromaContrast == .same`, `aromaCategory` yang dikirim adalah `fragranceCategory`.

Input:

1. Perbandingan dry vs wet
   - Picker segmented berdasarkan `AromaContrast`.
   - Pilihan:
     - `Sama`
     - `Berubah`
     - `Gak yakin`

2. Intensitas aroma wet
   - Menggunakan `MetricScale`.
   - Range `1...10`.
   - Step `1`.
   - Label bawah: `Halus` sampai `Tajam`.

3. Kategori aroma wet
   - Jika contrast bukan `.same`, user memilih kategori lewat `CategoryPickerGrid(stage: .aroma)`.
   - Jika contrast `.same`, kategori wet otomatis mengikuti kategori dry dan ditampilkan sebagai summary.

UI pendukung:

- `ContrastTrackerCard` menampilkan transisi:
  - Kering -> Wet/Bloom.
- Badge status:
  - `Kontras kuat` jika contrast `.changed` atau category berubah.
  - `Stabil` jika tidak berubah.

Descriptor wet:

- Floral: floral lebih terbaca saat bloom.
- Fruity: buah segar keluar saat wet, seperti citrus/berry/tropical.
- Nutty: nutty/cocoa muncul hangat saat wet.
- Sweet: karamel, gula merah, vanila.

#### Step 3: Taste

Taste berarti rasa saat kopi diminum, termasuk sensasi lidah dan retronasal.

State:

- `acidity: Double`, default `6`.
- `sweetness: Double`, default `6`.
- `bitterness: Double`, default `6`.
- `bodyScore: Double`, default `6`.

UI utama:

- `StepIntroCard` menjelaskan bahwa user sedang menilai rasa saat diminum.
- `SlurpMentorCard` mengingatkan teknik slurping/aerasi.

Input metric:

1. Acidity
   - Subtitle: sensasi fresh/bright, bukan asam menusuk.
   - Detail: acidity yang baik terasa hidup, bersih, rapi; contoh sitrus atau apel.
   - Label scale: `Flat` sampai `Bright`.

2. Sweetness
   - Subtitle: manis alami kopi, bukan gula tambahan.
   - Detail: sweetness membuat rasa bulat dan nyaman.
   - Label scale: `Kering` sampai `Round`.

3. Bitterness
   - Subtitle: pahit yang muncul saat diteguk.
   - Detail: bitterness ringan bisa memberi struktur, tapi berlebih menutup sweetness dan clarity.
   - Label scale: `Lembut` sampai `Tajam`.

4. Body
   - Subtitle: tekstur cairan di mulut.
   - Detail: body adalah mouthfeel, bukan rasa; tidak harus tebal.
   - Label scale: `Ringan` sampai `Tebal`.

Saat user tap `Lanjut` di step taste, app membuat `SensoryEvaluation` dan membuka `ResultView`.

## Result Flow

File: `ResultView.swift`

`ResultView` menerima:

```swift
let evaluation: SensoryEvaluation
```

Isi layar:

1. Metadata sesi
   - Bean name.
   - Bean origin.
   - Roast level.
   - Process level.

2. Ringkasan Fragrance -> Aroma
   - `FragranceAromaSummaryCard`.
   - Menampilkan category dan intensity dry/wet.
   - Badge:
     - `Kontras` jika aroma berubah.
     - `Stabil` jika tidak berubah.

3. Analisis Sensorik
   - Bar untuk:
     - Asam.
     - Manis.
     - Pahit.
     - Body.
   - Masing-masing memakai nilai `1...10`.

4. Pertanyaan refleksi
   - "Rasa apa yang paling dominan kamu rasakan saat minum?"
   - User memilih salah satu `FlavorCategory`.

Logika jawaban:

- `correctCategory` adalah `evaluation.aromaCategory`.
- Saat user memilih category, `checkAnswer(_:)` membandingkan pilihan dengan `correctCategory`.

Jika benar:

- `isCorrect = true`.
- Feedback message menyatakan badge kategori berhasil didapatkan.
- Sheet `FeedbackView` muncul dengan icon `star.fill`.

Jika salah:

- `isCorrect = false`.
- Feedback message memberi tahu bahwa profil lebih condong ke category yang benar.
- Sheet `FeedbackView` muncul dengan icon `lightbulb.fill`.
- Ada `NavigationLink` ke `TrainingView(flavor: category.rawValue)`.

Catatan penting:

- Saat ini kategori benar ditentukan dari `aromaCategory`, bukan dari metrik taste atau input kategori taste terpisah.
- Artinya quiz di Result menguji apakah user bisa mengenali dominansi yang dianggap sama dengan aroma wet/final aroma.

## Training Flow

File: `TrainingView.swift`

`TrainingView` muncul dari feedback result saat jawaban user salah.

Input:

- `flavor: String`

Konten:

- Hero icon `hand.raised.square.on.square.fill`.
- Judul: `Ayo kenali {flavor}!`
- Copy: "Gapapa salah tebak, ini proses belajar."
- Card `Siapkan {flavor}`.
- Instruksi umum untuk mencari referensi flavor.
- Langkah latihan:
  1. Cium referensi flavor.
  2. Tahan rasa itu di memori lidah.
  3. Icip kopi lagi dengan teknik slurp.
- Tombol `Oke, aku sudah coba!` untuk dismiss.

Ada helper `imageForFlavor(_:)` yang memetakan:

- Fruity -> jeruk/lemon.
- Floral -> bunga mawar.
- Nutty -> kacang/cokelat.
- Sweet -> gula/madu.

Catatan:

- Helper ini belum dipakai di UI.
- Layar training saat ini masih generik dan belum memiliki asset visual spesifik per flavor.

## Flavor Atlas Flow

File: `AtlasView.swift`

`AtlasView` adalah tab kedua aplikasi. Fungsi utamanya adalah katalog notes/flavor.

State:

- `searchText`
- `flavors: [FlavorNote]`

Data saat ini masih mock/hardcoded:

- Citrus, Fruity, unlocked.
- Berry, Fruity, locked.
- Jasmine, Floral, locked.
- Hazelnut, Nutty, unlocked.

Search:

- Jika `searchText` kosong, semua flavor ditampilkan.
- Jika tidak kosong, flavor difilter berdasarkan `name.localizedCaseInsensitiveContains(searchText)`.

Layout:

- `LazyVGrid`.
- Column adaptive minimum 150.
- Setiap item adalah `FlavorCard`.

Card behavior:

- Jika unlocked:
  - Menampilkan icon flavor.
  - Menampilkan nama flavor.
  - Warna brown.
  - Border brown opacity.

- Jika locked:
  - Menampilkan icon lock.
  - Nama disamarkan menjadi `???`.
  - Warna gray.

Navigasi:

- Tap flavor membuka `FlavorDetailView(flavor:)`.

## Flavor Detail Flow

File: `Views/FlavorDetail/FlavorDetailView.swift`

`FlavorDetailView` menampilkan detail flavor berdasarkan status unlock.

Jika flavor unlocked:

- Header visual dengan icon flavor.
- Title nama flavor.
- Konten edukasi:
  - `Profil Rasa`
  - `SCA Data & Science`
  - `Tips Latihan`

Jika flavor locked:

- Header visual dengan lock.
- Title `Terkunci`.
- Copy: "Teruslah bereksplorasi untuk membuka notes ini."
- Section `Cara Membuka`.
- Saran mencoba kopi Natural atau origin Ethiopia untuk membuka karakter terkait.

Catatan:

- Konten SCA/science saat ini masih generic string.
- Belum ada mekanisme unlock yang terhubung dengan hasil sesi sensory.

## Data Model

### CoffeeBean

File: `Models/CoffeeBean.swift`

```swift
struct CoffeeBean: Identifiable {
    let id = UUID()
    var name: String
    var notes: String
    var grind_size: String
}
```

Tujuan:

- Mewakili informasi beans.
- Saat ini belum terlihat dipakai langsung di flow UI utama.

Catatan style:

- Property `grind_size` memakai snake_case, berbeda dari konvensi Swift/camelCase.

### CoffeeSession

File: `Models/CoffeeSession.swift`

```swift
struct CoffeeSession: Identifiable {
    let id = UUID()
    let title: String
    let flavor: String
    var isCompleted: Bool
}
```

Tujuan:

- Digunakan untuk riwayat palate di Dashboard.
- Saat ini data masih mock di `DashboardView`.

### FlavorCategory

File: `Models/FlavorCategory.swift`

```swift
enum FlavorCategory: String, CaseIterable, Identifiable {
    case fruity = "Fruity"
    case floral = "Floral"
    case nutty = "Nutty"
    case sweet = "Sweet"
}
```

Tujuan:

- Kategori utama flavor yang digunakan di sensory input, result quiz, dan descriptor UI.

### FlavorNote

File: `Models/FlavorNote.swift`

```swift
struct FlavorNote: Identifiable {
    let id = UUID()
    let name: String
    let category: String
    let description: String
    let icon: String
    var isUnlocked: Bool
}
```

Tujuan:

- Model item untuk Flavor Atlas.
- Menyimpan status lock/unlock.

Catatan:

- `category` masih `String`, bukan `FlavorCategory`.
- Unlock state masih lokal/mock di `AtlasView`.

### SensoryEvaluation

File: `Models/SensoryEvaluation.swift`

Model utama hasil evaluasi sensory.

```swift
struct SensoryEvaluation: Identifiable {
    let id = UUID()

    var beanName: String
    var beanOrigin: String
    var roastLevel: String
    var processLevel: String

    var fragranceIntensity: Double
    var fragranceCategory: FlavorCategory

    var aromaContrast: AromaContrast
    var aromaIntensity: Double
    var aromaCategory: FlavorCategory

    var acidity: Double
    var sweetness: Double
    var bitterness: Double
    var bodyScore: Double
}
```

Field terbagi menjadi:

1. Metadata beans:
   - beanName
   - beanOrigin
   - roastLevel
   - processLevel

2. Fragrance/dry:
   - fragranceIntensity
   - fragranceCategory

3. Aroma/wet:
   - aromaContrast
   - aromaIntensity
   - aromaCategory

4. Taste:
   - acidity
   - sweetness
   - bitterness
   - bodyScore

### AromaContrast

File: `Models/SensoryEvaluation.swift`

```swift
enum AromaContrast: String, CaseIterable, Identifiable {
    case same = "Sama"
    case changed = "Berubah"
    case unsure = "Gak yakin"
}
```

Tujuan:

- Menyimpan persepsi user terhadap perubahan aroma dari dry ke wet.

### SensoryFlow

File: `Models/SensoryFlow.swift`

```swift
struct SensoryFlow: Identifiable {
    let id = UUID()
    let icon: String
    let title: String
    let subTitle: String
    let description: String
}
```

Tujuan:

- Model untuk menggambarkan step sensory.
- Saat ini belum dipakai aktif; `DashboardView` memakai data langsung di `FlowPage`.

### Taste

File: `Models/Taste.swift`

```swift
struct Taste: Identifiable {
    let id = UUID()
    let name: String
    var value: Double
}
```

Tujuan:

- Representasi metric taste.
- Saat ini belum terlihat dipakai langsung dalam flow UI utama, karena `SensoryInputView` menyimpan metric taste sebagai state terpisah.

## Komponen UI Penting

### SensoryInputView Components

Komponen internal:

- `SessionMetaRow`
  - Menampilkan metadata beans di header sensory.

- `StepIndicator`
  - Tiga titik progress berdasarkan current step.

- `FragranceStepView`
  - UI khusus smell dry coffee.

- `PulseRing`
  - Animasi ring untuk cue "cium sekarang".

- `AromaStepView`
  - UI khusus wet/bloom aroma.

- `ContrastTrackerCard`
  - Visualisasi perubahan category dry ke wet.

- `TasteStepView`
  - UI khusus scoring rasa.

- `SlurpMentorCard`
  - Tips singkat teknik slurp.

- `TasteMetricCard`
  - Card edukatif untuk acidity/sweetness/bitterness/body.

- `MetricScale`
  - Wrapper slider custom.

- `SmoothDiscreteSlider`
  - Slider custom berbasis `GeometryReader` dan `DragGesture`.
  - Menghitung filled track, posisi thumb, dan snapping ke step.

- `StepIntroCard`
  - Card info untuk tiap tahap.

- `InputCard`
  - Card prompt + content input.

- `CategoryPickerGrid`
  - Pilihan category dengan descriptor berbeda berdasarkan stage.

- `FlowChips`
  - Chip contoh notes.

### ResultView Components

Komponen:

- `SensoryBar`
  - Bar horizontal untuk metric taste.

- `CategoryButton`
  - Tombol pilihan category pada quiz result.

- `FeedbackView`
  - Sheet feedback benar/salah.

- `FragranceAromaSummaryCard`
  - Ringkasan perbandingan dry/wet.

### Atlas Components

Komponen:

- `FlavorCard`
  - Card flavor locked/unlocked.

- `InfoCard`
  - Card detail edukasi flavor.

## Status Data dan Persistence

Saat ini persistence yang terlihat hanya:

- `@AppStorage("hasCompletedFirstSession")` untuk onboarding completion.

Data yang masih mock/lokal:

- Riwayat session di `DashboardView`.
- Flavor list dan unlock status di `AtlasView`.
- Hasil `SensoryEvaluation` hanya dikirim antar view lewat navigation, belum disimpan.
- Badge dari feedback result hanya berupa message, belum terhubung ke Atlas atau storage.

Belum terlihat penggunaan:

- SwiftData/CoreData.
- Network API.
- File persistence.
- User account/authentication.

## Flow Data Saat Membuat Evaluasi

Urutan data dari input sampai hasil:

1. `CoffeeSetupView`
   - User mengisi metadata.
   - Data dikirim ke `SensoryInputView`.

2. `SensoryInputView`
   - Menyimpan state sensory lokal selama user melewati 3 step.
   - Pada step taste, membuat `SensoryEvaluation`.

3. `ResultView`
   - Menerima `SensoryEvaluation`.
   - Menampilkan summary.
   - Menjalankan quiz category.

4. `FeedbackView`
   - Menampilkan feedback benar/salah.
   - Jika salah, bisa membuka `TrainingView`.

Tidak ada data yang disimpan permanen setelah flow selesai.

## Navigasi Lengkap

Flow pengguna baru:

```text
KopiJuangApp
└── ContentView
    └── MasterPrepGuideView(isFirstRun: true)
        └── set hasCompletedFirstSession = true
            └── MainTabView
```

Flow pengguna lama:

```text
KopiJuangApp
└── MainTabView
    ├── DashboardView
    └── AtlasView
```

Flow mulai sesi dari Dashboard:

```text
DashboardView
└── CoffeeSetupView (🟡 Rencana: Tambah edu roast/process)
    └── SensoryInputView
        ├── Step 1: Fragrance
        ├── Step 2: Aroma
        ├── Step 3: Taste (🟡 Rencana: Tambah taste category input)
        └── ResultView
            ├── Quiz Layer 1 (Kategori Dominan)
            │   ├── Benar -> 🔴 Rencana: Secondary Quiz View -> Specific Notes Quiz -> Achievement View
            │   └── Salah -> FeedbackView -> TrainingView
            └── 🟡 Rencana: Post-training flow (Pilihan Retry Quiz / ke Dashboard)
```

Flow bantuan dari Dashboard:

```text
DashboardView
└── MasterPrepGuideView(isFirstRun: false)
```

Flow Atlas:

```text
MainTabView
└── AtlasView
    └── FlavorDetailView
```

## Catatan Teknis, Gap, dan Potensi Pengembangan

### Hal yang sudah kuat:

- Flow sensory sudah jelas dan bertahap.
- Model `SensoryEvaluation` sudah mencakup metadata, dry fragrance, wet aroma, dan taste metrics.
- UI memberi edukasi contextual pada tiap step.
- Ada pemisahan kasar antara Dashboard, Setup, Input, Result, Training, dan Atlas.
- Prinsip UX "kesalahan bukan kegagalan, tapi arah belajar" sangat kuat dan membuat app terasa supportive.

### Gap Kritis (Core Experience vs Implementasi):

Terdapat gap besar antara "Core Experience" (poin 11-13) dengan view yang sudah ada:
- **Cascading Quiz Belum Ada**: Core experience menjanjikan kuis 3 layer (Dominan -> Secondary -> Specific), namun `ResultView` saat ini hanya memiliki 1 layer (Dominan).
- **Gamification Belum Lengkap**: Halaman pencapaian (Achievement View) setelah menebak semua layer dan model Badge yang menyimpan progress per-layer belum ada.
- **Logika Kuis**: Jawaban "benar" saat ini ditentukan dari `aromaCategory` (input user sebelumnya), bukan dari hasil metrik rasa (Taste). Ini bisa membuat kuis kurang bermakna.

### Hal yang masih mock atau belum tersambung:

- Edukasi efek roast/process di `CoffeeSetupView` belum diimplementasikan (sesuai poin 6 core experience).
- `CoffeeSession` belum dibuat dari hasil evaluasi user.
- `DashboardView.sessions` masih hardcoded.
- `AtlasView.flavors` masih hardcoded. Konten `FlavorDetailView` juga masih generik.
- Unlock flavor/badge belum berubah berdasarkan hasil quiz.
- `TrainingView.imageForFlavor(_:)` belum dipakai.
- Post-training flow belum jelas (setelah "Oke, aku sudah coba!", user harus dikembalikan ke kuis atau dashboard?).
- `CoffeeBean`, `Taste`, dan `SensoryFlow` belum menjadi sumber data utama untuk UI.

### Improvement & Next Step Arsitektur (Berdasarkan Prioritas):

**🔴 Prioritas Tinggi (Critical):**
1. **State Management & Persistence**: Implementasi `SwiftData` atau `@AppStorage` JSON untuk menyimpan `UserProgress` (unlock status, badges), `CompletedSessions`, dan riwayat `SensoryEvaluation`. Tanpa ini, app tidak usable karena progress hilang saat ditutup.
2. **Perbaiki Logika Kuis (`correctCategory`)**: Tentukan jawaban benar dari heuristic Taste Metrics (misal: Acidity tinggi + Sweetness sedang = Fruity) ATAU ubah pertanyaan kuis menjadi "Kategori apa yang paling menggambarkan kopi ini?".
3. **Bangun Infrastruktur Gamification**: Buat model `UserProgress` dan `Badge`.
4. **Cascading Quiz & Flavor Wheel Model**: Buat struktur data `FlavorWheelNode` (mendukung layer 1, 2, 3) dan lengkapi UI untuk Secondary Taste Quiz dan Specific Notes Quiz.

**🟡 Prioritas Sedang (Enhancement):**
5. **Edukasi di Coffee Setup**: Tambahkan teks singkat di bawah picker Roast/Process tentang efek masing-masing level.
6. **Perjelas Post-Training Flow**: Tambahkan opsi "Coba tebak lagi" (kembali ke Result) atau "Kembali ke Dashboard" setelah training selesai.
7. **Input "Taste Category"**: Tambahkan input kategori kesan pertama setelah slurp di Step 3 (Taste) untuk menjembatani metrik skor dan kuis Result.

**🟢 Prioritas Rendah (Ekspansi):**
8. **Perluas Kategori Rasa (FlavorCategory)**: Saat ini hanya 4 (Fruity, Floral, Nutty, Sweet). Pertimbangkan untuk menambah Spices dan Roasted yang umum pada kopi Indonesia.

## Prinsip UX yang Sedang Dipakai

Pola UX aplikasi saat ini:

- Edukatif sebelum input.
- Input satu fokus per tahap.
- Bahasa instruksi dibuat sederhana dan praktis.
- Pengguna tidak hanya diminta memilih, tetapi diberi contoh notes.
- Kesalahan di Result tidak dianggap gagal, tetapi diarahkan ke training.
- Dashboard menjaga konteks belajar dengan sensory flow, pro tip, dan riwayat.

## File Penting

- `KopiJuangApp.swift`: entry point dan onboarding gate.
- `ContentView.swift`: landing pengguna baru.
- `MasterPrepGuideView.swift`: panduan persiapan sensory.
- `MainTabView.swift`: tab Dashboard dan Atlas.
- `DashboardView.swift`: home, riwayat, tips, mulai sesi.
- `CoffeeSetupView.swift`: form metadata beans.
- `SensoryInputView.swift`: flow sensory 3 tahap.
- `ResultView.swift`: hasil analisis, quiz, feedback.
- `TrainingView.swift`: latihan referensi rasa.
- `AtlasView.swift`: katalog flavor notes.
- `FlavorDetailView.swift`: detail flavor locked/unlocked.
- `SensoryEvaluation.swift`: model utama evaluasi sensory.
- `FlavorCategory.swift`: kategori rasa utama.
- `FlavorNote.swift`: model flavor atlas.
- `CoffeeSession.swift`: model riwayat sesi.

