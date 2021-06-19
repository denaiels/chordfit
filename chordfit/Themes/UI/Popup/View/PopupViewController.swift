//
//  PopupViewController.swift
//  chordfit
//
//  Created by Yafonia Hutabarat on 16/06/21.
//

import UIKit

class PopupViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    enum PopupType {
        case pause
        case quit
        case feedback
        case chooseBaseKey
        case restart
    }
    
    func showPopup(popupType: PopupType) {
        switch popupType {
        case .chooseBaseKey:
            print("choosebasekey")

        case .pause:
            print("pause")
            GamePausedPopupView().showPausePopup()
          
        case .quit:
            print("quit")
            GamePausedPopupView().showQuitPopup()
//
        case .feedback:
            print("feedback")
//            popupTitle.text = "Good Progress!"

        case .restart:
            print("restart")
            GamePausedPopupView().showRestartPopup()
//            popupTitle.text = "Are you sure?"

        }
        
    }
    
    func onClickQuit() {
        GamePausedPopupView().parentView.removeFromSuperview()
    }
    

}
