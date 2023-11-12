//
//  Weather.swift
//  WeatherAPI
//
//  Created by Артур Олехно on 11/11/2023.
//

import Foundation

struct Weather: Codable {
    let location: Location
    let current: Current
}

struct Current: Codable {
    let temp_c: Int
}

struct Location: Codable {
    let name: String
}
