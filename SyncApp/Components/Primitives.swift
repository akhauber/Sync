import SwiftUI

struct GlassCard<Content: View>: View {
    let content: Content

    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    var body: some View {
        content
            .padding(16)
            .raisedSurface()
    }
}

struct SoftButton: View {
    let title: String
    var systemImage: String? = nil
    var isPrimary: Bool = false
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 8) {
                if let systemImage {
                    Image(systemName: systemImage)
                }
                Text(title)
                    .fontWeight(.semibold)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 14)
            .background(isPrimary ? AnyShapeStyle(AccentFill()) : AnyShapeStyle(SyncColors.raised))
            .foregroundStyle(.primary)
            .clipShape(RoundedRectangle(cornerRadius: SyncRadius.button, style: .continuous))
            .overlay(
                RoundedRectangle(cornerRadius: SyncRadius.button, style: .continuous)
                    .stroke(SyncColors.stroke, lineWidth: 1)
            )
        }
        .buttonStyle(.plain)
        .scaleEffect(1)
        .accessibilityLabel(title)
    }
}

struct FilterChip: View {
    let title: String
    var selected: Bool

    var body: some View {
        Text(title)
            .font(.subheadline.weight(.medium))
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
            .background(selected ? AnyShapeStyle(AccentFill()) : AnyShapeStyle(SyncColors.inset))
            .clipShape(Capsule())
            .overlay(Capsule().stroke(SyncColors.stroke, lineWidth: 1))
    }
}

struct EmojiMoodScale: View {
    @Binding var selectedMood: String?
    private let options = ["😞", "😕", "😐", "🙂", "😄"]

    var body: some View {
        HStack(spacing: 12) {
            ForEach(options, id: \.self) { emoji in
                Button {
                    selectedMood = emoji
                } label: {
                    Text(emoji)
                        .font(.system(size: 28))
                        .padding(10)
                        .background(selectedMood == emoji ? AnyShapeStyle(AccentFill()) : AnyShapeStyle(SyncColors.inset))
                        .clipShape(Circle())
                }
                .buttonStyle(.plain)
                .accessibilityLabel("Mood \(emoji)")
            }
        }
    }
}
