//
//  GetUsersUseCase.swift
//  UserExplorerPro
//
//  Created by Kaushikkumar on 19/03/26.
//

class GetUsersUseCase {

    private let repo: UserRepository

    init(repo: UserRepository) {
        self.repo = repo
    }

    func execute(page: Int) async throws -> [User] {
        try await repo.getUsers(page: page)
    }
}
