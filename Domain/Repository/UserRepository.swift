//
//  UserRepository.swift
//  UserExplorerPro
//
//  Created by Kaushikkumar on 19/03/26.
//

protocol UserRepository {
    func getUsers(page: Int) async throws -> [User]
}
