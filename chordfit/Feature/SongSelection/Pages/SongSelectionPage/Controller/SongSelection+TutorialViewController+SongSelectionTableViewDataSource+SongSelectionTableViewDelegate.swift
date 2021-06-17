//
//  SongSelection_TutorialViewController+SongSelectionTableViewDataSource+SongSelectionTableViewDelegate.swift
//  chordfit
//
//  Created by Yafonia Hutabarat on 12/06/21.
//

import UIKit

extension SongSelection_TutorialViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songs?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = songSelection_TutorialView.songSelectionTableView.dequeueReusableCell(withIdentifier: "songSelectionCell", for: indexPath) as! SongSelectionTableViewCell
        cell.delegate = self
        cell.song = songs?[indexPath.row]
        return cell
        
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableCell(withIdentifier: "headerCell") as! HeaderTableViewCell
        return cell.contentView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
  
}

extension SongSelection_TutorialViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        overlayView.isHidden = false
        song = songs?[indexPath.row]
        performSegue(withIdentifier: "chooseBasekeyPopupSegue", sender: self)

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "chooseBasekeyPopupSegue" {
            if let viewController = segue.destination as? ChooseBaseKeyPopupViewController {
                viewController.songToPlay = song
                print(song?.title)
            }
        }
    }
}


