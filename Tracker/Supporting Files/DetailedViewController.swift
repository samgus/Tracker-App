//
//  DetailedViewController.swift
//  Tracker
//
//  Created by Sam Gustafsson on 5/17/22.
//

import Foundation
import UIKit

class DetailedViewController: BaseTableViewController{
    
    var nickName: String!
    var trackingNumber: String!
    override func viewDidLoad() {
        super.viewDidLoad()
        title = trackingNumber
        tableView.rowHeight = 75.0 //having this in the super class so the subclasses inheirit from its

    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailsCell", for: indexPath) as! ShippingCell
        
        cell.contentView.backgroundColor = Primary.shared.uiColor
        
        cell.textLabel?.textColor = .white
        cell.textLabel?.font = UIFont(name: "Poppins-Regular", size: 28)
        
        return cell
}
}
