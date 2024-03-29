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
    @EnvironmentObject var cron : Cronometro
    @EnvironmentObject var snakeColors: SnakeColors

    
    var body: some View {
        
        VStack(alignment: .leading){
            
            HStack {
                VStack(alignment: .leading){
                    

    
                    HStack(alignment: .firstTextBaseline){
                        
                        Image(systemName: "washer")
                            .font(.system(size: 22))
                        
                        Text(activity.selectedCategory ?? "unknown category")
                            .font(.subheadline)
                    }
                    
                    Text(activity.name ?? "unknown name")
                        .font(.title3)

                    
                    Text("Upcoming")
                        .padding(.horizontal)
                        .background(snakeColors.selectedColors[1])
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .foregroundColor(.white)
                    
                }//VStack
                .padding(.horizontal, 25)
                .padding(.vertical, 41)
                
                Spacer()
                
                CircularProgressBar()
                    .padding(25)
                

            }
            
            
            if isActive {
                HStack {
                    VStack (alignment: .leading){
                        Text("Done **1 days ago**")
                        Text("NFC Tag: **ON**")
                        Text("Repeat in **3 days**")
                        Text("Repeat when **at home**")
                    }
                    .padding(.horizontal, 30)
                    .padding(.bottom, 30)
                    
                    Spacer()
                 
                }
            }
        }
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 18))
       // .shadow(color: .red, radius: 0, x:-10, y:0)
        .shadow(color: Color(.black).opacity(0.10), radius: 15, x: 2, y: 2)
        .padding(.horizontal, 30)
        .padding(.vertical, 10)
        
        
        
          
        
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
