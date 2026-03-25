import SwiftUI

struct UserProfileView: View {

    let user: User

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                heroCard
                infoCard(
                    title: AppStrings.profileSectionTitle,
                    rows: [
                        (AppStrings.usernameLabel, user.username),
                        (AppStrings.genderLabel, user.gender),
                        (AppStrings.ageLabel, "\(user.age) \(AppStrings.ageYearsSuffix)")
                    ]
                )
            }
            .padding(20)
        }
        .background(screenBackground)
        .navigationTitle(AppStrings.profileSectionTitle)
        .navigationBarTitleDisplayMode(.inline)
    }

    private var heroCard: some View {
        HStack(spacing: 16) {
            AsyncImage(url: URL(string: user.imageURL)) { image in
                image
                    .resizable()
                    .scaledToFill()
            } placeholder: {
                ProgressView()
                    .tint(.white)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            .frame(width: 92, height: 92)
            .background(.white.opacity(0.18))
            .clipShape(Circle())

            VStack(alignment: .leading, spacing: 6) {
                Text(user.name)
                    .font(.title2.weight(.bold))
                    .foregroundStyle(.white)

                Text("@\(user.username)")
                    .font(.subheadline.weight(.semibold))
                    .foregroundStyle(.white.opacity(0.9))

                Text("\(user.age) \(AppStrings.ageYearsSuffix)")
                    .font(.caption.weight(.semibold))
                    .foregroundStyle(.white)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 6)
                    .background(.white.opacity(0.18))
                    .clipShape(Capsule())
            }

            Spacer()
        }
        .padding(22)
        .frame(maxWidth: .infinity)
        .background(
            LinearGradient(
                colors: [AppColors.detailGradientStart, AppColors.detailGradientEnd],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        )
        .clipShape(RoundedRectangle(cornerRadius: 28, style: .continuous))
        .shadow(color: .black.opacity(0.1), radius: 16, y: 8)
    }

    private var screenBackground: some View {
        LinearGradient(
            colors: [AppColors.screenBackgroundTop, Color.white],
            startPoint: .top,
            endPoint: .bottom
        )
        .ignoresSafeArea()
    }

    private func infoCard(title: String, rows: [(String, String)]) -> some View {
        VStack(alignment: .leading, spacing: 14) {
            Text(title)
                .font(.title3.weight(.semibold))

            VStack(spacing: 0) {
                ForEach(Array(rows.enumerated()), id: \.offset) { index, row in
                    UserInfoRow(title: row.0, value: row.1)

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
