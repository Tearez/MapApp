//
//  APIResponse.swift
//  MapApp
//
//  Created by Martin Dimitrov on 25.11.19.
//  Copyright © 2019 Appolica Learning. All rights reserved.
//

import Foundation

class APIResponse: Codable {
    let status: String
    let data: DataClass

    init(status: String, data: DataClass) {
        self.status = status
        self.data = data
    }
}

// MARK: - DataClass
class DataClass: Codable {
    let city: String
    let state: String
    let country: String
    let location: Location
    let current: Current

    init(city: String, state: String, country: String, location: Location, current: Current) {
        self.city = city
        self.state = state
        self.country = country
        self.location = location
        self.current = current
    }
}

// MARK: - Current
class Current: Codable {
    let weather: Weather
    let pollution: Pollution

    init(weather: Weather, pollution: Pollution) {
        self.weather = weather
        self.pollution = pollution
    }
}

// MARK: - Pollution
class Pollution : Codable {
    let ts: String
    let aqius: Int
    let mainus: String
    let aqicn: Int
    let maincn: String

    init(ts: String, aqius: Int, mainus: String, aqicn: Int, maincn: String) {
        self.ts = ts
        self.aqius = aqius
        self.mainus = mainus
        self.aqicn = aqicn
        self.maincn = maincn
    }
}

// MARK: - Weather
class Weather: Codable {
    let ts: String
    let tp: Int
    let pr: Int
    let hu: Int
    let ws: Double
    let wd: Int
    let ic: String

    init(ts: String, tp: Int, pr: Int, hu: Int, ws: Double, wd: Int, ic: String) {
        self.ts = ts
        self.tp = tp
        self.pr = pr
        self.hu = hu
        self.ws = ws
        self.wd = wd
        self.ic = ic
    }
}

// MARK: - Location
class Location: Codable {
    let type: String
    let coordinates: [Double]

    init(type: String, coordinates: [Double]) {
        self.type = type
        self.coordinates = coordinates
    }
}
