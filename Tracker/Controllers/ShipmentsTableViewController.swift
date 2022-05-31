//
//  ShipmentsTableViewController.swift
//  Tracker
//
//  Created by Sam Gustafsson on 5/16/22.
//

import Foundation
import UIKit
import SwipeCellKit
import CoreData
import CoreMedia


class ShipmentsTableViewController: BaseTableViewController, SwipeTableViewCellDelegate, UISearchBarDelegate {

    var items: [Shipments]?
    var filteredItems: [Shipments]?
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBarUpdatedColor()
        tableView.delegate = self
        tableView.allowsSelection = true
        searchBar.delegate = self
        
        tableView.rowHeight = 75.0 //having this in the super class so the subclasses inheirit from its
    }
    
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        getAllItems()
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //get the tracking number that is selected
        guard let item = filteredItems?[indexPath.row] else {return}
        //create an instance of the detailed view controller
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "TrackingViewController") as! TrackingViewController
        //set the tracking number on the view controller
        viewController.trackingNumber = item.trackingNumber
        viewController.nickName = item.name
        //use the nav controller to push it
        viewController.showBackButton = true
        navigationController?.pushViewController(viewController, animated: true)
        dismissKeyboard()
    }
    
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    //TableView DataSource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredItems?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell = tableView.dequeueReusableCell(withIdentifier: "ShippingCell", for: indexPath) as! ShippingCell
        
        cell.delegate = self
        
        cell.contentView.backgroundColor = Primary.shared.uiColor
        
        cell.textLabel?.textColor = .white
        cell.textLabel?.font = UIFont(name: "Poppins-Regular", size: 28)
        
        guard let item = filteredItems?[indexPath.row] else {return UITableViewCell()}
        
        cell.setUp(name: item.name ?? "", tracking: item.trackingNumber ?? "not found")
        //cell.textLabel?.text = items?[indexPath.row].name ?? "No Categories Added Yet"
        return cell
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else {
            filteredItems = items
            return
        }
        filteredItems = items?.filter({$0.name?.contains(searchText) == true})
        tableView.reloadData()
    }
    
    // Deleting the cell
    
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: "") { _, _, _ in
            self.context.delete((self.filteredItems?[indexPath.row])!)
            do {
                try self.context.save()
            }
            catch{
                print("Error deleting item")
            }
            self.getAllItems()
            
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        let swipe = UISwipeActionsConfiguration(actions: [delete])
        return swipe
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        guard orientation == .right else { return nil }

        let deleteAction = SwipeAction(style: .destructive, title: nil) { action, indexPath in
            // handle action by updating model with deletion
            self.updateModel(at: indexPath)
        }
        
        //deleteAction.backgroundColor = Colors.OffWhite
        deleteAction.textColor = .black
        deleteAction.font = UIFont(name: "Poppins-Medium", size: 14)

        // customize the action appearance
        deleteAction.image = UIImage.init(systemName: "trash")

        return [deleteAction]
    }

    
    func collectionView(_ collectionView: UICollectionView, editActionsOptionsForItemAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeTableOptions {
        var options = SwipeTableOptions()
        options.expansionStyle = .destructive
        return options
    }
    
    func updateModel(at indexPath: IndexPath){
        guard let shipment = filteredItems?[indexPath.row] else {return}
        deleteItem(item: shipment)
        filteredItems?.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic)
    }
    
    func searchBarUpdatedColor(){
        if let textfield = searchBar.value(forKey: "searchField") as? UITextField {
            textfield.textColor = UIColor.gray
            textfield.backgroundColor = UIColor.white
            textfield.font = UIFont(name: "Poppins-Regular.ttf", size: 16)
        }
    }

    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        dismissKeyboard()
    }
}

//CORE DATA METHOD
extension ShipmentsTableViewController{
    func getAllItems(){
        do{
            self.items = try context.fetch(Shipments.fetchRequest())
            self.filteredItems = self.items
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        catch {
            print("Error getting items from core data")
        }
        
        
        
    }

    func createItems(name: String, number: String){
        let newItem = Shipments(context: context)
        newItem.name = name
        newItem.trackingNumber = number

        do {
            try context.save()
        }
        catch{
            print("Error creating item")
        }
    }

    func deleteItem(item: Shipments){
        context.delete(item)

        do {
            try context.save()
        }
        catch{
            print("Error deleting item")
        }
    }

    func updateItem(item: Shipments, newName: String){
        item.name = newName
    }


}
