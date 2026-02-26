import SwiftUI

struct WorkerTabView: View {
    var body: some View {
        TabView {
            WorkerScheduleView()
                .tabItem { Label("My Schedule", systemImage: "calendar") }
            MarketplaceView()
                .tabItem { Label("Marketplace", systemImage: "bag") }
            AvailabilityView()
                .tabItem { Label("Availability", systemImage: "clock") }
            ProfileView(isManager: false)
                .tabItem { Label("Profile", systemImage: "person.crop.circle") }
        }
    }
}

struct WorkerScheduleView: View {
    @State private var mood: Int?
    @State private var showCheckIn = false

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 16) {
                    HStack {
                        ForEach(["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"], id: \.self) { day in
                            FilterChip(title: day, selected: day == "Wed")
                        }
                    }
                    .font(.caption)

                    ForEach(0..<3, id: \.self) { _ in
                        GlassCard {
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Wed · 11:00 AM – 7:00 PM")
                                    .font(.headline)
                                Text("8.0 hrs · Downtown")
                                    .foregroundStyle(.secondary)
                                HStack {
                                    FilterChip(title: "Server", selected: true)
                                    Spacer()
                                    Text("Starts in 2h")
                                        .font(.caption.weight(.medium))
                                        .padding(8)
                                        .background(.thinMaterial)
                                        .clipShape(Capsule())
                                }
                                HStack {
                                    SoftButton(title: "Sell Shift") {}
                                    SoftButton(title: "Details") {}
                                }
                            }
                        }
                    }
                }
                .padding()
            }
            .background(SyncTheme.bg0)
            .navigationTitle("My Schedule")
            .toolbar {
                ToolbarItem(placement: .bottomBar) {
                    SoftButton(title: "Request Time Off", isPrimary: true) {}
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Check-In") { showCheckIn = true }
                }
            }
            .sheet(isPresented: $showCheckIn) {
                PostShiftCheckInSheet(mood: $mood)
            }
        }
    }
}

struct AvailabilityView: View {
    @State private var days = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"].map {
        AvailabilityDay(weekday: $0, isAvailable: true, start: .now, end: .now.addingTimeInterval(6 * 3600), preferredWindow: .morning, notes: "")
    }

    var body: some View {
        NavigationStack {
            List {
                Section("Recurring Weekly Default") {
                    ForEach($days) { $day in
                        DisclosureGroup(day.weekday) {
                            Toggle("Available", isOn: $day.isAvailable)
                            Picker("Preferred", selection: $day.preferredWindow) {
                                ForEach(PreferredWindow.allCases) { window in
                                    Text(window.rawValue).tag(window)
                                }
                            }
                            TextField("Notes", text: $day.notes)
                        }
                    }
                }
                Section("Override Specific Week") {
                    Text("Select a week on calendar to override without changing default.")
                }
            }
            .navigationTitle("Availability")
            .safeAreaInset(edge: .bottom) {
                SoftButton(title: "Save", isPrimary: true) {}
                    .padding()
                    .background(.ultraThinMaterial)
            }
        }
    }
}

struct PostShiftCheckInSheet: View {
    @Binding var mood: Int?

    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 20) {
                Text("How was your shift today?")
                    .font(.title3.weight(.semibold))
                EmojiMoodScale(selection: $mood)
                Text("Prefer to open or close this weekend?")
                    .font(.subheadline.weight(.medium))
                HStack {
                    FilterChip(title: "Open", selected: false)
                    FilterChip(title: "Close", selected: true)
                }
                Button("Skip") {}
                    .foregroundStyle(.secondary)
                Spacer()
                SoftButton(title: "Save", isPrimary: true) {}
            }
            .padding()
            .presentationDetents([.height(340)])
        }
    }
}
