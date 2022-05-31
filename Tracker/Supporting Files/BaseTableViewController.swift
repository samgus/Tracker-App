//
//  BaseTableViewController.swift
//  Tracker
//
//  Created by Sam Gustafsson on 5/13/22.
//

import UIKit

class BaseTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(handleColorChangeNotification),
                                               name: NSNotification.Name(rawValue: "colorDidChange"),
                                               object: nil)
    }
    
    @objc func handleColorChangeNotification(_ notification: Notification) {
        navigationController?.navigationBar.backgroundColor = Primary.shared.uiColor
        //navigationController?.navigationBar.tintColor = Primary.shared.uiColor
        view.backgroundColor = Primary.shared.uiColor
        //print(notification)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.backgroundColor = Primary.shared.uiColor
        //navigationController?.navigationBar.tintColor = Primary.shared.uiColor
        view.backgroundColor = Primary.shared.uiColor
        tableView.reloadData()
    }

    
}
