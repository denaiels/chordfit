//
//  HomeViewController.swift
//  chordfit
//
//  Created by Graciela gabrielle Angeline on 11/06/21.
//

import UIKit
import CoreData

class HomeViewController: UIViewController {

    @IBOutlet weak var songTitleDC: UILabel!
    @IBOutlet weak var artistDC: UILabel!
    
    @IBOutlet weak var normalCollectionView: UICollectionView!
    @IBOutlet weak var playBtn: UIButton!
    
    @IBOutlet weak var hardCollectionView: UICollectionView!
    
    
    //managed object context
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var chords: [Songs]!
    
    var chordsNormal = [Songs]()
    var chordsHard = [Songs]()
    
    var progressBarA:Float = 0.0
    var progressBarB:Float = 0.0
   
    let categoryHeader = "HeaderCollectionView"
    
//    var chordProgression: [ChordProgression] =
//    [
//            ChordProgression(chordProgressiontitle: "vi - I - V - iv", songTitle: "Counting Stars", chordBar: 1),
//            ChordProgression(chordProgressiontitle: "I - V - vi - iii - IV -I - IV -V", songTitle: "Beautiful in White", chordBar: 0),
//    ]
    
   
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        playButton()
        
        self.navigationController?.isNavigationBarHidden = true
        normalCollectionView.dataSource = self
        normalCollectionView.delegate = self
        normalCollectionView.collectionViewLayout = UICollectionViewLayout()
        
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 15
        layout.minimumInteritemSpacing = 15
        layout.scrollDirection = .horizontal
        normalCollectionView.setCollectionViewLayout(layout, animated: true)
        
        hardCollectionView.delegate = self
        hardCollectionView.dataSource = self
        hardCollectionView.collectionViewLayout = UICollectionViewLayout()
        
        let layoutHard = UICollectionViewFlowLayout()
        layoutHard.minimumLineSpacing = 15
        layoutHard.minimumInteritemSpacing = 15
        layoutHard.scrollDirection = .horizontal
        hardCollectionView.setCollectionViewLayout(layout, animated: true)
        
        fetchData()
        
        songTitleDC.text = chords[0].title
        artistDC.text = chords[0].artist
    }
    
    @IBAction func playSong( _sender : UIButton) {
        performSegue(withIdentifier: "goToSongSelection", sender: self)
    }
    
    
    func playButton(){
        playBtn.layer.cornerRadius = playBtn.frame.height/2
        playBtn.layer.borderWidth = 1.5
        playBtn.layer.borderColor = UIColor.white.cgColor
        
        
    }
    
    func fetchData(){
        do {
//            let request = Songs.fetchRequest() as NSFetchRequest<Songs>
            self.chords = try context.fetch(Songs.fetchRequest())
            
            for dt in self.chords {
                
                if dt.category == SongProgressionCategory.Normal.rawValue {
                    let valueA = itungPoin(dataLagu: dt)
                    progressBarA += valueA
                    chordsNormal.append(dt)
                    
                    
                } else if dt.category == SongProgressionCategory.Hard.rawValue {
                    let valueB = itungPoin(dataLagu: dt)
                    progressBarB += valueB
                    chordsHard.append(dt)
                }
            }
            
            DispatchQueue.main.async {
                self.normalCollectionView.reloadData()
            }
        }
        
        catch {
            print("Error: \(error)")
        }
    }
    
    func itungPoin(dataLagu: Songs) -> Float{
        var data:Float = 0.0
        
        if (dataLagu.playedC) {
            data += 0.2
        }
        
        if (dataLagu.playedF) {
            data += 0.2
        }
        
        if (dataLagu.playedG) {
            data += 0.2
        }
        
        return data
        
    }
}


extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return 1

    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = normalCollectionView.dequeueReusableCell(withReuseIdentifier: "ChordProgressionNormal", for: indexPath) as! ChordProgressionCollectionViewCellA
        
        cell.chordPLabel?.text = chordsNormal[indexPath.row].progression
        cell.songTLabel?.text = chordsNormal[indexPath.row].title
        cell.songTLabel2?.text = chordsNormal[1].title
        cell.chordBar?.progress = progressBarA

        if (collectionView == hardCollectionView) {
            let cellB = hardCollectionView.dequeueReusableCell(withReuseIdentifier: "ChordProgressionHard", for: indexPath) as! ChordProgressionCollectionViewCellB
            
            cellB.chordPLabelB?.text = chordsHard[indexPath.row].progression
            cellB.songTLabelB?.text = chordsHard[indexPath.row].title
            cellB.songTLabelB2?.text = chordsHard[1].title
            cellB.chordBarB?.progress = progressBarB
            setupCollectionViewCellLayout(cell: cellB)
            return cellB
        }
        
        setupCollectionViewCellLayout(cell: cell)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == hardCollectionView {
            self.performSegue(withIdentifier: "hardToSongSelectionSegue", sender: self)
        }
        else{
            self.performSegue(withIdentifier: "normalToSongSelectionSegue", sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "normalToSongSelectionSegue" {
            if let destination = segue.destination as?
                    SongSelection_TutorialViewController, let index =
                    normalCollectionView.indexPathsForSelectedItems?.first {
                destination.chordProgression = chordsNormal[index.row].progression
            }

        }
        if segue.identifier == "hardToSongSelectionSegue" {
            if let destination = segue.destination as?
                    SongSelection_TutorialViewController, let index =
                    hardCollectionView.indexPathsForSelectedItems?.first {
                destination.chordProgression = chordsHard[index.row].progression
            }
        }
    }
        
//        print(self.chords[indexPath.row].title)
//        var cellA: ChordProgressionCollectionViewCellA?
//
//        var cellB: ChordProgressionCollectionViewCellB?
//
//        if (chords[indexPath.row].category == SongProgressionCategory.Normal.rawValue) {
//            cellA = normalCollectionView.dequeueReusableCell(withReuseIdentifier: "ChordProgressionNormal", for: indexPath) as! ChordProgressionCollectionViewCellA
//
//            cellA!.chordPLabel.text = self.chords![indexPath.row].progression
//            cellA!.songTLabel.text = self.chords![indexPath.row].title
//            cellA!.chordBar.progress = progressBarA
//            setupCollectionViewCellLayout(cell: cellA!)
//
//            return cellA!
//
//        }else if (chords[indexPath.row].category == SongProgressionCategory.Hard.rawValue){
//            cellB = hardCollectionView.dequeueReusableCell(withReuseIdentifier: "ChordProgressionHard", for: indexPath) as! ChordProgressionCollectionViewCellB
//
//            cellB!.chordPLabelB.text = self.chords![indexPath.row].progression
//            cellB!.songTLabelB.text = self.chords![indexPath.row].title
//            cellB!.chordBarB.progress = progressBarB
//        }
//
//
//        setupCollectionViewCellLayout(cell: cellB!)
//
//        return cellB!
        
//    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 170, height: 170)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 1, bottom: 0, right: 1)
    }
    
    func setupCollectionViewCellLayout(cell: UICollectionViewCell)
    {
        
        cell.layer.cornerRadius = 15.0
        cell.contentView.layer.masksToBounds = true

        cell.layer.shadowColor = UIColor.lightGray.cgColor
        cell.layer.shadowOffset = CGSize(width:5.0, height:5.0)
        cell.layer.shadowRadius = 5.0
        cell.layer.shadowOpacity = 0.8
        cell.layer.masksToBounds = false
        cell.layer.shadowPath = UIBezierPath(roundedRect: cell.bounds, cornerRadius: 20.0).cgPath
    }


}
