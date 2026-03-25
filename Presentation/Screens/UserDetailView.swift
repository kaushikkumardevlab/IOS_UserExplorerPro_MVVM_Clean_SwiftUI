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
                    title: AppStrings.profileSectionTitle,
                    rows: [
                        (AppStrings.usernameLabel, user.username),
                        (AppStrings.genderLabel, user.gender),
                        (AppStrings.ageLabel, "\(user.age) \(AppStrings.ageYearsSuffix)")
                    ]
                )
                infoSection(
                    title: AppStrings.contactSectionTitle,
                    rows: [
                        (AppStrings.emailLabel, user.email),
                        (AppStrings.phoneLabel, user.phone),
                        (AppStrings.cellLabel, user.cell)
                    ]
                )
                infoSection(
                    title: AppStrings.locationSectionTitle,
                    rows: [
                        (AppStrings.streetLabel, user.streetAddress),
                        (AppStrings.cityLabel, user.city),
                        (AppStrings.stateLabel, user.state),
                        (AppStrings.countryLabel, user.country)
                    ]
                )
            }
            .padding(20)
        }
        .background(
            LinearGradient(
                colors: [
                    AppColors.screenBackgroundTop,
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
                    AppColors.detailGradientStart,
                    AppColors.detailGradientEnd
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
        UserDetailView(user: .previewUser)
    }
}
