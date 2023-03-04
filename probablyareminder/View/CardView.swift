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
    var add = AddActivityView()
    
    
    var body: some View {
        
        VStack(){
            
            HStack {
                VStack(spacing: 0){
                    
 //                   Spacer()
    
                    HStack{
                        
//                        Image(systemName: "washer")
                        
                        Text(activity.selectedCategory ?? "unknown category" )
                    }.padding(.top)
                    
                    Text(activity.name ?? "unknown name")
                        .fontWeight(.semibold)
                        .padding()
                    
                    Text("next in 1 day")
                        .font(.caption)
                    
                Spacer()
                }//VStack
                
                Spacer()
                
                CircularProgressBar()
  //                  .frame(width: 20)
                    .padding(20)
  //                  .padding()
            }
            
            
            if isActive {
                
            }
        }//VStack
        .background(.white)
        .clipShape(CardShape(smallCornerRadius: 17.0, bigCornerRadius: 71.0, offset: 10.0))
        .shadow(color: .myRed, radius: 0, x:-10, y:0)
        .frame(width: 300)
            
          
        
      //  .clipShape(CardShape(smallCornerRadius: 23, bigCornerRadius: 71, offset: 10))
        
        .onTapGesture {
            withAnimation {
                isActive.toggle()
            }
            
        }
        
    }
    }


//struct CardView_Previews: PreviewProvider {
//    static var previews: some View {
//        CardView()
//    }
//}
