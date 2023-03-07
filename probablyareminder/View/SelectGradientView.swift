//
//  SwiftUIView.swift
//  LT_ListOfSuperHeroes
//
//  Created by GaetanoMiranda on 06/03/23.
//

import SwiftUI



struct MyColors: Identifiable {
    var id = UUID()
    var colors: [Color]
}



var gradienti: [MyColors] = [
    MyColors(colors: [.myPink, .myViolet, .myPurple]),
    MyColors(colors: [.myGreenLow, .myGreenMid, .myGreenHigh]),
    MyColors(colors: [.myBlueSky, .myBlueMid, .myBlue]),
    MyColors(colors: [.myYellow, .myOrange, .myRed])
]




struct SelectGradientView: View {
    
    @EnvironmentObject var snakeColors: SnakeColors
    @State private var selectedGradient = 1
    var body: some View {
        
        VStack {
            Text("select gradient")
                .font(.largeTitle)
            HStack{
                ForEach(0..<gradienti.count) {number in
                    Circle()
                        .strokeBorder(selectedGradient == number ? .blue : .white, lineWidth: 5)
                        .background(Circle().fill(LinearGradient(colors: gradienti[number].colors, startPoint: .topLeading, endPoint: .bottomTrailing)))
                        //.fill(gradienti[number].gradient)
                        .onTapGesture {
                            selectedGradient = number
                        }
                        
                    
                }
                .padding()
            }
            
            Button {
                snakeColors.selectedColors = gradienti[selectedGradient].colors
                print("ho premuto")
            } label: {
                Text("Done")
                    
            }
        }
    }
}

struct SelectGradientView_Previews: PreviewProvider {
    static var previews: some View {
        SelectGradientView()
    }
}
