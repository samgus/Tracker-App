//
//  ShippingCell.swift
//  Tracker
//
//  Created by Sam Gustafsson on 5/16/22.
//

import Foundation
import UIKit
import SwipeCellKit



class ShippingCell: SwipeTableViewCell{
    
    
    @IBOutlet weak var nickName: UILabel!
    @IBOutlet weak var trackingNumber: UILabel!
    
    //interface for the cell
    func setUp(name: String, tracking: String){
        nickName.text = name
        trackingNumber.text = tracking
    }
    
    
}
