//
//  SongSelection+TutorialViewController.swift
//  chordfit
//
//  Created by Yafonia Hutabarat on 12/06/21.
//

import UIKit
import CoreData



class SongSelection_TutorialViewController: UIViewController {

    @IBOutlet weak var songSelection_TutorialView: SongSelection_TutorialView!

    
    var song: Songs?
    var chordProgression: String?
    var songs: [Songs]!
    var allSongs: [Songs]!
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    // From Gameplay
    var getStar: Bool?
    var baseKeyFromGameplay: String?
  
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.title = chordProgression
        self.navigationController?.isNavigationBarHidden = false
        self.songs = fetchData()
        print(chordProgression)
        self.ExampleChordPickerView.selectRow(3, inComponent: 0, animated: true)
        
        chooseChordExampleView(options: 2)
        
  
        //ganti jadi filter core data berdasarkan type
//        songs = SongRepository.shared.getSongs()
        
        songSelection_TutorialView.songSelectionTableView.dataSource = self
        songSelection_TutorialView.songSelectionTableView.delegate = self
        
        songSelection_TutorialView.songSelectionTableView.registerCell(type: SongSelectionTableViewCell.self, identifier: "songSelectionCell")
        
        ExampleChordPickerView.delegate = self
        ExampleChordPickerView.dataSource = self
       
    }
    
    func fetchData() -> [Songs]{
        var songsToShow: [Songs] = []
        do {
          
            let request = Songs.fetchRequest() as NSFetchRequest<Songs>
            let allSongs = try self.context.fetch(request)
            
            for dt in allSongs {
                
                if dt.progression == chordProgression {
                    
                    songsToShow.append(dt)
                    print("ini dt")
                    print(dt)
                }
            }
        }
        
        catch {
            print("Error: \(error)")
        }
        return songsToShow
    }
    
    func checkForResultFromGameplay() {
        if getStar == true {
            getStar = false
        }
        
        // Update CoreData
        
    }
    
    @IBAction func unwind( _ seg: UIStoryboardSegue) {
        
    }
    @IBAction func backToHomeBtn( _sender : UIButton) {
//        performSegue(withIdentifier: "backToHomeStoryboard", sender: self)
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBOutlet weak var ExampleChordPickerView: UIPickerView!
    @IBOutlet weak var ExampleChordScrollView: UIScrollView!
    @IBOutlet weak var exampleStackView: UIStackView!
    @IBOutlet weak var viewChord1: UIView!
    @IBOutlet weak var progChordLabel1: UILabel!
    @IBOutlet weak var chordImageView1: UIImageView!
    @IBOutlet weak var chordNameLabel1: UILabel!
    @IBOutlet weak var viewChord2: UIView!
    @IBOutlet weak var progChordLabel2: UILabel!
    @IBOutlet weak var chordImageView2: UIImageView!
    @IBOutlet weak var chordNameLabel2: UILabel!
    @IBOutlet weak var viewChord3: UIView!
    @IBOutlet weak var progChordLabel3: UILabel!
    @IBOutlet weak var chordImageView3: UIImageView!
    @IBOutlet weak var chordNameLabel3: UILabel!
    @IBOutlet weak var viewChord4: UIView!
    @IBOutlet weak var progChordLabel4: UILabel!
    @IBOutlet weak var chordImageView4: UIImageView!
    @IBOutlet weak var chordNameLabel4: UILabel!
    @IBOutlet weak var viewChord5: UIView!
    @IBOutlet weak var progChordLabel5: UILabel!
    @IBOutlet weak var chordImageView5: UIImageView!
    @IBOutlet weak var chordNameLabel5: UILabel!
    @IBOutlet weak var viewChord6: UIView!
    @IBOutlet weak var progChordLabel6: UILabel!
    @IBOutlet weak var chordImageView6: UIImageView!
    @IBOutlet weak var chordNameLabel6: UILabel!
    
    let chordDict: [String: [String:String]] = [
        "C":["I":"C",
             "ii":"Dm",
             "iii":"Em",
             "IV":"F",
             "V":"G",
             "vi":"Am"
        ],
        "F":["I":"F",
             "ii":"Gm",
             "iii":"Am",
             "IV":"Bb",
             "V":"C",
             "vi":"Dm"
        ],
        "G":["I":"G",
             "ii":"Am",
             "iii":"Bm",
             "IV":"C",
             "V":"D",
             "vi":"Em"
        ]
    
    ]
    
    var chooseGroup: [String:String] = [:]
    
    
    func addChordExampleSubView1(){
        progChordLabel1.text = "I"
        progChordLabel2.text = "ii"
        progChordLabel3.text = "iii"
        progChordLabel4.text = "IV"
        progChordLabel5.text = "V"
        progChordLabel6.text = "vi"
    }
    
    func addChordExampleSubView2(){
        progChordLabel1.text = "I"
        progChordLabel2.text = "IV"
        progChordLabel3.text = "V"
        progChordLabel4.text = "vi"
        progChordLabel5.text = ""
        chordImageView5.isHidden = true
        chordNameLabel5.isHidden = true
        
        
        chordImageView2.image = UIImage(named: chooseGroup["IV"] ?? "ii")
        chordImageView3.image = UIImage(named: chooseGroup["V"] ?? "iii")
        chordImageView4.image = UIImage(named: chooseGroup["vi"] ?? "IV")
        
        viewChord6.isHidden = true
    }
    
    func chooseChordExampleView(options: Int){
        
        ExampleChordPickerView.setValue(UIColor.white, forKey: "textColor")
        
        switch options {
        case 1:
            addChordExampleSubView1()
        case 2:
            addChordExampleSubView2()
        default:
            addChordExampleSubView1()
        }
    }
}


extension SongSelection_TutorialViewController: UIPickerViewDelegate, UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return chordDict.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let r = Array(chordDict.keys)[row]
        chooseGroup = Array(chordDict.values)[row]
        return "do = \(r)"
    }
    
  
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        chordImageView1.image = UIImage(named: chooseGroup["I"] ?? "I")
        chordImageView2.image = UIImage(named: chooseGroup["ii"] ?? "ii")
        chordImageView3.image = UIImage(named: chooseGroup["iii"] ?? "iii")
        chordImageView4.image = UIImage(named: chooseGroup["IV"] ?? "IV")
        chordImageView5.image = UIImage(named: chooseGroup["V"] ?? "V")
        chordImageView6.image = UIImage(named: chooseGroup["vi"] ?? "vi")
    }
    
}
