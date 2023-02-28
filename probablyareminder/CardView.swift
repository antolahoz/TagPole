//
//  CardView.swift
//  LT_ListOfSuperHeroes
//
//  Created by GaetanoMiranda on 25/02/23.
//

import SwiftUI

struct CardView: View {
    
    var activity: Activity
    @State private var isActive = false
    var timeLeft: String = "2 d"
    var timePassed: String = "1 h"
    @State var completionPercentage = 0.9
    
    
    var body: some View {
        
        VStack () {
            HStack {
                Text(activity.name ?? "unknown name")
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                    .font(.title)
                    .padding()
                Spacer()
                Image(systemName: "trash.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50)
                    .padding()
                    .foregroundColor(.white)
                
                
                   
                
            }
            
            HStack (spacing: 0){
                Text(timePassed)
                    .padding()
                ProgressBar(value: $completionPercentage)
                    .frame(height: 20)
                Text(timeLeft)
                    .padding()
            }
            .foregroundColor(.white)
            
            if isActive {
                
                Button {
                    
                    withAnimation {
                        completionPercentage = 0
                    }
                    print(completionPercentage)
                    print("ssssssss")
                } label: {
                    Text("set as done")
                        .padding()
                        .background(.white)
                    .clipShape(Capsule())
                    .foregroundColor(.blue)
                        .padding()
                }
                
                
                
                
            }
           
        
                
        }
        .frame(width: 300)
        .background(.blue)
        .clipShape(RoundedRectangle(cornerRadius: 19))
        .onTapGesture {
            withAnimation {
                isActive.toggle()
            }
            
        }
        
    }
    }

//
//struct CardView_Previews: PreviewProvider {
//    static var previews: some View {
//        CardView()
//    }
//}
