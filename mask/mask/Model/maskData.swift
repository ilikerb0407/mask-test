//
//  maskData.swift
//  mask
//
//  Created by Kai Fu Jhuang on 2022/6/29.
//

import Foundation

// MARK: - MaskData
struct MaskData: Codable {
    let type: String
    let features: [Feature]
}

// MARK: - Feature
struct Feature: Codable {
    let type: FeatureType
    let properties: Properties
    let geometry: Geometry
}

// MARK: - Geometry
struct Geometry: Codable {
    let type: GeometryType
    let coordinates: [Double]
}

enum GeometryType: String, Codable {
    case point = "Point"
}

// MARK: - Properties
struct Properties: Codable {
    let id, name, phone, address: String
    let maskAdult, maskChild: Int
    let updated: Updated
    let available, note, customNote: String
    let website: String
    let county: County
    let town, cunli, servicePeriods: String

    enum CodingKeys: String, CodingKey {
        case id, name, phone, address
        case maskAdult = "mask_adult"
        case maskChild = "mask_child"
        case updated, available, note
        case customNote = "custom_note"
        case website, county, town, cunli
        case servicePeriods = "service_periods"
    }
}

enum County: String, Codable {
    case empty = ""
    case 南投縣 = "南投縣"
    case 嘉義市 = "嘉義市"
    case 嘉義縣 = "嘉義縣"
    case 基隆市 = "基隆市"
    case 宜蘭縣 = "宜蘭縣"
    case 屏東縣 = "屏東縣"
    case 彰化縣 = "彰化縣"
    case 新北市 = "新北市"
    case 新竹市 = "新竹市"
    case 新竹縣 = "新竹縣"
    case 桃園市 = "桃園市"
    case 澎湖縣 = "澎湖縣"
    case 臺中市 = "臺中市"
    case 臺北市 = "臺北市"
    case 臺南市 = "臺南市"
    case 臺東縣 = "臺東縣"
    case 花蓮縣 = "花蓮縣"
    case 苗栗縣 = "苗栗縣"
    case 連江縣 = "連江縣"
    case 金門縣 = "金門縣"
    case 雲林縣 = "雲林縣"
    case 高雄市 = "高雄市"
}

enum Updated: String, Codable {
    case the20220309225323 = "2022/03/09 22:53:23"
    case the20220309225503 = "2022/03/09 22:55:03"
}

enum FeatureType: String, Codable {
    case feature = "Feature"
}
