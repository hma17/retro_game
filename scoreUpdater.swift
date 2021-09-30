//
//  scoreUpdater.swift
//  DDAR1
//
//  Created by codeplus on 4/11/21.
//

import UIKit
import CoreData

let appDelegate = UIApplication.shared.delegate as! AppDelegate
let context = appDelegate.persistentContainer.viewContext

func updateScore(score: Int32, songTitle: String) -> Bool {
    let request = NSFetchRequest<NSFetchRequestResult>(entityName: "HighScores")
    request.returnsObjectsAsFaults = false
    do{
        let result = try context.fetch(request)
        for data in result as! [NSManagedObject] {
            if (data.value(forKey: "highScore") as! Int32) < score && (data.value(forKey: "song") as! String) == songTitle {
                data.setValue(score, forKey: "highScore")
                do{
                    try context.save()
                    }catch{
                    print("Error - CoreData failed saving")
                    }
                    print("updated score")
                return true
            }else{
            print(data.value(forKey:"song") as! String)
            print(data.value(forKey: "highScore"))
            }
        }
        }catch {
            print("Error - CoreData failed reading")
        }
    return false
}

func saveScore(score: Int32, songTitle: String, date: Date){
    let entity = NSEntityDescription.entity(forEntityName: "SongRecords", in: context)
    let newRecord = NSManagedObject(entity: entity!, insertInto: context)
    newRecord.setValue(songTitle, forKey: "songTitle")
    newRecord.setValue(score, forKey: "songScore")
    newRecord.setValue(date, forKey: "datePlayed")
    do{
        try context.save()
        }catch {
            print("Error - CoreData failed reading")
        }
    
}

func getAvgForSong(songName: String) -> (average: Double, timesPlayed: Int){

    var sumScore = 0
    var timesPlayed = 0
    if songName == ""{
        return (0, 0)
    }
    do{
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "SongRecords")
        request.predicate = NSPredicate(format: "songTitle = %@", songName)
        request.returnsObjectsAsFaults = false
        do{
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
                sumScore += data.value(forKey: "songScore") as! Int
                timesPlayed += 1
            }
        }catch {
            print("Error - CoreData failed reading")
        }
        let avgScoreForSong: Double
        if timesPlayed > 0{
            avgScoreForSong = Double(sumScore) / Double(timesPlayed)
        }else{
            avgScoreForSong = 0
        }
        return (avgScoreForSong, timesPlayed)
    }
}

func getSongHighScores() -> [Any] {
    let request = NSFetchRequest<NSFetchRequestResult>(entityName: "HighScores")
    request.returnsObjectsAsFaults = false
    do{
        let result = try context.fetch(request)
        return result
    }catch {
        print("Error - CoreData failed reading")
    }
    return []
}

func unlockDancer(dancerToUnlockKey: String){
    let defaults = UserDefaults.standard
    defaults.set(true, forKey: dancerToUnlockKey)
}



class scoreUpdater: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
