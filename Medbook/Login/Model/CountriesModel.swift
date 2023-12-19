//
//  CountriesModel.swift
//  Medbook
//
//  Created by RAHUL RANA on 19/12/23.
//

import Foundation

struct CountriesModel: Codable {
    let status: String?
    let statusCode: Int?
    let version, access: String?
    let data: [String: Country]?
    
    enum CodingKeys: String, CodingKey {
        case status
        case statusCode = "status-code"
        case version, access, data
    }
}

struct Country: Codable {
    let country: String?
    let region: String?
}

struct IPCountryModel: Codable {
    let status, country, countryCode, region: String?
    let regionName, city, zip: String?
    let lat, lon: Double?
    let timezone, isp, org, welcomeAs: String?
    let query: String?
    
    enum CodingKeys: String, CodingKey {
        case status, country, countryCode, region, regionName, city, zip, lat, lon, timezone, isp, org
        case welcomeAs = "as"
        case query
    }
}
