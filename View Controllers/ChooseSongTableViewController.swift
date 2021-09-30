//
//  ChooseSongTableViewController.swift
//  DDAR1
//
//  Created by Alex Gorman on 4/17/21.
//

import UIKit

class ChooseSongTableViewController: UITableViewController {
    var songTitle: [String] = ["Latch", "WAP", "What's Next", "Heartbreak Anniversary", "Montero", "Chicken Dance"]
    var songs: [UIImage] = [UIImage(named: "SongL")!, UIImage(named: "SongW")!, UIImage(named: "SongWN")!, UIImage(named: "SongHA")!, UIImage(named: "SongM")!, UIImage(named: "SongCD")!]
    var artists: [UIImage] = [UIImage(named: "ArtistL")!, UIImage(named: "ArtistW")!, UIImage(named: "ArtistWN")!, UIImage(named: "ArtistHA")!, UIImage(named: "ArtistM")!, UIImage(named: "ArtistCD")!]
    
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "songCell", for: indexPath) as! ChooseSongTableViewCell

        // Configure the cell...
        cell.title.image = songs[indexPath.row]
        cell.artist.image = artists[indexPath.row]

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

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
     let destVC = segue.destination as! DifficultyViewController
             
             let selectedRow = tableView!.indexPathForSelectedRow?.row
             
             destVC.titles = songTitle[selectedRow!]
             print(songTitle[selectedRow!])
    }
    

}
