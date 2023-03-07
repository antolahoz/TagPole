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
    
    @State private var showingAddScreen2 = false
    
    //    @StateObject var nfcController = NFCSessionRead()

    var body: some View {
        
        NavigationStack{
                    
 //           Divider()
            ZStack {
                Color(.systemGray6)
                    .ignoresSafeArea()
              //  VStack {
                   
                    ScrollView(){
                        
                       
                        ForEach(activities) { activity in
                            CardView(activity: activity)
                        }
                        
                    }
                //}
                
                

     .toolbar {
                   
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            showingAddScreen.toggle()
                        } label: {
                                Label("Options", systemImage: "plus")
                        }
                    }
         
         ToolbarItem(placement: .navigationBarLeading) {
             Button {
                 showingAddScreen2.toggle()
             } label: {
                     Label("Options", systemImage: "gear")
             }
         }
         
         

                }
                .sheet(isPresented: $showingAddScreen2){
                    SelectGradientView()
                }
                .sheet(isPresented: $showingAddScreen){
                    AddActivityView()
                }
            }
            .navigationTitle("Today")
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

//MARK: Deep Link

extension ContentView{
    
    func handleDeepLink(_ deepLink: DeepLink){

        
    }
}
