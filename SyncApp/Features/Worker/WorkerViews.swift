import SwiftUI

private let sampleShifts: [Shift] = [
    .init(day: "Mon", timeRange: "9:00a–3:00p", hours: 6, location: "Downtown", role: "Server", countdown: "Starts in 2h"),
    .init(day: "Tue", timeRange: "4:00p–10:00p", hours: 6, location: "Downtown", role: "Host", countdown: "Tomorrow")
]

private let marketShifts: [MarketplaceShift] = [
    .init(poster: "Alex P.", posterRole: "Server", date: "Wed, Mar 19", time: "5:00p–11:00p", location: "Downtown", roleTag: "Server", message: "Need to cover exam review", incentive: "$20 incentive"),
    .init(poster: "Jordan K.", posterRole: "Bartender", date: "Thu, Mar 20", time: "3:00p–9:00p", location: "Downtown", roleTag: "Bartender", message: nil, incentive: nil)
]

struct WorkerTabView: View {
    var body: some View {
        TabView {
            WorkerScheduleView().tabItem { Label("My Schedule", systemImage: "calendar") }
            MarketplaceView().tabItem { Label("Marketplace", systemImage: "bag") }
            AvailabilityView().tabItem { Label("Availability", systemImage: "clock") }
            ProfileView().tabItem { Label("Profile", systemImage: "person") }
        }
    }
}

struct WorkerScheduleView: View {
    @State private var showCheckIn = false

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack { ForEach(["Mon","Tue","Wed","Thu","Fri"], id: \.self) { day in FilterChip(label: day, selected: day == "Mon") } }
                    }

                    ForEach(sampleShifts) { shift in
                        GlassCard {
                            VStack(alignment: .leading, spacing: 8) {
                                Text("\(shift.day) • \(shift.timeRange)").font(.headline)
                                Text("\(shift.location) · \(shift.role)")
                                Text(shift.countdown).font(.caption).padding(6).background(SyncColors.bg2).clipShape(Capsule())
                                HStack { SoftButton(title: "Sell Shift", isPrimary: false) {}; SoftButton(title: "View Details", isPrimary: false) {} }
                            }
                        }
                    }
                }.padding()
            }
            .navigationTitle("My Schedule")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) { Button("Check-in") { showCheckIn = true } }
            }
            .sheet(isPresented: $showCheckIn) { PostShiftCheckInSheet() }
        }
    }
}

struct PostShiftCheckInSheet: View {
    @State private var mood: Int?
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("How was your shift today?").font(.title3.weight(.semibold))
            EmojiMoodScale(selectedMood: $mood)
            Text("Prefer to open or close this weekend?").font(.subheadline)
            HStack { FilterChip(label: "Open", selected: false); FilterChip(label: "Close", selected: true) }
            Button("Skip") {}
                .foregroundStyle(SyncColors.textSecondary)
            SoftButton(title: "Save") {}
        }
        .padding()
        .presentationDetents([.height(320)])
    }
}

struct AvailabilityView: View {
    var body: some View {
        NavigationStack {
            List {
                Section("Recurring Weekly Default") {
                    AvailabilityDayRow(day: "Monday")
                    AvailabilityDayRow(day: "Tuesday")
                    AvailabilityDayRow(day: "Wednesday")
                }
                Section("Week Override (Mar 17–23)") {
                    AvailabilityDayRow(day: "Thursday", isOverride: true)
                    AvailabilityDayRow(day: "Friday", isOverride: true)
                }
            }
            .navigationTitle("Availability")
            .safeAreaInset(edge: .bottom) {
                SoftButton(title: "Save Availability") {}
                    .padding()
                    .background(.ultraThinMaterial)
            }
        }
    }
}

struct AvailabilityDayRow: View {
    let day: String
    var isOverride = false
    @State private var isAvailable = true

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(day).font(.headline)
                if isOverride { Text("Override").font(.caption).padding(4).background(SyncColors.info).clipShape(Capsule()) }
                Spacer()
                Toggle("", isOn: $isAvailable).labelsHidden()
            }
            if isAvailable {
                Text("9:00 AM – 5:00 PM · Morning")
                    .font(.subheadline)
                    .foregroundStyle(SyncColors.textSecondary)
            }
        }
        .padding(.vertical, 4)
    }
}

struct MarketplaceView: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    Text("Open shifts from your team")
                        .foregroundStyle(SyncColors.textSecondary)
                    HStack { FilterChip(label: "Role", selected: true); FilterChip(label: "Date", selected: false); FilterChip(label: "Time", selected: false) }
                    ForEach(marketShifts) { shift in
                        GlassCard {
                            VStack(alignment: .leading, spacing: 8) {
                                Text("\(shift.poster) · \(shift.posterRole)")
                                    .font(.headline)
                                Text("\(shift.date) · \(shift.time)")
                                Text("\(shift.location) · \(shift.roleTag)")
                                if let message = shift.message { Text(message).font(.subheadline) }
                                if let incentive = shift.incentive { Text(incentive).font(.caption).padding(6).background(SyncColors.accentGradient).clipShape(Capsule()) }
                                HStack { SoftButton(title: "Decline", isPrimary: false) {}; SoftButton(title: "Claim") {} }
                            }
                        }
                    }
                }
                .padding()
            }
            .navigationTitle("Marketplace")
        }
    }
}
