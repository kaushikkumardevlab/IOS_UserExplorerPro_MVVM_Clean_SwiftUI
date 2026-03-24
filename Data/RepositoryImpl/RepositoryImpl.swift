//
//  RepositoryImpl.swift
//  UserExplorerPro
//
//  Created by Kaushikkumar on 19/03/26.
//

class UserRepositoryImpl: UserRepository {

    private let api: APIService

    init(api: APIService) {
        self.api = api
    }

    func getUsers(page: Int) async throws -> [User] {
        let dtos = try await api.fetchUsers(page: page)
        return dtos.map { $0.toDomain() }
    }
}
