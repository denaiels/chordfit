//
//  chordProgression.swift
//  chordfit
//
//  Created by Graciela gabrielle Angeline on 13/06/21.
//

import Foundation
import UIKit

struct ChordProgression{
    let chordProgressiontitle: String
    let songTitle: String
    let chordBar: Int
}

//new
enum SongProgression: String, CaseIterable {
    case vi_I_V_IV = "vi_I_V_IV"
    case I_V_vi_iii_IV_I_IV_V = "I-V-vi-iii-IV-I-IV-V"
    
    func getCategory() -> String{
        switch self{
        case .vi_I_V_IV:
            return "Normal"
            
        case .I_V_vi_iii_IV_I_IV_V:
            return "Hard"
        }
    }
}
