//
//  SnakeColors.swift
//  LT_ListOfSuperHeroes
//
//  Created by GaetanoMiranda on 07/03/23.
//

import Foundation
import SwiftUI

class SnakeColors: ObservableObject {
   @Published var selectedColors: [Color] = [.blue, .green]
}
