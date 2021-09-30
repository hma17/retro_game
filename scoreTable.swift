//
//  scoreTable.swift
//  DDAR1
//
//  Created by codeplus on 4/11/21.
//

import UIKit
import CoreData

class scoreTable: UITableViewController {
    
    let songs = getSongHighScores() as! [NSManagedObject]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return songs.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellScore", for: indexPath) as! cellScore

        // Configure the cell...
        
        cell.songName?.text = songs[indexPath.row].value(forKey: "song") as? String
        print(songs[indexPath.row].value(forKey: "song") as! String)
        cell.highestScore?.text = String(songs[indexPath.row].value(forKey: "highScore") as! Int)
        
        if (cell.songName?.text == "Latch") {
            cell.albumCov.image = UIImage(named:"LatchPic")!
        
            cell.songTitle.image = UIImage(named:"SongL")!
        }
        
        if (cell.songName?.text == "Heartbreak Anniversary") {
            cell.albumCov.image = UIImage(named:"HeartbreakPic")!
            cell.songTitle.image = UIImage(named:"SongHA")!
        }
        
        if (cell.songName?.text == "WAP") {
            cell.albumCov.image = UIImage(named:"wappic")!
            cell.songTitle.image = UIImage(named:"SongW")!
        }
        
        if (cell.songName?.text == "Chicken Dance") {
            cell.albumCov.image = UIImage(named:"ChickenPic")!
            cell.songTitle.image = UIImage(named:"SongCD")!
        }
    
        if (cell.songName?.text == "Montero") {
            cell.albumCov.image = UIImage(named:"MonteroPic")!
            cell.songTitle.image = UIImage(named:"SongM")!
        }
        
        if (cell.songName?.text == "What's Next") {
            cell.albumCov.image = UIImage(named:"WhatsNextPic")!
            cell.songTitle.image = UIImage(named:"SongWN")!
        }
        
        
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        let destVC = segue.destination as! detailScore
        _ = tableView.indexPathForSelectedRow?.row
        let myCell = tableView.cellForRow(at: (tableView.indexPathForSelectedRow)!) as! cellScore
        
       // destVC.HScore = myCell.highestScore.value(forKey: "highScore") as! Int
      //  destVC.HScore = Int(myCell.highestScore.text)
        destVC.HScore = Int(myCell.highestScore.text!)! 
       // destVC.songName = myCell.songName.value(forKey: "song") as! String
        destVC.songName = myCell.songName.text!
        
        if (destVC.songName == "What's Next") {
            destVC.picture = UIImage(named:"WhatsNextPic")!
            destVC.songPicture = UIImage(named:"SongWN")!
        }
        
        if (destVC.songName == "Latch") {
            destVC.picture = UIImage(named:"LatchPic")!
            destVC.songPicture = UIImage(named:"SongL")!
        }
        
        if (destVC.songName == "Montero") {
            destVC.picture =
            UIImage(named:"MonteroPic")!
            destVC.songPicture = UIImage(named:"SongM")!
        }
        
        if (destVC.songName == "Chicken Dance") {
            destVC.picture =
            UIImage(named:"ChickenPic")!
            destVC.songPicture = UIImage(named:"SongCD")!
        }
        
        if (destVC.songName == "WAP") {
            destVC.picture =
            UIImage(named:"wappic")!
            destVC.songPicture = UIImage(named:"SongW")!
        }
        
        if (destVC.songName == "Heartbreak Anniversary") {
            destVC.picture =
            UIImage(named:"HeartbreakPic")!
            destVC.songPicture = UIImage(named:"SongHA")!
        }
    }

}
