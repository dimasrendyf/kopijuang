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
    var fragranceCategory: FlavorCategory = .nutty

    var aromaContrast: AromaContrast = .unsure
    var aromaIntensity: Double = 6
    var aromaCategory: FlavorCategory = .nutty

    var acidity: Double = 6
    var sweetness: Double = 6
    var bitterness: Double = 6
    var bodyScore: Double = 6
    var tasteCategory: FlavorCategory = .fruity

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

    func onFragranceStepAppear() {
        if aromaCategory == .nutty { aromaCategory = fragranceCategory }
    }

    func onAromaStepAppear() {
        if aromaContrast == .same { aromaCategory = fragranceCategory }
    }

    func goNext() {
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
        SensoryEvaluation(
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
            bitterness: bitterness,
            bodyScore: bodyScore,
            tasteCategory: tasteCategory
        )
    }
}
