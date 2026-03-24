//
//  UserListView.swift
//  UserExplorerPro
//
//  Created by Kaushikkumar on 19/03/26.
//

import SwiftUI

struct UserListView: View {

    @StateObject var vm = AppDI.makeUserViewModel()

    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(
                    colors: [
                        Color(red: 0.96, green: 0.98, blue: 1.0),
                        Color(red: 0.91, green: 0.96, blue: 0.98),
                        Color.white
                    ],
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()

                ScrollView {
                    LazyVStack(spacing: 20, pinnedViews: [.sectionHeaders]) {
                        Section {
                            LazyVStack(spacing: 16) {
                            ForEach(vm.users) { user in
                                NavigationLink(value: user) {
                                    UserCardView(user: user)
                                }
                                .buttonStyle(.plain)
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
                        } header: {
                            stickyHeader
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 8)
                    .padding(.bottom, 24)
                }
            }
            .navigationTitle("Users")
            .navigationBarTitleDisplayMode(.large)
            .navigationDestination(for: User.self) { user in
                UserDetailView(user: user)
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
                        Color(red: 0.96, green: 0.98, blue: 1.0),
                        Color(red: 0.91, green: 0.96, blue: 0.98)
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
                    Color(red: 0.17, green: 0.36, blue: 0.88),
                    Color(red: 0.15, green: 0.73, blue: 0.78)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )

            Circle()
                .fill(.white.opacity(0.12))
                .frame(width: 180, height: 180)
                .offset(x: 110, y: -70)

            VStack(alignment: .leading, spacing: 10) {
                Text("User Explorer")
                    .font(.system(size: 30, weight: .bold, design: .rounded))
                    .foregroundStyle(.white)

                Text("Browse profiles, preview locations, and open detailed contact information.")
                    .font(.subheadline)
                    .foregroundStyle(.white.opacity(0.9))

                Label("\(vm.users.count) loaded", systemImage: "person.3.fill")
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
        .frame(height: 190)
        .clipShape(RoundedRectangle(cornerRadius: 28, style: .continuous))
        .shadow(color: .black.opacity(0.12), radius: 18, y: 10)
    }

    private var loadingCard: some View {
        HStack(spacing: 12) {
            ProgressView()

            Text("Loading more users...")
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
            .background(Color(red: 0.92, green: 0.95, blue: 1.0))
            .clipShape(RoundedRectangle(cornerRadius: 22, style: .continuous))

            VStack(alignment: .leading, spacing: 8) {
                HStack(alignment: .top) {
                    VStack(alignment: .leading, spacing: 4) {
                        Text(user.name)
                            .font(.headline)
                            .foregroundStyle(.primary)

                        Text("@\(user.username)")
                            .font(.caption.weight(.semibold))
                            .foregroundStyle(Color(red: 0.15, green: 0.48, blue: 0.78))
                    }

                    Spacer(minLength: 12)

                    Text(user.gender)
                        .font(.caption.weight(.semibold))
                        .foregroundStyle(Color(red: 0.11, green: 0.48, blue: 0.55))
                        .padding(.horizontal, 10)
                        .padding(.vertical, 6)
                        .background(Color(red: 0.86, green: 0.96, blue: 0.94))
                        .clipShape(Capsule())
                }

                Text(user.email)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .lineLimit(1)

                HStack(spacing: 8) {
                    Label(user.city, systemImage: "mappin.circle.fill")
                    Text("•")
                    Text("\(user.age) yrs")
                }
                .font(.caption)
                .foregroundStyle(.tertiary)
            }

            Image(systemName: "arrow.up.right")
                .font(.footnote.weight(.bold))
                .foregroundStyle(Color(red: 0.16, green: 0.40, blue: 0.82))
                .padding(10)
                .background(Color(red: 0.91, green: 0.95, blue: 1.0))
                .clipShape(Circle())
        }
        .padding(18)
        .background(.white.opacity(0.92))
        .clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
        .shadow(color: .black.opacity(0.06), radius: 14, y: 8)
    }
}

