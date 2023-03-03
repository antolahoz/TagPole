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
                    .font(.headline)
                    .padding()
                Spacer()
                CircularProgressBar()
                    .frame(width: 20)
                    .padding()
                Spacer()
            }
            
            
            if isActive {
                
                
            }
            
           
        
                
        }
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

//
//struct CardView_Previews: PreviewProvider {
//    static var previews: some View {
//        CardView()
//    }
//}

