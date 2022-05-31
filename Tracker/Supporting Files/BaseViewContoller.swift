//
//  BaseViewContoller.swift
//  Tracker
//
//  Created by Sam Gustafsson on 5/13/22.
//

import UIKit

class Primary{
    var color: Color = Color.peach {
      didSet {
        UserDefaults.standard.set(color.rawValue, forKey: "color")
        uiColor = color.color
      }
    }

    var uiColor: UIColor = Color.peach.color
    
    static let shared = Primary()
    
    
}

class BaseViewContoller: UIViewController {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(handleColorChangeNotification),
                                               name: NSNotification.Name(rawValue: "colorDidChange"),
                                               object: nil)
    }
    
    @objc func handleColorChangeNotification(_ notification: Notification) {
        navigationController?.navigationBar.backgroundColor = Primary.shared.uiColor
        view.backgroundColor = Primary.shared.uiColor
        //print(notification)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.backgroundColor = Primary.shared.uiColor
        view.backgroundColor = Primary.shared.uiColor
    }

}
