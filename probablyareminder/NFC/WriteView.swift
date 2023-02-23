//
//  WriteView.swift
//  probablyareminder
//
//  Created by GaetanoMiranda on 23/02/23.
//

import SwiftUI

struct WriteView : View {
    
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



struct WriteView_Previews: PreviewProvider {
    static var previews: some View {
        WriteView(isActive: .constant(true) )
    }
}
