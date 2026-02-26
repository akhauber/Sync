import SwiftUI

struct ManagerTabView: View {
    var body: some View {
        TabView {
            ManagerScheduleView().tabItem { Label("Schedule", systemImage: "calendar") }
            ManageView().tabItem { Label("Manage", systemImage: "person.3") }
            NotificationsView().tabItem { Label("Notifications", systemImage: "bell") }
            ProfileView().tabItem { Label("Profile", systemImage: "person") }
        }
    }
}

struct ManagerScheduleView: View {
    @State private var showInsights = false

    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
                HStack {
                    FilterChip(label: "List", selected: true)
                    FilterChip(label: "Grid", selected: false)
                    Spacer()
                }

                GlassCard {
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Generate next week")
                            .font(.headline)
                        Text("Uses availability, mood trends, and Toast performance.")
                            .foregroundStyle(SyncColors.textSecondary)
                        SoftButton(title: "Generate Schedule", icon: "sparkles") {}
                    }
                }

                Spacer()
            }
            .padding()
            .navigationTitle("Schedule")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showInsights = true
                    } label: {
                        Image(systemName: "chart.bar.doc.horizontal")
                    }
                    .accessibilityLabel("Insights")
                }
            }
            .sheet(isPresented: $showInsights) {
                InsightsView()
            }
        }
    }
}

struct InsightsView: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 16) {
                    GlassCard {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Performance by time of day").font(.headline)
                            InsightBar(label: "Morning", value: 0.78)
                            InsightBar(label: "Afternoon", value: 0.63)
                            InsightBar(label: "Evening", value: 0.89)
                            Text("Last updated: Last night, 2:14 AM")
                                .font(.caption)
                                .foregroundStyle(SyncColors.textTertiary)
                        }
                    }

                    GlassCard {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Top pairings").font(.headline)
                            Text("Server + Host on evening shifts")
                            Text("Coverage gaps: Friday close")
                                .foregroundStyle(SyncColors.warning)
                        }
                    }
                }
                .padding()
            }
            .navigationTitle("Insights")
        }
    }
}

struct InsightBar: View {
    let label: String
    let value: CGFloat

    var body: some View {
        VStack(alignment: .leading) {
            Text(label).font(.subheadline)
            GeometryReader { geo in
                ZStack(alignment: .leading) {
                    RoundedRectangle(cornerRadius: 8).fill(SyncColors.bg2)
                    RoundedRectangle(cornerRadius: 8)
                        .fill(SyncColors.accentGradient)
                        .frame(width: geo.size.width * value)
                }
            }
            .frame(height: 10)
        }
    }
}

struct ManageView: View {
    var body: some View {
        NavigationStack {
            List {
                Label("Team roster", systemImage: "person.3")
                Label("Assign roles per shift", systemImage: "person.crop.rectangle")
                Label("Coverage warnings", systemImage: "exclamationmark.triangle")
            }
            .navigationTitle("Manage")
        }
    }
}

struct NotificationsView: View {
    private let items = [
        AppNotification(title: "Shift trade completed", subtitle: "Maya claimed Alex's shift", timestamp: "Now"),
        AppNotification(title: "Coverage gap detected", subtitle: "Friday close needs 1 Server", timestamp: "10m"),
        AppNotification(title: "Schedule generated", subtitle: "Week of Mar 24 ready for edits", timestamp: "1h")
    ]

    var body: some View {
        NavigationStack {
            List(items) { item in
                VStack(alignment: .leading, spacing: 6) {
                    Text(item.title).font(.headline)
                    Text(item.subtitle)
                    Text(item.timestamp).font(.caption).foregroundStyle(SyncColors.textSecondary)
                }
                .swipeActions {
                    Button("Dismiss", role: .destructive) {}
                }
            }
            .navigationTitle("Notifications")
            .toolbar { Button("Mark all read") {} }
        }
    }
}
