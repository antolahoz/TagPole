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
    
    
    var body: some View {
        
        VStack(alignment: .leading){
            
            HStack {
                VStack(alignment: .leading){
                    

    
                    HStack{
                        
                        Image(systemName: "washer")
                        
                        Text(activity.selectedCategory ?? "unknown category")
                    } .font(.callout)
                    
                    Text(activity.name ?? "unknown name")
                        .font(.title)

                    
                    Text("Upcoming")
                        .padding(.horizontal)
                        .background(.yellow)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .foregroundColor(.white)
                    
                }//VStack
                .padding(.horizontal)
                
                Spacer()
                
                CircularProgressBar()
                    .padding()

            }
            
            
            if isActive {
                HStack {
                    VStack (alignment: .leading){
                        Text("NFC Tag: **ON**")
                        Text("Repeat in **3 days**")
                        Text("Repeeat when **at home**")
                    }
                    .padding()
                    
                    Spacer()
                    Button {
                        
                    } label: {
                        Text("Done now")
                            .padding()
                            .background(.blue)
                            .clipShape(Capsule())
                            .foregroundColor(.white)
                        
                    }
                    .padding()
                }
            }
        }
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 18))
        .shadow(color: .red, radius: 0, x:-10, y:0)
        .padding(.horizontal, 30)
            
          
        
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
