//
//  SwipeTableViewController.swift
//  Tracker
//
//  Created by Sam Gustafsson on 5/3/22.
//

import UIKit
import SwipeCellKit

class TrackingsTableViewController: BaseTableViewController, SwipeTableViewCellDelegate {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = 75.0 //having this in the super class so the subclasses inheirit from its
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func updateModel(at indexPath: IndexPath){
        //guard let shipment = items?[indexPath.row] else {return}
        //deleteItem(item: shipment)
        //items?.remove(at: indexPath.row)
        //tableView.deleteRows(at: [indexPath], with: .automatic)
    }
    
    //TableView DataSource Methods
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! SwipeTableViewCell
        cell.contentView.backgroundColor = Primary.shared.uiColor
        
        cell.delegate = self
        
                
        return cell
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        guard orientation == .right else { return nil }

        let deleteAction = SwipeAction(style: .destructive, title: nil) { action, indexPath in
            // handle action by updating model with deletion
            self.updateModel(at: indexPath)
        }
        
        deleteAction.backgroundColor = Colors.OffWhite
        deleteAction.textColor = .black
        deleteAction.font = UIFont(name: "Poppins-Medium", size: 14)

        // customize the action appearance
        deleteAction.image = UIImage(named: "delete-64")

        return [deleteAction]
    }

    
    func collectionView(_ collectionView: UICollectionView, editActionsOptionsForItemAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeTableOptions {
        var options = SwipeTableOptions()
        options.expansionStyle = .destructive
        return options
    }
        
}

