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
    
    
    
    var progress: Float {
        get {
            calculateProgress(lastTimeDone: activity.lastTimeDone ?? Date.now, frequency: Int(activity.frequency))
        }
    }

    
    var body: some View {
        
        VStack(alignment: .leading){
            
            HStack {
                VStack(alignment: .leading){
                    

    
                    HStack(alignment: .firstTextBaseline){
                        
                        Image(systemName: iconsDictionary[activity.selectedCategory ?? "gear"] ?? "gear")
                            .font(.system(size: 22))
                        
                        Text(activity.selectedCategory ?? "unknown category")
                            .font(.subheadline)
                    }
                    
                    Text(activity.name ?? "unknown name")
                        .font(.title2)
                      
                    
// expired, upcoming, just done.
                    
                    Text(progress >= 1 ? "expired" : (progress > 0.5 ? "upcoming" :"just done"))
                        .font(.subheadline)
                        .fontWeight(.medium)
//                        .font(.system(size:11))
                        .padding(.horizontal, 10)
                     //   .padding(.vertical, 1)
                        .background(progress >= 1 ? snakeColors.selectedColors[2] : (progress > 0.5 ? snakeColors.selectedColors[1] :snakeColors.selectedColors[0]))
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .foregroundColor(.white)
                    
                }//VStack
                .padding(.horizontal, 25)
              //  .padding(.vertical, 41)
                
                Spacer()
                
                CircularProgressBar(lastTimeDone: activity.lastTimeDone ?? Date.now, frequency: Int(activity.frequency))
                    .padding(25)
                

            }
            
            
            if isActive {
                HStack {
                    VStack (alignment: .leading){
                        
                        
                        
                        Text("Done **1 days ago**")
                        Text("NFC Tag: **Paired**")
                        Text("Repeat every **\(activity.frequency)** days")
                        Text("Notify when **at home**")
                    }
                    .padding(.horizontal, 30)
                    .padding(.bottom, 30)
                    
                    Spacer()
                 
                }
            }
        }
        .background(Color("CardBackground"))
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
