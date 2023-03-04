//
//  nfcButton.swift
//  probablyareminder
//
//  Created by GaetanoMiranda on 23/02/23.
//

import SwiftUI
import CoreNFC
import os

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
    
    
    class Coordinator : NSObject, NFCNDEFReaderSessionDelegate, ObservableObject{
        
        var session : NFCNDEFReaderSession?
        @Binding var data : String
        @Published var cron = Cronometro()
        
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
            
//            cron.restartTimer()
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
