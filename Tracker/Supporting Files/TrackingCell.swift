//
//  TrackingCell.swift
//  Tracker
//
//  Created by Sam Gustafsson on 4/22/22.
//

import UIKit

class TrackingCell: UITableViewCell {

    @IBOutlet weak var cellDateLabel: UILabel!
    @IBOutlet weak var cellTimeLabel: UILabel!
    @IBOutlet weak var cellStatusLabel: UILabel!
    @IBOutlet weak var cellLocationLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.tintColor = Primary.shared.uiColor

        // Configure the view for the selected state
    }

}
