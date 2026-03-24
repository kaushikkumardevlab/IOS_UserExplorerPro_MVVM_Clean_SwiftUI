//
//  AppDI.swift
//  UserExplorerPro
//
//  Created by Kaushikkumar on 19/03/26.
//

class AppDI {

    static func makeUserViewModel() -> UserViewModel {
        let api = APIService()
        let repo = UserRepositoryImpl(api: api)
        let useCase = GetUsersUseCase(repo: repo)

        return UserViewModel(useCase: useCase)
    }
}
