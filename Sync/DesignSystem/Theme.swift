import SwiftUI

enum SyncTheme {
    static let bg0 = Color(red: 0.95, green: 0.93, blue: 0.89)
    static let bg0Dark = Color(red: 0.14, green: 0.13, blue: 0.12)
    static let bg1 = Color.white.opacity(0.75)
    static let bg2 = Color.white.opacity(0.5)
    static let stroke = Color.black.opacity(0.08)

    static let textPrimary = Color.primary
    static let textSecondary = Color.secondary
    static let success = Color(red: 0.47, green: 0.62, blue: 0.46)
    static let warning = Color(red: 0.82, green: 0.58, blue: 0.29)
    static let destructive = Color(red: 0.72, green: 0.36, blue: 0.32)

    static let accentGradient = LinearGradient(
        colors: [Color(red: 0.93, green: 0.80, blue: 0.52),
                 Color(red: 0.91, green: 0.75, blue: 0.50),
                 Color(red: 0.93, green: 0.72, blue: 0.62)],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )

    static func appBackground(for scheme: ColorScheme) -> Color {
        scheme == .dark ? bg0Dark : bg0
    }
}
