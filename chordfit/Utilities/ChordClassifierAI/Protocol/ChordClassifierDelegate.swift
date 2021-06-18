//
//  GenderClassifierDelegate.swift
//  chordfit
//
//  Created by Daniel Santoso on 17/06/21.
//

import Foundation

protocol ChordClassifierDelegate {
    func displayPredictionResult(identifier: String, confidence: Double)
    func addToIdentifiedChords(identifier: String)
    func checkIdentifiedAndRealChord(identifier: String)
}
