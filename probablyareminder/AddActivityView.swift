//
//  AddActivityView.swift
//  probablyareminder
//
//  Created by GaetanoMiranda on 22/02/23.
//
import CoreNFC
import SwiftUI

struct AddActivityView: View {
    
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    
    @State private var name = ""
    @State private var description = ""
    @State private var frequency = 1
    @State private var lastTimeDone = Date.now
    var sessionWrite = NFCSessionWrite()
    private var icons = ["drop.fill","trash.fill","lightbulb.fill"]
    let tagID = "probablyareminder://home" + UUID().uuidString
   // let tagID = "https://probablyareminder://\(UUID().uuidString)"
   // let url = URL(string: "https://probablyareminder.example.com/\(UUID().uuidString)")
    
    var body: some View {

        
        NavigationView {
            
            Form {
                Section {
                    TextField("Name", text: $name)
                }
                Section {
                    TextEditor(text: $description)
                } header: {
                    Text("Description")
                }
                
                Picker("Frequency", selection: $frequency) {
                    ForEach(1..<100) {
                        Text("every \($0) days")
                    }
                }
                
                DatePicker("Last time done", selection: $lastTimeDone)
                
                Button {
                    
                    self.sessionWrite.beginScanning(message: self.tagID)
                    
                } label: {
                    Text("Pair NFC Tag")
                }
            }
        
            
            .navigationBarItems(trailing:
                                Button (action: {
             let newActivity = Activity(context: moc)
                newActivity.id = UUID(uuidString: tagID)
                newActivity.name = name
                newActivity.descritpion = description
                newActivity.lastTimeDone = lastTimeDone
                newActivity.icon = icons.randomElement()
                
                
                
                try? moc.save()
                dismiss()
                
                                }) {
                                    Text("Done")
                                }
                            )
            .navigationBarItems(leading:
                                Button (action: {
             
                                }) {
                                    Text("Cancel")
                                }
                            )
        }.navigationTitle("Add new Activity")
    }
    
}

struct AddActivityView_Previews: PreviewProvider {
    static var previews: some View {
        AddActivityView()
    }
}
