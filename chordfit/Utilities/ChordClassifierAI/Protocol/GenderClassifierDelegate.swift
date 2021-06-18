//
//  GenderClassifierDelegate.swift
//  chordfit
//
//  Created by Daniel Santoso on 17/06/21.
//

import Foundation

protocol GenderClassifierDelegate {
    func displayPredictionResult(identifier: String, confidence: Double)
}
