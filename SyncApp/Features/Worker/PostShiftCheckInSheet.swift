import SwiftUI

struct PostShiftCheckInSheet: View {
    @State private var mood: String?
    @State private var choice: String?

    var body: some View {
        VStack(spacing: 20) {
            Text("How was your shift today?")
                .font(.headline)
            EmojiMoodScale(selectedMood: $mood)

            VStack(alignment: .leading, spacing: 10) {
                Text("Prefer to open or close this weekend?")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                HStack {
                    FilterChip(title: "Open", selected: choice == "Open")
                        .onTapGesture { choice = "Open" }
                    FilterChip(title: "Close", selected: choice == "Close")
                        .onTapGesture { choice = "Close" }
                }
            }

            SoftButton(title: "Submit", isPrimary: true) {}
            Button("Skip") {}
                .foregroundStyle(.secondary)
        }
        .padding()
        .presentationDetents([.fraction(0.42)])
    }
}
