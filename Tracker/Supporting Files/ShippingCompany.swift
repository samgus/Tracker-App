//
//  ShippingCompany.swift
//  Tracker
//
//  Created by Sam Gustafsson on 5/4/22.
//

import Foundation

enum ShippingCompany: String{
    case fedex
    case ups
    case usps
    case dhl
    case unknown
    
    var urlPath: String?{
        switch self{
        case .fedex:
            return "FedEx"
        case .ups:
            return "UPS"
        case .usps:
            return "USPS"
        case .dhl:
            return "DHL"
        case .unknown:
            return nil
        }
    }
    
    var dateFormat: String{
        switch self{
        case .ups:
            return "yyyy-MM-dd HH:mm"
        case .usps, .fedex:
            return "yyyy-MM-dd HH:mm:ss"
        case .dhl:
            return "DHL"
        case .unknown:
            return ""
        }
    }
}

extension String{
    var isOnlyNumbers: Bool {
        let numbers: [Character] = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
        let invalidCharacters = self.filter{ !numbers.contains($0) }
        return invalidCharacters.count == 0
    }
    
    var shippingCompany: ShippingCompany{
        
        if self.count == 18 && self.hasPrefix("1Z"){
            return .ups
        }
        if [20,21,22].contains(self.count) && self.isOnlyNumbers {
            return .usps
        }
        if [12,15].contains(self.count) && self.isOnlyNumbers {
            return .fedex
        }
        if self.count == 10{
            return .dhl
        }
        else {
            return .unknown
        }
    }
}

