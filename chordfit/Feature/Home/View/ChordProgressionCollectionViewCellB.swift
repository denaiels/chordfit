//
//  AbcCollectionViewCell.swift
//  chordfit
//
//  Created by Graciela gabrielle Angeline on 20/06/21.
//

import UIKit

class ChordProgressionCollectionViewCellB: UICollectionViewCell {
    
    @IBOutlet weak var chordPLabelB: UILabel!
    @IBOutlet weak var songTLabelB: UILabel!
    @IBOutlet weak var chordBarB: ProgressView!
    
    
}

class ProgressViewB: UIProgressView {
     override func layoutSubviews() {
          super.layoutSubviews()
          let maskLayerPath = UIBezierPath(roundedRect: bounds, cornerRadius: self.frame.height / 2)
          let maskLayer = CAShapeLayer()
          maskLayer.frame = self.bounds
          maskLayer.path = maskLayerPath.cgPath
          layer.mask = maskLayer
    }
}
