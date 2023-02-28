//
//  ContentView.swift
//  probablyareminder
//
//  Created by GaetanoMiranda on 22/02/23.
//

import SwiftUI
import UIKit

struct ContentView: View {
    
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: [
        SortDescriptor(\.lastTimeDone),
        SortDescriptor(\.name)
    ]) var activities:FetchedResults<Activity>
    @State private var showingAddScreen = false
    
    var body: some View {
        NavigationStack{
            
            VStack(alignment: .leading) {
                Text("Upcoming")
                    .font(.title)
                    .padding(.horizontal)
                Divider()
                ScrollView(.horizontal){
                    
                   
                    
                    HStack {
                        ForEach(activities) { item in
                            NavigationLink {
                                ActivityDetailView()
                            } label: {
                                VStack {
                                    Text(item.name ?? "unknown name")
                                        .fontWeight(.bold)
                                    Image(systemName: item.icon ?? "bulb.fill")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 50, height: 50)
                                    HStack {
                                        Text("time left")
                                            .font(.caption)
                                            .padding()
                                       
                                        Text("00.00.00")
                                            .font(.caption)
                                            .padding()
                                        
                                    }
                                    
                                    
                                }
                                .frame(width: 160, height: 200 )
                                .background(.ultraThickMaterial)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke())
                                .shadow(radius: 5)
                                .padding()
                                
                            }
                        }
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


//MARK: Deep Link

extension ContentView{
    
    func handleDeepLink(_ deepLink: DeepLink){

        
    }
}
