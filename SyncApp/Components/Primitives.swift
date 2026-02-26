import SwiftUI

struct GlassCard<Content: View>: View {
    @ViewBuilder var content: Content

    var body: some View {
        content.syncCardStyle()
    }
}

struct InsetWell<Content: View>: View {
    @ViewBuilder var content: Content

    var body: some View {
        content.syncInsetStyle()
    }
}

struct SoftButton: View {
    let title: String
    var icon: String? = nil
    var isPrimary: Bool = true
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 8) {
                if let icon {
                    Image(systemName: icon)
                }
                Text(title)
                    .font(.headline)
            }
            .foregroundStyle(isPrimary ? .black : SyncColors.textPrimary)
            .frame(maxWidth: .infinity)
            .frame(height: 50)
            .background(background)
            .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
        }
        .buttonStyle(.plain)
    }

    @ViewBuilder
    private var background: some View {
        if isPrimary {
            SyncColors.accentGradient
        } else {
            SyncColors.bg1
        }
    }
}

struct FilterChip: View {
    let label: String
    var selected: Bool

    var body: some View {
        Text(label)
            .font(.subheadline.weight(.medium))
            .padding(.horizontal, 14)
            .padding(.vertical, 9)
            .background(selected ? AnyShapeStyle(SyncColors.accentGradient) : AnyShapeStyle(SyncColors.bg1))
            .clipShape(Capsule())
            .overlay(Capsule().stroke(SyncColors.stroke))
    }
}

struct EmojiMoodScale: View {
    @Binding var selectedMood: Int?
    private let moods = ["😞", "😕", "😐", "🙂", "😄"]

    var body: some View {
        HStack(spacing: 12) {
            ForEach(Array(moods.enumerated()), id: \.offset) { idx, emoji in
                Button {
                    selectedMood = idx
                } label: {
                    Text(emoji)
                        .font(.title2)
                        .frame(width: 44, height: 44)
                        .background((selectedMood == idx ? SyncColors.accentGradient : LinearGradient(colors: [SyncColors.bg1], startPoint: .top, endPoint: .bottom)))
                        .clipShape(Circle())
                }
                .accessibilityLabel("Mood \(idx + 1)")
            }
        }
    }
}
