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
    @IBOutlet weak var overlayView: UIView!
    
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
        
        overlayView.isHidden = true
        //ganti jadi filter core data berdasarkan type
//        songs = SongRepository.shared.getSongs()
        
        songSelection_TutorialView.songSelectionTableView.dataSource = self
        songSelection_TutorialView.songSelectionTableView.delegate = self
        
        songSelection_TutorialView.songSelectionTableView.registerCell(type: SongSelectionTableViewCell.self, identifier: "songSelectionCell")
       
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
}
