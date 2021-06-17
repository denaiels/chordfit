//
//  ChooseKeyPopupView.swift
//  chordfit
//
//  Created by Yafonia Hutabarat on 14/06/21.
//

import UIKit

class GamePausedPopupView: UIView {
    
    
    @IBOutlet weak var popupView: UIView!
    @IBOutlet weak var popupTitle: UILabel!
    @IBOutlet weak var resumeButton: UIButton!
    @IBOutlet weak var restartButton: UIButton!
    @IBOutlet weak var quitButton: UIButton!
    @IBOutlet weak var outerView: UIView!
    @IBOutlet var parentView: UIView!

//    let gradientLayer = CAGradientLayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        Bundle.main.loadNibNamed("ChooseBaseKeyPopupView", owner: self, options: nil)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        commonInit()
//        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit() {
        parentView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height )
        parentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.type = .radial
        
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.5)
            let endY = 0.5 + popupView.frame.size.width / popupView.frame.size.height / 2
            gradientLayer.endPoint = CGPoint(x: 1, y: endY)
        gradientLayer.colors = [
            ChordFitColors.init().lightPurple?.cgColor,
            ChordFitColors.init().purple?.cgColor
        ]
        gradientLayer.cornerRadius = 36
        
        gradientLayer.frame = popupView.bounds
        
        popupView.layer.insertSublayer(gradientLayer, at: 0)
//        popupView.layer.insertSublayer(gradientLayer, a)
        
        popupView.layer.cornerRadius = 36
        popupView.layer.borderWidth = 5
        popupView.layer.borderColor = UIColor.white.cgColor
        popupView.layer.shadowOffset = .zero
        popupView.layer.shadowRadius = 7
        popupView.layer.shadowOpacity = 0.3
        
        outerView.layer.cornerRadius = 45
        
        resumeButton.layer.borderWidth = 2
        resumeButton.layer.borderColor = UIColor.white.cgColor
        resumeButton.layer.cornerRadius = 16
        
        
        restartButton.layer.borderWidth = 2
        restartButton.layer.borderColor = UIColor.white.cgColor
        restartButton.layer.cornerRadius = 16
        
        quitButton.layer.borderWidth = 2
        quitButton.layer.borderColor = UIColor.white.cgColor
        quitButton.layer.cornerRadius = 16
      
    }
    
    enum PopupType {
        case pause
        case quit
        case feedback
        case chooseBaseKey
        case restart
    }
    
    func showPausePopup() {
        popupTitle.text = "Game paused"
    
        let window = UIApplication.shared.keyWindow!
        window.addSubview(parentView)
    }
    
    func showQuitPopup() {
        popupTitle.text = "Are you sure?"
        resumeButton.isHidden = true
        restartButton.setTitle("yes, quit", for: .normal)
        
        let window = UIApplication.shared.keyWindow!
        window.addSubview(parentView)
    }
    
    func showRestartPopup() {
        popupTitle.text = "Are you sure?"
        resumeButton.isHidden = true
        restartButton.setTitle("yes, restart", for: .normal)
        let window = UIApplication.shared.keyWindow!
        window.addSubview(parentView)
    }
    
    @IBAction func onClickQuit(_ sender: Any) {
        PopupViewController().onClickQuit()
    }
    
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        gradientLayer.frame = popupView.bounds
//
//    }
    
}
