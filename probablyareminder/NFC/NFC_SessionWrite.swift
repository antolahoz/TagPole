//
//  NFCSessionWrite.swift
//  probablyareminder
//
//  Created by GaetanoMiranda on 23/02/23.
//

import SwiftUI
import CoreNFC

class NFCSessionWrite : NSObject, NFCNDEFReaderSessionDelegate{
    
    var session : NFCNDEFReaderSession?
    var message = ""
    var recordType : RecordType = .text
    
    
    func beginScanning(message: String, recordType: RecordType){
        
        guard NFCNDEFReaderSession.readingAvailable else {
            
            print("Scanning not support for this device")
            return
        }
        self.message = message
        self.recordType = recordType
        
        session = NFCNDEFReaderSession(delegate: self, queue: .main, invalidateAfterFirstRead: false)
        session?.alertMessage = "Hold your iphone near a NFC"
        session?.begin()
    }
    
    
    func readerSession(_ session: NFCNDEFReaderSession, didInvalidateWithError error: Error) {
        
    }
    
    func readerSession(_ session: NFCNDEFReaderSession, didDetectNDEFs messages: [NFCNDEFMessage]) {
        
    }
    
    func readerSessionDidBecomeActive(_ session: NFCNDEFReaderSession) {
        
    }
    
    func readerSession(_ session: NFCNDEFReaderSession, didDetect tags: [NFCNDEFTag]) {
        
        if tags.count>1 {
            
            let retryInterval = DispatchTimeInterval.milliseconds(2000)
            session.alertMessage = "More than one tag detected. Please, try again"
            DispatchQueue.global().asyncAfter(deadline: .now() + retryInterval) {
                session.restartPolling()
            }
            return
        }
        
        let tag = tags.first!
        print("Got first tag!")
        session.connect(to: tag){ (error) in
            
            if error != nil{
                
                session.alertMessage = "Unable to connect to tag."
                session.invalidate()
                print("Error connect")
                return
            }
            
        }
        
        //query tag if no error occur
        tag.queryNDEFStatus{ (ndefStatus, capacity, error) in
            
            if error != nil{
                
                session.alertMessage = "Unable to query the NFC NDEF tag"
                session.invalidate()
                print("Error query tag.")
                return
            }
            
            //processed to query
            switch ndefStatus{
                
            case .notSupported:
                print("Not Support")
                session.alertMessage = "Tag is not NDEF complaint"
                session.invalidate()
            case .readWrite:
                //writing code logic
                print("Read write")
                let payLoad : NFCNDEFPayload?
                
                switch self.recordType{
                    
                case .text:
                    guard !self.message.isEmpty else {
                        
                        session.alertMessage = "Empty Data"
                        session.invalidate(errorMessage: "Empty text data")
                        return
                    }
                    //make our payload
                    payLoad = NFCNDEFPayload(format: .nfcWellKnown, type:
                                                "T".data(using: .utf8)!,
                                             identifier: "Text".data(using: .utf8)!,
                                             payload: self.message.data(using: .utf8)!)
                    
                case .url:
                    //Make sure our URl is actual URL
                    guard let url = URL(string: self.message) else{
                        print("Not a valid URL")
                        session.alertMessage = "Unrecognize URL"
                        session.invalidate(errorMessage: "Data is not a URL")
                        return
                    }
                    //make payload
                    payLoad = NFCNDEFPayload.wellKnownTypeURIPayload(url: url)
                }
                
                //make our message array
                let nfcMessage = NFCNDEFMessage(records: [payLoad!])
                //write to tag
                tag.writeNDEF(nfcMessage) { (error) in
                    
                    if error != nil{
                        
                        session.alertMessage = "Write NDEF fail: \(error!.localizedDescription)"
                        print("fail write: \(error!.localizedDescription)")
                    } else {
                        session.alertMessage = "Write NDEF succesful"
                        print("Succes write.")
                        
                    }
                    session.invalidate()
                }
                
                
            case .readOnly:
                print("Not Support")
                session.alertMessage = "Tag is read only."
                session.invalidate()
            @unknown default:
                print("Unknown error")
                session.alertMessage = "Unknown NDEF tag status"
                session.invalidate()
            }
            
            
        }
    }//func readerSession(_ session: NFCNDEFReaderSession, didDetect tags: [NFCNDEFTag])
    
}
