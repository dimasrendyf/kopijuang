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
                .foregroundStyle(Color.primary.opacity(0.72))

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
            
            Text("•").foregroundStyle(Color.primary.opacity(0.55))
            
            Label(beanOrigin, systemImage: "map.fill")
            
            Text("•").foregroundStyle(Color.primary.opacity(0.55))
            
            Label(roastLevel, systemImage: "flame.fill")
            
            Text("•").foregroundStyle(Color.primary.opacity(0.55))
            
            Label(processLevel, systemImage: "drop.fill")
        }
        .font(.caption)
        .foregroundStyle(Color.primary.opacity(0.72))
        .lineLimit(1)
        .minimumScaleFactor(0.8)
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
                title: "Tahap ini: Fragrance",
                message: "Kamu mencium wangi kopi sebelum diseduh. Ini kesempatan pertamamu — begitu air masuk, aromanya akan berubah."
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
                        .foregroundStyle(Color.primary.opacity(0.72))
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
                    title: "Seberapa jelas aromanya?",
                    prompt: "Cium 3 kali pendek. Geser rendah kalau aromanya samar, geser tinggi kalau aromanya langsung kebaca tanpa usaha."
                ) {
                    MetricScale(
                        value: $intensity,
                        range: 0...10,
                        step: 1,
                        lowText: "Belum terasa",
                        highText: "Tajam"
                    )
                }
                
                InputCard(
                    title: "Aromanya mengarah ke mana?",
                    prompt: "Pilih kategori aroma yang paling dekat: buah, bunga, manis, kacang, rempah, panggang, hijau, asam-fermentasi, atau aroma asing. Pilih kesan pertama yang paling kuat."
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
                title: "Tahap ini: Aroma",
                message: "Tuang sedikit air panas, lalu cium lagi. Aromanya beda dari tadi? Normal — air mengubah karakter kopi. Catat bedanya."
            )
            .padding(.horizontal)
            
            VStack(spacing: 14) {
                InputCard(
                    title: "Sama atau berubah?",
                    prompt: "Bandingkan wangi tadi (kering) dengan sekarang (setelah kena air). Terasa sama atau beda karakternya?"
                ) {
                    Picker("Kontras", selection: $contrast) {
                        ForEach(AromaContrast.allCases) { c in
                            Text(c.rawValue).tag(c)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
                InputCard(
                    title: "Seberapa jelas aroma setelah kena air?",
                    prompt: "Air panas bisa membuka aroma baru. Geser rendah kalau tetap halus, geser tinggi kalau aromanya makin naik dan mudah dikenali."
                ) {
                    MetricScale(
                        value: $wetIntensity,
                        range: 0...10,
                        step: 1,
                        lowText: "Belum terasa",
                        highText: "Tajam"
                    )
                }
                
                if contrast != .same {
                    InputCard(
                    title: "Aroma basahnya mengarah ke mana?",
                    prompt: "Bandingkan dengan aroma kering. Kalau berubah, pilih kategori aroma baru yang paling terasa setelah bloom."
                    ) {
                        CategoryPickerGrid(stage: .aroma, selection: $wetCategory) {
                            showDiscovery = true
                        }
                    }
                } else {
                    InputCard(
                        title: "Kategori tetap sama",
                        prompt: "Kamu memilih sama antara aroma kering dan basah — jadi kategori aroma basah mengikuti yang tadi kamu pilih saat kering."
                    ) {
                        HStack {
                            Text("Kategori wet")
                                .font(.subheadline)
                                .foregroundStyle(Color.primary.opacity(0.72))
                            Spacer()
                            if let dry = dryCategory {
                                Text(dry.rawValue)
                                    .font(.headline)
                                    .foregroundStyle(.brown)
                            } else {
                                Text("—")
                                    .font(.headline)
                                    .foregroundStyle(Color.primary.opacity(0.55))
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
                Text("Perubahan wangi")
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
                    .foregroundStyle(Color.primary.opacity(0.55))
                ContrastPill(title: "Wet/Bloom", category: wetCategory)
            }
            
            Text("Misalnya: saat kering tercium cokelat, setelah air masuk berubah jadi buah. Perubahan seperti ini normal dan informatif.")
                .font(.caption)
                .foregroundStyle(Color.primary.opacity(0.72))
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
                .foregroundStyle(Color.primary.opacity(0.65))
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
                    title: "Tahap ini: Taste",
                    message: "Seruput kopinya pelan-pelan. Isi skala sesuai apa yang kamu rasakan — tidak ada benar atau salah."
                )
                SlurpMentorCard()
                    .padding(.vertical, 10)
            }
            .padding(.horizontal)

            VStack(alignment: .leading, spacing: 10) {
                Text("Nilai rasa dasar di mulut")
                    .font(.title3.bold())
                Text("Nilai satu per satu. Asam = segar/bright, manis = bulat/nyaman, pahit = getir, body = tebal-tipisnya cairan di mulut.")
                    .font(.subheadline)
                    .foregroundStyle(Color.primary.opacity(0.72))
                    .fixedSize(horizontal: false, vertical: true)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal)

            VStack(spacing: 12) {
                TasteMetricCard(
                    title: "Acidity",
                    subtitle: "Rasa segar, seperti jeruk atau apel.",
                    detail: "Bukan asam yang menusuk — lebih ke sensasi bright yang bikin pengen nyeruput lagi.",
                    value: $acidity,
                    range: 0...10,
                    step: 1,
                    lowText: "Belum terasa",
                    highText: "Bright"
                )
                
                TasteMetricCard(
                    title: "Sweetness",
                    subtitle: "Manis alami, bukan kayak gula.",
                    detail: "Manis yang bikin rasa terasa bulat dan nyaman. Semakin terasa, biasanya semakin enak ditelan.",
                    value: $sweetness,
                    range: 0...10,
                    step: 1,
                    lowText: "Belum terasa",
                    highText: "Round"
                )
                
                TasteMetricCard(
                    title: "Bitterness",
                    subtitle: "Pahit saat kopi diteguk.",
                    detail: "Pahit ringan itu wajar dan bisa bikin rasa lebih berstruktur. Nilai sesuai yang kamu rasakan.",
                    value: $bitterness,
                    range: 0...10,
                    step: 1,
                    lowText: "Belum terasa",
                    highText: "Tajam"
                )
                
                TasteMetricCard(
                    title: "Body",
                    subtitle: "Ringan atau tebal di mulut?",
                    detail: "Ini soal tekstur cairan saat diminum — kayak bedanya air biasa sama susu. Tidak harus tebal untuk enak.",
                    value: $bodyScore,
                    range: 0...10,
                    step: 1,
                    lowText: "Belum terasa",
                    highText: "Tebal"
                )
            }
            .padding(.horizontal)

            InputCard(
                title: "Rasa utamanya masuk kategori mana?",
                prompt: "Setelah slurp dan hembus lewat hidung, pilih kategori rasa yang paling dominan. Jangan cari jawaban sempurna; pilih yang paling mirip."
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
            return "Light roast biasanya lebih segar dan cerah. Coba perhatikan sensasi asam ringan di sisi lidah."
        case "dark":
            return "Dark roast biasanya lebih pahit dan bertekstur tebal. Coba rasakan aftertaste-nya — apakah terasa panjang?"
        case "medium":
            return "Medium roast cenderung seimbang. Coba amati mana yang lebih menonjol: asam, manis, atau pahit."
        default:
            return "Coba cari satu atribut yang paling kamu rasakan dulu, baru bandingkan dengan yang lain."
        }
    }

    private var processHint: String {
        switch processLevel.lowercased() {
        case "natural":
            return "Natural process biasanya terasa lebih manis dan fruity — seperti ada rasa buah yang muncul."
        case "wash", "washed":
            return "Washed process biasanya terasa lebih bersih dan terang. Coba perhatikan kejernihan rasanya."
        case "honey":
            return "Honey process sering memberi manis yang lembut dan tekstur yang nyaman di mulut."
        case "anaerobic":
            return "Anaerobic process sering punya karakter yang unik dan fermentasi — nilai perlahan agar tetap objektif."
        case "wet hulled":
            return "Wet hulled sering terasa tebal dan earthy. Coba perhatikan teksturnya saat diminum."
        default:
            return "Gunakan sebagai titik awal, lalu bandingkan dengan apa yang benar-benar kamu rasakan."
        }
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Label("Petunjuk berdasarkan kopi ini", systemImage: "link")
                .font(.headline)
                .foregroundStyle(.brown)

            Text("Ini hanya panduan awal — yang paling penting tetap sensasi yang kamu rasakan langsung.")
                .font(.subheadline.weight(.medium))

            VStack(alignment: .leading, spacing: 6) {
                Label(roastHint, systemImage: "flame.fill")
                Label(processHint, systemImage: "drop.fill")
            }
            .font(.caption)
            .foregroundStyle(Color.primary.opacity(0.72))
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
                Text("Cara nyeruput yang benar")
                    .font(.subheadline.bold())
                Text("Jangan langsung ditelan. Seruput sambil sedikit hirup udara, lalu hembuskan lewat hidung. Rasanya jadi jauh lebih kaya.")
                    .font(.caption)
                    .foregroundStyle(Color.primary.opacity(0.72))
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
            .foregroundStyle(Color.primary.opacity(0.65))
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
                .foregroundStyle(Color.primary.opacity(0.72))
                .fixedSize(horizontal: false, vertical: true)
            Text(detail)
                .font(.caption)
                .foregroundStyle(Color.primary.opacity(0.65))
                .fixedSize(horizontal: false, vertical: true)
            
            HStack {
                Text("Nilai saat ini")
                    .font(.caption.weight(.semibold))
                    .foregroundStyle(Color.primary.opacity(0.65))
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
            .foregroundStyle(Color.primary.opacity(0.65))
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
                .foregroundStyle(Color.primary.opacity(0.72))
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
                .foregroundStyle(Color.primary.opacity(0.72))
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
                            .foregroundStyle(Color.primary.opacity(0.72))
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
                    .foregroundStyle(Color.primary.opacity(0.65))
                VStack(alignment: .leading, spacing: 2) {
                    Text("Bingung pilih yang mana?")
                        .font(.subheadline.weight(.semibold))
                        .foregroundStyle(Color.primary.opacity(0.72))
                    Text("Buka panduan pengecapan — ada contoh aroma dan rasa untuk setiap kategori.")
                        .font(.caption)
                        .foregroundStyle(Color.primary.opacity(0.65))
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
