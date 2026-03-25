import SwiftUI

struct UserContactView: View {

    let user: User

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                contactHero
                infoCard(
                    title: AppStrings.contactSectionTitle,
                    rows: [
                        (AppStrings.emailLabel, user.email),
                        (AppStrings.phoneLabel, user.phone),
                        (AppStrings.cellLabel, user.cell)
                    ]
                )
            }
            .padding(20)
        }
        .background(screenBackground)
        .navigationTitle(AppStrings.contactSectionTitle)
        .navigationBarTitleDisplayMode(.inline)
    }

    private var contactHero: some View {
        VStack(alignment: .leading, spacing: 12) {
            Label(user.email, systemImage: "envelope.fill")
            Label(user.phone, systemImage: "phone.fill")
            Label(user.cell, systemImage: "iphone")
        }
        .font(.headline)
        .foregroundStyle(.white)
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(22)
        .background(
            LinearGradient(
                colors: [AppColors.primaryGradientStart, AppColors.primaryGradientEnd],
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
