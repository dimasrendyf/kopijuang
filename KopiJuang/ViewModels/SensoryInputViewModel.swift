//
//  SensoryInputViewModel.swift
//  KopiJuang
//

import Foundation
import Observation

@MainActor
@Observable
final class SensoryInputViewModel {
    let beanName: String
    let beanOrigin: String
    let roastLevel: String
    let processLevel: String

    var step: SensoryInputStep = .fragrance
    var scrollToTopNonce: Int = 0

    var fragranceIntensity: Double = 6
    var fragranceCategory: FlavorCategory?

    var aromaContrast: AromaContrast = .unsure
    var aromaIntensity: Double = 6
    var aromaCategory: FlavorCategory?

    var acidity: Double = 6
    var sweetness: Double = 6
    var bitterness: Double = 6
    var bodyScore: Double = 6
    var tasteCategory: FlavorCategory?

    init(
        beanName: String,
        beanOrigin: String,
        roastLevel: String,
        processLevel: String
    ) {
        self.beanName = beanName
        self.beanOrigin = beanOrigin
        self.roastLevel = roastLevel
        self.processLevel = processLevel
    }

    func onAromaStepAppear() {
        if aromaContrast == .same, let f = fragranceCategory {
            aromaCategory = f
        }
    }

    /// Bisa "Lanjut" / navigasi hasil: kategori wajib dipilih per aturan step.
    var canAdvanceFromCurrentStep: Bool {
        switch step {
        case .fragrance:
            return fragranceCategory != nil
        case .aroma:
            if aromaContrast == .same { return fragranceCategory != nil }
            return aromaCategory != nil
        case .taste:
            return tasteCategory != nil
        }
    }

    func goNext() {
        guard canAdvanceFromCurrentStep else { return }
        switch step {
        case .fragrance:
            step = .aroma
        case .aroma:
            step = .taste
        case .taste:
            return
        }
        scrollToTopNonce += 1
    }

    /// `true` = navigated to previous step; `false` = caller should `dismiss`.
    @discardableResult
    func goBack() -> Bool {
        switch step {
        case .fragrance:
            return false
        case .aroma:
            step = .fragrance
        case .taste:
            step = .aroma
        }
        scrollToTopNonce += 1
        return true
    }

    func makeEvaluation() -> SensoryEvaluation {
        guard let f = fragranceCategory, let t = tasteCategory else {
            preconditionFailure("makeEvaluation: kategori wajib sudah terisi (cek canAdvanceFromCurrentStep).")
        }
        let a: FlavorCategory
        if aromaContrast == .same {
            a = f
        } else {
            guard let w = aromaCategory else {
                preconditionFailure("makeEvaluation: aroma basah wajib jika kontras bukan Sama.")
            }
            a = w
        }
        return SensoryEvaluation(
            beanName: beanName,
            beanOrigin: beanOrigin,
            roastLevel: roastLevel,
            processLevel: processLevel,
            fragranceIntensity: fragranceIntensity,
            fragranceCategory: f,
            aromaContrast: aromaContrast,
            aromaIntensity: aromaIntensity,
            aromaCategory: a,
            acidity: acidity,
            sweetness: sweetness,
            bitterness: bitterness,
            bodyScore: bodyScore,
            tasteCategory: t
        )
    }
}
