//
//  AppDelegate.swift
//  probablyareminder
//
//  Created by Antonio Lahoz on 26/02/23.
//



import UIKit
import CoreNFC


class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    /*
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
        
        guard let nfcbutton = window?.rootViewController as? nfcButton else {
            fatalError("")
        }
        
        DispatchQueue.main.async {
            // You send the message to `ScanViewController` for processing.
            _ = nfcbutton.updateWithNDEFMessage(ndefMessage)
        }
        
        return true
    }
     */
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        
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
        
        //Hand off to mainViewController
        
        var contentview = ContentView()
        contentview.handleDeepLink(deepLink)
        
        return true
    }
}


