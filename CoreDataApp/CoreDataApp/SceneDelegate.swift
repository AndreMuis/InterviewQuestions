//
//  SceneDelegate.swift
//  CoreDataApp
//
//  Created by user176866 on 8/19/20.
//  Copyright © 2020 user176866. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func sceneDidEnterBackground(_ scene: UIScene) {
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }
}
