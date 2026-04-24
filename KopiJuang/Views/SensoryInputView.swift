//
//  SensoryInputView.swift
//  KopiJuang
//
//  Created by Dimas Rendy Febianto on 19/04/26.
//

import SwiftUI
import UIKit

struct SensoryInputView: View {
    @Environment(\.dismiss) var dismiss
    @State private var viewModel: SensoryInputViewModel

    init(beanName: String, beanOrigin: String, roastLevel: String, processLevel: String) {
        _viewModel = State(
            wrappedValue: SensoryInputViewModel(
                beanName: beanName,
                beanOrigin: beanOrigin,
                roastLevel: roastLevel,
                processLevel: processLevel
            )
        )
    }

    var body: some View {
        @Bindable var viewModel = viewModel
        ScrollViewReader { proxy in
            ScrollView {
                VStack(spacing: 32) {
                    Color.clear
                        .frame(height: 1)
                        .id("top")

                    header
                    
                    switch viewModel.step {
                    case .fragrance:
                        FragranceStepView(
                            intensity: $viewModel.fragranceIntensity,
                            category: $viewModel.fragranceCategory
                        )
                    case .aroma:
                        AromaStepView(
                            dryCategory: viewModel.fragranceCategory,
                            contrast: $viewModel.aromaContrast,
                            wetCategory: $viewModel.aromaCategory,
                            wetIntensity: $viewModel.aromaIntensity
                        )
                        .onAppear { viewModel.onAromaStepAppear() }
                    case .taste:
                        TasteStepView(
                            roastLevel: viewModel.roastLevel,
                            processLevel: viewModel.processLevel,
                            acidity: $viewModel.acidity,
                            sweetness: $viewModel.sweetness,
                            bitterness: $viewModel.bitterness,
                            bodyScore: $viewModel.bodyScore,
                            category: $viewModel.tasteCategory
                        )
                    }

                    footer
                }
            }
            .scrollDismissesKeyboard(.interactively)
            .onChange(of: viewModel.scrollToTopNonce) { _, _ in
                withAnimation(.easeInOut(duration: 0.25)) {
                    proxy.scrollTo("top", anchor: .top)
                }
            }
        }
        .navigationTitle("Sensory")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    if !viewModel.goBack() { dismiss() }
                } label: {
                    Image(systemName: "chevron.left")
                        .font(.headline)
                }
                .tint(.brown)
            }
        }
    }

    private var header: some View {
        VStack(spacing: 10) {
            Text(viewModel.step.title)
                .font(.title2.bold())
            Text(viewModel.step.subtitle)
                .font(.subheadline)
                .foregroundStyle(.secondary)

            StepIndicator(current: viewModel.step)
                .padding(.top, 4)

            SessionMetaRow(
                beanName: viewModel.beanName,
                beanOrigin: viewModel.beanOrigin,
                roastLevel: viewModel.roastLevel,
                processLevel: viewModel.processLevel
            )
                .padding(.top, 4)
        }
        .multilineTextAlignment(.center)
        .padding(.top)
        .padding(.horizontal)
    }

    private var footer: some View {
        let canGo = viewModel.canAdvanceFromCurrentStep
        return VStack(spacing: 12) {
            if viewModel.step == .taste {
                // `makeEvaluation()` hanya boleh dipanggil bila pilihan lengkap; jangan sertakan
                // di `NavigationLink` bila canGo = false, karena body SwiftUI mengevaluasi destination.
                if canGo {
                    NavigationLink(
                        destination: ResultView(
                            evaluation: viewModel.makeEvaluation()
                        )
                    ) {
                        tasteFooterLabel(active: true)
                    }
                    .padding(.horizontal)
                } else {
                    Button(action: {}) {
                        tasteFooterLabel(active: false)
                    }
                    .buttonStyle(.plain)
                    .disabled(true)
                    .padding(.horizontal)
                }
            } else {
                Button {
                    viewModel.goNext()
                } label: {
                    Text("Lanjut")
                        .font(.headline)
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(canGo ? Color.brown : Color.brown.opacity(0.35))
                        .cornerRadius(12)
                }
                .disabled(!canGo)
                .padding(.horizontal)
            }
        }
    }

    private func tasteFooterLabel(active: Bool) -> some View {
        Text("Lanjut")
            .font(.headline)
            .foregroundStyle(.white)
            .frame(maxWidth: .infinity)
            .padding()
            .background(active ? Color.brown : Color.brown.opacity(0.35))
            .cornerRadius(12)
    }
}

#Preview {
    SensoryInputView(beanName: "Ethiopia", beanOrigin: "Ethiopia", roastLevel: "Medium", processLevel: "Natural")
}

private struct SessionMetaRow: View {
    let beanName: String
    let beanOrigin: String
    let roastLevel: String
    let processLevel: String
    
    var body: some View {
        HStack(spacing: 8) {
            Label(beanName, systemImage: "cup.and.saucer.fill")
            
            Text("•").foregroundStyle(.secondary)
            
            Label(beanOrigin, systemImage: "map.fill")
            
            Text("•").foregroundStyle(.secondary)
            
            Label(roastLevel, systemImage: "flame.fill")
            
            Text("•").foregroundStyle(.secondary)
            
            Label(processLevel, systemImage: "drop.fill")
        }
        .font(.caption)
        .foregroundStyle(.secondary)
        .lineLimit(1) // Memastikan teks tetap dalam satu baris
        .minimumScaleFactor(0.8) // Mengecilkan teks otomatis jika ruang tidak cukup
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 12)
        .padding(.vertical, 10)
        .background(Color.brown.opacity(0.08))
        .cornerRadius(12)
    }
}

private struct StepIndicator: View {
    let current: SensoryInputStep

    var body: some View {
        HStack(spacing: 8) {
            ForEach(SensoryInputStep.allCases, id: \.rawValue) { s in
                Circle()
                    .fill(s.rawValue <= current.rawValue ? Color.brown : Color.brown.opacity(0.2))
                    .frame(width: 10, height: 10)
            }
        }
    }
}

// MARK: - Step 1: Fragrance (Dry Coffee)
private struct FragranceStepView: View {
    @Binding var intensity: Double
    @Binding var category: FlavorCategory?
    
    @State private var isSniffing = true
    @State private var ringScale: CGFloat = 0.2
    @State private var ringOpacity: Double = 0.8
    @State private var showDiscovery = false
    
    var body: some View {
        VStack(spacing: 18) {
            StepIntroCard(
                title: "Info tahap ini",
                message: "Kamu sedang menilai fragrance: wangi kopi saat masih kering (sebelum dicampur air)."
            )
            .padding(.horizontal)
            
            ZStack {
                PulseRing(color: .brown, scale: ringScale, opacity: ringOpacity)
                    .frame(width: 220, height: 220)
                
                Circle()
                    .fill(Color.brown.opacity(0.08))
                    .frame(width: 150, height: 150)
                
                Image(systemName: "nose.fill")
                    .font(.system(size: 44))
                    .foregroundStyle(.brown)
                
                VStack {
                    Spacer()
                    Text("Cium sekarang")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                        .padding(.bottom, 12)
                }
            }
            .onTapGesture {
                isSniffing.toggle()
                if isSniffing { startPulse() }
            }
            .onAppear {
                startPulse()
            }
            
            VStack(spacing: 14) {
                InputCard(
                    title: "Aksi 1",
                    prompt: "Geser slider untuk menilai seberapa kuat wangi kopi kering yang kamu cium."
                ) {
                    MetricScale(
                        value: $intensity,
                        range: 1...10,
                        step: 1,
                        lowText: "Halus",
                        highText: "Tajam"
                    )
                }
                
                InputCard(
                    title: "Aksi 2",
                    prompt: "Dari opsi di bawah, pilih kategori notes yang paling dominan kamu rasakan saat mencium kopi kering."
                ) {
                    CategoryPickerGrid(stage: .fragrance, selection: $category) {
                        showDiscovery = true
                    }
                }
            }
            .padding(.horizontal)
        }
        .sheet(isPresented: $showDiscovery) {
            NavigationStack {
                DiscoveryNotesView(stage: .fragrance) { showDiscovery = false }
            }
        }
    }
    
    private func startPulse() {
        ringScale = 0.2
        ringOpacity = 0.8
        guard isSniffing else { return }
        withAnimation(.easeOut(duration: 1.25).repeatForever(autoreverses: false)) {
            ringScale = 1.0
            ringOpacity = 0.0
        }
    }
}

private struct PulseRing: View {
    let color: Color
    let scale: CGFloat
    let opacity: Double
    
    var body: some View {
        Circle()
            .stroke(color.opacity(0.35), lineWidth: 10)
            .scaleEffect(scale)
            .opacity(opacity)
    }
}

// MARK: - Step 2: Aroma (Wet Coffee / Bloom)
private struct AromaStepView: View {
    let dryCategory: FlavorCategory?
    
    @Binding var contrast: AromaContrast
    @Binding var wetCategory: FlavorCategory?
    @Binding var wetIntensity: Double
    @State private var showDiscovery = false
    
    var body: some View {
        VStack(spacing: 18) {
            StepIntroCard(
                title: "Info tahap ini",
                message: "Kamu sedang menilai aroma: wangi kopi setelah dicampur air panas (wet/bloom)."
            )
            .padding(.horizontal)
            
//            ContrastTrackerCard(
//                dryCategory: dryCategory,
//                contrast: contrast,
//                wetCategory: contrast == .same ? dryCategory : wetCategory
//            )
//            .padding(.horizontal)
            
            VStack(spacing: 14) {
                InputCard(
                    title: "Aksi 1",
                    prompt: "Bandingkan wangi kopi kering dan wangi kopi setelah kena air. Pilih apakah karakternya sama atau berubah."
                ) {
                    Picker("Kontras", selection: $contrast) {
                        ForEach(AromaContrast.allCases) { c in
                            Text(c.rawValue).tag(c)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
                InputCard(
                    title: "Aksi 2",
                    prompt: "Geser slider untuk menilai seberapa kuat wangi kopi setelah dicampur air."
                ) {
                    MetricScale(
                        value: $wetIntensity,
                        range: 1...10,
                        step: 1,
                        lowText: "Halus",
                        highText: "Tajam"
                    )
                }
                
                if contrast != .same {
                    InputCard(
                        title: "Aksi 3",
                        prompt: "Dari opsi di bawah, pilih kategori notes yang paling dominan kamu rasakan saat kopi sudah wet/bloom."
                    ) {
                        CategoryPickerGrid(stage: .aroma, selection: $wetCategory) {
                            showDiscovery = true
                        }
                    }
                } else {
                    InputCard(
                        title: "Aksi 3",
                        prompt: "Karena kamu pilih “Sama”, kategori wet mengikuti kategori saat kering."
                    ) {
                        HStack {
                            Text("Kategori wet")
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                            Spacer()
                            if let dry = dryCategory {
                                Text(dry.rawValue)
                                    .font(.headline)
                                    .foregroundStyle(.brown)
                            } else {
                                Text("—")
                                    .font(.headline)
                                    .foregroundStyle(.tertiary)
                            }
                        }
                    }
                }
            }
            .padding(.horizontal)
        }
        .onChange(of: contrast) { old, new in
            if new == .same, let d = dryCategory {
                wetCategory = d
            } else if old == .same, new != .same {
                wetCategory = nil
            }
        }
        .sheet(isPresented: $showDiscovery) {
            NavigationStack {
                DiscoveryNotesView(stage: .aroma) { showDiscovery = false }
            }
        }
    }
}

private struct ContrastTrackerCard: View {
    let dryCategory: FlavorCategory
    let contrast: AromaContrast
    let wetCategory: FlavorCategory
    
    private var isMeaningfulChange: Bool {
        contrast == .changed || (wetCategory != dryCategory)
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text("Wangi saat kering → wangi saat kena air")
                    .font(.headline)
                Spacer()
                Text(isMeaningfulChange ? "Kontras kuat" : "Stabil")
                    .font(.caption.weight(.semibold))
                    .padding(.horizontal, 10)
                    .padding(.vertical, 6)
                    .background((isMeaningfulChange ? Color.orange : Color.green).opacity(0.12))
                    .foregroundStyle(isMeaningfulChange ? .orange : .green)
                    .clipShape(Capsule())
            }
            
            HStack(spacing: 10) {
                ContrastPill(title: "Kering", category: dryCategory)
                Image(systemName: "arrow.right")
                    .foregroundStyle(.secondary)
                ContrastPill(title: "Wet/Bloom", category: wetCategory)
            }
            
            Text("Contoh: saat kering terasa cokelat, lalu saat wet berubah jadi buah. Perubahan ini insight penting untuk profil kopimu.")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .padding()
        .background(Color(.secondarySystemBackground))
        .cornerRadius(16)
    }
}

private struct ContrastPill: View {
    let title: String
    let category: FlavorCategory
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title)
                .font(.caption2)
                .foregroundStyle(.secondary)
            Text(category.rawValue)
                .font(.subheadline.weight(.semibold))
                .foregroundStyle(.brown)
        }
        .padding(.vertical, 10)
        .padding(.horizontal, 12)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(.systemBackground))
        .cornerRadius(12)
    }
}

// MARK: - Step 3: Taste (Sip + Retronasal)
private struct TasteStepView: View {
    let roastLevel: String
    let processLevel: String
    @Binding var acidity: Double
    @Binding var sweetness: Double
    @Binding var bitterness: Double
    @Binding var bodyScore: Double
    @Binding var category: FlavorCategory?
    @State private var showDiscovery = false
    
    var body: some View {
        VStack(spacing: 20) {
            VStack(alignment: .leading, spacing: 12) {
                StepIntroCard(
                    title: "Info tahap ini",
                    message: "Kamu menilai rasa saat diminum. Seruput perlahan, lalu isi skala; ini intensitas, bukan benar/salah."
                )
                SlurpMentorCard()
                TasteBridgeCard(
                    roastLevel: roastLevel,
                    processLevel: processLevel
                )
            }
            .padding(.horizontal)

            VStack(alignment: .leading, spacing: 10) {
                Text("Intensitas pengecap")
                    .font(.title3.bold())
                Text("Geser 1 (rendah) – 10 (tinggi) untuk masing-masing atribut. Angka = seberapa menonjol, bukan gaya seduh.")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .fixedSize(horizontal: false, vertical: true)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal)

            VStack(spacing: 12) {
                TasteMetricCard(
                    title: "Acidity",
                    subtitle: "Segar/bright, bukan asam menusuk.",
                    detail: "Yang rapi: hidup, bersih; bayangkan sitrus ringan atau malat seperti apel.",
                    value: $acidity,
                    range: 1...10,
                    step: 1,
                    lowText: "Flat",
                    highText: "Bright"
                )
                
                TasteMetricCard(
                    title: "Sweetness",
                    subtitle: "Manis alami (bukan gula tabel).",
                    detail: "Membulatkan profil; semakin jelas, biasanya keseimbangan terasa enak ditelan.",
                    value: $sweetness,
                    range: 1...10,
                    step: 1,
                    lowText: "Kering",
                    highText: "Round"
                )
                
                TasteMetricCard(
                    title: "Bitterness",
                    subtitle: "Pahit saat diteguk.",
                    detail: "Pahit ringan bisa struktur; pahit menutup manis/klaritas wajar diberi skor sesuai sensasi.",
                    value: $bitterness,
                    range: 1...10,
                    step: 1,
                    lowText: "Lembut",
                    highText: "Tajam"
                )
                
                TasteMetricCard(
                    title: "Body",
                    subtitle: "Mouthfeel (ringan–tebal).",
                    detail: "Tekstur cairan, bukan wajib tebal; yang penting nyaman di mulut dan konsisten saat mendingin.",
                    value: $bodyScore,
                    range: 1...10,
                    step: 1,
                    lowText: "Ringan",
                    highText: "Tebal"
                )
            }
            .padding(.horizontal)

            InputCard(
                title: "Kesan akhir (L1)",
                prompt: "Pilih kelompok yang paling dominan setelah slurp, mengikuti 9 kategori peta latihan di atas."
            ) {
                CategoryPickerGrid(stage: .taste, selection: $category) {
                    showDiscovery = true
                }
            }
            .padding(.horizontal)
        }
        .sheet(isPresented: $showDiscovery) {
            NavigationStack {
                DiscoveryNotesView(stage: .taste) { showDiscovery = false }
            }
        }
    }
}

private struct TasteBridgeCard: View {
    let roastLevel: String
    let processLevel: String

    private var roastHint: String {
        switch roastLevel.lowercased() {
        case "light":
            return "Light roast biasanya punya acidity lebih cerah. Coba fokus ke sensasi fresh di sisi lidah."
        case "dark":
            return "Dark roast biasanya punya body dan pahit lebih dominan. Coba cek apakah aftertaste terasa tebal."
        case "medium":
            return "Medium roast biasanya lebih balance. Coba amati keseimbangan asam, manis, dan pahit."
        default:
            return "Profil roast ini bisa bergerak dinamis. Coba cari atribut yang paling menonjol dulu."
        }
    }

    private var processHint: String {
        switch processLevel.lowercased() {
        case "natural":
            return "Natural process biasanya membawa sweetness lebih menonjol dan karakter fruity."
        case "wash", "washed":
            return "Washed process biasanya terasa lebih bersih dan terang. Coba cek kejernihan rasa."
        case "honey":
            return "Honey process sering memberi manis yang round dan body yang nyaman."
        case "anaerobic":
            return "Anaerobic process sering menonjolkan karakter unik dan fermenty; nilai dengan tenang agar tetap objektif."
        case "wet hulled":
            return "Wet hulled sering memberi body tebal dan nuansa earthy. Coba perhatikan struktur rasanya."
        default:
            return "Process ini tetap bisa jadi patokan awal. Bandingkan dengan sensasi yang kamu rasakan langsung."
        }
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Label("Jembatan ke sensasi (roast + proses)", systemImage: "link")
                .font(.headline)
                .foregroundStyle(.brown)

            Text("Roast \(roastLevel) dan proses \(processLevel) cuma jembatan; cek kembali ke slurp, bukan teori.")
                .font(.subheadline.weight(.medium))

            VStack(alignment: .leading, spacing: 6) {
                Label(roastHint, systemImage: "flame.fill")
                Label(processHint, systemImage: "drop.fill")
            }
            .font(.caption)
            .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(14)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(.ultraThinMaterial)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color.brown.opacity(0.32), lineWidth: 1)
        )
    }
}

private struct SlurpMentorCard: View {
    var body: some View {
        HStack(alignment: .top, spacing: 14) {
            Image(systemName: "tornado")
                .font(.title2)
                .foregroundStyle(.orange)
                .frame(width: 36, height: 36)
                .background(Color.orange.opacity(0.12))
                .clipShape(Circle())
            
            VStack(alignment: .leading, spacing: 4) {
                Text("Slurp & aerasi")
                    .font(.subheadline.bold())
                Text("Seruput cukup keras: cairan menyebar di lidah, aroma mendorong retronasal. Satu cangkir, beberapa slurp kecil, bukan tersedak.")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            Spacer(minLength: 0)
        }
        .padding(14)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color(.systemBackground))
        )
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color.orange.opacity(0.35), lineWidth: 1)
        )
    }
}

// MARK: - Shared Components
private struct MetricSlider: View {
    let title: String
    @Binding var value: Double
    let range: ClosedRange<Double>
    let step: Double
    let lowText: String
    let highText: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(title)
                    .font(.subheadline.weight(.semibold))
            }
            
            Slider(
                value: $value,
                in: range,
                step: step,
                onEditingChanged: { isEditing in
                    if !isEditing {
                        UIImpactFeedbackGenerator(style: .soft).impactOccurred()
                    }
                }
            )
            .tint(.brown)
            
            HStack {
                Text(lowText).font(.caption2)
                Spacer()
                Text(highText).font(.caption2)
            }
            .foregroundStyle(.secondary)
        }
    }
}

private struct TasteMetricCard: View {
    let title: String
    let subtitle: String
    let detail: String
    @Binding var value: Double
    let range: ClosedRange<Double>
    let step: Double
    let lowText: String
    let highText: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(title)
                .font(.headline)
            Text(subtitle)
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .fixedSize(horizontal: false, vertical: true)
            Text(detail)
                .font(.caption)
                .foregroundStyle(.secondary)
                .fixedSize(horizontal: false, vertical: true)
            
            HStack {
                Text("Skala saat ini")
                    .font(.caption.weight(.semibold))
                    .foregroundStyle(.secondary)
                Spacer()
                Text("\(Int(value)) / 10")
                    .font(.caption.weight(.semibold).monospacedDigit())
                    .foregroundStyle(.brown)
            }
            .accessibilityElement(children: .combine)

            MetricScale(
                value: $value,
                range: range,
                step: step,
                lowText: lowText,
                highText: highText
            )
        }
        .padding()
        .background(Color(.systemBackground))
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color.brown.opacity(0.22), lineWidth: 1)
        )
        .cornerRadius(20)
    }
}

private struct MetricScale: View {
    @Binding var value: Double
    let range: ClosedRange<Double>
    let step: Double
    let lowText: String
    let highText: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            SmoothDiscreteSlider(
                value: $value,
                range: range,
                step: step
            )
            .frame(height: 44)
            
            HStack {
                Text(lowText).font(.caption2)
                Spacer()
                Text(highText).font(.caption2)
            }
            .foregroundStyle(.secondary)
        }
    }
}

private struct SmoothDiscreteSlider: View {
    @Binding var value: Double
    let range: ClosedRange<Double>
    let step: Double

    @State private var localValue: Double
    @State private var isDragging = false

    init(value: Binding<Double>, range: ClosedRange<Double>, step: Double) {
        _value = value
        self.range = range
        self.step = step
        _localValue = State(initialValue: value.wrappedValue)
    }

    private var display: Double { isDragging ? localValue : value }

    var body: some View {
        GeometryReader { geo in
            let width = geo.size.width
            let height = geo.size.height
            let thumbSize: CGFloat = 28
            let trackHeight: CGFloat = 8
            let trackXStart = thumbSize / 2
            let trackXEnd = width - thumbSize / 2
            let trackWidth = max(1, trackXEnd - trackXStart)

            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: trackHeight / 2)
                    .fill(Color(.systemGray5))
                    .frame(height: trackHeight)
                    .position(x: width / 2, y: height / 2)

                RoundedRectangle(cornerRadius: trackHeight / 2)
                    .fill(Color.brown)
                    .frame(width: filledWidth(trackWidth: trackWidth), height: trackHeight)
                    .position(x: trackXStart + filledWidth(trackWidth: trackWidth) / 2, y: height / 2)

                Circle()
                    .fill(Color(.systemBackground))
                    .overlay(
                        Circle().stroke(Color.brown.opacity(0.35), lineWidth: 2)
                    )
                    .shadow(color: .black.opacity(0.08), radius: 6, x: 0, y: 2)
                    .frame(width: thumbSize, height: thumbSize)
                    .position(x: thumbX(trackWidth: trackWidth, trackXStart: trackXStart), y: height / 2)
            }
            .contentShape(Rectangle())
            .highPriorityGesture(
                DragGesture(minimumDistance: 0)
                    .onChanged { gesture in
                        isDragging = true
                        let x = clamp(gesture.location.x, min: trackXStart, max: trackXEnd)
                        let ratio = (x - trackXStart) / trackWidth
                        let raw = range.lowerBound + ratio * (range.upperBound - range.lowerBound)
                        localValue = snapped(raw)
                    }
                    .onEnded { _ in
                        value = localValue
                        isDragging = false
                        UIImpactFeedbackGenerator(style: .soft).impactOccurred()
                    }
            )
        }
        .onChange(of: value) { _, newValue in
            if !isDragging { localValue = newValue }
        }
    }

    private func snapped(_ raw: Double) -> Double {
        guard step > 0 else { return clamp(raw, min: range.lowerBound, max: range.upperBound) }
        let normalized = (raw - range.lowerBound) / step
        let rounded = normalized.rounded()
        let snapped = range.lowerBound + rounded * step
        return clamp(snapped, min: range.lowerBound, max: range.upperBound)
    }

    private func filledWidth(trackWidth: CGFloat) -> CGFloat {
        let ratio = (display - range.lowerBound) / (range.upperBound - range.lowerBound)
        return clamp(CGFloat(ratio) * trackWidth, min: 0, max: trackWidth)
    }

    private func thumbX(trackWidth: CGFloat, trackXStart: CGFloat) -> CGFloat {
        trackXStart + filledWidth(trackWidth: trackWidth)
    }

    private func clamp<T: Comparable>(_ x: T, min: T, max: T) -> T {
        Swift.min(Swift.max(x, min), max)
    }
}

private struct StepIntroCard: View {
    let title: String
    let message: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Label(title, systemImage: "info.circle.fill")
                .font(.headline)
                .foregroundStyle(.brown)
            Text(message)
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .fixedSize(horizontal: false, vertical: true)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(14)
        .background(Color.brown.opacity(0.08))
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color.brown.opacity(0.2), lineWidth: 1)
        )
        .cornerRadius(16)
    }
}

private struct InputCard<Content: View>: View {
    let title: String
    let prompt: String
    @ViewBuilder let content: Content
    
    init(title: String, prompt: String, @ViewBuilder content: () -> Content) {
        self.title = title
        self.prompt = prompt
        self.content = content()
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Label(title, systemImage: "hand.tap.fill")
                .font(.headline)
                .foregroundStyle(.brown)
            Text(prompt)
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .fixedSize(horizontal: false, vertical: true)
            content
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(14)
        .background(Color(.systemBackground))
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color.brown.opacity(0.28), lineWidth: 1)
        )
        .shadow(color: .black.opacity(0.03), radius: 6, x: 0, y: 2)
        .cornerRadius(20)
    }
}

private struct CategoryPickerGrid: View {
    let stage: DiscoveryStage
    @Binding var selection: FlavorCategory?
    var onUnsureTap: (() -> Void)? = nil
    
    var body: some View {
        VStack(spacing: 10) {
            ScrollView {
                LazyVStack(spacing: 10) {
                    ForEach(FlavorCategory.allCases) { category in
                        categoryRow(category)
                    }
                }
            }
            .frame(maxHeight: 520)
            unsureButton
        }
    }
    
    private func categoryRow(_ category: FlavorCategory) -> some View {
        let descriptor = CategoryPickerDescriptors.descriptor(for: category, stage: stage)
        let isSelected = selection.map { $0 == category } ?? false

        return Button {
            selection = category
        } label: {
            VStack(alignment: .leading, spacing: 10) {
                HStack(spacing: 10) {
                    ZStack {
                        Circle()
                            .fill(Color.brown.opacity(isSelected ? 0.18 : 0.10))
                            .frame(width: 36, height: 36)
                        Image(systemName: category.pickerGridIconName)
                            .font(.subheadline.weight(.semibold))
                            .foregroundStyle(.brown)
                    }
                    
                    VStack(alignment: .leading, spacing: 2) {
                        Text(category.rawValue)
                            .font(.headline)
                        Text(descriptor.summary)
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                    
                    Spacer()
                    
                    Image(systemName: isSelected ? "checkmark.circle.fill" : "circle")
                        .foregroundStyle(isSelected ? .brown : .secondary)
                }
                
                if !descriptor.examples.isEmpty {
                    FlowChips(chips: descriptor.examples)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 18)
                    .fill(isSelected ? Color.brown.opacity(0.10) : Color(.systemBackground))
            )
            .overlay(
                RoundedRectangle(cornerRadius: 18)
                    .stroke(isSelected ? Color.brown.opacity(0.45) : Color(.systemGray4), lineWidth: 1)
            )
        }
        .buttonStyle(.plain)
    }

    private var unsureButton: some View {
        Button {
            onUnsureTap?()
        } label: {
            HStack(spacing: 10) {
                Image(systemName: "questionmark.circle")
                    .foregroundStyle(.secondary)
                VStack(alignment: .leading, spacing: 2) {
                    Text("Butuh panduan?")
                        .font(.subheadline.weight(.semibold))
                        .foregroundStyle(.secondary)
                    Text("Buka catatan pengecapan: kelompok aroma/rasa dipetakan seperti di latihan.")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                        .fixedSize(horizontal: false, vertical: true)
                }
                Spacer()
            }
            .padding(.vertical, 10)
            .padding(.horizontal, 12)
            .background(Color(.systemGray6))
            .cornerRadius(14)
            .overlay(
                RoundedRectangle(cornerRadius: 14)
                    .stroke(Color(.systemGray4), style: StrokeStyle(lineWidth: 1, dash: [4, 4]))
            )
        }
        .buttonStyle(.plain)
    }
}

private struct FlowChips: View {
    let chips: [String]
    
    var body: some View {
        let shown = Array(chips.prefix(4))
        return HStack(spacing: 8) {
            ForEach(shown, id: \.self) { chip in
                Text(chip)
                    .font(.caption2.weight(.semibold))
                    .foregroundStyle(.brown)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 6)
                    .background(Color.brown.opacity(0.10))
                    .clipShape(Capsule())
            }
            Spacer(minLength: 0)
        }
    }
}
