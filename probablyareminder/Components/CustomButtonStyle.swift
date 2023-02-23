//
//  CustomButtonStyle.swift
//  probablyareminder
//
//  Created by GaetanoMiranda on 23/02/23.
//

import SwiftUI

struct CustomButtonStyle: ButtonStyle {
    
    func makeBody(configuration: Configuration) -> some View {
        EmptyView()
    }
    
}

struct CustomButtonStyle_Previews: PreviewProvider {
    static var previews: some View {
        Button("prova") {}
            .buttonStyle(CustomButtonStyle())
    }
}
