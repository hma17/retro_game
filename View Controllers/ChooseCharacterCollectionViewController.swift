//
//  ChooseCharacterCollectionViewController.swift
//  DDAR1
//
//  Created by Alex Gorman on 4/17/21.
//

import UIKit

private let reuseIdentifier = "Cell"

class ChooseCharacterCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    var names: [UIImage] = [UIImage(named: "NameAlex")!, UIImage(named: "NameHuda")!, UIImage(named: "NameAmit")!, UIImage(named: "NameBrycen")!, UIImage(named: "NameBenj")!, UIImage(named: "NameDivya")!, UIImage(named: "NameZoe")!]
    var Locked: UIImage = UIImage(named: "Locked")!
    var CharacterImage1: UIImage = UIImage(named: "CharcaterImage1")!
    var CharacterImage2: UIImage = UIImage(named: "CharacterImage2")!
    var ChooseChar: UIImage = UIImage(named: "ChooseYourCharacter")!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        //let destViewController = segue.destination as? ChooseSongTableViewController
        //let indexPaths : NSArray = collectionView.indexPathsForSelectedItems! as NSArray
        //let indexx : IndexPath = indexPaths[0] as! IndexPath
        //destViewController.numberr = indexx[selectedindexPath.row]
        let myRow = collectionView.indexPathsForSelectedItems?.first
        let dancerChosen = myRow?[1]
        let defaults = UserDefaults.standard
        if dancerChosen == 1 && defaults.bool(forKey: "dancerTwoUnlocked") == true{
        defaults.set(dancerChosen, forKey: "currentDancer")
        }else{
            defaults.set(0, forKey: "currentDancer")
        }
     }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        let myRow = collectionView.indexPathsForSelectedItems?.first
        let dancerChosen = myRow?[1]
        let defaults = UserDefaults.standard
        if dancerChosen == 1 && defaults.bool(forKey: "dancerTwoUnlocked") == true{
        return true
        }else if dancerChosen == 0{
            return true
        }else{
            return false
        }
    }
    

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return names.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "charCell", for: indexPath) as! ChooseCharacterCollectionViewCell
    
        // Configure the cell
        cell.CharName.image = names[indexPath.row]
        cell.CharPic.image = Locked
        if (indexPath.row == 0) {
            cell.CharPic.image = CharacterImage1
        }
        
        let defaults = UserDefaults.standard
        let dancerTwoUnlocked = defaults.bool(forKey: "dancerTwoUnlocked")
        
        if (indexPath.row == 1 && dancerTwoUnlocked) {
            cell.CharPic.image = CharacterImage2
        }
        
    
        return cell
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView.reloadData()
    }
    
    // MARK: UICollectionViewDelegate
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
            {
            let w  = (view.frame.width-30)/2
            return CGSize(width: w, height: w)
            }
        
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
                
                switch kind {
                case UICollectionView.elementKindSectionHeader:
                    guard
                        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "CharacterHeader", for: indexPath) as? ChooseCharacterCollectionReusableView else {
                            fatalError("Invalid view type")
                    }
                    
                    headerView.ChooseYourCharacter.image = ChooseChar
                    return headerView
                default:
                    assert(false, "Invalid element type")
                }
            }
 


    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
