import SwiftUI

enum SyncColors {
    static let background = Color(red: 0.96, green: 0.94, blue: 0.90)
    static let raised = Color(red: 0.98, green: 0.96, blue: 0.93)
    static let inset = Color(red: 0.92, green: 0.90, blue: 0.86)
    static let stroke = Color.primary.opacity(0.08)
    static let primaryText = Color.primary
    static let secondaryText = Color.secondary
    static let accentStart = Color(red: 0.91, green: 0.78, blue: 0.48)
    static let accentMiddle = Color(red: 0.89, green: 0.74, blue: 0.47)
    static let accentEnd = Color(red: 0.93, green: 0.70, blue: 0.56)
    static let success = Color(red: 0.50, green: 0.67, blue: 0.53)
    static let warning = Color(red: 0.82, green: 0.61, blue: 0.32)
    static let destructive = Color(red: 0.77, green: 0.43, blue: 0.39)
}

enum SyncRadius {
    static let card: CGFloat = 24
    static let button: CGFloat = 20
}

struct RaisedSurface: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background(.ultraThinMaterial)
            .clipShape(RoundedRectangle(cornerRadius: SyncRadius.card, style: .continuous))
            .overlay(
                RoundedRectangle(cornerRadius: SyncRadius.card, style: .continuous)
                    .stroke(SyncColors.stroke, lineWidth: 1)
            )
            .shadow(color: .black.opacity(0.10), radius: 12, x: 0, y: 8)
            .shadow(color: .white.opacity(0.18), radius: 8, x: -2, y: -2)
    }
}

extension View {
    func raisedSurface() -> some View { modifier(RaisedSurface()) }

    func syncTitle() -> some View {
        font(.system(.largeTitle, design: .default, weight: .semibold))
            .tracking(-0.4)
    }
}

struct AccentFill: ShapeStyle {
    func resolve(in environment: EnvironmentValues) -> some ShapeStyle {
        LinearGradient(
            colors: [SyncColors.accentStart, SyncColors.accentMiddle, SyncColors.accentEnd],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }
}
