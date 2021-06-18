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
    
    @IBOutlet weak var result: UILabel!
    
    @IBAction func startButton(_ sender: UIButton) {
        startAgainAudioEngine()
    }
    @IBAction func stopButton(_ sender: UIButton) {
        stopAudioEngine()
    }
    
    var inputFormat: AVAudioFormat!
    var analyzer: SNAudioStreamAnalyzer!
    var analyzer2: SNAudioFileAnalyzer!
    var resultsObserver = ResultsObserver()
    let analysisQueue = DispatchQueue(label: "com.bts.AnalysisQueue")
    
    let transcribedText: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .center
        view.textAlignment = .center
        view.numberOfLines = 0
        view.font = UIFont.systemFont(ofSize: 20)
        return view
        
    }()
    
    let placeholderText: UILabel = {
            let view = UILabel()
            view.translatesAutoresizingMaskIntoConstraints = false
            view.contentMode = .center
            view.textAlignment = .center
            view.numberOfLines = 0
            view.text = "Chord Classifier of Base Key C"
            view.font = UIFont.systemFont(ofSize: 25)
            return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        resultsObserver.delegate = self
        inputFormat = audioEngine.inputNode.inputFormat(forBus: 0)
        analyzer = SNAudioStreamAnalyzer(format: inputFormat)
        
        buildUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        startAudioEngine()
    }
    
    func buildUI() {
        self.view.addSubview(placeholderText)
        self.view.addSubview(transcribedText)
        
        NSLayoutConstraint.activate(
            [transcribedText.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                transcribedText.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
                transcribedText.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
                transcribedText.heightAnchor.constraint(equalToConstant: 100),
                transcribedText.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            ]
        )
                
        NSLayoutConstraint.activate(
            [placeholderText.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
                placeholderText.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
                placeholderText.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
                placeholderText.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            ]
        )
    }
    
    private func startAudioEngine() {
        
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
        
        do {
            try audioEngine.start()
        } catch( _) {
            print("Error in starting the Audio Engine")
        }
    }
    
    private func stopAudioEngine() {
        audioEngine.stop()
    }
    
    private func startAgainAudioEngine() {
        do {
            try audioEngine.start()
        } catch( _) {
            print("Error in starting the Audio Engine")
        }
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
    var delegate: GenderClassifierDelegate?
    
    func request(_ request: SNRequest, didProduce result: SNResult) {
        guard let result = result as? SNClassificationResult else { return }
        
        guard let classification = result.classifications.first else { return }
        
        let timeInSeconds = result.timeRange.start.seconds
        
        let formattedTime = String(format: "%.2f", timeInSeconds)
        print("Analysis result for audio at time: \(formattedTime)")
        
        let confidence = classification.confidence * 100.0
        
        if confidence > 65 {
            if classification.identifier == "C" {
                print("C Found")
            } else if classification.identifier == "G" {
                print("G Found")
            } else if classification.identifier == "Am" {
                print("Am Found")
            } else if classification.identifier == "F" {
                print("F Found")
            }
            
            delegate?.displayPredictionResult(identifier: classification.identifier, confidence: confidence)
        }
    }
}

extension ChordClassifierViewController: GenderClassifierDelegate {
    func displayPredictionResult(identifier: String, confidence: Double) {
        DispatchQueue.main.async {
            self.transcribedText.text = ("Recognition: \(identifier)\nConfidence \(confidence)")
            print(identifier, confidence)
            
//            if identifier == "C" || identifier == "G" || identifier == "Am" || identifier == "F" {
//                self.result.text = ("Correct! You're playing \(identifier)")
//            }
            
        }
    }
}
