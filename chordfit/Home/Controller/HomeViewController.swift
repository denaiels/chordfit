//
//  HomeViewController.swift
//  chordfit
//
//  Created by Graciela gabrielle Angeline on 11/06/21.
//

import UIKit
import CoreData

class HomeViewController: UIViewController {

    @IBOutlet weak var normalLbl: UILabel!
    @IBOutlet weak var hardLbl: UILabel!
    @IBOutlet weak var normalCollectionView: UICollectionView!
    @IBOutlet weak var playBtn: UIButton!
    
    
    //managed object context
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var chords: [Songs]!
    
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
        
        normalCollectionView.register(HeaderCollectionView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: categoryHeader)
        
        fetchData()
    }
    
    func playButton(){
        playBtn.layer.cornerRadius = playBtn.frame.height/2
        playBtn.layer.borderWidth = 1.5
        playBtn.layer.borderColor = UIColor.white.cgColor
    }
    
    func fetchData(){
        do {
            
            let request = Songs.fetchRequest() as NSFetchRequest<Songs>
            self.chords = try context.fetch(request)
//
//            let dt = self.chords
            
            for dt in self.chords {

                if dt.category == "Normal" {
                    let pred = NSPredicate(format: "category CONTAINS %@", "Normal")
                    request.predicate = pred}
                    
//                } else if dt.category == "Hard"{
//                    let pred = NSPredicate(format: "category CONTAINS %@", "Hard")
//                    request.predicate = pred
//                }
            }
            
//            DispatchQueue.main.async {
//                self.normalCollectionView.reloadData()
//            }
            
            normalCollectionView.reloadData()
            
        } catch {
            print("Error: \(error)")
        }
}
}


extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.chords?.count ?? 0
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ChordProgression", for: indexPath) as! ChordProgressionCollectionViewCell
        
        setupCollectionViewCellLayout(cell: cell)
        
        cell.chordPLabel?.text = "\(String(describing: self.chords![indexPath.row].progression))"
        
        cell.songTLabel?.text = "\(String(describing: self.chords![indexPath.row].title))"
        

//        cell.chordPLabel?.text = self.chords![indexPath.row].progression
//        cell.songTLabel?.text = self.chords![indexPath.row].title
    
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 170, height: 170)
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
//            return CGSize(width: 50, height: 30)
//    }
//    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 1, bottom: 0, right: 1)
    }
    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        print(chordProgression[indexPath.row].chordProgressiontitle)
//    }
    
//    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
//
//        switch kind {
//
//        case UICollectionView.elementKindSectionHeader:
//                let headerView = normalCollectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: categoryHeader, for: indexPath) as! HeaderCollectionView
//
//            headerView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 30)
//
//            headerView.categoryHeaderTitle?.text = "tutut"
//
//            return headerView
//
//            default:
//                assert(false, "Unexpected element kind")
//            }
//
//    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
//
//        if let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: categoryHeader, for: indexPath) as? HeaderCollectionView{
//            sectionHeader.categoryHeaderTitle?.text = "TEST"
//            return sectionHeader
//        }
//        return UICollectionReusableView()
    

//        let categoryHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "HeaderCollectionView", for: indexPath) as? HeaderCollectionView
        
        //cara-1
//        var reusableView : UICollectionReusableView? = nil
//
//        if (kind == UICollectionView.elementKindSectionHeader) {
//                // Create Header
//            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "HeaderCollectionView", for: indexPath) as! HeaderCollectionView
//
//            headerView.frame = CGRect(x:0, y:0, width: view.frame.width, height: 200)
//            headerView.categoryHeaderTitle.text = self.chords![indexPath.row].category
//
//                reusableView = headerView
//            }
//            return reusableView!

            
//        let category = self.chords![indexPath.section].category

//        return UICollectionReusableView()
//    }
//    
   
    //cara-2
//    func collectionView(_ collectionView: UICollectionView,
//                                 viewForSupplementaryElementOfKind kind: String,
//                                 at indexPath: IndexPath) -> UICollectionReusableView {
//      // 1
//      switch kind {
//      // 2
//      case UICollectionView.elementKindSectionHeader:
//        // 3
//        guard
//          let headerView = normalCollectionView.dequeueReusableSupplementaryView(
//            ofKind: kind,
//            withReuseIdentifier: "\(HeaderCollectionView.self)",
//            for: indexPath) as? HeaderCollectionView
//          else {
//            fatalError("Invalid view type")
//        }
//
//        headerView.categoryHeaderTitle?.text = self.chords![indexPath.row].category
//
//        return headerView
//
//      default:
//        // 4
//        assert(false, "Invalid element type")
//      }
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
