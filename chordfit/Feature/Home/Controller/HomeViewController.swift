//
//  HomeViewController.swift
//  chordfit
//
//  Created by Graciela gabrielle Angeline on 11/06/21.
//

import UIKit
import CoreData

class HomeViewController: UIViewController {

    @IBOutlet weak var normalCollectionView: UICollectionView!
    @IBOutlet weak var playBtn: UIButton!
    
    @IBOutlet weak var hardCollectionView: UICollectionView!
    
    //managed object context
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var chords: [Songs]!
    
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
                    
                    
                } else if dt.category == SongProgressionCategory.Hard.rawValue {
                    let valueB = itungPoin(dataLagu: dt)
                    progressBarB += valueB
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
        return self.chords?.count ?? 0
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = normalCollectionView.dequeueReusableCell(withReuseIdentifier: "ChordProgressionNormal", for: indexPath) as! ChordProgressionCollectionViewCellA
        
        cell.chordPLabel?.text = self.chords![indexPath.row].progression
        cell.songTLabel?.text = self.chords![indexPath.row].title
        cell.chordBar?.progress = progressBarA
        
        if (collectionView == hardCollectionView) {
            let cellB = hardCollectionView.dequeueReusableCell(withReuseIdentifier: "ChordProgressionHard", for: indexPath) as! ChordProgressionCollectionViewCellB
            
            cellB.chordPLabelB?.text = self.chords![indexPath.row].progression
            cellB.songTLabelB?.text = self.chords![indexPath.row].title
            cellB.chordBarB?.progress = progressBarB

            return cellB
        }
        
//        var cell: ChordProgressionCollectionViewCell?
//
//        if (chords[indexPath.row].category == SongProgression.Normal.rawValue) {
//            cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ChordProgressionNormal", for: indexPath) as! ChordProgressionCollectionViewCell
//
//            cell!.chordPLabel.text = self.chords![indexPath.row].progression
//            cell!.songTLabel.text = self.chords![indexPath.row].title
//            cell!.chordBar.progress = progressBarA
//
//        }else if (chords[indexPath.row].category == SongProgression.Normal.rawValue){
//            cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ChordProgressionHard", for: indexPath) as! ChordProgressionCollectionViewCellB
//
//            cell!.chordPLabelB.text = self.chords![indexPath.row].progression
//            cell!.songTLabelB.text = self.chords![indexPath.row].title
//            cell!.chordBarB.progress = progressBarB
//        }
        
        setupCollectionViewCellLayout(cell: cell)
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 170, height: 170)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 1, bottom: 0, right: 1)
    }
    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        print(chordProgression[indexPath.row].chordProgressiontitle)
//    }


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
