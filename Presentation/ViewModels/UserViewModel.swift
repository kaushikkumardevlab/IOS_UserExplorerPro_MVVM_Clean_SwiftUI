//
//  UserViewModel.swift
//  UserExplorerPro
//
//  Created by Kaushikkumar on 19/03/26.
//

import Combine
import SwiftUI

@MainActor
class UserViewModel: ObservableObject {

    @Published var users: [User] = []
    @Published var isLoading = false

    private let useCase: GetUsersUseCase

    private var page = 1

    init(useCase: GetUsersUseCase) {
        self.useCase = useCase
    }

    func loadUsers() {
        Task {
            isLoading = true

            do {
                let newUsers = try await useCase.execute(page: page)
                users.append(contentsOf: newUsers)
                page += 1
            } catch {
                print(error)
            }

            isLoading = false
        }
    }
}
