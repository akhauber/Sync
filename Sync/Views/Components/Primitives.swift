import SwiftUI

struct GlassCard<Content: View>: View {
    let content: Content

    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    var body: some View {
        content
            .padding(16)
            .background(.ultraThinMaterial)
            .overlay(
                RoundedRectangle(cornerRadius: 24)
                    .stroke(SyncTheme.stroke, lineWidth: 1)
            )
            .clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
            .shadow(color: .black.opacity(0.08), radius: 12, x: 0, y: 8)
            .shadow(color: .white.opacity(0.35), radius: 4, x: 0, y: -1)
    }
}

struct InsetWell<Content: View>: View {
    let content: Content

    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    var body: some View {
        content
            .padding(12)
            .background(SyncTheme.bg2)
            .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
            .overlay(
                RoundedRectangle(cornerRadius: 18)
                    .stroke(.white.opacity(0.45), lineWidth: 1)
            )
    }
}

struct SoftButton: View {
    let title: String
    var isPrimary: Bool = false
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.headline)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 14)
        }
        .background(isPrimary ? AnyShapeStyle(SyncTheme.accentGradient) : AnyShapeStyle(.thinMaterial))
        .foregroundStyle(.primary)
        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(SyncTheme.stroke, lineWidth: 1)
        )
        .contentShape(Rectangle())
    }
}

struct EmojiMoodScale: View {
    @Binding var selection: Int?
    private let emojis = ["😞", "😕", "😐", "🙂", "😄"]

    var body: some View {
        HStack(spacing: 8) {
            ForEach(0..<emojis.count, id: \.self) { index in
                Button {
                    selection = index + 1
                } label: {
                    Text(emojis[index])
                        .font(.title2)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 8)
                        .background(selection == index + 1 ? SyncTheme.accentGradient : LinearGradient(colors: [.clear], startPoint: .top, endPoint: .bottom))
                        .clipShape(Capsule())
                }
                .accessibilityLabel("Mood \(index + 1)")
            }
        }
    }
}

struct FilterChip: View {
    let title: String
    var selected: Bool

    var body: some View {
        Text(title)
            .font(.subheadline.weight(.medium))
            .padding(.horizontal, 14)
            .padding(.vertical, 8)
            .background(selected ? AnyShapeStyle(SyncTheme.accentGradient) : AnyShapeStyle(.thinMaterial))
            .clipShape(Capsule())
            .overlay(Capsule().stroke(SyncTheme.stroke, lineWidth: 1))
    }
}
