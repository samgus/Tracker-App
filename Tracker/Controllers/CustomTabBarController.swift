//
//  CustomTabBarController.swift
//  Tracker
//
//  Created by Sam Gustafsson on 5/13/22.
//

import UIKit

class CustomTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(handleColorChangeNotification),
                                               name: NSNotification.Name(rawValue: "colorDidChange"),
                                               object: nil)
    }
    
    @objc func handleColorChangeNotification(_ notification: Notification) {
        tabBar.tintColor = Primary.shared.uiColor
        
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tabBar.tintColor = Primary.shared.uiColor
    }

}
