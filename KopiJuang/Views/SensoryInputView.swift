//
//  SensoryInputView.swift
//  KopiJuang
//
//  Created by Dimas Rendy Febianto on 19/04/26.
//

import SwiftUI

struct SensoryInputView: View {
    @Environment(\.dismiss) var dismiss
    let beanName: String
    let beanOrigin: String
    let roastLevel: String
    let processLevel: String
    
    enum Step: Int, CaseIterable {
        case fragrance = 0
        case aroma = 1
        case taste = 2
        
        var title: String {
            switch self {
            case .fragrance: return "Fragrance"
            case .aroma: return "Aroma"
            case .taste: return "Taste"
            }
        }
        
        var subtitle: String {
            switch self {
            case .fragrance: return "Nikmati wangi murni dari bubuk kopi sebelum tersentuh air. Ini adalah langkah awal dari perjalanan rasa dan aroma kopimu."
            case .aroma: return "Saksikan momen blooming. Saat air bertemu kopi, aroma karakter utama mulai terbuka"
            case .taste: return "Seruput kopi Anda dengan sedikit udara. Teknik menyeruput membantu menyebarkan kopi ke seluruh palet mulut dan mengalirkan aroma ke rongga hidung bagian dalam (retronasal), sehingga rasa kopi terasa lebih utuh."
            }
        }
    }
    
    @State private var step: Step = .fragrance
    
    // State 1
    @State private var fragranceIntensity: Double = 6
    @State private var fragranceCategory: FlavorCategory = .nutty
    
    // State 2
    @State private var aromaContrast: AromaContrast = .unsure
    @State private var aromaIntensity: Double = 6
    @State private var aromaCategory: FlavorCategory = .nutty
    
    // State 3
    @State private var acidity: Double = 6
    @State private var sweetness: Double = 6
    @State private var mouthfeel: Double = 6
    @State private var aftertaste: Double = 6
    @State private var aftertasteDuration: Double = 6
    
    @State private var scrollToTopNonce: Int = 0
    
    var body: some View {
        NavigationStack {
            ScrollViewReader { proxy in
                ScrollView {
                    VStack(spacing: 32) {
                        Color.clear
                            .frame(height: 1)
                            .id("top")
                        
                        header
                        
                        switch step {
                        case .fragrance:
                            FragranceStepView(
                                intensity: $fragranceIntensity,
                                category: $fragranceCategory
                            )
                            .onAppear {
                                if aromaCategory == .nutty { aromaCategory = fragranceCategory }
                            }
                        case .aroma:
                            AromaStepView(
                                dryCategory: fragranceCategory,
                                dryIntensity: fragranceIntensity,
                                contrast: $aromaContrast,
                                wetCategory: $aromaCategory,
                                wetIntensity: $aromaIntensity
                            )
                            .onAppear {
                                if aromaContrast == .same { aromaCategory = fragranceCategory }
                            }
                        case .taste:
                            TasteStepView(
                                acidity: $acidity,
                                sweetness: $sweetness,
                                mouthfeel: $mouthfeel,
                                aftertaste: $aftertaste,
                                aftertasteDuration: $aftertasteDuration
                            )
                        }
                        
                        footer
                    }
                }
                .onChange(of: scrollToTopNonce) { _ in
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
                        goBackOrDismiss()
                    } label: {
                        Image(systemName: "chevron.left")
                            .font(.headline)
                    }
                    .tint(.brown)
                }
            }
        }
    }
    
    private var header: some View {
        VStack(spacing: 10) {
            Text(step.title)
                .font(.title2.bold())
            Text(step.subtitle)
                .font(.subheadline)
                .foregroundStyle(.secondary)
            
            StepIndicator(current: step)
                .padding(.top, 4)
            
            SessionMetaRow(beanName: beanName, beanOrigin: beanOrigin)
                .padding(.top, 4)
        }
        .multilineTextAlignment(.center)
        .padding(.top)
        .padding(.horizontal)
    }
    
    private var footer: some View {
        VStack(spacing: 12) {
            if step == .taste {
                NavigationLink(
                    destination: ResultView(
                        evaluation: SensoryEvaluation(
                            beanName: beanName,
                            beanOrigin: beanOrigin,
                            roastLevel: roastLevel,
                            processLevel: processLevel,
                            fragranceIntensity: fragranceIntensity,
                            fragranceCategory: fragranceCategory,
                            aromaContrast: aromaContrast,
                            aromaIntensity: aromaIntensity,
                            aromaCategory: aromaContrast == .same ? fragranceCategory : aromaCategory,
                            acidity: acidity,
                            sweetness: sweetness,
                            mouthfeel: mouthfeel,
                            aftertaste: aftertaste,
                            aftertasteDuration: aftertasteDuration
                        )
                    )
                ) {
                    Text("Lanjut")
                        .font(.headline)
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.brown)
                        .cornerRadius(12)
                }
                .padding(.horizontal)
            } else {
                Button {
                    goNext()
                } label: {
                    Text("Lanjut")
                        .font(.headline)
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.brown)
                        .cornerRadius(12)
                }
                .padding(.horizontal)
            }
        }
    }
    
    private func goNext() {
        switch step {
        case .fragrance:
            step = .aroma
            scrollToTopNonce += 1
        case .aroma:
            step = .taste
            scrollToTopNonce += 1
        case .taste:
            break
        }
    }
    
    private func goBackOrDismiss() {
        switch step {
        case .fragrance:
            dismiss()
        case .aroma:
            step = .fragrance
            scrollToTopNonce += 1
        case .taste:
            step = .aroma
            scrollToTopNonce += 1
        }
    }
    
}

#Preview {
    SensoryInputView(beanName: "Ethiopia", beanOrigin: "Ethiopia", roastLevel: "Medium", processLevel: "Natural")
}

private struct SessionMetaRow: View {
    let beanName: String
    let beanOrigin: String
    
    var body: some View {
        HStack(spacing: 8) {
            Label(beanName, systemImage: "cup.and.saucer.fill")
            Text("•")
                .foregroundStyle(.secondary)
            Label(beanOrigin, systemImage: "circle.grid.2x1.fill")
        }
        .font(.caption)
        .foregroundStyle(.secondary)
        .lineLimit(1)
    }
}

private struct StepIndicator: View {
    let current: SensoryInputView.Step
    
    var body: some View {
        HStack(spacing: 8) {
            ForEach(SensoryInputView.Step.allCases, id: \.rawValue) { s in
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
    @Binding var category: FlavorCategory
    
    @State private var isSniffing = true
    @State private var ringScale: CGFloat = 0.2
    @State private var ringOpacity: Double = 0.8
    
    var body: some View {
        VStack(spacing: 18) {
            StepIntroCard(
                title: "Tugas kamu",
                message: "Ini wangi kopi saat masih kering (belum kena air). Dekatkan hidung ke bubuk kopi, nilai sekuat apa wanginya, lalu pilih karakter aroma yang paling kamu rasakan."
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
                InputCard(title: "Seberapa kuat wanginya?") {
                    MetricScale(
                        value: $intensity,
                        range: 1...10,
                        step: 1,
                        maxLabel: "/ 10",
                        lowText: "Halus",
                        highText: "Tajam"
                    )
                }
                
                InputCard(title: "Kategori") {
                    CategoryPickerGrid(stage: .fragrance, selection: $category)
                }
            }
            .padding(.horizontal)
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
    let dryCategory: FlavorCategory
    let dryIntensity: Double
    
    @Binding var contrast: AromaContrast
    @Binding var wetCategory: FlavorCategory
    @Binding var wetIntensity: Double
    
    var body: some View {
        VStack(spacing: 18) {
            StepIntroCard(
                title: "Tugas kamu",
                message: "Saat kopi tersentuh air, aroma akan berevolusi. Bandingkan dengan dry fragrance tadi: apakah karakternya tetap sama, atau muncul profil wangi yang baru dan lebih kompleks?"
            )
            .padding(.horizontal)
            
            ContrastTrackerCard(
                dryCategory: dryCategory,
                dryIntensity: dryIntensity,
                contrast: contrast,
                wetCategory: contrast == .same ? dryCategory : wetCategory,
                wetIntensity: wetIntensity
            )
            .padding(.horizontal)
            
            VStack(spacing: 14) {
                InputCard(title: "Apakah aromanya berubah?") {
                    Picker("Kontras", selection: $contrast) {
                        ForEach(AromaContrast.allCases) { c in
                            Text(c.rawValue).tag(c)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
                InputCard(title: "Seberapa kuat aromanya (wet)?") {
                    MetricScale(
                        value: $wetIntensity,
                        range: 1...10,
                        step: 1,
                        maxLabel: "/ 10",
                        lowText: "Halus",
                        highText: "Tajam"
                    )
                }
                
                if contrast != .same {
                    InputCard(title: "Kategori aroma (wet)") {
                        CategoryPickerGrid(stage: .aroma, selection: $wetCategory)
                    }
                } else {
                    InputCard(title: "Kategori aroma (wet)") {
                        HStack {
                            Text("Ikut dry fragrance")
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                            Spacer()
                            Text(dryCategory.rawValue)
                                .font(.headline)
                                .foregroundStyle(.brown)
                        }
                    }
                }
            }
            .padding(.horizontal)
        }
        .onChange(of: contrast) { newValue in
            if newValue == .same { wetCategory = dryCategory }
        }
    }
}

private struct ContrastTrackerCard: View {
    let dryCategory: FlavorCategory
    let dryIntensity: Double
    let contrast: AromaContrast
    let wetCategory: FlavorCategory
    let wetIntensity: Double
    
    private var isMeaningfulChange: Bool {
        contrast == .changed || (wetCategory != dryCategory)
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text("Dry → Wet")
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
                ContrastPill(title: "Dry", category: dryCategory, intensity: dryIntensity)
                Image(systemName: "arrow.right")
                    .foregroundStyle(.secondary)
                ContrastPill(title: "Wet", category: wetCategory, intensity: wetIntensity)
            }
            
            Text("Insight: kopi bisa “cokelat” saat kering, lalu “buah” saat basah. Catat kontras = insight mahal.")
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
    let intensity: Double
    
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
    @Binding var acidity: Double
    @Binding var sweetness: Double
    @Binding var mouthfeel: Double
    @Binding var aftertaste: Double
    @Binding var aftertasteDuration: Double
    
    var body: some View {
        VStack(spacing: 18) {
            StepIntroCard(
                title: "Tugas kamu",
                message: "Ini rasa saat diminum. Ambil 1–2 seruput (slurp kalau bisa), lalu hembuskan lewat hidung untuk retronasal. Isi skor cepat—gak ada jawaban benar/salah."
            )
            .padding(.horizontal)
            
            SlurpMentorCard()
                .padding(.horizontal)
            
            VStack(spacing: 14) {
                TasteMetricCard(
                    title: "Acidity (Brightness)",
                    subtitle: "Rasa segar/cerah. Cari yang bersih & seimbang.",
                    detail: "Bukan “asam” yang bikin perih. Ini sensasi seperti sitrus/apel yang bikin kopi terasa hidup. Dalam cupping (SCA/WCR), acidity bagus terasa jelas tapi rapi.",
                    value: $acidity,
                    range: 1...10,
                    step: 1,
                    maxLabel: "/ 10",
                    lowText: "Flat",
                    highText: "Bright"
                )
                
                TasteMetricCard(
                    title: "Sweetness",
                    subtitle: "Manis alami yang bikin rasa “round”.",
                    detail: "Bukan gula. Sweetness di cupping sering terasa sebagai roundness yang merapikan acidity. Fokus: manis jelas, tidak getir/harsh.",
                    value: $sweetness,
                    range: 1...10,
                    step: 1,
                    maxLabel: "/ 10",
                    lowText: "Kering",
                    highText: "Round"
                )
                
                TasteMetricCard(
                    title: "Body (Mouthfeel)",
                    subtitle: "Tekstur di mulut (tea-like → syrupy).",
                    detail: "Body itu mouthfeel, bukan rasa. Skor tinggi tidak selalu lebih enak; yang dicari nyaman dan sesuai profil.",
                    value: $mouthfeel,
                    range: 1...10,
                    step: 1,
                    maxLabel: "/ 10",
                    lowText: "Tea-like",
                    highText: "Syrupy"
                )
                
                TasteMetricCard(
                    title: "Aftertaste Quality",
                    subtitle: "Kualitas finish: bersih, manis, konsisten.",
                    detail: "Bukan sekadar “lama”. Setelah ditelan, rasa sisa yang bagus terasa bersih dan menyenangkan—bukan ashy/harsh/pahit menggantung.",
                    value: $aftertaste,
                    range: 1...10,
                    step: 1,
                    maxLabel: "/ 10",
                    lowText: "Kotor",
                    highText: "Bersih"
                )
                
                TasteMetricCard(
                    title: "Aftertaste Duration",
                    subtitle: "Seberapa lama finish tertinggal.",
                    detail: "Finish yang lama biasanya terasa persisten dan menyenangkan. Kalau lama tapi pahit/ashy, itu bukan poin plus.",
                    value: $aftertasteDuration,
                    range: 1...10,
                    step: 1,
                    maxLabel: "/ 10",
                    lowText: "Cepat hilang",
                    highText: "Persisten"
                )
            }
            .padding(.horizontal)
        }
    }
}

private struct SlurpMentorCard: View {
    var body: some View {
        HStack(spacing: 14) {
            Image(systemName: "lightbulb.fill")
                .font(.title)
                .foregroundStyle(.yellow)
                .frame(width: 38)
            
            VStack(alignment: .leading, spacing: 4) {
                Text("Barista Tips: Slurping")
                    .font(.subheadline.bold())
                Text("Seruput keras (aerasi). Kopi menyebar ke lidah + aroma naik ke hidung (retronasal).")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            Spacer()
        }
        .padding()
        .background(Color(.secondarySystemBackground))
        .cornerRadius(16)
    }
}

// MARK: - Shared Components
private struct MetricSlider: View {
    let title: String
    @Binding var value: Double
    let range: ClosedRange<Double>
    let step: Double
    let maxLabel: String
    let lowText: String
    let highText: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(title)
                    .font(.subheadline.weight(.semibold))
            }
            
            Slider(value: $value, in: range, step: step)
            .tint(.brown)
            .softHapticOnChange(Int(value))
            
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
    let maxLabel: String
    let lowText: String
    let highText: String
    
    @State private var showDetail = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack(alignment: .firstTextBaseline) {
                VStack(alignment: .leading, spacing: 4) {
                    Text(title)
                        .font(.headline)
                    Text(subtitle)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                        .fixedSize(horizontal: false, vertical: true)
                }
                Spacer()
                Button {
                    withAnimation(.easeInOut(duration: 0.2)) { showDetail.toggle() }
                } label: {
                    Image(systemName: "info.circle")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
                .buttonStyle(.plain)
                .accessibilityLabel("Info")
            }
            
            if showDetail {
                Text(detail)
                    .font(.caption)
                    .foregroundStyle(.secondary)
                    .padding(.top, 2)
                    .transition(.opacity.combined(with: .move(edge: .top)))
            }
            
            MetricScale(
                value: $value,
                range: range,
                step: step,
                maxLabel: maxLabel,
                lowText: lowText,
                highText: highText
            )
        }
        .padding()
        .background(Color(.secondarySystemBackground))
        .cornerRadius(20)
    }
}

private struct MetricScale: View {
    @Binding var value: Double
    let range: ClosedRange<Double>
    let step: Double
    let maxLabel: String
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
            .softHapticOnChange(Int(value))
            
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
    
    private var stepsCount: Int {
        Int(((range.upperBound - range.lowerBound) / step).rounded(.down))
    }
    
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
                        let x = clamp(gesture.location.x, min: trackXStart, max: trackXEnd)
                        let ratio = (x - trackXStart) / trackWidth
                        let raw = range.lowerBound + ratio * (range.upperBound - range.lowerBound)
                        value = snapped(raw)
                    }
            )
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
        let ratio = (value - range.lowerBound) / (range.upperBound - range.lowerBound)
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
        VStack(alignment: .leading, spacing: 6) {
            Text(title)
                .font(.headline)
            Text(message)
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .fixedSize(horizontal: false, vertical: true)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(Color(.secondarySystemBackground))
        .cornerRadius(16)
    }
}

private struct InputCard<Content: View>: View {
    let title: String
    @ViewBuilder let content: Content
    
    init(title: String, @ViewBuilder content: () -> Content) {
        self.title = title
        self.content = content()
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(title)
                .font(.headline)
            content
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(Color(.secondarySystemBackground))
        .cornerRadius(20)
    }
}

private extension View {
    @ViewBuilder
    func softHapticOnChange(_ trigger: Int) -> some View {
        if #available(iOS 17.0, *) {
            sensoryFeedback(.selection, trigger: trigger)
        } else {
            self
        }
    }
}

private struct CategoryPickerGrid: View {
    enum SensoryStage {
        case fragrance
        case aroma
        case taste
    }
    
    let stage: SensoryStage
    @Binding var selection: FlavorCategory
    
    var body: some View {
        VStack(spacing: 10) {
            ForEach(FlavorCategory.allCases) { category in
                categoryRow(category)
            }
        }
    }
    
    private func categoryRow(_ category: FlavorCategory) -> some View {
        let descriptor = descriptorForStage(category)
        let isSelected = selection == category
        
        return Button {
            selection = category
        } label: {
            VStack(alignment: .leading, spacing: 10) {
                HStack(spacing: 10) {
                    ZStack {
                        Circle()
                            .fill(Color.brown.opacity(isSelected ? 0.18 : 0.10))
                            .frame(width: 36, height: 36)
                        Image(systemName: iconForCategory(category))
                            .font(.subheadline.weight(.semibold))
                            .foregroundStyle(.brown)
                    }
                    
                    VStack(alignment: .leading, spacing: 2) {
                        Text(category.rawValue)
                            .font(.headline)
                        Text(descriptor.summary)
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                            .lineLimit(2)
                    }
                    
                    Spacer()
                    
                    if isSelected {
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundStyle(.brown)
                    }
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
    
    private struct Descriptor {
        let summary: String
        let examples: [String]
    }
    
    private func descriptorForStage(_ category: FlavorCategory) -> Descriptor {
        switch stage {
        case .fragrance:
            return dryDescriptor(category)
        case .aroma:
            return wetDescriptor(category)
        case .taste:
            return sipDescriptor(category)
        }
    }
    
    private func dryDescriptor(_ category: FlavorCategory) -> Descriptor {
        switch category {
        case .floral:
            return Descriptor(
                summary: "Wangi bunga/teh yang manis-ringan (di hidung, dry).",
                examples: ["Jasmine", "Rose", "Chamomile", "Black tea"]
            )
        case .fruity:
            return Descriptor(
                summary: "Wangi buah matang yang manis (di hidung, dry).",
                examples: ["Citrus", "Berry", "Apple", "Grape"]
            )
        case .nutty:
            return Descriptor(
                summary: "Wangi kacang/cokelat “brown” (di hidung, dry).",
                examples: ["Hazelnut", "Almond", "Cocoa"]
            )
        case .sweet:
            return Descriptor(
                summary: "Wangi manis: madu/vanila/karamel (di hidung, dry).",
                examples: ["Honey", "Vanilla", "Caramel"]
            )
        }
    }
    
    private func wetDescriptor(_ category: FlavorCategory) -> Descriptor {
        switch category {
        case .floral:
            return Descriptor(
                summary: "Floral sering makin kebaca saat bloom (wet).",
                examples: ["Jasmine", "Rose", "Chamomile", "Black tea"]
            )
        case .fruity:
            return Descriptor(
                summary: "Buah segar makin “keluar” saat wet (citrus/berry).",
                examples: ["Citrus", "Berry", "Tropical"]
            )
        case .nutty:
            return Descriptor(
                summary: "Nutty/cocoa muncul hangat saat wet.",
                examples: ["Hazelnut", "Cocoa", "Brown sugar"]
            )
        case .sweet:
            return Descriptor(
                summary: "Sweet aromatics: karamel, gula merah, vanila (wet).",
                examples: ["Brown sugar", "Caramel", "Vanillin"]
            )
        }
    }
    
    private func sipDescriptor(_ category: FlavorCategory) -> Descriptor {
        switch category {
        case .floral:
            return Descriptor(
                summary: "Saat sip, floral kebaca via retronasal (bukan “di lidah”).",
                examples: ["Jasmine", "Black tea"]
            )
        case .fruity:
            return Descriptor(
                summary: "Saat sip, fruity biasanya bareng acidity yang rapi.",
                examples: ["Citrus", "Berry"]
            )
        case .nutty:
            return Descriptor(
                summary: "Saat sip, nutty/cocoa sering jadi mid-palate yang hangat.",
                examples: ["Cocoa", "Almond"]
            )
        case .sweet:
            return Descriptor(
                summary: "Saat sip, sweet terasa sebagai roundness (bukan gula).",
                examples: ["Honey", "Vanilla"]
            )
        }
    }
    
    private func iconForCategory(_ cat: FlavorCategory) -> String {
        switch cat {
        case .fruity: return "leaf.fill"
        case .floral: return "sparkles"
        case .nutty: return "circle.grid.3x3.fill"
        case .sweet: return "cube.fill"
        }
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
