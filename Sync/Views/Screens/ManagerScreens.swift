import SwiftUI

struct ManagerTabView: View {
    var body: some View {
        TabView {
            ManagerScheduleView()
                .tabItem { Label("Schedule", systemImage: "calendar") }
            ManageView()
                .tabItem { Label("Manage", systemImage: "person.3") }
            NotificationsView()
                .tabItem { Label("Notifications", systemImage: "bell") }
            ProfileView(isManager: true)
                .tabItem { Label("Profile", systemImage: "person.crop.circle") }
        }
    }
}

struct ManagerScheduleView: View {
    @State private var isGenerating = false
    @State private var showInsights = false

    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
                HStack {
                    Picker("View", selection: .constant(0)) {
                        Text("List").tag(0)
                        Text("Grid").tag(1)
                    }
                    .pickerStyle(.segmented)
                    Button("Insights") { showInsights = true }
                }

                SoftButton(title: isGenerating ? "Sync is building your schedule…" : "Generate Schedule", isPrimary: true) {
                    isGenerating = true
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
                        isGenerating = false
                    }
                }

                List(0..<6, id: \.self) { _ in
                    HStack {
                        VStack(alignment: .leading) {
                            Text("Wed 11:00 – 7:00")
                            Text("Server · Downtown")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                        Spacer()
                        Menu {
                            Button("Reassign") {}
                            Button("Remove", role: .destructive) {}
                            Button("Add Note") {}
                        } label: {
                            Image(systemName: "ellipsis.circle")
                        }
                    }
                }
                .listStyle(.plain)
            }
            .padding()
            .navigationTitle("Schedule")
            .sheet(isPresented: $showInsights) { InsightsView() }
        }
    }
}

struct InsightsView: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 16) {
                    GlassCard {
                        VStack(alignment: .leading, spacing: 10) {
                            Text("Performance by Time of Day")
                                .font(.headline)
                            BarRow(label: "Morning", value: 0.72)
                            BarRow(label: "Afternoon", value: 0.86)
                            BarRow(label: "Evening", value: 0.64)
                            Text("Last updated: last night")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                    }
                    GlassCard {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Top Pairings")
                                .font(.headline)
                            Text("• Jordan + Priya on Afternoon Service")
                            Text("• Alex + Sam on Brunch")
                        }
                    }
                    GlassCard {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Employee Snapshot")
                                .font(.headline)
                            Text("Works well with 8 teammates")
                            Text("Best window: Afternoon")
                            Text("Avg tips and covers trending up")
                        }
                    }
                }
                .padding()
            }
            .navigationTitle("Insights")
        }
    }
}

struct BarRow: View {
    let label: String
    let value: CGFloat

    var body: some View {
        VStack(alignment: .leading) {
            Text(label)
                .font(.subheadline)
            GeometryReader { proxy in
                RoundedRectangle(cornerRadius: 8)
                    .fill(.thinMaterial)
                    .overlay(alignment: .leading) {
                        RoundedRectangle(cornerRadius: 8)
                            .fill(SyncTheme.accentGradient)
                            .frame(width: proxy.size.width * value)
                    }
            }
            .frame(height: 12)
        }
    }
}

struct ManageView: View {
    var body: some View {
        NavigationStack {
            List {
                Text("Team roster")
                Text("Role assignments by shift")
                Text("Coverage warnings")
            }
            .navigationTitle("Manage")
        }
    }
}

struct NotificationsView: View {
    var body: some View {
        NavigationStack {
            List {
                ForEach(0..<4, id: \.self) { _ in
                    GlassCard {
                        VStack(alignment: .leading) {
                            Text("Shift trade completed")
                                .font(.headline)
                            Text("Downtown · Just now")
                                .foregroundStyle(.secondary)
                        }
                    }
                    .swipeActions {
                        Button("Dismiss", role: .destructive) {}
                    }
                }
            }
            .navigationTitle("Notifications")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Mark all read") {}
                }
            }
        }
    }
}
