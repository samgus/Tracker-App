
import UIKit
import CoreData

class ShipmentsViewController: TrackingsTableViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        searchBarUpdatedColor()
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
                view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    
    func searchBarUpdatedColor(){
        if let textfield = searchBar.value(forKey: "searchField") as? UITextField {
            textfield.textColor = UIColor.gray
            textfield.backgroundColor = UIColor.white
            textfield.font = UIFont(name: "Poppins-Regular.ttf", size: 16)
        }
    }
}


    
    

