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
            
            VStack() {
                Text("Upcoming")
                    .font(.title)
                    .padding(.horizontal)
                Divider()
                ScrollView(){
                    
                   
                    
                    ForEach(activities) { activity in
                        CardView(activity: activity)
                        
                    }
                }
                
                Text("Other")
                    .font(.title)
                    .padding(.horizontal)
                Divider()
                
               
                Spacer()
            }
            
//            List {
//                ForEach(activities) { activity in
//                    NavigationLink {
//                        ActivityDetailView()
//                    } label: {
//                        HStack {
//                            Text(activity.name ?? "Unknown Title")
//
//                        }
//                    }
//                }.onDelete(perform: deleteActivity)
//            }.listStyle(.inset)
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
