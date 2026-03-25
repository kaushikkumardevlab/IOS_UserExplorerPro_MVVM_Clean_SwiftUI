import SwiftUI

struct UserLocationView: View {

    let user: User

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                locationHero
                infoCard(
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
        .background(screenBackground)
        .navigationTitle(AppStrings.locationSectionTitle)
        .navigationBarTitleDisplayMode(.inline)
    }

    private var locationHero: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(user.city)
                .font(.title2.weight(.bold))
            Text(user.state)
                .font(.headline)
            Text(user.country)
                .font(.subheadline.weight(.semibold))
            Text(user.streetAddress)
                .font(.body)
                .padding(.top, 4)
        }
        .foregroundStyle(.white)
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(22)
        .background(
            LinearGradient(
                colors: [AppColors.detailGradientStart, AppColors.primaryGradientEnd],
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
