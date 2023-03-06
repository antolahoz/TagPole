//
//  nfcButton.swift
//  probablyareminder
//
//  Created by GaetanoMiranda on 23/02/23.
//

import SwiftUI
import CoreNFC
import os
import Foundation


//NFC Read

struct NFCSessionRead: UIViewRepresentable{
    
    // MARK: - Properties

    @Binding var data : String
    
    
    // MARK: - Actions
    
    
    func makeUIView(context: UIViewRepresentableContext<NFCSessionRead>) -> UIButton {
        
        
        let button = UIButton()
        button.setTitle("Read NFC", for: .normal)
        button.backgroundColor = UIColor.black
        button.addTarget(context.coordinator, action: #selector(context.coordinator.beginScan(_:)), for: .touchUpInside)
         
        return button
         
    }
    
    func updateUIView(_ uiView: UIButton, context: UIViewRepresentableContext<NFCSessionRead>) {
        //Do nothing
    }
    
    func makeCoordinator() -> NFCSessionRead.Coordinator {
        return Coordinator(data: $data)
    }
    
    func updateWithNDEFMessage(_ message: NFCNDEFMessage) -> Bool {
        // UI elements are updated based on the received NDEF message.
        let urls: [URLComponents] = message.records.compactMap { (payload: NFCNDEFPayload) -> URLComponents? in
            // Search for URL record with matching domain host and scheme.
            if let url = payload.wellKnownTypeURIPayload() {
                let components = URLComponents(url: url, resolvingAgainstBaseURL: false)
                if components?.host == "probablyareminder.example.com" && components?.scheme == "https" {
                    return components
                }
            }
            return nil
        }
        
        // Valid tag should only contain 1 URL and contain multiple query items.
        guard urls.count == 1,
            let items = urls.first?.queryItems else {
            return false
        }
        
        // Get the optional info text from the text payload.
        var additionInfo: String? = nil

        for payload in message.records {
            (additionInfo, _) = payload.wellKnownTypeTextPayload()
            
            if additionInfo != nil {
                break
            }
        }
        
        DispatchQueue.main.async {
            
        }
        
        return true
    }
    
    class Coordinator : NSObject, NFCNDEFReaderSessionDelegate, ObservableObject{
        
        var session : NFCNDEFReaderSession?
        @Binding var data : String
        @ObservedObject var cron = Cronometro()
        
        init(data: Binding<String>) {
            
            _data = data
        }
        
        @objc func beginScan(_ sender: Any){
            
            guard NFCNDEFReaderSession.readingAvailable else{
                
                print("error: Scanning not support")
                
                return
            }
            
            session = NFCNDEFReaderSession(delegate: self, queue: .main, invalidateAfterFirstRead: true)
            session?.alertMessage = "Hold your iphone near to scan."
            session?.begin()
            
        }
        
        
        func readerSession(_ session: NFCNDEFReaderSession, didInvalidateWithError error: Error) {
            
            if let readerError = error as? NFCReaderError{
                
                if (readerError.code != .readerSessionInvalidationErrorFirstNDEFTagRead)
                    &&
                    (readerError.code != .readerSessionInvalidationErrorUserCanceled){
                    
                    print("error nfc reader: \(readerError.localizedDescription)")
                }
            }
            
            self.session = nil
        }
        
        func readerSession(_ session: NFCNDEFReaderSession, didDetectNDEFs messages: [NFCNDEFMessage]) {
            guard
                
                let nfcMess = messages.first,
                let record = nfcMess.records.first,
                record.typeNameFormat == .absoluteURI || record.typeNameFormat == .nfcWellKnown,
                let payload = String(data: record.payload, encoding: .utf8)
                
                
                    
            else{
                
                
                return
            }
            
            cron.timerIsPaused = false
//            cron.startTimer()
            print(payload)
            self.data = payload
            
            
        }
        
        
        
    }//class coordinator
}//nfcButton



/*

//SwiftUI

class NFCSessionRead : NSObject, NFCNDEFReaderSessionDelegate, ObservableObject{
    
    var session : NFCNDEFReaderSession?
//    @Binding var data : String
    @Published var cron = Cronometro()
    
    override init() {
        
    }
    
//    init(data: Binding<String>) {
//
//        _data = data
//    }
    
    @objc func beginScan(_ sender: Any){
        
        guard NFCNDEFReaderSession.readingAvailable else{
            
            print("error: Scanning not support")
            
            return
        }
        
        session = NFCNDEFReaderSession(delegate: self, queue: .main, invalidateAfterFirstRead: true)
        session?.alertMessage = "Hold your iphone near to scan."
        session?.begin()
        
    }
    
    
    func readerSession(_ session: NFCNDEFReaderSession, didInvalidateWithError error: Error) {
        
        if let readerError = error as? NFCReaderError{
            
            if (readerError.code != .readerSessionInvalidationErrorFirstNDEFTagRead)
                &&
                (readerError.code != .readerSessionInvalidationErrorUserCanceled){
                
                print("error nfc reader: \(readerError.localizedDescription)")
            }
        }
        
        self.session = nil
    }
    
    func readerSession(_ session: NFCNDEFReaderSession, didDetectNDEFs messages: [NFCNDEFMessage]) {
        guard
            
            let nfcMess = messages.first,
            let record = nfcMess.records.first,
            record.typeNameFormat == .absoluteURI || record.typeNameFormat == .nfcWellKnown,
            let payload = String(data: record.payload, encoding: .utf8)
                
        else{
            
            return
        }
        
//            cron.restartTimer()
//        cron.startTimer()
        print(payload)
//        self.data = payload
        
        
    }
    
}
*/


/*
See LICENSE folder for this sample’s licensing information.

Abstract:
The view controller that scans and displays NDEF messages.
*/

/*

import UIKit
import CoreNFC

/// - Tag: ndefReading_1
class MessagesTableViewController: UITableViewController, NFCNDEFReaderSessionDelegate {
    // MARK: - Properties

    let reuseIdentifier = "reuseIdentifier"
    var detectedMessages = [NFCNDEFMessage]()
    var session: NFCNDEFReaderSession?

    // MARK: - Actions
    
    /// - Tag: beginScanning
    @IBAction func beginScanning(_ sender: Any) {
        session = NFCNDEFReaderSession(delegate: self, queue: nil, invalidateAfterFirstRead: true)
        session?.begin()
    }

    // MARK: - NFCNDEFReaderSessionDelegate

    func readerSession(_ session: NFCNDEFReaderSession, didDetectNDEFs messages: [NFCNDEFMessage]) {
        // Process detected NFCNDEFMessage objects
        detectedMessages.append(contentsOf: messages)
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        print("forza")
    }

    func readerSession(_ session: NFCNDEFReaderSession, didInvalidateWithError error: Error) {
        // Check invalidation reason from the returned error. A new session instance is required to read new tags.
        if let readerError = error as? NFCReaderError {
            // Show alert dialog box when the invalidation reason is not because of a read success from the single tag read mode,
            // or user cancelled a multi-tag read mode session from the UI or programmatically using the invalidate method call.
            if (readerError.code != .readerSessionInvalidationErrorFirstNDEFTagRead)
                && (readerError.code != .readerSessionInvalidationErrorUserCanceled) {
                let alertController = UIAlertController(title: "Session Invalidated", message: error.localizedDescription, preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                DispatchQueue.main.async {
                    self.present(alertController, animated: true, completion: nil)
                }
            }
        }
    }
}
*/
