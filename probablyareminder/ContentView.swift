//
//  ContentView.swift
//  probablyareminder
//
//  Created by GaetanoMiranda on 22/02/23.
//

import SwiftUI

struct ContentView: View {
    
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: [
        SortDescriptor(\.lastTimeDone),
        SortDescriptor(\.name)
    ]) var activities:FetchedResults<Activity>
    @State private var showingAddScreen = false
    
    var body: some View {
        
        NavigationStack{
            Divider()
            ZStack {
                Color(.systemGray6)
                VStack {
                   
                    ScrollView(){
                        
                       
                        ForEach(activities) { activity in
                            CardView(activity: activity)
                            
                        }
                    }
                }
                
                

     .toolbar {
                   
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            showingAddScreen.toggle()
                        } label: {
                                Label("Options", systemImage: "plus")
                        }
                    }

                }
                .sheet(isPresented: $showingAddScreen){
                    AddActivityView()
                }
                
            .navigationTitle("Today")
            }
            
        }
    }
    
    func deleteActivity(at offsets: IndexSet) {
        for offset in offsets {
            let activity = activities[offset]
            moc.delete(activity)
        }
        
        try? moc.save()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
