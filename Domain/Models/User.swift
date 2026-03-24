//
//  User.swift
//  UserExplorerPro
//
//  Created by Kaushikkumar on 19/03/26.
//

struct User: Identifiable, Codable, Hashable {
    let id: String
    let name: String
    let email: String
    let imageURL: String
    let thumbnailURL: String
    let gender: String
    let username: String
    let phone: String
    let cell: String
    let city: String
    let state: String
    let country: String
    let streetAddress: String
    let age: Int
}
