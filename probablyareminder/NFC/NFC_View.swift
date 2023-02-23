//
//  NFC.swift
//  probablyareminder
//
//  Created by GaetanoMiranda on 23/02/23.

//
//  ContentView.swift
//  MC3
//
//  Created by Antonio Lahoz on 16/02/23.
//

import CoreNFC
import SwiftUI

struct NFCView: View{
    
    @State var data = ""
    @State var showWrite = false
    let holder = "Read message will display here..."
    
    /*
     */
    
    var body: some View{
        
        NavigationStack(){
            
            GeometryReader{ reader in
                
                VStack(spacing: 30){
                    
                    ZStack(alignment: .topLeading){
                        
                        RoundedRectangle(cornerRadius: 20)
                            .foregroundColor(.white)
                            .overlay(RoundedRectangle(cornerRadius: 20)
                                .stroke(Color.gray, lineWidth: 4)
                            )
                        
                        Text(self.data.isEmpty ? self.holder : self.data)
                            .foregroundColor(self.data.isEmpty ? .gray : .black)
                            .padding()
                        
                    }.frame(height: reader.size.height * 0.4)
                    
                    nfcButton(data: self.$data)
                        .frame(height: reader.size.height * 0.07)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                    
                    //Write button
                    
                    NavigationLink(destination: WriteView(isActive: self.$showWrite), isActive: self.$showWrite){
                        
                        Button(action: {
                            
                            self.showWrite.toggle()
                        }){
                            
                            Text("Write NFC")
                                .frame(width: reader.size.width * 0.9, height: reader.size.height * 0.07)
                        }.foregroundColor(.white)
                            .background(Color.black)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                    }
                    
                    Spacer()
                }.frame(width: reader.size.width * 0.9)
                    .navigationBarTitle("NFC App", displayMode: .inline)
                    .padding(.top, 20)
            }
            .padding(.leading, 35.0)
            
        }
    }
}

/*
struct Payload{
    
    var type : RecordType
    var pickerMsg : String
}
*/

/*
struct WriteView : View{
    
    @State var record = ""
    @State private var selection = 0
    
    @Binding var isActive : Bool
    
    var sessionWrite = NFCSessionWrite()
    var recordType = [Payload(type: .text, pickerMsg: "Text"), Payload(type: .url, pickerMsg: "URL")]
    
    var body: some View{
        
        Form{
            
            Section{
                TextField("Message here...", text: self.$record)
            }
            
            Section{
                Picker(selection: self.$selection, label: Text("Pick a record type.")){
                    ForEach(0..<self.recordType.count){
                        
                        Text(self.recordType[$0].pickerMsg)
                    }
                }
            }
            Section{
                
                Button(action: {
                    
                    self.sessionWrite.beginScanning(message: self.record, recordType: self.recordType[selection].type)
                }){
                    Text("Write")
                }
            }
            .navigationBarTitle("NFC Write")
            .navigationBarItems(leading:
                                    Button(action: {
                self.isActive.toggle()
            }){
                /*
                HStack(spacing: 5){
                    
                    Image(systemName: "chevron.left")
                    Text("Back")
                }
                 */
            }
            )
        }
    }
}
 */

struct NFCView_Previews: PreviewProvider {
    
    static var previews: some View{
        
        NFCView()
    }
}
    
    /*
     */
    
    //NFC Write

/*
enum RecordType{
        
    case text, url
}
 */
/*
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
  */
    
    
/*
//NFC Read
    
    struct nfcButton: UIViewRepresentable{
        
        @Binding var data : String
        
        func makeUIView(context: UIViewRepresentableContext<nfcButton>) -> UIButton {
            
            let button = UIButton()
            button.setTitle("Read NFC", for: .normal)
            button.backgroundColor = UIColor.black
            button.addTarget(context.coordinator, action: #selector(context.coordinator.beginScan(_:)), for: .touchUpInside)
            return button
        }
        
        func updateUIView(_ uiView: UIButton, context: UIViewRepresentableContext<nfcButton>) {
            //Do nothing
        }
        
        func makeCoordinator() -> nfcButton.Coordinator {
            return Coordinator(data: $data)
        }
        
        
        class Coordinator : NSObject, NFCNDEFReaderSessionDelegate{
            
            var session : NFCNDEFReaderSession?
            @Binding var data : String
            
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
                
                print(payload)
                self.data = payload
            }
            
            
            
        }//class coordinator
    }//nfcButton

*/
