//
//  chordProgression.swift
//  chordfit
//
//  Created by Graciela gabrielle Angeline on 13/06/21.
//

import Foundation
import UIKit
//
//struct ChordProgression{
//    let chordProgressiontitle: String
//    let songTitle: String
//    let chordBar: Int
//}

//new
enum SongProgression: String, CaseIterable {
    case Normal
    case Hard
    
    func getProgression() -> String{
        switch self{
        case .Normal:
            return "IV - V - vi"
            
        case .Hard:
            return "I - II - iii"
        }
    }
}
