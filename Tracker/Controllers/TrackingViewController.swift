
import UIKit
import CoreData
import AVKit

class TrackingViewController: BaseViewContoller, UITableViewDelegate, UITableViewDataSource {
    
    var showBackButton = false
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var companyLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var trackingTableView: UITableView!
    @IBOutlet weak var logoImage: UIImageView!
    
    @IBOutlet weak var backButton: UIBarButtonItem!
    
    
    var response: TracktryApi.GetTrackingResponse?
    var itemArray = [Shipments]() //making the inital array for the tableview
    
    var trackingNumber: String?
    var nickName: String?
    
    var audioPlayer: AVAudioPlayer?
    
    lazy var dateFormatter: DateFormatter = {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm"
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "MMMM dd, yyyy"
        return dateFormatterGet
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        searchBarUpdatedColor()

        tableView.delegate = self
        tableView.dataSource = self
        tableView.layer.opacity = 0
        searchBar.delegate = self

        if showBackButton == false{
            navigationItem.leftBarButtonItem = nil
        }
       
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
                view.addGestureRecognizer(tap)
        
    }
    
    @objc func dismissKeyboard() {
            //Causes the view (or one of its embedded text fields) to resign the first responder status.
            view.endEditing(true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let trackingNumber = trackingNumber {
            searchBar.heightAnchor.constraint(equalToConstant: 0).isActive = true
            searchBar.isHidden = true
            navigationItem.title = nickName
            navigationItem.rightBarButtonItem = nil
            
            refreshList(trackingNumber: trackingNumber)
            
        }
    }
    
    
    @IBAction func backButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return response?.data.first?.originInfo?.trackInfo?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let trackinfo = response?.data.first?.originInfo?.trackInfo else {
            return UITableViewCell()
        }
        
        guard let carrier_code = response?.data.first?.carrier else {return UITableViewCell()}
        guard let shippingCompany = ShippingCompany(rawValue: carrier_code) else { return UITableViewCell() }

        let currentTrackInfo = trackinfo[indexPath.row]
        
        dateLabel.text = currentTrackInfo.date?.formattedDate(from: shippingCompany.dateFormat, to: "MMMM dd, yyyy")
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TrackingCell
        cell.cellDateLabel.text = currentTrackInfo.date?.formattedDate(from: shippingCompany.dateFormat, to: "MMMM dd, yyyy")
        cell.cellTimeLabel.text = currentTrackInfo.date?.formattedDate(from: shippingCompany.dateFormat, to: "h:mm a")

        cell.cellStatusLabel?.text = currentTrackInfo.statusDescription
        cell.cellLocationLabel?.text = currentTrackInfo.details
        cell.textLabel?.textColor = .white
        cell.textLabel?.font = UIFont(name: "Poppins-Regular", size: 16)
        cell.cellStatusLabel.font = UIFont(name: "Poppins-Medium", size: 16)
        cell.cellLocationLabel.font = UIFont(name: "Poppins-Medium", size: 16)
        
        guard let cellDateString = cell.cellDateLabel?.text else {return cell}
        
        //formatting the DATE LABEL
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm"
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "MMMM dd, yyyy" // change this format to change how date looks
        let cellDate: NSDate? = dateFormatterGet.date(from: cellDateString) as NSDate?
        if let cellDate = cellDate {
            cell.cellDateLabel?.text = dateFormatterPrint.string(from: cellDate as Date)
        }
        
        //formatting the TIME LABEL
        let timeFormatterGet = DateFormatter()
        timeFormatterGet.dateFormat = "yyyy-MM-dd HH:mm"
        let timeFormatterPrint = DateFormatter()
        timeFormatterPrint.dateFormat = "h:m a" // change this format to change how time looks
        let cellTime: NSDate? = timeFormatterGet.date(from: cellDateString) as NSDate?
        if let cellTime = cellTime {
            cell.cellTimeLabel?.text = timeFormatterPrint.string(from: cellTime as Date)
        }
        
        return cell
    }
    
    //Data Manipulation Methods
    func saveShipments(){
        do {
            try context.save()
        } catch {
            print("Error saving categories \(error)")
        }
        
        tableView.reloadData()
    }
    
    public func loadShipments(){
        let request : NSFetchRequest<Shipments> = Shipments.fetchRequest()
        
        do {
            itemArray = try context.fetch(request)
        } catch{
            print("Error loading categories \(error)")
        }
        tableView.reloadData()
    }
    
    
    //NOT WORKING YET
    //Delete Data From Swipe
    func updateModel(at indexPath: IndexPath) {
        self.context.delete(self.itemArray[indexPath.row])
        self.itemArray.remove(at: indexPath.row)
        self.saveShipments()
    }
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Name Your Shipment", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            let newShipment = Shipments(context: self.context)
            newShipment.name = textField.text!
            newShipment.trackingNumber = self.searchBar.text
            
            do {
                self.audioPlayer = try AVAudioPlayer(contentsOf: Bundle.main.url(forResource: "pickupCoin", withExtension: "wav")!)
                self.audioPlayer?.play()
            } catch {
                print(error.localizedDescription)
            }
            
            self.itemArray.append(newShipment)
            
            self.saveShipments()
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
        
        alert.addAction(action)
        alert.addAction(cancel)
        
        alert.addTextField { (field) in
            textField = field
            textField.placeholder = "Nickname"
        }
        
        present(alert, animated: true, completion: nil)
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
    func searchBarUpdatedColor(){
        if let textfield = searchBar.value(forKey: "searchField") as? UITextField {
            textfield.textColor = UIColor.gray
            textfield.backgroundColor = UIColor.white
            textfield.font = UIFont(name: "Poppins-Regular.ttf", size: 16)
        }
    }
    
    func refreshList(trackingNumber: String){
        postApiCall(trackingNumber: trackingNumber) { response in
            self.getApiCall(trackingNumber: trackingNumber){ getResponse in
                DispatchQueue.main.async {
                    guard let getResponse = getResponse, getResponse.data.isEmpty == false else {
                        self.tableView.isHidden = true
                        return
                    }
                  
                    UIView.animate(withDuration: 0.5) {
                        self.tableView.layer.opacity = 1
                        self.logoImage.layer.opacity = 0
                        self.response = getResponse
                        self.companyLabel.text  = getResponse.data.first?.carrier
                        self.statusLabel.text = getResponse.data.first?.status
                        
                        self.dateLabel.text = getResponse.data.first?.updatedAt

                        self.tableView.reloadData()
                    }

                    print(getResponse)
                }
            }
            
        }
    }
}



//SEARCH BAR METHOD
extension TrackingViewController: UISearchBarDelegate{
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let trackingNumber = searchBar.searchTextField.text else {
            tableView.isHidden = true
            return
        }
        refreshList(trackingNumber: trackingNumber)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
            UIView.animate(withDuration: 0.5) {
                self.tableView.layer.opacity = 0
                self.logoImage.layer.opacity = 1
            }
        }
    }
}

//API CALLER METHOD
extension TrackingViewController{
    public func postApiCall(trackingNumber: String, completion: @escaping (TracktryApi.DataResponse?) -> Void){
        guard let companyPath = trackingNumber.shippingCompany.urlPath else {return}
        let baseUrl = "https://api.tracktry.com/v1/trackings/post"
        //POST URL
        let postUrl = URL(string: baseUrl)
        print(baseUrl)
        
        var postRequest = URLRequest(url: postUrl!)
        //postRequest.httpBody = DetectCourierBody(tracking: Tracking(trackingNumber: trackingNumber)).data
        postRequest.httpMethod = "POST"
        postRequest.httpBody = TracktryApi.PostTrackingBody(tracking_number: trackingNumber, carrier_code: companyPath).data
        postRequest.setValue("b9b68046-8784-4c4b-af53-2629a6afd4e7", forHTTPHeaderField: "tracktry-api-key")
        postRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        guard postUrl != nil else {
            print("Error creating url object")
            return
        }
        
        //Post the URLsession
            let postSession = URLSession.shared
        
        //Create post data task
        let postDataTask = postSession.dataTask(with: postRequest) { (data, response, error) in
            guard (response as? HTTPURLResponse)?.statusCode == 200 else {
              completion(nil)
              return
            }
            guard let data = data else {return}
            let decoder = JSONDecoder()
            
            do{
                let response = try decoder.decode(TracktryApi.PostTrackingResponse.self, from: data)
                completion(response)
                print(response)
            }
            catch{
                print("Error parsing response data")
                completion(nil)
            }
        }
        //Fire off the post data task
        postDataTask.resume()
    }
    
    public func getApiCall(trackingNumber: String, completion: @escaping (TracktryApi.GetTrackingResponse?) -> Void){
        guard let companyPath = trackingNumber.shippingCompany.urlPath else {return}
        //GET URL
        //1Z48673W0497000713
        let urlString = "https://api.tracktry.com/v1/trackings/\(companyPath)/\(trackingNumber)"
        let getUrl = URL(string: urlString)
        print(urlString)

        var getRequest = URLRequest(url: getUrl!)
        getRequest.httpMethod = "GET"
        getRequest.setValue("b9b68046-8784-4c4b-af53-2629a6afd4e7", forHTTPHeaderField: "Tracktry-Api-Key")
        getRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        guard getUrl != nil else {
            print("Error creating url object")
            return
        }
        print(getRequest)

        //Get the URLsession
        let getSession = URLSession.shared

        //Create get data task
        let getDataTask = getSession.dataTask(with: getRequest) { (data, response, error) in
            guard let data = data else {return}
            let decoder = JSONDecoder()

            do {
                let response = try decoder.decode(TracktryApi.GetTrackingResponse.self, from: data)
                completion(response)
            } catch {
                print(error)
                print("Error parsing response data")
                completion(nil)
            }
        }
        //Fire off the get data task
        getDataTask.resume()
    }
}

//API Method

struct TracktryApi {
    
    struct GetTrackingResponse: Codable {
        let data: [DataResponse]
    }
    
    struct PostTrackingBody: Codable {
        let tracking_number: String
        let carrier_code: String
        var data: Data?{
            return try? JSONEncoder().encode(self)
        }
    }

    typealias PostTrackingResponse = DataResponse

    struct DataResponse: Codable {
        let id: String?
        let trackingNumber: String?
        let carrier: String?
        let status: String?
        let createdAt: String?
        let updatedAt: String?
        let code: Int?
        let message: String?
        let originInfo: OriginInfo?
        
        enum CodingKeys: String, CodingKey {
            case trackingNumber = "tracking_number"
            case carrier = "carrier_code"
            case createdAt = "created_at"
            case updatedAt = "updated_at"
            case originInfo = "origin_info"
            case id, status, code, message
        }
    }

    struct OriginInfo: Codable {
        let trackInfo: [TrackInfo]?
        
        enum CodingKeys: String, CodingKey {
            case trackInfo = "trackinfo"
        }
    }

    struct TrackInfo: Codable {
        let date: String?
        let statusDescription: String?
        let details: String?
        let checkpointStatus: String?
        
        enum CodingKeys: String, CodingKey {
            case date = "Date"
            case statusDescription = "StatusDescription"
            case details = "Details"
            case checkpointStatus = "checkpoint_status"
        }
    }

}

extension String {
    func formattedDate(from originalDateFormat: String,
                       to newDateFormat: String) -> String? {
        return try? DateUtility.convert(self, from: originalDateFormat, to: newDateFormat)
    }
}

class DateUtility {
    enum ConversionError: Error {
        case invalidOriginalDateFormat
    }
    
    class func convert(_ dateString: String,
                       from originalDateFormat: String,
                       to newDateFormat: String) throws -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = originalDateFormat
        guard let date = dateFormatter.date(from: dateString) else {
            throw ConversionError.invalidOriginalDateFormat
        }
        dateFormatter.dateFormat = newDateFormat
        return dateFormatter.string(from: date)
    }
}
