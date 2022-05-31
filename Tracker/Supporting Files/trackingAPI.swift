//
//  trackingAPI.swift
//  Tracker
//
//  Created by Sam Gustafsson on 4/1/22.
//

import Foundation
import UIKit

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? newJSONDecoder().decode(Welcome.self, from: jsonData)

struct ResponseBody: Codable {
    let data: [Datum2]
    let meta: Meta2
}

struct Datum2: Codable {
    let archived: Bool
    let carrier_code: String
    let origin_info, destination_info: NInfo
}

struct Meta2: Codable {
    let code: Int
    let message: String
}

// MARK: - Datum
struct Datum: Codable {
    let id, trackingNumber, carrierCode: String
    let status: Status
    let createdAt, updatedAt: Date
    let orderCreateTime: JSONNull?
    let customerEmail, title: String
    let orderID, comment, customerName: JSONNull?
    let archived: Bool
    let originalCountry: String
    let itemTimeLength, stayTimeLength: Int
    let serviceCode, statusInfo: JSONNull?
    let originInfo, destinationInfo: NInfo
    let lastEvent, lastUpdateTime: String //use

    enum CodingKeys: String, CodingKey {
        case id
        case trackingNumber = "tracking_number"
        case carrierCode = "carrier_code"
        case status
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case orderCreateTime = "order_create_time"
        case customerEmail = "customer_email"
        case title
        case orderID = "order_id"
        case comment
        case customerName = "customer_name"
        case archived
        case originalCountry = "original_country"
        case itemTimeLength, stayTimeLength
        case serviceCode = "service_code"
        case statusInfo = "status_info"
        case originInfo = "origin_info"
        case destinationInfo = "destination_info"
        case lastEvent, lastUpdateTime
    }
}

// MARK: - NInfo
struct NInfo: Codable {
    let itemReceived: String?
    //let itemDispatched, departfromAirport, arrivalfromAbroad: String?
    let customsClearance: String?
   // let destinationArrived: JSONNull?
    let weblink: String?
    //let phone: JSONNull?
    let carrierCode: String?
    let trackinfo: [Trackinfo]?
    //let referenceNumber: JSONNull?

    enum CodingKeys: String, CodingKey {
        case itemReceived = "ItemReceived"
        //case itemDispatched = "ItemDispatched"
        //case departfromAirport = "DepartfromAirport"
        //case arrivalfromAbroad = "ArrivalfromAbroad"
        case customsClearance = "CustomsClearance"
        //case destinationArrived = "DestinationArrived"
        case weblink
             //phone
        case carrierCode = "carrier_code"
        case trackinfo
        //case referenceNumber = "ReferenceNumber"
    }
}

// MARK: - Trackinfo
struct Trackinfo: Codable {
    let actType: ActType?
    let date, statusDescription, details: String
    let checkpointStatus: Status
    let substatus: String
    let itemNode: String?
    let substatusNum: Int?

    enum CodingKeys: String, CodingKey {
        case actType = "ActType"
        case date = "Date"
        case statusDescription = "StatusDescription"
        case details = "Details"
        case checkpointStatus = "checkpoint_status"
        case substatus
        case itemNode = "ItemNode"
        case substatusNum = "substatus_num"
    }
}

enum ActType: String, Codable {
    case d = "D"
    case i = "I"
    case m = "M"
    case x = "X"
}

enum Status: String, Codable {
    case delivered = "delivered"
    case transit = "transit"
}

// MARK: - Meta
struct Meta: Codable {
    let code: Int
    let type, message: String
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}

// MARK: - Welcome
struct DetectCourierBody: Codable {
    var data: Data?{
        return try? JSONEncoder().encode(self)
    }
    let tracking: Tracking
}

// MARK: - Tracking
struct Tracking: Codable {
    let trackingNumber: String

    enum CodingKeys: String, CodingKey {
        case trackingNumber = "tracking_number"
    }
}

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? newJSONDecoder().decode(Welcome.self, from: jsonData)

// MARK: - Welcome
struct DetectCourierResponse: Codable {
    let data: DataClass
}

// MARK: - DataClass
struct DataClass: Codable {
    let total: Int
    let couriers: [Courier]
}

// MARK: - Courier
struct Courier: Codable {
    let slug, name, phone, otherName: String
    let webURL: String
    let requiredFields: [String]
    let optionalFields: [JSONAny]
    let defaultLanguage: String
    let supportLanguages, serviceFromCountryIso3: [String]

    enum CodingKeys: String, CodingKey {
        case slug, name, phone
        case otherName = "other_name"
        case webURL = "web_url"
        case requiredFields = "required_fields"
        case optionalFields = "optional_fields"
        case defaultLanguage = "default_language"
        case supportLanguages = "support_languages"
        case serviceFromCountryIso3 = "service_from_country_iso3"
    }
}


// MARK: - Encode/decode helpers

class JSONCodingKey: CodingKey {
    let key: String

    required init?(intValue: Int) {
        return nil
    }

    required init?(stringValue: String) {
        key = stringValue
    }

    var intValue: Int? {
        return nil
    }

    var stringValue: String {
        return key
    }
}

class JSONAny: Codable {

    let value: Any

    static func decodingError(forCodingPath codingPath: [CodingKey]) -> DecodingError {
        let context = DecodingError.Context(codingPath: codingPath, debugDescription: "Cannot decode JSONAny")
        return DecodingError.typeMismatch(JSONAny.self, context)
    }

    static func encodingError(forValue value: Any, codingPath: [CodingKey]) -> EncodingError {
        let context = EncodingError.Context(codingPath: codingPath, debugDescription: "Cannot encode JSONAny")
        return EncodingError.invalidValue(value, context)
    }

    static func decode(from container: SingleValueDecodingContainer) throws -> Any {
        if let value = try? container.decode(Bool.self) {
            return value
        }
        if let value = try? container.decode(Int64.self) {
            return value
        }
        if let value = try? container.decode(Double.self) {
            return value
        }
        if let value = try? container.decode(String.self) {
            return value
        }
        if container.decodeNil() {
            return JSONNull()
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decode(from container: inout UnkeyedDecodingContainer) throws -> Any {
        if let value = try? container.decode(Bool.self) {
            return value
        }
        if let value = try? container.decode(Int64.self) {
            return value
        }
        if let value = try? container.decode(Double.self) {
            return value
        }
        if let value = try? container.decode(String.self) {
            return value
        }
        if let value = try? container.decodeNil() {
            if value {
                return JSONNull()
            }
        }
        if var container = try? container.nestedUnkeyedContainer() {
            return try decodeArray(from: &container)
        }
        if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self) {
            return try decodeDictionary(from: &container)
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decode(from container: inout KeyedDecodingContainer<JSONCodingKey>, forKey key: JSONCodingKey) throws -> Any {
        if let value = try? container.decode(Bool.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(Int64.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(Double.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(String.self, forKey: key) {
            return value
        }
        if let value = try? container.decodeNil(forKey: key) {
            if value {
                return JSONNull()
            }
        }
        if var container = try? container.nestedUnkeyedContainer(forKey: key) {
            return try decodeArray(from: &container)
        }
        if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key) {
            return try decodeDictionary(from: &container)
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decodeArray(from container: inout UnkeyedDecodingContainer) throws -> [Any] {
        var arr: [Any] = []
        while !container.isAtEnd {
            let value = try decode(from: &container)
            arr.append(value)
        }
        return arr
    }

    static func decodeDictionary(from container: inout KeyedDecodingContainer<JSONCodingKey>) throws -> [String: Any] {
        var dict = [String: Any]()
        for key in container.allKeys {
            let value = try decode(from: &container, forKey: key)
            dict[key.stringValue] = value
        }
        return dict
    }

    static func encode(to container: inout UnkeyedEncodingContainer, array: [Any]) throws {
        for value in array {
            if let value = value as? Bool {
                try container.encode(value)
            } else if let value = value as? Int64 {
                try container.encode(value)
            } else if let value = value as? Double {
                try container.encode(value)
            } else if let value = value as? String {
                try container.encode(value)
            } else if value is JSONNull {
                try container.encodeNil()
            } else if let value = value as? [Any] {
                var container = container.nestedUnkeyedContainer()
                try encode(to: &container, array: value)
            } else if let value = value as? [String: Any] {
                var container = container.nestedContainer(keyedBy: JSONCodingKey.self)
                try encode(to: &container, dictionary: value)
            } else {
                throw encodingError(forValue: value, codingPath: container.codingPath)
            }
        }
    }

    static func encode(to container: inout KeyedEncodingContainer<JSONCodingKey>, dictionary: [String: Any]) throws {
        for (key, value) in dictionary {
            let key = JSONCodingKey(stringValue: key)!
            if let value = value as? Bool {
                try container.encode(value, forKey: key)
            } else if let value = value as? Int64 {
                try container.encode(value, forKey: key)
            } else if let value = value as? Double {
                try container.encode(value, forKey: key)
            } else if let value = value as? String {
                try container.encode(value, forKey: key)
            } else if value is JSONNull {
                try container.encodeNil(forKey: key)
            } else if let value = value as? [Any] {
                var container = container.nestedUnkeyedContainer(forKey: key)
                try encode(to: &container, array: value)
            } else if let value = value as? [String: Any] {
                var container = container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key)
                try encode(to: &container, dictionary: value)
            } else {
                throw encodingError(forValue: value, codingPath: container.codingPath)
            }
        }
    }

    static func encode(to container: inout SingleValueEncodingContainer, value: Any) throws {
        if let value = value as? Bool {
            try container.encode(value)
        } else if let value = value as? Int64 {
            try container.encode(value)
        } else if let value = value as? Double {
            try container.encode(value)
        } else if let value = value as? String {
            try container.encode(value)
        } else if value is JSONNull {
            try container.encodeNil()
        } else {
            throw encodingError(forValue: value, codingPath: container.codingPath)
        }
    }

    public required init(from decoder: Decoder) throws {
        if var arrayContainer = try? decoder.unkeyedContainer() {
            self.value = try JSONAny.decodeArray(from: &arrayContainer)
        } else if var container = try? decoder.container(keyedBy: JSONCodingKey.self) {
            self.value = try JSONAny.decodeDictionary(from: &container)
        } else {
            let container = try decoder.singleValueContainer()
            self.value = try JSONAny.decode(from: container)
        }
    }

    public func encode(to encoder: Encoder) throws {
        if let arr = self.value as? [Any] {
            var container = encoder.unkeyedContainer()
            try JSONAny.encode(to: &container, array: arr)
        } else if let dict = self.value as? [String: Any] {
            var container = encoder.container(keyedBy: JSONCodingKey.self)
            try JSONAny.encode(to: &container, dictionary: dict)
        } else {
            var container = encoder.singleValueContainer()
            try JSONAny.encode(to: &container, value: self.value)
        }
    }
}
