import SwiftUI

enum SyncColors {
    static let bg0 = Color(red: 0.96, green: 0.94, blue: 0.90)
    static let bg1 = Color(red: 0.98, green: 0.97, blue: 0.95)
    static let bg2 = Color(red: 0.92, green: 0.90, blue: 0.86)
    static let stroke = Color.black.opacity(0.08)

    static let textPrimary = Color(red: 0.16, green: 0.15, blue: 0.14)
    static let textSecondary = Color(red: 0.34, green: 0.33, blue: 0.31)
    static let textTertiary = Color(red: 0.52, green: 0.50, blue: 0.47)

    static let success = Color(red: 0.52, green: 0.63, blue: 0.51)
    static let warning = Color(red: 0.86, green: 0.63, blue: 0.32)
    static let destructive = Color(red: 0.75, green: 0.40, blue: 0.36)
    static let info = Color(red: 0.74, green: 0.69, blue: 0.61)

    static let accentGradient = LinearGradient(
        colors: [
            Color(red: 0.94, green: 0.82, blue: 0.56),
            Color(red: 0.89, green: 0.76, blue: 0.52),
            Color(red: 0.93, green: 0.72, blue: 0.61)
        ],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
}

extension View {
    func syncCardStyle(radius: CGFloat = 24) -> some View {
        self
            .padding(16)
            .background(
                RoundedRectangle(cornerRadius: radius, style: .continuous)
                    .fill(.ultraThinMaterial)
                    .overlay(
                        RoundedRectangle(cornerRadius: radius, style: .continuous)
                            .stroke(SyncColors.stroke)
                    )
                    .shadow(color: .black.opacity(0.08), radius: 12, x: 0, y: 8)
                    .shadow(color: .white.opacity(0.75), radius: 4, x: -2, y: -2)
            )
    }

    func syncInsetStyle(radius: CGFloat = 18) -> some View {
        self
            .padding(12)
            .background(
                RoundedRectangle(cornerRadius: radius, style: .continuous)
                    .fill(SyncColors.bg2)
                    .overlay(
                        RoundedRectangle(cornerRadius: radius, style: .continuous)
                            .stroke(SyncColors.stroke)
                    )
            )
    }
}
