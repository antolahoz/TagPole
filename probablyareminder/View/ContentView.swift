//
//  ContentView.swift
//  probablyareminder
//
//  Created by GaetanoMiranda on 22/02/23.
//


import SwiftUI


struct ContentView: View {
    
    @State var data = ""
    
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: [
        SortDescriptor(\.lastTimeDone),
        SortDescriptor(\.name)
    ]) var activities:FetchedResults<Activity>
    @State private var showingAddScreen = false
    @State private var showingGradientScreen = false
    @EnvironmentObject var snakeColors: SnakeColors
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
                                        .accentColor(snakeColors.selectedColors[2])
                                }
                            }
                            
                            ToolbarItemGroup(placement: .navigationBarLeading) {

                                                       Menu {
                                                             Button(action: {}) {
                                                                Label("Edit activity", systemImage: "slider.horizontal.3")
                                                             }

                                                             Button(action: {showingGradientScreen.toggle()}) {
                                                                Label("Change theme", systemImage: "paintbrush")

                                                             }
                                                       }
                                                    label: {
                                                       Label("Add", systemImage: "ellipsis.circle")
                                                            .accentColor(snakeColors.selectedColors[2])
                                                    }
                                                    }
                            
                        }
                        .sheet(isPresented: $showingAddScreen){
                            AddActivityView()
                        }
                        
                        .sheet(isPresented: $showingGradientScreen){
                            SelectGradientView()
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
