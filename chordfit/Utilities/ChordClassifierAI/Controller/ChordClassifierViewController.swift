//
//  ChordClassifierViewController.swift
//  chordfit
//
//  Created by Daniel Santoso on 17/06/21.
//

import UIKit
import AVKit
import SoundAnalysis

class ChordClassifierViewController: UIViewController {

    private let audioEngine = AVAudioEngine()
    private var cChordClassifier = Base_Key_C()
    private var fChordClassifier = Base_Key_F()
    private var gChordClassifier = Base_Key_G()
    
    var inputFormat: AVAudioFormat!
    var analyzer: SNAudioStreamAnalyzer!
    var analyzer2: SNAudioFileAnalyzer!
    var resultsObserver = ResultsObserver()
    let analysisQueue = DispatchQueue(label: "com.bts.AnalysisQueue")
    
    var identified: [String] = []
    var currentChord: String = ""
    var isCorrectChord: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let gameScene = GameScene()
        gameScene.chordClassifierViewController = self
        
        resultsObserver.delegate = self
        inputFormat = audioEngine.inputNode.inputFormat(forBus: 0)
        analyzer = SNAudioStreamAnalyzer(format: inputFormat)
        
        prepareAudioEngine()
    }
    
    func prepareAudioEngine() {
        
        do {
            let requestC = try SNClassifySoundRequest(mlModel: cChordClassifier.model)
            try analyzer.add(requestC, withObserver: resultsObserver)
        } catch {
            print("Unable to prepare request: \(error.localizedDescription)")
            return
        }
        
        audioEngine.inputNode.installTap(onBus: 0, bufferSize: 8000, format: inputFormat) { buffer, time in
            self.analysisQueue.async {
                self.analyzer.analyze(buffer, atAudioFramePosition: time.sampleTime)
            }
        }
        
        print("Prepared Audio Engine. Ready to Launch in 3..2..1..")
    }
    
    func startAudioEngine() {
        isCorrectChord = false
        
        do {
            try audioEngine.start()
            print("---Start Listening---")
        } catch( _) {
            print("Error in starting the Audio Engine")
        }
    }
    
    func stopAudioEngine() {
        audioEngine.stop()
        print("---Stop Listening---")
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

class ResultsObserver: NSObject, SNResultsObserving {
    var delegate: ChordClassifierDelegate?
    
    func request(_ request: SNRequest, didProduce result: SNResult) {
        guard let result = result as? SNClassificationResult else { return }
        
        guard let classification = result.classifications.first else { return }
        
//        let timeInSeconds = result.timeRange.start.seconds
//
//        let formattedTime = String(format: "%.2f", timeInSeconds)
//        print("Analysis result for audio at time: \(formattedTime)")
        
        let confidence = classification.confidence * 100.0
        
        if confidence > 65 {
            let identifiedChord = classification.identifier
            print(identifiedChord, confidence)
            delegate?.addToIdentifiedChords(identifier: identifiedChord)
            delegate?.checkIdentifiedAndRealChord(identifier: identifiedChord)
        }
    }
}

extension ChordClassifierViewController: ChordClassifierDelegate {
    
    func displayPredictionResult(identifier: String, confidence: Double) {
        DispatchQueue.main.async {
//            self.transcribedText.text = ("Recognition: \(identifier)\nConfidence \(confidence)")
            print(identifier, confidence)
            
//            if identifier == "C" || identifier == "G" || identifier == "Am" || identifier == "F" {
//                self.result.text = ("Correct! You're playing \(identifier)")
//            }
            
        }
    }
    
    func addToIdentifiedChords(identifier: String) {
        identified.append(identifier)
    }
    
    func checkIdentifiedAndRealChord(identifier: String) {
        print("checking...")
        let identifiedChordPlayed = identifier
        let realChordAsked = currentChord
        print("Chord Identified: \(identifiedChordPlayed)")
        print("Real Chord Asked: \(realChordAsked)")
        
        if identifiedChordPlayed == realChordAsked {
            isCorrectChord = true
            print("You've played the correct chord, that is \(realChordAsked)")
        }
    }
}
