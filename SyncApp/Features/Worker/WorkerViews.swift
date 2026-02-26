import SwiftUI

struct WorkerTabView: View {
    var body: some View {
        TabView {
            WorkerScheduleView()
                .tabItem { Label("My Schedule", systemImage: "calendar") }
            MarketplaceView()
                .tabItem { Label("Marketplace", systemImage: "arrow.left.arrow.right") }
            AvailabilityView()
                .tabItem { Label("Availability", systemImage: "clock") }
            ProfileView()
                .tabItem { Label("Profile", systemImage: "person") }
        }
    }
}

struct WorkerScheduleView: View {
    @EnvironmentObject private var session: SessionStore
    @State private var selectedDay = 0

    var body: some View {
        NavigationStack {
            ScrollView {
                HStack(spacing: 8) {
                    ForEach(0..<7) { day in
                        FilterChip(title: shortDay(day), selected: selectedDay == day)
                            .onTapGesture { selectedDay = day }
                    }
                }
                .padding(.horizontal)

                VStack(spacing: 12) {
                    ForEach(session.shifts.filter { !$0.isMarketplace }) { shift in
                        ShiftCard(shift: shift, sellAction: {}, detailAction: {})
                    }
                }
                .padding()
            }
            .navigationTitle("My Schedule")
            .safeAreaInset(edge: .bottom) {
                SoftButton(title: "Request Time Off", systemImage: "plus", isPrimary: true) {}
                    .padding()
            }
        }
    }

    private func shortDay(_ offset: Int) -> String {
        let symbols = Calendar.current.shortWeekdaySymbols
        return symbols[offset]
    }
}

struct AvailabilityView: View {
    @State private var days = Calendar.current.weekdaySymbols.map { ($0, true) }

    var body: some View {
        NavigationStack {
            List {
                Section("Weekly default") {
                    ForEach(days.indices, id: \.self) { idx in
                        DisclosureGroup(days[idx].0) {
                            Toggle("Available", isOn: Binding(get: { days[idx].1 }, set: { days[idx].1 = $0 }))
                            Picker("Preferred", selection: .constant("Morning")) {
                                Text("Morning").tag("Morning")
                                Text("Afternoon").tag("Afternoon")
                                Text("Evening").tag("Evening")
                            }
                            .pickerStyle(.segmented)
                        }
                    }
                }
            }
            .navigationTitle("Availability")
            .safeAreaInset(edge: .bottom) {
                SoftButton(title: "Save Availability", isPrimary: true) {}
                    .padding()
            }
        }
    }
}

struct ShiftCard: View {
    let shift: Shift
    let sellAction: () -> Void
    let detailAction: () -> Void

    var body: some View {
        GlassCard {
            VStack(alignment: .leading, spacing: 10) {
                Text(shift.role)
                    .font(.headline)
                Text("\(shift.location) · 8h")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                HStack {
                    SoftButton(title: "Sell Shift", action: sellAction)
                    SoftButton(title: "View Details", action: detailAction)
                }
            }
        }
    }
}

struct MarketplaceView: View {
    @EnvironmentObject private var session: SessionStore

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 10) {
                    Text("Pick up open shifts")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            FilterChip(title: "Role", selected: true)
                            FilterChip(title: "Date", selected: false)
                            FilterChip(title: "Evening", selected: false)
                        }
                    }
                }
                .padding(.horizontal)

                VStack(spacing: 12) {
                    ForEach(session.shifts.filter { $0.isMarketplace }) { shift in
                        MarketplaceCard(shift: shift)
                    }
                }
                .padding()
            }
            .navigationTitle("Marketplace")
        }
    }
}

struct MarketplaceCard: View {
    let shift: Shift

    var body: some View {
        GlassCard {
            VStack(alignment: .leading, spacing: 8) {
                Text("\(shift.assigneeName) · \(shift.role)")
                    .font(.headline)
                Text("\(shift.location)")
                    .foregroundStyle(.secondary)
                if let note = shift.note {
                    Text(note)
                        .font(.footnote)
                }
                HStack {
                    SoftButton(title: "Decline") {}
                    SoftButton(title: "Claim", isPrimary: true) {}
                }
            }
        }
    }
}
