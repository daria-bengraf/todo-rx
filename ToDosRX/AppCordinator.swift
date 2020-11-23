//
//  AppCordinator.swift
//  ToDosRX
//
//  Created by Dariya Bengraf on 11.10.2020.
//  Copyright © 2020 Dariya Bengraf. All rights reserved.
//

import UIKit
class AppCoordinator {
    
    private var window = UIWindow()
    
    init(window:UIWindow) {
        self.window = window
    }
    
    func start() {
        window.rootViewController = UINavigationController(rootViewController: ToDoListController())
        window.makeKeyAndVisible()
    }
}
