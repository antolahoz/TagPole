//
//  DataController.swift
//  probablyareminder
//
//  Created by GaetanoMiranda on 22/02/23.
//

import CoreData
import Foundation

class DataController: ObservableObject {
     let container = NSPersistentContainer(name: "Activities")
    
    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("core data failed to load: \(error.localizedDescription ) ")
            }
            
        }
    }
}

