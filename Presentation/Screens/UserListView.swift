//
//  UserListView.swift
//  UserExplorerPro
//
//  Created by Kaushikkumar
//

import SwiftUI

private enum UserRoute: Hashable {
    case detail(User)
    case profile(User)
    case contact(User)
    case location(User)
}

struct UserListView: View {

    @StateObject var vm = AppDI.makeUserViewModel()

    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(
                    colors: [
                        AppColors.screenBackgroundTop,
                        AppColors.screenBackgroundMiddle,
                        Color.brown
                    ],
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()

                ScrollView {
                    LazyVStack(spacing: 20, pinnedViews: [.sectionHeaders]) {
                        Section(header:stickyHeader) {
                            LazyVStack(spacing: 16) {
                            ForEach(vm.users) { user in
                                UserCardView(user: user)
                                .onAppear {
                                    if user.id == vm.users.last?.id {
                                        vm.loadUsers()
                                    }
                                }
                            }

                            if vm.isLoading {
                                loadingCard
                            }
                            }
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 8)
                    .padding(.bottom, 24)
                }
            }
            .navigationTitle(AppStrings.usersNavigationTitle)
            .navigationBarTitleDisplayMode(.large)
            .navigationDestination(for: UserRoute.self) { route in
                switch route {
                case .detail(let user):
                    UserDetailView(user: user)
                case .profile(let user):
                    UserProfileView(user: user)
                case .contact(let user):
                    UserContactView(user: user)
                case .location(let user):
                    UserLocationView(user: user)
                }
            }
        }
        .onAppear {
            if vm.users.isEmpty {
                vm.loadUsers()
            }
        }
    }

    private var stickyHeader: some View {
        headerCard
            .padding(.bottom, 4)
            .background(
                LinearGradient(
                    colors: [
                        AppColors.screenBackgroundTop,
                        AppColors.screenBackgroundMiddle
                    ],
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()
            )
    }

    private var headerCard: some View {
        ZStack(alignment: .bottomLeading) {
            LinearGradient(
                colors: [
                    AppColors.primaryGradientStart,
                    AppColors.primaryGradientEnd
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )

            VStack(alignment: .leading, spacing: 10) {
                Text(AppStrings.userExplorerTitle)
                    .font(.system(size: 30, weight: .bold, design: .rounded))
                    .foregroundStyle(.white)

                Text(AppStrings.userExplorerSubtitle)
                    .font(.subheadline)
                    .foregroundStyle(.white.opacity(0.9))

                Label("\(vm.users.count) \(AppStrings.loadedUsersSuffix)", systemImage: "person.3.fill")
                    .font(.subheadline.weight(.semibold))
                    .foregroundStyle(.white)
                    .padding(.horizontal, 14)
                    .padding(.vertical, 8)
                    .background(.white.opacity(0.18))
                    .clipShape(Capsule())
            }
            .padding(24)
        }
        .frame(maxWidth: .infinity)
        .frame(height: 150)
        .clipShape(RoundedRectangle(cornerRadius: 28, style: .continuous))
        .shadow(color: .black.opacity(0.12), radius: 18, y: 10)
    }

    private var loadingCard: some View {
        HStack(spacing: 12) {
            ProgressView()

            Text(AppStrings.loadingMoreUsers)
                .font(.subheadline.weight(.medium))
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity, alignment: .center)
        .padding(.vertical, 18)
        .background(.white.opacity(0.85))
        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
    }
}

private struct UserCardView: View {

    let user: User

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack(spacing: 16) {
                AsyncImage(url: URL(string: user.thumbnailURL)) { image in
                    image
                        .resizable()
                        .scaledToFill()
                } placeholder: {
                    ProgressView()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
                .frame(width: 72, height: 72)
                .background(AppColors.cardBackground)
                .clipShape(RoundedRectangle(cornerRadius: 22, style: .continuous))

                VStack(alignment: .leading, spacing: 8) {
                    HStack(alignment: .top) {
                        VStack(alignment: .leading, spacing: 4) {
                            Text(user.name)
                                .font(.headline)
                                .foregroundStyle(.primary)

                            Text("@\(user.username)")
                                .font(.caption.weight(.semibold))
                                .foregroundStyle(AppColors.usernameText)
                        }

                        Spacer(minLength: 12)

                        Text(user.gender)
                            .font(.caption.weight(.semibold))
                            .foregroundStyle(AppColors.genderText)
                            .padding(.horizontal, 10)
                            .padding(.vertical, 6)
                            .background(AppColors.genderBackground)
                            .clipShape(Capsule())
                        
                        
                        NavigationLink(value: UserRoute.detail(user)) {
                            Image(systemName: "arrow.up.right")
                                .font(.footnote.weight(.bold))
                                .foregroundStyle(AppColors.actionIcon)
                                .padding(10)
                                .background(AppColors.actionBackground)
                                .clipShape(Circle())
                        }
                        .buttonStyle(.plain)
                    }

                    Text(user.email)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                        .lineLimit(1)

                    HStack(spacing: 8) {
                        Label(user.city, systemImage: "mappin.circle.fill")
                        Text("•")
                        Text("\(user.age) \(AppStrings.yearsShortSuffix)")
                    }
                    .font(.caption)
                    .foregroundStyle(.tertiary)
                }
            }

            HStack(spacing: 10) {
                cardActionLink(
                    icon: "person.text.rectangle",
                    title: AppStrings.profileActionTitle,
                    route: .profile(user)
                )

                cardActionLink(
                    icon: "phone.fill",
                    title: AppStrings.contactActionTitle,
                    route: .contact(user)
                )

                cardActionLink(
                    icon: "map.fill",
                    title: AppStrings.locationActionTitle,
                    route: .location(user)
                )

//                Spacer(minLength: 8)

                
            }
        }
        .padding(18)
        .background(.white.opacity(0.92))
        .clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
        .shadow(color: .black.opacity(0.06), radius: 14, y: 8)
    }

    private func cardActionLink(icon: String, title: String, route: UserRoute) -> some View {
        NavigationLink(value: route) {
            Label(title, systemImage: icon)
                .font(.caption.weight(.semibold))
                .foregroundStyle(AppColors.actionIcon)
                .padding(.horizontal, 12)
                .padding(.vertical, 8)
                .background(AppColors.actionBackground)
                .clipShape(Capsule())
        }
        .buttonStyle(.plain)
    }
}

#Preview("User Card") {
    UserCardView(user: .previewUser)
    .padding()
    .background(
        LinearGradient(
            colors: [AppColors.screenBackgroundTop, AppColors.screenBackgroundMiddle],
            startPoint: .top,
            endPoint: .bottom
        )
    )
}
