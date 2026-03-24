//
//  APIService.swift
//  UserExplorerPro
//
//  Created by Kaushikkumar on 19/03/26.
//

import Foundation

class APIService {

    func fetchUsers(page: Int) async throws -> [UserDTO] {
        let url = URL(string: "https://randomuser.me/api/?page=\(page)&results=20")!

        let (data, _) = try await URLSession.shared.data(from: url)

        let response = try JSONDecoder().decode(UserResponse.self, from: data)
        return response.results
    }
}
