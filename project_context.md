# Project Context: KopiJuang

Dokumen ini menjelaskan KopiJuang dari sisi produk dan kode. Target pembaca: orang awam yang belum tahu struktur app, tapi ingin langsung paham alur, tujuan, file penting, dan cara fitur saling nyambung.

---

## 1. Ringkasan Singkat

**KopiJuang** adalah aplikasi iOS untuk membantu pemula/barista pemula belajar membaca rasa kopi.

App tidak cuma meminta user menilai kopi, tapi memandu user pelan-pelan:

1. Mencatat info beans.
2. Mencium kopi kering.
3. Mencium kopi setelah kena air.
4. Mencicip kopi.
5. Memilih keluarga rasa utama.
6. Menurunkan pilihan ke rasa yang lebih spesifik.
7. Menyimpan hasil ke riwayat.
8. Membuka progress di Flavor Atlas.

Konsep utama app:

- **Belajar lewat pengalaman**, bukan kuis benar-salah.
- **Bahasa Indonesia sederhana**, cocok untuk pemula.
- **Sensory training** pakai pendekatan WCR/SCA secara deskriptif.
- **Flavor wheel internal** punya 3 lapis: kategori besar, turunan, note spesifik.
- **Riwayat** menyimpan sesi agar user bisa membangun palate memory.

---

## 2. Teknologi Yang Dipakai

### SwiftUI

Semua UI dibuat dengan SwiftUI. Tidak ada UIKit view controller utama. UIKit hanya dipakai kecil untuk haptic feedback.

Contoh file UI:

- `KopiJuang/Views/DashboardView.swift`
- `KopiJuang/Views/CoffeeSetupView.swift`
- `KopiJuang/Views/SensoryInputView.swift`
- `KopiJuang/Views/ResultView.swift`
- `KopiJuang/Views/CascadingQuizView.swift`
- `KopiJuang/Views/FinalAnalysisView.swift`
- `KopiJuang/Views/AtlasView.swift`

### SwiftData

SwiftData dipakai untuk menyimpan:

- progress user
- riwayat sesi
- badge

Setup SwiftData ada di:

- `KopiJuang/App/KopiJuangApp.swift`

Model SwiftData ada di:

- `KopiJuang/Models/UserData.swift`
- `KopiJuang/Models/UserProgressStore.swift`

### Observation

Beberapa view model memakai `@Observable`, contoh:

- `AtlasViewModel`
- `CascadingQuizViewModel`
- `FinalAnalysisViewModel`
- `ResultViewModel`
- `SensoryInputViewModel`

---

## 3. Struktur Navigasi App

### Entry Point

File utama:

- `KopiJuang/App/KopiJuangApp.swift`

App membaca:

```swift
@AppStorage("hasCompletedFirstSession")
```

Kalau user belum pernah masuk:

- tampil `ContentView`

Kalau sudah:

- tampil `MainTabView`

### Onboarding Sederhana

File:

- `KopiJuang/Views/ContentView.swift`

Isi:

- gambar kopi
- judul
- subtitle
- tombol `Mulai`

Saat tombol ditekan:

- `hasCompletedFirstSession = true`
- app masuk ke `MainTabView`

### Main Tab

File:

- `KopiJuang/Views/MainTabView.swift`

Tab app:

- Dashboard
- Atlas

`MainTabView` sekarang punya **satu `NavigationStack` utama** untuk flow utama app.

Kenapa ini penting:

- Supaya navigasi dari Dashboard ke Setup, Sensory, Result, Cascading, Final bisa satu jalur.
- Supaya tombol `Selesai & Kembali ke Dashboard` bisa reset root navigation.

Root stack punya:

```swift
.id("navigation-root-\(dashboardResetCounter)")
```

Saat `dashboardResetCounter` naik, SwiftUI rebuild `NavigationStack`, sehingga path navigasi dibuang dan user balik ke root.

### NavigationService

File:

- `KopiJuang/Services/NavigationService.swift`

Fungsi:

```swift
NavigationService.popToRootView()
```

Yang dilakukan:

- baca `dashboardResetCounter`
- tambah 1
- simpan ke `UserDefaults`

Efek:

- `MainTabView` reset ke Dashboard
- `NavigationStack` rebuild
- user keluar dari flow panjang dan balik root

### Kenapa Masih Ada NavigationStack Lain?

Beberapa `NavigationStack` tetap ada di sheet atau preview.

Contoh:

- `DiscoveryNotesView` dibuka sebagai sheet.
- `FeedbackView` adalah sheet.
- `FlavorGuidanceSheet` adalah sheet.
- Preview SwiftUI butuh stack agar navigation title terlihat.

Sheet butuh stack sendiri karena modal punya navigation context sendiri. Kalau dipaksa pakai root stack utama, title, toolbar, dan push ke detail bisa rusak.

---

## 4. Alur User Dari Awal Sampai Akhir

Flow paling utama:

```text
ContentView
  -> MainTabView
    -> DashboardView
      -> CoffeeSetupView
        -> SensoryInputView
          -> ResultView
            -> FeedbackView
            -> CascadingQuizView
              -> CascadingQuizView berikutnya
                -> FinalAnalysisView
                  -> DashboardView
```

Versi manusia:

1. User buka app.
2. User masuk Dashboard.
3. User tekan tombol plus.
4. User isi detail beans.
5. User mulai sesi sensory.
6. User mencium kopi kering.
7. User mencium kopi basah.
8. User mencicip kopi.
9. App menampilkan hasil awal.
10. User memilih kategori rasa utama.
11. App mengajak user mempersempit rasa ke layer berikutnya.
12. User dapat analisis final.
13. Sesi masuk riwayat.
14. User balik Dashboard.

---

## 5. Dashboard

File:

- `KopiJuang/Views/DashboardView.swift`

Fungsi Dashboard:

- Menyambut user.
- Menampilkan edukasi singkat tentang sensory flow.
- Menampilkan Pro Tip.
- Menampilkan riwayat sesi.
- Menyediakan tombol plus untuk mulai sesi baru.

### Komponen Di Dashboard

#### Greeting

Text:

- `Halo, Future Barista!`
- `Setiap tegukan adalah langkah menuju keahlian.`

#### SensoryFlowShowcase

Menjelaskan 3 tahap:

- Fragrance: kopi kering
- Aroma: kopi setelah kena air
- Taste: kopi dicicip

#### ProTipCard

Sekarang Pro Tip bisa di-slide.

Data tips ada di:

- `KopiJuang/Models/CoffeeTip.swift`
- `KopiJuang/Models/CoffeeTipData.swift`

#### Riwayat Palate

Data riwayat dibaca dari SwiftData:

```swift
@Query(sort: \SessionHistory.date, order: .reverse)
```

Kalau riwayat kosong:

- tampil `EmptyHistoryCard`

Kalau ada:

- tampil `SessionRowLabel`
- tap baris menuju `SessionHistoryDetailView`

---

## 6. Setup Beans

File:

- `KopiJuang/Views/CoffeeSetupView.swift`
- `KopiJuang/ViewModels/CoffeeSetupViewModel.swift`

Tujuan layar ini:

- User memberi konteks kopi sebelum sesi sensory.

Input:

- nama kopi
- origin
- roast level
- process

### Roast Level

Contoh:

- Light
- Medium
- Dark
- Omni

Roast membantu app memberi konteks umum:

- Light cenderung lebih bright.
- Dark cenderung lebih pahit/body.
- Medium lebih seimbang.

Ini bukan hukum mutlak. Ini hanya panduan awal.

### Process

Contoh:

- Natural
- Wash/Washed
- Honey
- Anaerobic
- Wet Hulled

Process membantu app memberi konteks:

- Natural sering lebih fruity.
- Washed sering lebih bersih.
- Honey sering manis lembut.
- Anaerobic bisa lebih fermentatif.
- Wet Hulled bisa lebih body/earthy.

### Cupping Checklist

Komponen:

- `KopiJuang/Views/CuppingChecklistSection.swift`

Isi checklist:

- seduh dan giling
- bersihkan lidah
- waktu mencicip
- slurp dan retronasal

Tujuan:

- membantu pemula siap sebelum menilai rasa

---

## 7. Input Sensorik

File utama:

- `KopiJuang/Views/SensoryInputView.swift`
- `KopiJuang/ViewModels/SensoryInputViewModel.swift`

Ini layar inti pengecapan.

`SensoryInputViewModel` menyimpan state:

- step saat ini
- nilai fragrance
- kategori fragrance
- aroma contrast
- nilai aroma
- kategori aroma
- acidity
- sweetness
- bitterness
- body
- taste category

### Skala Slider

Semua slider sekarang mulai dari **0**.

Range:

```swift
0...10
```

Kenapa default 0:

- supaya user sadar harus menggeser slider
- supaya app tidak memberi nilai asumsi dari awal

User tidak bisa lanjut jika slider masih 0.

### Step 1: Fragrance

Fragrance = aroma kopi kering sebelum terkena air.

User mengisi:

- seberapa jelas aromanya
- aromanya mengarah ke mana

Copy UI sekarang diarahkan untuk pemula:

- Cium 3 kali pendek.
- Kalau samar, nilai rendah.
- Kalau langsung kebaca, nilai tinggi.
- Pilih keluarga aroma paling dekat.

### Step 2: Aroma

Aroma = aroma kopi setelah terkena air/bloom.

User mengisi:

- aroma sama atau berubah
- seberapa jelas aroma basah
- kalau berubah, aroma basah mengarah ke kategori apa

Jika user memilih `Sama`, app pakai kategori fragrance sebagai aroma category.

### Step 3: Taste

Taste = rasa di mulut setelah slurp.

User mengisi:

- acidity
- sweetness
- bitterness
- body
- kategori rasa utama

Copy pemula:

- acidity = segar/bright
- sweetness = bulat/nyaman
- bitterness = getir/pahit
- body = tebal-tipis cairan di mulut

### Retronasal

App sering menyebut:

- slurp
- hembus lewat hidung
- aroma dari mulut naik ke hidung belakang

Ini penting karena banyak aroma kopi terasa bukan cuma di lidah, tapi saat retronasal.

---

## 8. Hasil Awal

File:

- `KopiJuang/Views/ResultView.swift`
- `KopiJuang/ViewModels/ResultViewModel.swift`

Setelah SensoryInput selesai, app masuk Result.

Isi Result:

- metadata kopi
- ringkasan fragrance vs aroma
- bar sensory
- saran seduhan berikutnya
- pertanyaan kategori rasa utama
- tombol bantuan catatan pengecapan

### FragranceAromaSummaryCard

Menunjukkan:

- Dry
- Wet
- apakah stabil atau kontras

Ini membantu user sadar bahwa aroma kering dan basah bisa berbeda.

### Analisis Sensorik

Menampilkan bar:

- Asam
- Manis
- Pahit
- Body

Nilai berasal dari slider user.

### Saran Untuk Seduhan Berikutnya

Sumber:

- `KopiJuang/Models/BrewHeuristics.swift`

Catatan penting:

- Ini bukan standar skor resmi WCR/SCA.
- Ini panduan deskriptif berbasis pola umum roast/process.
- WCR lebih fokus pada bahasa sensory dan intensitas deskriptif.
- SCA memberi prinsip evaluasi dan brewing umum.
- Jadi app memakai pendekatan aman: `jika terasa begini, coba ubah satu variabel`.

Contoh saran:

- jika acidity rendah dan cangkir flat, coba grind lebih halus/suhu naik sedikit
- jika bitterness tinggi, coba suhu turun/grind lebih kasar/waktu kontak lebih pendek
- jika body terlalu ringan, coba rasio lebih pekat

### Pemilihan Kategori Utama

User memilih satu dari 9 kategori besar:

- Sweet
- Floral
- Fruity
- Sour / Fermented
- Green / Vegetative
- Other
- Roasted
- Spices
- Nutty / Cocoa

Ini bukan ujian benar-salah. Ini tahap refleksi:

- rasa paling dominan masuk keluarga mana?

Setelah memilih:

- progress user disimpan
- feedback sheet muncul
- user lanjut eksplorasi layer rasa

---

## 9. Flavor Wheel Internal

File:

- `KopiJuang/Models/FlavorCategory.swift`
- `KopiJuang/Models/FlavorWheelNode.swift`
- `KopiJuang/Models/FlavorWheelData.swift`

Flavor wheel app punya 3 layer.

### Layer 1

Kategori besar:

1. Sweet
2. Floral
3. Fruity
4. Sour / Fermented
5. Green / Vegetative
6. Other
7. Roasted
8. Spices
9. Nutty / Cocoa

### Layer 2

Contoh:

- Fruity -> Berry, Citrus, Dried Fruit, Tropical
- Sweet -> Brown Sugar, Vanilla, Sweet Aromatic
- Roasted -> Cereal, Tobacco / Asphalt, Gosong-kering

### Layer 3

Contoh:

- Berry -> Blackberry, Raspberry, Blueberry, Strawberry
- Citrus -> Lemon, Lime, Grapefruit, Orange
- Brown Sugar -> Honey, Caramel, Maple, Molasses

### Kenapa Pakai ID?

`FlavorWheelNode` punya:

- `id`
- `name`
- `description`
- `layer`
- `parent`
- `children`

`id` dipakai untuk navigasi dan lookup.

Jangan asal ubah id, karena:

- progress unlock pakai node
- training guide pakai id
- cascading quiz pakai id
- final analysis baca parent dari id

---

## 10. Cascading Quiz

File:

- `KopiJuang/Views/CascadingQuizView.swift`
- `KopiJuang/ViewModels/CascadingQuizViewModel.swift`

Setelah user memilih kategori utama di Result, user masuk quiz berjenjang.

Contoh flow:

```text
Fruity
  -> Berry
    -> Blueberry
```

Atau:

```text
Sweet
  -> Brown Sugar
    -> Caramel
```

### Cara Kerja

`CascadingQuizViewModel` menerima:

- `evaluation`
- `selectedPrimaryCategory`
- `parentNodeId`

Lalu mencari node:

```swift
FlavorWheelNode.findNode(by: parentNodeId)
```

Jika node punya children:

- tampil pilihan anak

Jika user memilih anak yang masih punya children:

- navigasi ke `CascadingQuizView` berikutnya

Jika user memilih node terakhir:

- simpan session
- navigasi ke `FinalAnalysisView`

### Guidance Sheet

Ada tombol:

- `Bingung pilih yang mana?`

Sheet menampilkan:

- cara membedakan pilihan
- latihan indera
- hint per child

Sumber:

- `FlavorNodeGuidance.swift`
- `WCRSensoryTraining.swift`

---

## 11. Latihan Indera / WCR Sensory Training

File:

- `KopiJuang/Models/WCRSensoryTraining.swift`
- `KopiJuang/Views/WCRSensoryTrainingView.swift`

Fungsi:

- memberi metode latihan untuk setiap node rasa
- bukan menampilkan intensity WCR mentah
- bukan memaksa user beli reference resmi
- fokus pada cara belajar: cium, cicip, mouthfeel, drill

Setiap guide punya:

- `smellTraining`
- `tasteTraining`
- `mouthTraining`
- `dailyDrill`

Contoh:

- untuk Fruity: bandingkan citrus, berry, tropical, dried fruit
- untuk Citrus: cium kulit jeruk/lemon/lime
- untuk Nutty/Cocoa: bandingkan almond, peanut, cocoa powder, dark chocolate

### Kenapa Tidak Pakai Angka Intensity WCR?

Versi awal pernah memakai intensity/reference.

Lalu diubah karena terlalu teknis untuk pemula.

Keputusan produk sekarang:

- pakai metode latihannya saja
- copy singkat
- mudah dipahami newbie barista
- intensity resmi tidak ditampilkan

### Coverage

`WCRSensoryTraining` sekarang punya guide untuk semua node utama di app:

- semua L1
- semua L2
- semua L3 yang ada di `FlavorWheelData`

Ada juga fallback `generatedGuide` jika suatu hari node baru ditambahkan tapi guide belum ditulis.

---

## 12. Final Analysis

File:

- `KopiJuang/Views/FinalAnalysisView.swift`
- `KopiJuang/ViewModels/FinalAnalysisViewModel.swift`

Ini layar akhir setelah user selesai memilih layer rasa.

Isi:

- highlight profil
- data yang terekam
- profil akhir
- saran seduhan berikutnya
- progress familiarity
- tombol `Selesai & Kembali ke Dashboard`

### Highlight Profil

Copy lama `Kamu mengebor...` sudah diganti.

Sekarang:

- `Kamu mempersempit rasa dari ...`

Lebih ramah untuk barista pemula.

### Tombol Selesai

Action:

```swift
NavigationService.popToRootView()
```

Efek:

- `dashboardResetCounter` naik
- `MainTabView` reset ke tab Dashboard
- root `NavigationStack` rebuild
- user balik Dashboard

---

## 13. Atlas

File:

- `KopiJuang/Views/AtlasView.swift`
- `KopiJuang/ViewModels/AtlasViewModel.swift`
- `KopiJuang/Views/FlavorDetail/FlavorDetailView.swift`

Flavor Atlas adalah tempat user melihat note yang sudah terbuka.

### AtlasViewModel

Membangun list dari:

- `FlavorWheelData.wheel`
- `UserProgress`

Untuk setiap node, app membuat `FlavorNote`.

`FlavorNote` berisi:

- id
- name
- category
- description
- icon
- layer
- isUnlocked
- experienceCount
- familiarityLevel

### FlavorDetailView

Jika note terbuka:

- tampil profil rasa
- tampil latihan indera
- tampil tips latihan

Jika terkunci:

- tampil pesan agar user lanjut eksplorasi

---

## 14. Riwayat Sesi

File:

- `KopiJuang/Views/SessionHistoryDetailView.swift`
- `KopiJuang/Models/SessionSnapshot.swift`

Setiap sesi yang selesai akan masuk `SessionHistory`.

Data yang disimpan:

- bean name
- origin
- roast
- process
- fragrance category
- fragrance intensity
- aroma contrast
- aroma category
- aroma intensity
- acidity
- sweetness
- bitterness
- body
- taste category
- primary category
- secondary note
- specific note

Nilai sensory sekarang memakai skala:

```text
0...10
```

`0` artinya belum terasa / belum digeser.

User tidak bisa menyelesaikan flow kalau nilai masih 0 di input wajib.

---

## 15. Model Data Utama

### SensoryEvaluation

File:

- `KopiJuang/Models/SensoryEvaluation.swift`

Ini data satu sesi sebelum/saat dianalisis.

Isi:

- metadata beans
- fragrance
- aroma
- taste metrics
- taste category

Dipakai oleh:

- `ResultView`
- `BrewHeuristics`
- `CascadingQuizView`
- `FinalAnalysisView`
- `SessionSnapshot`

### UserProgress

File:

- `KopiJuang/Models/UserData.swift`

Menyimpan progress jangka panjang user:

- unlocked primary notes
- unlocked secondary notes
- unlocked specific notes
- experienced notes
- total correct guesses
- completed sessions
- badges

### UserProgressStore

File:

- `KopiJuang/Models/UserProgressStore.swift`

Fungsi:

- ambil progress utama jika ada
- kalau belum ada, buat progress baru

### SessionHistory

File:

- `KopiJuang/Models/UserData.swift`

Menyimpan riwayat sesi.

Ada `snapshotData` opsional berisi JSON dari `SessionSnapshot`.

### UserBadge

File:

- `KopiJuang/Models/UserData.swift`

Untuk badge/pencapaian.

---

## 16. BrewHeuristics

File:

- `KopiJuang/Models/BrewHeuristics.swift`

Fungsi:

- memberi ekspektasi kasar berdasarkan roast dan process
- memberi saran seduhan berikutnya

### Apakah Ini Standar WCR/SCA?

Jawaban pendek:

- bukan standar resmi angka WCR/SCA
- sudah dibuat lebih aman dan selaras prinsip WCR/SCA

WCR Sensory Lexicon:

- fokus pada bahasa deskriptif rasa/aroma/mouthfeel
- tidak memberi formula brewing
- tidak menilai kualitas baik/buruk

SCA:

- punya prinsip cupping, extraction, brew control
- saran brew adjustment boleh dipakai sebagai panduan umum

Maka app memakai BrewHeuristics sebagai:

- pembanding kasar
- bukan verdict
- bukan benar/salah
- bukan standar kualitas

### Saran Yang Diberikan

Contoh pola:

- acidity rendah + cup flat -> grind lebih halus / suhu naik / kontak lebih lama
- acidity terlalu tajam -> grind lebih kasar / suhu turun / kontak lebih pendek
- sweetness rendah -> ekstraksi mungkin kurang lengkap
- bitterness tinggi -> kemungkinan over-extraction atau roast impact
- body ringan -> rasio lebih pekat / grind lebih halus
- body berat -> rasio lebih encer / grind lebih kasar

---

## 17. TrainingView Dan Discovery Notes

File:

- `KopiJuang/Views/DiscoveryNotesView.swift`
- `KopiJuang/Views/TrainingView.swift`
- `KopiJuang/ViewModels/TrainingViewModel.swift`
- `KopiJuang/Models/Training/TrainingContent.swift`

### DiscoveryNotesView

Dipakai sebagai daftar bantuan.

User bisa membuka dari:

- SensoryInput
- Result

Isi:

- daftar 9 flavor category
- per kategori ada learning line
- tap kategori masuk TrainingView

### TrainingView

Menampilkan:

- intro
- latihan singkat
- langkah latihan
- reference note

### TrainingContent

Berisi materi untuk kombinasi:

```text
9 kategori x 3 stage = 27 blok
```

Stage:

- fragrance
- aroma
- taste

---

## 18. Copywriting Dan UX Yang Sudah Diarahkan

Keputusan copy terbaru:

- pakai Bahasa Indonesia sederhana
- hindari istilah teknis tanpa penjelasan
- tetap pakai istilah standar seperti `slurp`, `retronasal`, `body`
- untuk istilah teknis, beri konteks di kalimat sekitar
- hindari kata aneh seperti `mengebor`
- pemula harus tahu apa yang harus dilakukan, bukan cuma disuruh nilai

Contoh perubahan:

- `Wanginya mirip apa?` -> `Aromanya mengarah ke mana?`
- `Seberapa terasa?` -> `Nilai rasa dasar di mulut`
- `Kamu mengebor...` -> `Kamu mempersempit rasa...`

Warna subtext juga dinaikkan kontrasnya:

- banyak `.secondary/.tertiary` diganti ke `Color.primary.opacity(...)`

Tujuan:

- subtitle lebih terbaca di background abu-abu
- HIG tetap aman
- hierarchy visual tetap lembut

---

## 19. Style UI

Gaya visual app:

- warna utama: brown
- card rounded
- banyak background `secondarySystemBackground`
- button utama: brown solid + teks putih
- button bantuan: outline brown
- chip: brown opacity

### Button Bantuan

Style `Butuh bantuan: catatan pengecapan` dibuat mirip:

- `Bingung pilih yang mana?`

Tujuan:

- user mengerti keduanya sama-sama bantuan
- visual konsisten

### Question Section Result

Style button kategori di `ResultView` disamakan dengan sensory picker:

- icon circle brown
- title
- subtitle
- examples chip
- selected state dengan border brown

---

## 20. File Index

### App

- `KopiJuang/App/KopiJuangApp.swift`

### Navigation

- `KopiJuang/Views/MainTabView.swift`
- `KopiJuang/ViewModels/MainTabViewModel.swift`
- `KopiJuang/Services/NavigationService.swift`

### Onboarding

- `KopiJuang/Views/ContentView.swift`
- `KopiJuang/Views/MasterPrepGuideView.swift`
- `KopiJuang/Views/CoffeeFeelView.swift`

Catatan:

- `ContentView` dipakai oleh `KopiJuangApp`
- `MasterPrepGuideView` dan `CoffeeFeelView` masih ada sebagai flow alternatif/legacy

### Dashboard

- `KopiJuang/Views/DashboardView.swift`
- `KopiJuang/Models/CoffeeTip.swift`
- `KopiJuang/Models/CoffeeTipData.swift`

### Setup

- `KopiJuang/Views/CoffeeSetupView.swift`
- `KopiJuang/ViewModels/CoffeeSetupViewModel.swift`
- `KopiJuang/Views/CuppingChecklistSection.swift`

### Sensory Input

- `KopiJuang/Views/SensoryInputView.swift`
- `KopiJuang/ViewModels/SensoryInputViewModel.swift`
- `KopiJuang/Models/SensoryInputStep.swift`
- `KopiJuang/Models/SensoryEvaluation.swift`

### Result

- `KopiJuang/Views/ResultView.swift`
- `KopiJuang/ViewModels/ResultViewModel.swift`
- `KopiJuang/Models/BrewHeuristics.swift`

### Flavor Wheel

- `KopiJuang/Models/FlavorCategory.swift`
- `KopiJuang/Models/FlavorCategory+Presentation.swift`
- `KopiJuang/Models/FlavorWheelNode.swift`
- `KopiJuang/Models/FlavorWheelData.swift`
- `KopiJuang/Models/FlavorNodeGuidance.swift`
- `KopiJuang/Models/CategoryPickerDescriptors.swift`

### Cascading Quiz

- `KopiJuang/Views/CascadingQuizView.swift`
- `KopiJuang/ViewModels/CascadingQuizViewModel.swift`

### Final Analysis

- `KopiJuang/Views/FinalAnalysisView.swift`
- `KopiJuang/ViewModels/FinalAnalysisViewModel.swift`

### Atlas

- `KopiJuang/Views/AtlasView.swift`
- `KopiJuang/ViewModels/AtlasViewModel.swift`
- `KopiJuang/Views/FlavorDetail/FlavorDetailView.swift`
- `KopiJuang/Models/FlavorNote.swift`

### Training

- `KopiJuang/Views/DiscoveryNotesView.swift`
- `KopiJuang/Views/TrainingView.swift`
- `KopiJuang/ViewModels/TrainingViewModel.swift`
- `KopiJuang/Models/Training/TrainingContent.swift`
- `KopiJuang/Models/WCRSensoryTraining.swift`
- `KopiJuang/Views/WCRSensoryTrainingView.swift`

### History / Data

- `KopiJuang/Views/SessionHistoryDetailView.swift`
- `KopiJuang/Models/SessionSnapshot.swift`
- `KopiJuang/Models/UserData.swift`
- `KopiJuang/Models/UserProgressStore.swift`

---

## 21. Hal Penting Kalau Mau Lanjut Development

### 1. Jangan Ubah Node ID Sembarangan

Node id dipakai banyak tempat:

- progress
- unlock atlas
- cascading quiz
- training guide
- final analysis

Kalau id berubah, data lama bisa tidak cocok.

### 2. Kalau Tambah Flavor Node, Tambah Juga Training Guide

Minimal update:

- `FlavorWheelData.swift`
- `FlavorNodeGuidance.swift`
- `WCRSensoryTraining.swift`

Kalau lupa, fallback masih jalan, tapi copy jadi generic.

### 3. Kalau Ubah Skala Slider, Update Semua Komentar Dan History

Sekarang skala:

```text
0...10
```

Jangan balik ke `1...10` tanpa update:

- `SensoryInputView`
- `SensoryInputViewModel`
- `SensoryEvaluation`
- `SessionSnapshot`
- copy training
- Result display

### 4. Kalau Ubah Navigasi, Tes Tombol Final

Wajib tes:

```text
Dashboard -> Setup -> Sensory -> Result -> Cascading -> Final -> Selesai
```

Tombol final harus balik Dashboard.

### 5. Jangan Klaim WCR/SCA Sebagai Standar Angka Brewing

Gunakan wording:

- "selaras prinsip"
- "panduan deskriptif"
- "pembanding kasar"
- "bukan standar kualitas"

Hindari wording:

- "standar resmi WCR"
- "skor harus segini"
- "benar/salah"

### 6. Build Lokal Perlu Xcode Penuh

`xcodebuild` pernah gagal karena active developer directory masih:

```text
/Library/Developer/CommandLineTools
```

Untuk build via terminal, perlu Xcode penuh aktif via `xcode-select`.

---

## 22. Status Terbaru

Versi saat ini adalah versi terbaik sejauh ini menurut owner project.

Fitur yang sudah masuk:

- dashboard dengan pro tip swipeable
- setup beans lebih ringkas
- sensory slider default 0
- sensory flow 0...10
- result question style sama dengan sensory picker
- bantuan catatan pengecapan style konsisten
- subtext lebih terbaca
- WCR training untuk semua node wheel
- final button balik Dashboard fixed
- single root `NavigationStack` untuk main app
- sheet tetap punya stack sendiri bila perlu

Dokumen ini harus di-update lagi jika:

- flavor wheel berubah
- data model berubah
- flow navigasi berubah
- persistence berubah
- wording sensory/training berubah besar

