//
//  AppDelegate.swift
//  DDAR1
//
//  Created by Huda Aldadah on 3/31/21.
//  Edited by Neel Gajjar 4/9/21.

import UIKit
import CoreData
import UserNotifications
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {

    var window: UIWindow?

//comment for commit.
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        FirebaseApp.configure()
        let center = UNUserNotificationCenter.current()
        center.delegate = self
        let options: UNAuthorizationOptions = [.alert, .badge, .sound]
        // request user authorization for notifications
        center.requestAuthorization(options: options) { (granted, error) in
            if granted {
                print("Permission Granted")
                DispatchQueue.main.async() {
                    application.registerForRemoteNotifications()
                }
                self.setUpNotification()
            }
        }
        
        let defaults = UserDefaults.standard
        let hasLaunchedBefore = defaults.bool(forKey: "hasLaunchedBefore")
        //defaults.set(0, forKey: "currentDancer")
        //let hasLaunchedBefore = false
        let songs: [String] = ["Heartbreak Anniversary", "WAP", "Montero", "Chicken Dance", "What's Next", "Latch"]
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        if !hasLaunchedBefore{
            defaults.set(true, forKey: "hasLaunchedBefore")
            defaults.set(true, forKey: "dancerOneUnlocked")
            defaults.set(false, forKey: "dancerTwoUnlocked")
            defaults.set(false, forKey: "dancerThreeUnlocked")
            defaults.set(0, forKey: "currentDanceDollars")
            defaults.set(0, forKey: "currentDancer")
            for song in songs{
                let entity = NSEntityDescription.entity(forEntityName: "HighScores", in: context)
                let newRecord = NSManagedObject(entity: entity!, insertInto: context)
                newRecord.setValue(song, forKey: "song")
                newRecord.setValue(0, forKey: "highScore")
                newRecord.setValue("Hip Hop", forKey: "genre")
            }
        }
        do{
            try context.save()
        }catch {
            print("Error - CoreData failed reading")
        }

        
        return true
    }
    
    func setUpNotification() {
        // create the notification content attributes
        let content = UNMutableNotificationContent()
        content.title = "AR Just Dance"
        content.body = "Play your favorite tunes in AR with a wide assortment of dancing characters!"
        content.categoryIdentifier = "myUniqueCategory"
        
           
        let timeTrigger = UNTimeIntervalNotificationTrigger(timeInterval: 15.0, repeats: false) // timeInterval seconds from now

        let notificationAction = UNNotificationAction(identifier: "remindLater", title: "Remind me to play later!", options: [])
        let myCategory = UNNotificationCategory(identifier: "myUniqueCategory", actions: [notificationAction], intentIdentifiers: [], options: [])
        
        UNUserNotificationCenter.current().setNotificationCategories([myCategory])
        
        // Creating request
        let request = UNNotificationRequest(identifier: "myUniqueIdentifierString1234",
                    content: content, trigger: timeTrigger)
        
        // Add the request to the main Notification center.
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.add(request) { (error) in
           if error != nil {
                print("Notification not created")
           } else {
                print("Notification created")
            }
        }
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        let content = notification.request.content
        // Process notification content
        print("Received Notification with \(content.title) -  \(content.body)")
        completionHandler([.badge, .sound]) // Display notification as regular alert and play sound
    }
    
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        let actionIdentifier = response.actionIdentifier

        switch actionIdentifier {
        case UNNotificationDismissActionIdentifier: // Notification dismissed by user
            completionHandler()
        case UNNotificationDefaultActionIdentifier: // App opened from notification
            completionHandler()
        case "remindLater":
            do {
                self.setUpNotification()
                completionHandler()
            }
        default:
            completionHandler()
        }
    }
    
    
    
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "DDAR1")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}

