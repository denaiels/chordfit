//
//  ChordProgressionCollectionViewCell.swift
//  chordfit
//
//  Created by Graciela gabrielle Angeline on 12/06/21.
//

import UIKit

class ChordProgressionCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var chordPLabel: UILabel!
    @IBOutlet weak var songTLabel: UILabel!
    @IBOutlet weak var chordBar: UIProgressView!
    
//    func setup(with chordProgression: ChordProgression) {
//        chordPLabel.text = chordProgression.chordProgressiontitle
//        songTLabel.text = chordProgression.songTitle
//        chordBar.progress = 0.5
//    }
}

class ProgressView: UIProgressView {
     override func layoutSubviews() {
          super.layoutSubviews()
          let maskLayerPath = UIBezierPath(roundedRect: bounds, cornerRadius: self.frame.height / 2)
          let maskLayer = CAShapeLayer()
          maskLayer.frame = self.bounds
          maskLayer.path = maskLayerPath.cgPath
          layer.mask = maskLayer
    }
}


