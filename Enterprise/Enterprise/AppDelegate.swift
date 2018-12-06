//
//  AppDelegate.swift
//  Enterprise
//
//  Created by admin on 12/10/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit
import CoreData
import GoogleMaps
import GooglePlaces
//import IQKeyboardManagerSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, CLLocationManagerDelegate {

    var window: UIWindow?
    //for location
    var location: CLLocation?
    var latitude: CLLocationDegrees?
    var longitude: CLLocationDegrees?
    let locationManager = CLLocationManager()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        MagicalRecord.setupCoreDataStack()
        if #available(iOS 10.0, *) {
            UINavigationBar.appearance().barTintColor = UIColor(displayP3Red: 1/255, green: 146/255, blue: 85/255, alpha: 1)
        } else {
            // Fallback on earlier versions
        }
        UINavigationBar.appearance().tintColor = UIColor.white
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)

        let loginVC : LoginViewController = storyBoard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        let masterVC : ENMasterViewController = storyBoard.instantiateViewController(withIdentifier: "ENMasterViewController") as! ENMasterViewController
        let EventStatusVC : ENCheckExisitingServiceViewController = storyBoard.instantiateViewController(withIdentifier: "ENCheckExisitingServiceViewController") as! ENCheckExisitingServiceViewController
        //let loginVC : ENCheckExisitingServiceViewController = storyBoard.instantiateViewController(withIdentifier: "ENCheckExisitingServiceViewController") as! ENCheckExisitingServiceViewController
        let navVC : UINavigationController = UINavigationController()
        navVC.setViewControllers([loginVC], animated: false)
        //navVC.setViewControllers([masterVC], animated: false)
        self.window?.rootViewController = navVC
        
        
        
        
        GMSServices.provideAPIKey("AIzaSyAjv2xvxKxP_hbmhq2xBXen7uurxCC4bzI")
        GMSPlacesClient.provideAPIKey("AIzaSyAjv2xvxKxP_hbmhq2xBXen7uurxCC4bzI")
        locationManager.distanceFilter = 50
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.delegate = self
        return true
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        location = locations.last
        
        let camera = GMSCameraPosition.camera(withLatitude: (location?.coordinate.latitude)!, longitude:(location?.coordinate.longitude)!, zoom:14)
        
        
        latitude = (locationManager.location?.coordinate.latitude)!
        longitude = (locationManager.location?.coordinate.longitude)!
        location = CLLocation(latitude: latitude!, longitude: longitude!) //changed!!!
        CLGeocoder().reverseGeocodeLocation(location!, completionHandler: {(placemarks, error) -> Void in
            if error != nil {
                return
            }else if let country = placemarks?.first?.country,
                let city = placemarks?.first?.addressDictionary {
                
                let jsonData = try? JSONSerialization.data(withJSONObject: city, options: [])
                let jsonString = String(data: jsonData!, encoding: .utf8)
                print(jsonString)
                
                
                let srNo        =   placemarks?.first?.name
                let subLocality =   placemarks?.first?.subLocality
                let locality    =   placemarks?.first?.locality
                let postalCode  =   placemarks?.first?.postalCode
                
                print(country)
                //self.serviceLocationTxtfields.text = srNo! + "," + subLocality! + "," + locality! + "," + postalCode!
                //print(self.serviceLocationTxtfields.text)
            }
            else {
            }
        })
        self.locationManager.stopUpdatingLocation()
        
    }
    
    
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status
        {
        case .restricted:
            print("Location access was restricted.")
        case .denied:
            print("User denied access to location.")
            /*
            let alertController = UIAlertController(title: NSLocalizedString("You denied location privacy", comment: ""), message: NSLocalizedString("To enable go to settings and enable it again", comment: ""), preferredStyle: .alert)
            
            let cancelAction = UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: .cancel, handler: nil)
            let settingsAction = UIAlertAction(title: NSLocalizedString("Settings", comment: ""), style: .default, handler: { action in
                if let aString = URL(string: UIApplication.openSettingsURLString) {
                    UIApplication.shared.openURL(aString)
                }
            })
            
            alertController.addAction(cancelAction)
            alertController.addAction(settingsAction)
            
            present(alertController, animated: true)
            */
            
            let alertController = UIAlertController(title: NSLocalizedString("You denied location privacy", comment: ""), message: NSLocalizedString("To enable go to settings and enable it again", comment: ""), preferredStyle: .alert)

            let cancelAction = UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: .cancel, handler: nil)
            let settingsAction = UIAlertAction(title: NSLocalizedString("Settings", comment: ""), style: .default, handler: { action in
                if let aString = URL(string: UIApplication.openSettingsURLString) {
                    UIApplication.shared.openURL(aString)
                }
            })
            alertController.addAction(cancelAction)
            alertController.addAction(settingsAction)

            UIApplication.topViewController()?.present(alertController, animated: true, completion: nil)
            
            
            
            
            
            
            
            
        case .notDetermined:
            print("Location status not determined.")
        case .authorizedAlways: fallthrough
        case .authorizedWhenInUse:
            print("Location status is OK.")
            print("Authorize.")
            break
        }
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        self.saveContext()
    }

    // MARK: - Core Data stack

    @available(iOS 10.0, *)
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "Enterprise")
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

    // iOS 9 and below
    lazy var applicationDocumentsDirectory: URL = {
        
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return urls[urls.count-1]
    }()
    
    lazy var managedObjectModel: NSManagedObjectModel = {
        // The managed object model for the application. This property is not optional. It is a fatal error for the application not to be able to find and load its model.
        let modelURL = Bundle.main.url(forResource: "coreDataTestForPreOS", withExtension: "momd")!
        return NSManagedObjectModel(contentsOf: modelURL)!
    }()
    
    lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
        // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it. This property is optional since there are legitimate error conditions that could cause the creation of the store to fail.
        // Create the coordinator and store
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        let url = self.applicationDocumentsDirectory.appendingPathComponent("SingleViewCoreData.sqlite")
        var failureReason = "There was an error creating or loading the application's saved data."
        do {
            try coordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: url, options: nil)
        } catch {
            // Report any error we got.
            var dict = [String: AnyObject]()
            dict[NSLocalizedDescriptionKey] = "Failed to initialize the application's saved data" as AnyObject?
            dict[NSLocalizedFailureReasonErrorKey] = failureReason as AnyObject?
            
            dict[NSUnderlyingErrorKey] = error as NSError
            let wrappedError = NSError(domain: "YOUR_ERROR_DOMAIN", code: 9999, userInfo: dict)
            // Replace this with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog("Unresolved error \(wrappedError), \(wrappedError.userInfo)")
            abort()
        }
        
        return coordinator
    }()
    
    lazy var managedObjectContext: NSManagedObjectContext = {
        // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.) This property is optional since there are legitimate error conditions that could cause the creation of the context to fail.
        let coordinator = self.persistentStoreCoordinator
        var managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = coordinator
        return managedObjectContext
    }()
    // MARK: - Core Data Saving support

    func saveContext () {
        if #available(iOS 10.0, *) {
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
        else
        {
            // iOS 9.0 and below - however you were previously handling it
            if managedObjectContext.hasChanges {
                do {
                    try managedObjectContext.save()
                } catch {
                    // Replace this implementation with code to handle the error appropriately.
                    // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                    let nserror = error as NSError
                    NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
                    abort()
                }
            }
            
        }
        

}

}

extension UIApplication {
    class func topViewController(controller: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let navigationController = controller as? UINavigationController {
            return topViewController(controller: navigationController.visibleViewController)
        }
        if let tabController = controller as? UITabBarController {
            if let selected = tabController.selectedViewController {
                return topViewController(controller: selected)
            }
        }
        if let presented = controller?.presentedViewController {
            return topViewController(controller: presented)
        }
        return controller
    } }
