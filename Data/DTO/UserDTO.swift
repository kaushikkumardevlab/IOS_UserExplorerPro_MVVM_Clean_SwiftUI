//
//  UserDTO.swift
//  UserExplorerPro
//
//  Created by Kaushikkumar on 19/03/26.
//

import Foundation

struct UserResponse: Codable {
    let results: [UserDTO]
}

struct UserDTO: Codable {
    let gender: String
    let name: NameDTO
    let email: String
    let login: LoginDTO
    let location: LocationDTO
    let dob: DateOfBirthDTO
    let phone: String
    let cell: String
    let picture: PictureDTO
}

struct NameDTO: Codable {
    let first: String
    let last: String
}

struct LoginDTO: Codable {
    let uuid: String
    let username: String
}

struct LocationDTO: Codable {
    let street: StreetDTO
    let city: String
    let state: String
    let country: String
}

struct StreetDTO: Codable {
    let number: Int
    let name: String
}

struct DateOfBirthDTO: Codable {
    let age: Int
}

struct PictureDTO: Codable {
    let large: String
    let medium: String
    let thumbnail: String
}

extension UserDTO {
    func toDomain() -> User {
        User(
            id: login.uuid,
            name: "\(name.first) \(name.last)",
            email: email,
            imageURL: picture.large,
            thumbnailURL: picture.thumbnail,
            gender: gender.capitalized,
            username: login.username,
            phone: phone,
            cell: cell,
            city: location.city,
            state: location.state,
            country: location.country,
            streetAddress: "\(location.street.number) \(location.street.name)",
            age: dob.age
        )
    }
}
