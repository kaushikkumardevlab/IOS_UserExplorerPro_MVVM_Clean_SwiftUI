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

extension User {
    static let previewUser = User(
        id: "preview-user-1",
        name: "Sophia Carter",
        email: "sophia.carter@example.com",
        imageURL: "https://randomuser.me/api/portraits/women/44.jpg",
        thumbnailURL: "https://randomuser.me/api/portraits/thumb/women/44.jpg",
        gender: "Female",
        username: "sophiacarter",
        phone: "(202) 555-0148",
        cell: "(202) 555-0199",
        city: "San Francisco",
        state: "California",
        country: "United States",
        streetAddress: "240 Market Street",
        age: 29
    )
}
