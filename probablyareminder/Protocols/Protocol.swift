//
//  Protocol.swift
//  probablyareminder
//
//  Created by Antonio Lahoz on 07/03/23.
//

import Foundation
import UIKit

protocol DeeplinkHandlerProtocol {
    
    func canOpenURL(_ url: URL) -> Bool
    func openURL(_ url: URL)
}

protocol DeeplinkCoordinatorProtocol {
    @discardableResult
    func handleURL(_ url: URL) -> Bool
}

final class DeeplinkCoordinator {
    
    let handlers: [DeeplinkHandlerProtocol]
    
    init(handlers: [DeeplinkHandlerProtocol]) {
        self.handlers = handlers
    }
}

extension DeeplinkCoordinator: DeeplinkCoordinatorProtocol {
    
    @discardableResult
    func handleURL(_ url: URL) -> Bool{
        guard let handler = handlers.first(where: { $0.canOpenURL(url) }) else {
            return false
        }
              
        handler.openURL(url)
        return true
    }
}

final class CardDeepLinkHandler : DeeplinkHandlerProtocol{
    
    var activity = AddActivityView()
    
    private weak var rootViewController: UIViewController?
        init(rootViewController: UIViewController?) {
            self.rootViewController = rootViewController
        }
    
    func canOpenURL(_ url: URL) -> Bool {
        
        return url.absoluteString == activity.tagID
    }
    
    func openURL(_ url: URL){
        
        guard canOpenURL(url) else {
            return
        }
        
        let viewController = ActivityDetailView()
//        viewController. = "Account"
//        viewController.view.backgroundColor = .yellow
//        rootViewController?.present(viewController, animated: true)
    }
    
}
