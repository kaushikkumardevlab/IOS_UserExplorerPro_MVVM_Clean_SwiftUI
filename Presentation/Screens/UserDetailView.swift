//
//  UserDetailView.swift
//  UserExplorerPro
//
//  Created by Kaushikkumar on 19/03/26.
//

import SwiftUI

struct UserDetailView: View {

    let user: User

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                headerSection
                infoSection(
                    title: "Profile",
                    rows: [
                        ("Username", user.username),
                        ("Gender", user.gender),
                        ("Age", "\(user.age) years")
                    ]
                )
                infoSection(
                    title: "Contact",
                    rows: [
                        ("Email", user.email),
                        ("Phone", user.phone),
                        ("Cell", user.cell)
                    ]
                )
                infoSection(
                    title: "Location",
                    rows: [
                        ("Street", user.streetAddress),
                        ("City", user.city),
                        ("State", user.state),
                        ("Country", user.country)
                    ]
                )
            }
            .padding(20)
        }
        .background(
            LinearGradient(
                colors: [
                    Color(red: 0.96, green: 0.98, blue: 1.0),
                    Color.white
                ],
                startPoint: .top,
                endPoint: .bottom
            )
        )
        .navigationTitle(user.name)
        .navigationBarTitleDisplayMode(.inline)
    }

    private var headerSection: some View {
        ZStack(alignment: .bottomLeading) {
            LinearGradient(
                colors: [
                    Color(red: 0.19, green: 0.40, blue: 0.88),
                    Color(red: 0.14, green: 0.72, blue: 0.78)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )

            VStack(alignment: .leading, spacing: 16) {
                AsyncImage(url: URL(string: user.imageURL)) { image in
                    image
                        .resizable()
                        .scaledToFill()
                } placeholder: {
                    ProgressView()
                        .tint(.white)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
                .frame(width: 110, height: 110)
                .background(.white.opacity(0.2))
                .clipShape(Circle())
                .overlay(
                    Circle()
                        .stroke(.white.opacity(0.35), lineWidth: 3)
                )

                VStack(alignment: .leading, spacing: 6) {
                    Text(user.name)
                        .font(.system(size: 28, weight: .bold, design: .rounded))
                        .foregroundStyle(.white)

                    Text("\(user.city), \(user.country)")
                        .font(.headline)
                        .foregroundStyle(.white.opacity(0.9))
                }
            }
            .padding(24)
        }
        .frame(maxWidth: .infinity)
        .frame(height: 280)
        .clipShape(RoundedRectangle(cornerRadius: 28, style: .continuous))
        .shadow(color: .black.opacity(0.12), radius: 20, y: 10)
    }

    private func infoSection(title: String, rows: [(String, String)]) -> some View {
        VStack(alignment: .leading, spacing: 14) {
            Text(title)
                .font(.title3.weight(.semibold))

            VStack(spacing: 0) {
                ForEach(Array(rows.enumerated()), id: \.offset) { index, row in
                    DetailRow(title: row.0, value: row.1)

                    if index < rows.count - 1 {
                        Divider()
                            .padding(.leading, 16)
                    }
                }
            }
            .background(.white)
            .clipShape(RoundedRectangle(cornerRadius: 22, style: .continuous))
            .shadow(color: .black.opacity(0.06), radius: 14, y: 6)
        }
    }
}

private struct DetailRow: View {

    let title: String
    let value: String

    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            Text(title)
                .font(.subheadline.weight(.semibold))
                .foregroundStyle(.secondary)
                .frame(width: 86, alignment: .leading)

            Text(value)
                .font(.body)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(16)
    }
}

#Preview {
    NavigationStack {
        UserDetailView(
            user: User(
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
        )
    }
}
