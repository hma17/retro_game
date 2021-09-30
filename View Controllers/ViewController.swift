//
//  ViewController.swift
//  DDAR1
//
//  Created by Huda Aldadah on 3/31/21.
//

import UIKit
import SceneKit
import ARKit
import AVFoundation

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var score: UILabel!
    @IBOutlet weak var streakMessage: UILabel!
    var scoreNum = 0
    var streak = 0
    var lastHit = 0
    var countdown = 120
    
    var timer = Timer()
    //let scoreUpdate = scoreUpdater()
    let currentDateTime = Date()
    var easyMoves: [String] = [""]
    var medMoves: [String] = [""]
    var hardMoves: [String] = [""]
    
    var difficulty: Int = 2
    var titles: String = ""
    var artists: String = ""
    var initialheight: Int = 20
    
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var circle: UIImageView!
    @IBOutlet weak var square: UIImageView!
    @IBOutlet weak var shape3: UIImageView!
    @IBOutlet weak var triangle: UIImageView!
    @IBOutlet weak var goal1: UIImageView!
    @IBOutlet weak var goal2: UIImageView!
    @IBOutlet weak var goal3: UIImageView!
    @IBOutlet weak var goal4: UIImageView!
    

    //@IBOutlet weak var start: UIImageView!
    //@IBOutlet weak var streakMessage: UILabel!
    var animations = [String: CAAnimation]()
    var currAnimationKey = String()
    var idle:Bool = true
    var audioPlayer = AVAudioPlayer()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
        // Create a new scene MODIFIED
        //let scene = SCNScene(named: "art.scnassets/ship.scn")!
        let scene = SCNScene()
        
        // Set the scene to the view
        sceneView.scene = scene
        
        //ADDEDBYME
        loadAnimations()
        
        score.text = "\(scoreNum)"
        streakMessage.isHidden = true
        streakMessage.text = "Streak! +20"
        timerLabel.text = timeString(time: TimeInterval(countdown))
        
    }
    
    @objc func updateCounter() {
        if countdown == 0 {
            updateScore(score: Int32(scoreNum), songTitle: titles)
            saveScore(score: Int32(scoreNum), songTitle: titles, date: currentDateTime)
            let defaults = UserDefaults.standard
            if (scoreNum > 50) {
                unlockDancer(dancerToUnlockKey: "dancerTwoUnlocked")
                print("dancer two is set as unlocked unlocked")
            }
            print( String(defaults.bool(forKey: "dancerTwoUnlocked")) + "afetr print")
        }
        
        if countdown <= 0 {
            circle.layer.removeAllAnimations()
            square.layer.removeAllAnimations()
            shape3.layer.removeAllAnimations()
            triangle.layer.removeAllAnimations()
            streakMessage.text = "Time's up! Game Over"
            streakMessage.isHidden = false
            audioPlayer.stop()
            
            
            
        }
        
        if countdown >= 0 {
            //print("\(countdown) seconds to the end of the world")
            timerLabel.text = timeString(time: TimeInterval(countdown))
            countdown = countdown - 1
            
        }
        
    }
    
    func timeString(time:TimeInterval) -> String {
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    func loadAnimations () {
          // Load the character in the idle animation
        let defaults = UserDefaults.standard
        var idleScene = SCNScene(named: "art.scnassets/IdleFixed.dae")!
        easyMoves = ["twist", "chicken", "hh1", "hhDancing", "houseDance"]
        medMoves = ["circle", "gagnam", "slide", "snake", "twerk"]
        hardMoves = ["freezes", "NSFC", "NSSC", "wave"]
        if ((defaults.integer(forKey: "currentDancer")) == 1) {
            idleScene = SCNScene(named: "art.scnassets/idle2Fixed.dae")!
            easyMoves = ["Groove2", "Belly2", "HHC2", "Maca2"]
            medMoves = ["Groove2", "Belly2", "HHC2", "Maca2"]
            hardMoves = ["Groove2", "Belly2", "HHC2", "Maca2"]
        }

          // This node will be parent of all the animation models
          let node = SCNNode()

          // Add all the child nodes to the parent node
          for child in idleScene.rootNode.childNodes {
            node.addChildNode(child)
          }

          // Set up some properties
          node.position = SCNVector3(0, -20, -20)
          node.scale = SCNVector3(0.1, 0.1, 0.1)

          // Add the node to the scenew
          sceneView.scene.rootNode.addChildNode(node)

          // Load all the DAE animations
        loadAnimation(withKey: "Groove2", sceneName: "art.scnassets/groove2Fixed", animationIdentifier: "groove2Fixed-1")
        loadAnimation(withKey: "Belly2", sceneName: "art.scnassets/Belly2Fixed", animationIdentifier: "Belly2Fixed-1")
        loadAnimation(withKey: "HHC2", sceneName: "art.scnassets/HHC2Fixed", animationIdentifier: "HHC2Fixed-1")
        loadAnimation(withKey: "Maca2", sceneName: "art.scnassets/Maca2Fixed", animationIdentifier: "Maca2Fixed-1")
        
        
        loadAnimation(withKey: "messedUp", sceneName: "art.scnassets/MessedUpFixed", animationIdentifier: "MessedUpFixed-1")
        loadAnimation(withKey: "chicken", sceneName: "art.scnassets/ChickenFixed", animationIdentifier: "ChickenFixed-1")
        loadAnimation(withKey: "circle", sceneName: "art.scnassets/CircularHeadFixed", animationIdentifier: "CircularHeadFixed-1")
        loadAnimation(withKey: "freezes", sceneName: "art.scnassets/FreezesFixed", animationIdentifier: "FreezesFixed-1")
        loadAnimation(withKey: "freezeV1", sceneName: "art.scnassets/FreezeV1Fixed", animationIdentifier: "FreezeV1Fixed-1")
        loadAnimation(withKey: "freezeV4", sceneName: "art.scnassets/FreezeV4Fixed", animationIdentifier: "FreezeV4Fixed-1")
        loadAnimation(withKey: "gagnam", sceneName: "art.scnassets/GagnamFixed", animationIdentifier: "GagnamFixed-1")
                loadAnimation(withKey: "hh1", sceneName: "art.scnassets/HH1Fixed", animationIdentifier: "HH1Fixed-1")
                loadAnimation(withKey: "hhDancing", sceneName: "art.scnassets/HHDancingFixed", animationIdentifier: "HHDancingFixed-1")
                loadAnimation(withKey: "houseDance", sceneName: "art.scnassets/HouseDanceFixed", animationIdentifier: "HouseDanceFixed-1")
                loadAnimation(withKey: "NSFC", sceneName: "art.scnassets/NSFloorCFixed", animationIdentifier: "NSFloorCFixed-1")
                loadAnimation(withKey: "NSSC", sceneName: "art.scnassets/NSSpinCFixed", animationIdentifier: "NSSpinCFixed-1")
                loadAnimation(withKey: "silly", sceneName: "art.scnassets/SillyFixed", animationIdentifier: "SillyFixed-1")
                loadAnimation(withKey: "slide", sceneName: "art.scnassets/SlideFixed", animationIdentifier: "SlideFixed-1")
                loadAnimation(withKey: "snake", sceneName: "art.scnassets/SnakeFixed", animationIdentifier: "SnakeFixed-1")
                loadAnimation(withKey: "twerk", sceneName: "art.scnassets/TwerkFixed", animationIdentifier: "TwerkFixed-1")
                loadAnimation(withKey: "twist", sceneName: "art.scnassets/TwistFixed", animationIdentifier: "TwistFixed-1")
                loadAnimation(withKey: "wave", sceneName: "art.scnassets/WaveFixed", animationIdentifier: "WaveFixed-1")
        
        
        }
    func loadAnimation(withKey: String, sceneName:String, animationIdentifier:String) {
          let sceneURL = Bundle.main.url(forResource: sceneName, withExtension: "dae")
          let sceneSource = SCNSceneSource(url: sceneURL!, options: nil)

          if let animationObject = sceneSource?.entryWithIdentifier(animationIdentifier, withClass: CAAnimation.self) {
            // The animation will only play once
            if (withKey == "messedUp") {
                animationObject.repeatCount = 1
            }
            else {
                animationObject.repeatCount = 10
            }
            // To create smooth transitions between animations
            animationObject.fadeInDuration = CGFloat(1)
            animationObject.fadeOutDuration = CGFloat(0.5)

            // Store the animation for later use
            animations[withKey] = animationObject
          }
        }
    func playAnimation(key: String) {
          // Add the animation to start playing it right away
          sceneView.scene.rootNode.addAnimation(animations[key]!, forKey: key)
        currAnimationKey = key
        }
    

        func stopAnimation(key: String) {
          // Stop the animation with a smooth transition
          sceneView.scene.rootNode.removeAnimation(forKey: key, blendOutDuration: CGFloat(0.5))
        }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()

        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        audioPlayer.stop()
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
    func displayStreak () -> String {
        if ((scoreNum != 0) && (streak % 5) == 0) {
            return "Streak! +20"
        }
        return ""
    }
    
    @IBAction func targetTapped(_ sender: Any) {
        let g1 = goal1.superview!.convert(goal1.frame, to: nil)
        let currentRippleLocation = circle.layer.presentation()?.frame
        
        if g1.intersects(currentRippleLocation!) {
            //print("overlaps!")
            scoreNum += 1
            score.text = "\(scoreNum)"
            
            //Haptic Feedback for tap
            let generator = UIImpactFeedbackGenerator(style: .light)
            generator.impactOccurred()
            
            if (scoreNum < 30 && scoreNum > 1) {
                playAnimation(key: easyMoves.randomElement()!)
            }
            if (scoreNum < 90 && scoreNum > 30) {
                playAnimation(key: medMoves.randomElement()!)
            }
            if (scoreNum > 90) {
                playAnimation(key: hardMoves.randomElement()!)
            }
            
            if lastHit == 0 {
                lastHit = 1
                //streakMessage.text = ""
            }
            
            else if lastHit == 1 {
                streak += 1
                if (streak % 5) == 0 {
                    scoreNum += 20
                    score.text = "\(scoreNum)"
                    streakMessage.isHidden = false
                    UIView.animate(withDuration: 5.0, animations: { () -> Void in
                        self.streakMessage.alpha = 0
                        }, completion: { _ in self.streakMessage.isHidden = true; self.streakMessage.alpha = 1
                        })
                    //streakMessage.text = "Streak! +20"
                    //streakMessage.isHidden = false

                }
                //streakMessage.text = ""
            }
            
        }
        
        else {
            lastHit = 0
            streak = 0
            playAnimation(key: "messedUp")
            //streakMessage.text = ""
        }
    }
    
    @IBAction func target2Tapped(_ sender: Any) {
        let g2 = goal2.superview!.convert(goal2.frame, to: nil)
        let currentRippleLocation2 = square.layer.presentation()?.frame
        
        if g2.intersects(currentRippleLocation2!) {
            //print("overlaps!")
            scoreNum += 1
            score.text = "\(scoreNum)"
            
            //Haptic Feedback for tap
            let generator = UIImpactFeedbackGenerator(style: .light)
            generator.impactOccurred()
            
            if lastHit == 0 {
                lastHit = 1
                //streakMessage.text = ""
            }
            else if lastHit == 1 {
                streak += 1
                if (streak % 5) == 0 {
                    scoreNum += 20
                    score.text = "\(scoreNum)"
                    streakMessage.isHidden = false
                    UIView.animate(withDuration: 5.0, animations: { () -> Void in
                        self.streakMessage.alpha = 0
                        }, completion: { _ in self.streakMessage.isHidden = true; self.streakMessage.alpha = 1
                        })
                    //streakMessage.text = "Streak! +20"
                    //streakMessage.isHidden = false

                }
                //streakMessage.text = ""
            }
            
        }
        
        else {
            lastHit = 0
            streak = 0
            playAnimation(key: "messedUp")
            //streakMessage.text = ""
        }
    }
    
    @IBAction func target3Tapped(_ sender: Any) {
        let g3 = goal3.superview!.convert(goal3.frame, to: nil)
        let currentRippleLocation3 = shape3.layer.presentation()?.frame
        
        if g3.intersects(currentRippleLocation3!) {
            //print("overlaps!")
            scoreNum += 1
            score.text = "\(scoreNum)"
            
            //Haptic Feedback for tap
            let generator = UIImpactFeedbackGenerator(style: .light)
            generator.impactOccurred()
            
            if lastHit == 0 {
                lastHit = 1
                //streakMessage.text = ""
            }
            else if lastHit == 1 {
                streak += 1
                if (streak % 5) == 0 {
                    scoreNum += 20
                    score.text = "\(scoreNum)"
                    streakMessage.isHidden = false
                    UIView.animate(withDuration: 5.0, animations: { () -> Void in
                        self.streakMessage.alpha = 0
                        }, completion: { _ in self.streakMessage.isHidden = true; self.streakMessage.alpha = 1
                        })
                    //streakMessage.text = "Streak! +20"
                    //streakMessage.isHidden = false

                }
                //streakMessage.text = ""
            }
            
        }
        
        else {
            lastHit = 0
            streak = 0
            //streakMessage.text = ""
        }
    }
    
    @IBAction func target4Tapped(_ sender: Any) {
        let g4 = goal4.superview!.convert(goal4.frame, to: nil)
        let currentRippleLocation4 = triangle.layer.presentation()?.frame
        
        if g4.intersects(currentRippleLocation4!) {
            //print("overlaps!")
            scoreNum += 1
            score.text = "\(scoreNum)"
            
            //Haptic Feedback for tap
            let generator = UIImpactFeedbackGenerator(style: .light)
            generator.impactOccurred()
            
            if lastHit == 0 {
                lastHit = 1
                //streakMessage.text = ""
            }
            else if lastHit == 1 {
                streak += 1
                if (streak % 5) == 0 {
                    scoreNum += 20
                    score.text = "\(scoreNum)"
                    streakMessage.isHidden = false
                    UIView.animate(withDuration: 5.0, animations: { () -> Void in
                        self.streakMessage.alpha = 0
                        }, completion: { _ in self.streakMessage.isHidden = true; self.streakMessage.alpha = 1
                        })
                    //streakMessage.text = "Streak! +20"
                    //streakMessage.isHidden = false

                }
                //streakMessage.text = ""
            }
            
        }
        
        else {
            lastHit = 0
            streak = 0
            playAnimation(key: "messedUp")
            //streakMessage.text = ""
        }
    }
    
    func resetImage(x: String) {
        if countdown <= 0 {
            circle.layer.removeAllAnimations()
            square.layer.removeAllAnimations()
            shape3.layer.removeAllAnimations()
            triangle.layer.removeAllAnimations()
        }
        else {
        if (x == "one") {
        UIImageView.animate(withDuration: 0.01, delay: 0.0, options: UIView.AnimationOptions.curveLinear, animations: {
            self.circle.frame.origin.y = CGFloat(self.initialheight)
            self.circle.alpha = 1
        }, completion: {(finished: Bool) in self.continueGame(num: "one")});
        }
        if (x == "two") {
        UIImageView.animate(withDuration: 0.01, delay: 0.0, options: UIView.AnimationOptions.curveLinear, animations: {
            self.square.frame.origin.y = CGFloat(self.initialheight)
            self.square.alpha = 1
        }, completion: {(finished: Bool) in self.continueGame(num: "two")});
        }
        if (x == "three") {
        UIImageView.animate(withDuration: 0.01, delay: 0.0, options: UIView.AnimationOptions.curveLinear, animations: {
            self.shape3.frame.origin.y = CGFloat(self.initialheight)
            self.shape3.alpha = 1
        }, completion: {(finished: Bool) in self.continueGame(num: "three")});
        }
        if (x == "four") {
        UIImageView.animate(withDuration: 0.01, delay: 0.0, options: UIView.AnimationOptions.curveLinear, animations: {
            self.triangle.frame.origin.y = CGFloat(self.initialheight)
            self.triangle.alpha = 1
        }, completion: {(finished: Bool) in self.continueGame(num: "four")});
        }
        }
        
    }
    
    func continueGame(num: String) {
//        if start.frame.intersects(circle.frame) {
//            print("overlaps!1")
//        }
        if countdown <= 0 {
            circle.layer.removeAllAnimations()
            square.layer.removeAllAnimations()
            shape3.layer.removeAllAnimations()
            triangle.layer.removeAllAnimations()
        }
        else {
        if (num == "one") {
        UIImageView.animate(withDuration: TimeInterval(10 - difficulty), delay: TimeInterval(Int.random(in: 0...5)), animations: {
            self.circle.frame.origin.y += self.view.frame.height
        },completion: {(finished: Bool) in self.resetImage(x: "one")})
        }
        if (num == "two") {
        UIImageView.animate(withDuration: TimeInterval(10 - difficulty), delay: TimeInterval(Int.random(in: 0...5)), animations: {
            self.square.frame.origin.y += self.view.frame.height
        },completion: {(finished: Bool) in self.resetImage(x: "two")})
        }
        if (num == "three") {
        UIImageView.animate(withDuration: TimeInterval(10 - difficulty), delay: TimeInterval(Int.random(in: 0...5)), animations: {
            self.shape3.frame.origin.y += self.view.frame.height
        },completion: {(finished: Bool) in self.resetImage(x: "three")})
        }
        if (num == "four") {
        UIImageView.animate(withDuration: TimeInterval(10 - difficulty), delay: TimeInterval(Int.random(in: 0...5)), animations: {
            self.triangle.frame.origin.y += self.view.frame.height
        },completion: {(finished: Bool) in self.resetImage(x: "four")})
        }
        }

    }
    
    
    @IBAction func startTapped(_ sender: Any) {
        
        initialheight = Int(self.circle.frame.origin.y)
        
        startButton.isHidden = true
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
        //Play song
        guard let path = NSDataAsset(name: titles)?.data else{
            fatalError("unable to find asset")
        }
        do{
            audioPlayer = try AVAudioPlayer(data: path)
            audioPlayer.play()
        }
        catch{
            print(error)
        }
        let defaults = UserDefaults.standard
        if ((defaults.integer(forKey: "currentDancer")) == 1) {
            playAnimation(key: "Groove2")
        }
        else{
        playAnimation(key: "silly")
        }
        
        UIImageView.animate(withDuration: TimeInterval(10 - difficulty), delay: TimeInterval(Int.random(in: 0...5)), animations: {
            self.circle.frame.origin.y += self.view.frame.height
        },completion: {(finished: Bool) in self.resetImage(x: "one")})

        UIImageView.animate(withDuration: TimeInterval(10 - difficulty), delay: TimeInterval(Int.random(in: 0...5)), animations: {
            self.square.frame.origin.y += self.view.frame.height
        },completion: {(finished: Bool) in self.resetImage(x: "two")})
        
        UIImageView.animate(withDuration: TimeInterval(10 - difficulty), delay: TimeInterval(Int.random(in: 0...5)), animations: {
            self.shape3.frame.origin.y += self.view.frame.height
        },completion: {(finished: Bool) in self.resetImage(x: "three")})

        UIImageView.animate(withDuration: TimeInterval(10 - difficulty), delay: TimeInterval(Int.random(in: 0...5)), animations: {
            self.triangle.frame.origin.y += self.view.frame.height
        },completion: {(finished: Bool) in self.resetImage(x: "four")})
       

    }


    // MARK: - ARSCNViewDelegate
    
/*
    // Override to create and configure nodes for anchors added to the view's session.
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        let node = SCNNode()
     
        return node
    }
*/
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        
    }
}
