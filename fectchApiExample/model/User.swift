//
//  User.swift
//  fectchApiExample
//
//  Created by miguel toledo on 29/08/22.
//


import Foundation


import Foundation

//ROOT RESPONSE
struct Response: Codable {
    let results: [User]
    let info: Info
}


// INFO
struct Info: Codable {
    let seed: String
    let results, page: Int
    let version: String
}


//USER
struct User: Codable {
    let gender: String
    let name: Name
    let location: Location
    let email: String
    let login: Login
    let dob, registered: Dob
    let phone, cell: String
    let id: ID
    let picture: Picture
    let nat: String
}

// DOB -- I DONT KNOW W'S IT
struct Dob: Codable {
    let date: String
    let age: Int
}

//ID
struct ID: Codable {
    let name: String
    let value: String?
}

//LOCATION
struct Location: Codable {
    let street: Street
    let city, state, country: String
    let postcode: Postcode
    let coordinates: Coordinates
    let timezone: Timezone
}

//Enumeracion necesario para manejar el tipo de
enum Postcode: Codable {
    case integer(Int)
    case string(String)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Int.self) {
            print("Entre al caso especial de integer ")
            self = .integer(x)
            return
        }
        if let x = try? container.decode(String.self) {
            print("Entre al caso especial de string ")
            self = .string(x)
            return
        }
        throw DecodingError.typeMismatch(Postcode.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "No se pudo hacer match con ninguno de los tipos de postcode"))
    }
}

// COORDINATES
struct Coordinates: Codable {
    let latitude, longitude: String
}

// STREET
struct Street: Codable {
    let number: Int
    let name: String
}

// TIMEZONE
struct Timezone: Codable {
    let offset, timezoneDescription: String

       enum CodingKeys: String, CodingKey {
           case offset
           case timezoneDescription = "description"
       }
}

// LOGIN
struct Login: Codable {
    let uuid, username, password, salt: String
    let md5, sha1, sha256: String
}

// NAME
struct Name: Codable {
    let title, first, last: String
}

// PICTURE
struct Picture: Codable {
    let large, medium, thumbnail: String
}
