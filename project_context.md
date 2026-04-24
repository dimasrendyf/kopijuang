# Project context: KopiJuang

Dokumen ini menjelaskan **tujuan aplikasi**, **alur pengguna & kode**, **model data**, **sistem rasa (flavor wheel)**, serta **ringkasan perubahan** yang telah diiterasikan di project (termasuk penyelarasan copy Bahasa Indonesia dan UX). Tujuannya agar kamu bisa membaca satu file dan memahami bagaimana bagian-bagian saling terhubung.

---

## 1. Apa itu KopiJuang?

**KopiJuang** adalah aplikasi iOS (SwiftUI) yang membantu pengguna **mencatat dan memetakan pengalaman sensorik kopi** secara bertahap: dari biji kering (fragrance), setelah kena air (aroma), sampai rasa di mulut (taste). Setelah itu pengguna **mengekspresikan kesan dominan** lewat kategori rasa berlapis (primary → secondary → specific) yang terinspirasi leksikon pengecapan umum (bukan salinan resmi pihak ketiga).

**Bahasa UI** diarahkan ke **Bahasa Indonesia** yang jelas dan edukatif. **Target persona**: pemula / calon barista yang belajar membedakan nuansa.

**Stack teknis**

- **SwiftUI** untuk seluruh UI.
- **SwiftData** (`ModelContainer` di `KopiJuangApp`) untuk `UserProgress`, `SessionHistory`, `UserBadge`.
- **Observation** (`@Observable`) untuk beberapa view model (`ResultViewModel`, `TrainingViewModel`, dll.).

---

## 2. Entry point & navigasi tingkat tinggi

### 2.1 `KopiJuangApp.swift`

- `@AppStorage("hasCompletedFirstSession")` mengontrol onboarding.
- Jika **belum** selesai: tampil `ContentView`.
- Jika **sudah**: tampil `MainTabView`.
- `.modelContainer(modelContainer)` menyuntikkan SwiftData ke seluruh hierarki.

Ada logika **pemulihan store** bila `ModelContainer` gagal dibuat (hapus file `default.store` + sidecar WAL/SHM di Application Support, lalu coba lagi).

### 2.2 Onboarding singkat: `ContentView.swift`

- Landing dengan gambar, judul, subcopy.
- Tombol **“Mulai”** mengatur `hasCompletedFirstSession = true` → app pindah ke `MainTabView`.
- **Catatan**: di tree saat ini, first run **tidak** melewati `MasterPrepGuideView` dari sini. File `MasterPrepGuideView.swift` dan `CoffeeFeelView.swift` masih ada di project; alur alternatif bisa dipakai nanti atau dari tempat lain.

### 2.3 Tab utama: `MainTabView.swift`

- Tab **Dashboard** (`DashboardView`) — index 0.
- Tab **Atlas** (`AtlasView`) — index 1.
- `@AppStorage("dashboardResetCounter")` + `MainTabViewModel`: saat counter berubah, tab dipaksa kembali ke Dashboard (berguna setelah selesai flow analisis agar “reset” ke home).

---

## 3. Alur sesi kopi (happy path)

Ringkasan urutan **dari mulai sampai selesai**:

```text
DashboardView
  → CoffeeSetupView (metadata + checklist)
  → SensoryInputView
        Step 1: Fragrance (kering)
        Step 2: Aroma (basah / kontras)
        Step 3: Taste (metrik + refleksi kategori)
  → ResultView
        → Sheet FeedbackView (setelah pilih kategori primary)
        → navigationDestination → CascadingQuizView (L2 / L3 dari flavor wheel)
              → (recursive) deeper layer atau
              → FinalAnalysisView
```

**Detail per tahap** ada di bawah; nama file mengikuti urutan di atas.

---

## 4. Layar & tanggung jawab file

### 4.1 Dashboard — `DashboardView.swift`

- `@Query` ke `SessionHistory` (urut tanggal terbaru) untuk **Riwayat Palate**.
- Tanpa riwayat: `EmptyHistoryCard`.
- Ada `NavigationLink` ke `SessionHistoryDetailView` per baris.
- **FAB** (`+`) → `CoffeeSetupView`.

Komponen edukatif di dalamnya: `SensoryFlowShowcase`, `ProTipCard`, dll.

### 4.2 Setup beans — `CoffeeSetupView.swift` + `CoffeeSetupViewModel.swift`

**Input**

- Nama kopi, origin (opsional untuk start), **Roast** (Light, Medium, Dark, Omni), **Proses** (Natural, Wash, Honey, Anaerobic, Wet Hulled).

**Perilaku**

- Di bawah picker Roast/Proses, **teks penjelas singkat** (`roastDescription`, `processDescription`) memberi konteks sensorik (bukan prediksi cup spesifik).
- **Tidak ada** blok “prediksi skor” terpisah di sini; ekspektasi kasar untuk hasil disatukan di **layar hasil** lewat `BrewHeuristics` (lihat §7).
- **Checklist pengecapan**: `CuppingChecklistSection` (collapsible). `AppStorage("shouldExpandCuppingChecklistOnFirstOpen")` membuka sekali saat pertama agar user melihat alat/ritme cupping.
- Tombol **Mulai** (toolbar) → `SensoryInputView(...)` dengan `disabled(!viewModel.canStart)`.

### 4.3 Input sensorik — `SensoryInputView.swift` + `SensoryInputViewModel.swift` (bila ada)

Tiga fase: **fragrance**, **aroma**, **taste** (bukan nama file terpisah; satu view dengan state machine step).

- Header: metadata beans, indikator step.
- **Fragrance**: intensitas + **FlavorCategory** (9 pilihan) lewat `CategoryPickerGrid` / komponen terkait.
- **Aroma**: `AromaContrast` (Sama / Berubah / …) + intensitas + kategori; logika menyesuaikan kategori jika “sama” dengan dry.
- **Taste** (`TasteStepView`, struct privat di dalam `SensoryInputView.swift`):
  - Slider metrik: acidity, sweetness, bitterness, body (skala 1–10).
  - **Eksplorasi rasa** diarahkan ke konteks **roast + proses** (teks bantu dari setup), bukan ramalan angka.
  - Pemilihan **kategori dominan** (primary) sejalan `FlavorCategory` 9 (bukan 4 lama).

Akhir: membentuk `SensoryEvaluation` dan navigasi ke `ResultView`.

### 4.4 Hasil — `ResultView.swift` + `ResultViewModel.swift`

**Tampil**

- Metadata sesi.
- `FragranceAromaSummaryCard`: ringkasan kering vs basah.
- **Analisis sensorik**: bar asam, manis, pahit, body.
- **Saran untuk seduhan besok** (dua lapisan teks):
  - `brewTipInsight` ← `BrewHeuristics.softTypicalLine(roast:process:)` — satu paragraf “gambaran umum” profil, **dengan menyebut “level sangrai … dengan proses …”** (bukan cuma “Light + Natural” tanpa label).
  - `brewTipAction` ← `BrewHeuristics.nextBrewGuidance(for:)` — paragraf berikut yang membandingkan skor user dengan *ekspektasi rentang* bila jauh, dan saran perbaikan; **tanpa menyisipkan literal range kode** ke teks tampilan.
- Pertanyaan refleksi: user memilih **satu** `FlavorCategory` primary yang paling menggambarkan profil **secara keseluruhan** (bukan kuis benar/salah tegas).

**Setelah pilih kategori — `checkAnswer`**

- Menyimpan progres `UserProgress` (unlock primary, append experienced note) lewat `UserProgressStore.primary` + `modelContext.save()`.
- **Bukan** lagi skenario “jawaban salah” dominan: `isCorrect` di-set `true` untuk alur eksplorasi; fokus ke **lanjut layer berikutnya**.
- Menampilkan **sheet** `FeedbackView` dengan copy & ikon sukses (bukan bintang “Brilliant” semata — iterasi terakhir memakai ikon perayaan + judul *mengenali cita rasa baru*).

**Lanjut**

- `onFeedbackNextTapped` menutup sheet, lalu `navigateToCascading` → `CascadingQuizView` dengan kategori terpilih dan `parentNodeId` = `FlavorCategory` raw value (L1 id).

### 4.5 Kuis berjenjang (flavor wheel) — `CascadingQuizView.swift` + `CascadingQuizViewModel.swift`

- Menampilkan **anak** dari `FlavorWheelNode` sesuai `parentNodeId` (L1 = string raw value kategori, mis. `"Fruity"`).
- Setiap anak memiliki `name` + `description` (dari `FlavorWheelData`).
- User memilih satu node → **Lanjut** → jika masih ada anak, navigasi rekursif ke `CascadingQuizView` berikutnya dengan `parentNodeId` = id node terpilih; jika sudah di ujung, bisa menuju `FinalAnalysisView` (tergantung logika di view model).

### 4.6 Analisis akhir — `FinalAnalysisView.swift` + `FinalAnalysisViewModel.swift`

- Menyimpan ringkasan / penutup sesi (dan kemungkinan menulis `SessionHistory` / badge — cek implementasi spesifik di file).

### 4.7 Catatan pengecapan (discovery) — `DiscoveryNotesView.swift`

- Dari `ResultView`, tautan bantuan membuka lembar referensi (stage taste) agar user membaca prinsip tanpa harus “menang” dulu.

### 4.8 Latihan rasa — `TrainingView.swift` + `TrainingViewModel.swift` + `TrainingContent.swift`

- Dipanggil jika butuh **materi terstruktur** per **(FlavorCategory × DiscoveryStage)**.
- `TrainingViewModel` memuat `TrainingContentBlock` dari `TrainingContent.block(category:stage:)`.
- Isi: `stageIntro`, `lead`, `steps[]`, `reference` — **parafase prinsip pengecapan**, diselaraskan ke **Bahasa Indonesia** yang wajar (bukan terjemahan kaku), dengan istilah asing bila memang standar meja (slurp, retronasal, dll.).

### 4.9 Atlas — `AtlasView.swift` + `AtlasViewModel.swift`

- Eksplorasi hierarki / notes (terhubung `FlavorWheelData` dan progres unlock).

### 4.10 Riwayat — `SessionHistoryDetailView.swift`

- Membaca `SessionHistory` + opsional `snapshotData` (JSON `SessionSnapshot`) jika tersedia.

---

## 5. Model & data penting

### 5.1 `SensoryEvaluation` — `Models/SensoryEvaluation.swift`

Struktur inti hasil satu sesi: metadata beans, fragrance (intensitas + kategori), aroma (kontras + intensitas + kategori), taste (empat skor). Dipakai dari `ResultView` → `BrewHeuristics` → `CascadingQuizView` → `FinalAnalysisView`.

### 5.2 `FlavorCategory` — `Models/FlavorCategory.swift`

**9 kasus** L1 (selaras gugus lapisan luar umum peta cita rasa / leksikon sensorik):

| Case | Label `rawValue` (UI) |
|------|------------------------|
| sweet | Sweet |
| floral | Floral |
| fruity | Fruity |
| sourFermented | Sour / Fermented |
| greenVegetative | Green / Vegetative |
| other | Other |
| roasted | Roasted |
| spices | Spices |
| nuttyCocoa | Nutty / Cocoa |

- `fromStoredName` + `String.asNormalizedPrimaryFlavor` menangani data lama (mis. “Nutty” → “Nutty / Cocoa”).

### 5.3 Pohon rasa — `Models/FlavorWheelNode.swift` + `Models/FlavorWheelData.swift`

- `FlavorWheelData.wheel` adalah array 9 node L1; tiap node punya `children` (L2), lalu L3.
- **Id** string stabil untuk navigasi (tidak diubah sembarangan); `name` + `description` untuk UI.
- **Deskripsi** diarahkan ke **Bahasa Indonesia** alami; nama bisa campuran (istilah internasional) bila perlu.

### 5.4 Tahap discovery — `Models/DiscoveryStage.swift`

- `fragrance` | `aroma` | `taste` — dipakai `TrainingView` / materi baca.

### 5.5 Presentasi kategori — `Models/FlavorCategory+Presentation.swift` (+ `CategoryPickerDescriptors.swift`)

- Warna, ikon SF Symbol, *blurb* singkat per kategori untuk grid picker.

### 5.6 Heuristik seduh — `Models/BrewHeuristics.swift`

- `expectation(roast:process:)` → rentang 1–10 per metrik (internal).
- `softTypicalLine` → **satu paragraf** ramah untuk card “insight” (menyebut **level sangrai** + **proses** secara eksplisit).
- `nextBrewGuidance` → teks **panjang** (intro + 0–4 paragraf deviasi) membandingkan skor user vs ekspektasi; intro memakai pola **“Kira-kira begini: level sangrai X, prosesnya Y …”** agar jelas membedakan **tingkat sangrai** vs **proses pasca panen**, bukan menyamakan keduanya sebagai “gaya rasa” generik saja.

### 5.7 SwiftData — `Models/UserData.swift` + `UserProgressStore.swift`

- `UserProgress`: `unlockedPrimaryNotes`, `unlockedSecondaryNotes`, `unlockedSpecificNotes`, `experiencedNotes`, `totalCorrectGuesses`, relasi `completedSessions`, `badges`.
- `SessionHistory`: `beanName`, `roastLevel`, `processLevel`, `finalCategory`, `snapshotData` opsional.
- `UserBadge`: badge per kategori / layer.
- `UserProgressStore.primary` mengambil entri pertama atau membuat baru.

---

## 6. Komponen UI yang sering muncul

- `MetricScale` / `SmoothDiscreteSlider` — slider skala 1–10.
- `CategoryPickerGrid` — pemilih 9 kategori dengan deskriptor per stage.
- `CuppingChecklistSection` — checklist alat/ritme; **tinggi/scroll** disesuaikan agar teks **tidak tertutup** indikator `TabView` bila isi panjang.
- `FeedbackView` — sheet pasca pilihan primary: ikon (mis. perayaan), judul, subcopy, pesan lanjut, tombol “Lanjut …” / tutup.
- `SensoryBar` — bar horisontal metrik hasil.

---

## 7. Ringkasan perubahan (iterasi kolaborasi) — agar histori tidak hilang

Bagian ini mencatat **apa yang sengaja diubah** di codebase dan **mengapa** (dari ringkasan sesi + pekerjaan copy/UX). Urutan kronologis mungkin tidak persis, tetapi cakupannya utuh.

### 7.1 Sistem rasa: dari 4 kategori → 9 + flavor wheel

- **FlavorCategory** diperluas ke **9** gugus L1 (selaras peta/leksem umum, bukan salinan peta bercetak resmi).
- **FlavorWheelData** membangun **hierarki tiga lapis** (L1–L3) dengan `id` stabil; **deskripsi** (dan sebagian `name`) di-**Indonesia**-kan.
- **Mapping legacy**: string tersimpan lama (mis. “Nutty”) dinormalisasi ke label baru (“Nutty / Cocoa”) lewat `fromStoredName` / `asNormalizedPrimaryFlavor`.
- **UI**: picker kategori, Atlas, kuis `CascadingQuizView` memakai struktur yang sama.

### 7.2 Alur hasil: prediksi dihapus, saran digabung ke heuristik

- Insight setup tidak lagi “meramal” skor; **patokan** dipindah ke **ResultView** lewat `BrewHeuristics`, dengan bahasa yang menjelaskan **kombinasi level sangrai + proses** dan skala 1–10 sebagai **acuan**, bukan hukum.

### 7.3 Coffee setup

- Fokus **metadata +** penjelas roast/proses + **checklist cupping** (expand sekali, layout aman di scroll).

### 7.4 Taste & discovery

- **TasteStepView** (atau ekuivalen) mendukung **9 kategori** + instruksi per grup slider + hierarki kartu bila diimplementasi di file terkait.
- **DiscoveryNotes** / `TrainingView` + **TrainingContent** menyediakan materi **SCA/WCR-dish** (parafase) per pasangan (kategori × stage).

### 7.5 Copy Bahasa Indonesia (TrainingContent, FlavorWheelData, BrewHeuristics)

- **TrainingContent**: teks diselaraskan agar **natural**, mengurangi kesan terjemahan mesin; isi per blok dijaga **27** pasangan (9 × 3 stage).
- **FlavorWheelData**: fokus pada `description` (dan nama ringkas) agar enak dibaca di grid/kuis.
- **BrewHeuristics**:
  - **softTypicalLine**: memakai frasa **“Level sangrai X dengan proses Y”** (atau setara) agar jelas membedakan **roast** vs **proses**.
  - **nextBrewGuidance**: intro diperbaiki (bukan “gambaran kasar untuk Light dan proses Natural” yang ambigu); paragraf deviasi tanpa **literal templating** kisaran angka ke pengguna; gaya lebih lisan.
- **CuppingChecklistSection**: teks + penyesuaian **tinggi/scroll** agar konten tidak tertabrak page control.

### 7.6 Result: feedback pasca jawaban

- Ganti gaya “Brilliant + bintang” menjadi **pesan celebratory** (mis. **mengenali cita rasa baru**) + ikon yang lebih “happy” (mis. `party.popper.fill`) + **symbolEffect** bounce (sesuai deployment iOS proyek).
- **Pesan secondary** (mengajak lanjut ke rasa turunan) + **ResultViewModel.feedbackMessage** diselaraskan.
- `checkAnswer` mengarah ke progres + sheet, bukan fokus “nilai 100% benar” semata (sesuai arah *eksplorasi*).

### 7.7 Regresi & build

- Beberapa siklus pengecekan **compile** dilakukan untuk `ResultView`, `FinalAnalysis`, `Atlas`, string `userProgress` — rincian error build lokal tergantung environment Xcode; **sumber kebenaran** di repo ini adalah file Swift yang tersync.

### 7.8 Insiden yang perlu dihindari (pelajaran)

- **TrainingContent** pernah hampir korup karena suntingan besar bertumpuk; jika menulis ulang, pastikan **switch** 27 cabang **exhaustif** dan tidak ada `case` sisa placeholder (`temp`, `aroma2` ganda, dll.).

---

## 8. Prinsip produk / UX (yang jadi pedoman di kode)

- **Edukatif dulu, nilai belakangan** — dokumentasi sensorik sebelum “skor sempurna”.
- **Salah pilih kategori** bukan kegagalan; **latihan** (`TrainingView`) dan **materi** (`TrainingContent`) mem-backup.
- **Teks hasil** menjembatani **setup (roast, proses)** dan **pengalaman cangkir (skor)** lewat heuristik, bukan ramalan ajaib.
- **Aksesibilitas** ringan: contoh `accessibilityLabel` di ikon feedback (sesuai iterasi `FeedbackView`).

---

## 9. Indeks file (kumpulan cepat)

| Area | File utama |
|------|------------|
| App | `KopiJuangApp.swift` |
| Onboarding | `ContentView.swift` |
| Tab | `MainTabView.swift`, `MainTabViewModel.swift` |
| Dashboard | `DashboardView.swift` |
| Setup | `CoffeeSetupView.swift`, `CoffeeSetupViewModel.swift` |
| Sensory | `SensoryInputView.swift`, `SensoryInputViewModel.swift`, `Taste` step views di folder Views |
| Hasil | `ResultView.swift`, `ResultViewModel.swift` |
| Heuristik | `BrewHeuristics.swift` |
| Wheel | `FlavorWheelData.swift`, `FlavorWheelNode.swift` |
| Kategori | `FlavorCategory.swift`, `FlavorCategory+Presentation.swift` |
| Kuis layer | `CascadingQuizView.swift`, `CascadingQuizViewModel.swift` |
| Penutup | `FinalAnalysisView.swift`, `FinalAnalysisViewModel.swift` |
| Training | `TrainingView.swift`, `TrainingViewModel.swift`, `Training/TrainingContent.swift` |
| Checklist | `CuppingChecklistSection.swift` |
| Discovery | `DiscoveryNotesView.swift`, `DiscoveryStage.swift` |
| Atlas | `AtlasView.swift`, `AtlasViewModel.swift` |
| Detail flavor | `FlavorDetail/FlavorDetailView.swift` |
| Data | `SensoryEvaluation.swift`, `UserData.swift`, `UserProgressStore.swift`, `SessionSnapshot.swift` |
| Prep (opsional) | `MasterPrepGuideView.swift`, `CoffeeFeelView.swift` |

---

## 10. Hal yang wajar masih “bisa dikembangkan”

- Konsistensi: mana yang masih memakai mock vs SwiftData penuh di Atlas/Dashboard, cek kembali sebelum rilis.
- `CoffeeFeelView` / `MasterPrepGuideView` jika produk memutuskan onboarding wajib prep guide sebelum `MainTabView`.
- Uji `symbolEffect` / SF Symbol di **deployment target** minimum yang kamu set di Xcode.
- Tes alur penuh: sesi → Result → Feedback → Cascading → FinalAnalysis → kembali Dashboard (`dashboardResetCounter`).

---

*Dokumen ini menggantikan/meringkas bagian lama `project_context.md` yang sudah tidak selaras (mis. 4 kategori, `aromaCategory` sebagai kunci kuis, atau alur `ContentView` ke `MasterPrepGuideView`). Bila menemukan selisih dengan kode, **utamakan isi repositori**; perbarui dokumen ini setelah perubahan besar berikutnya.*
