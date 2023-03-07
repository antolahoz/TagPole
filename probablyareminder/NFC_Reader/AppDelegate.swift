//
//  AppDelegate.swift
//  probablyareminder
//
//  Created by Antonio Lahoz on 26/02/23.
//



import UIKit
import CoreNFC


enum OpeningMode {
    case card(Int)
    case normal
}

class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    static private(set) var shared: AppDelegate!
    
    var openingURL: String?
    
    func application(_ application: UIApplication,
                     continue userActivity: NSUserActivity,
                     restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
        
        // You handle the user activity created by the NFC background tag reading feature.
        guard userActivity.activityType == NSUserActivityTypeBrowsingWeb else {
            return false
        }
        
        // Confirm that the NSUserActivity object contains a valid NDEF message.
        let ndefMessage = userActivity.ndefMessagePayload
        guard !ndefMessage.records.isEmpty,
            ndefMessage.records[0].typeNameFormat != .empty else {
                return false
        }
        
        
        guard let nfcbutton = window?.rootViewController as? NFCSessionRead else {
            fatalError("")
        }
        
        DispatchQueue.main.async {
            // You send the message to `ScanViewController` for processing.
            _ = nfcbutton.updateWithNDEFMessage(ndefMessage)
        }
        
        return true
    }
     
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        AppDelegate.shared = self
        //Process the URL
        guard let components = NSURLComponents(url: url, resolvingAgainstBaseURL: true),
                let host = components.host else{
            
            print("Invalid URL")
            return false
        }

        print("components: \(components)")
        
        //create the deep link

        guard let deepLink = DeepLink(rawValue: host)
        else{
            
            print("Deep link not found: \(host)")
            return false
        }
        
        //Hand off to ContentView
        
        let contentview = ContentView()
        contentview.handleDeepLink(deepLink)
        
        return true
    }
}


