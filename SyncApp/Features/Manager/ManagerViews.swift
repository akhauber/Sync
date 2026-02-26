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
            ProfileView()
                .tabItem { Label("Profile", systemImage: "person") }
        }
    }
}

struct ManagerScheduleView: View {
    @State private var showInsights = false

    var body: some View {
        NavigationStack {
            VStack(spacing: 14) {
                Picker("View", selection: .constant(0)) {
                    Text("List").tag(0)
                    Text("Grid").tag(1)
                }
                .pickerStyle(.segmented)

                SoftButton(title: "Generate Schedule", systemImage: "sparkles", isPrimary: true) {}

                GlassCard {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Sync is building your schedule…")
                            .font(.headline)
                        ProgressView()
                    }
                }

                Spacer()
            }
            .padding()
            .navigationTitle("Schedule")
            .toolbar {
                Button {
                    showInsights = true
                } label: {
                    Image(systemName: "chart.bar.doc.horizontal")
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
                VStack(spacing: 12) {
                    GlassCard {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Team performance heatmap")
                                .font(.headline)
                            Text("Last updated: last night")
                                .font(.footnote)
                                .foregroundStyle(.secondary)
                            ForEach(["Morning", "Afternoon", "Evening"], id: \.self) { slot in
                                VStack(alignment: .leading) {
                                    Text(slot)
                                    RoundedRectangle(cornerRadius: 8)
                                        .fill(AccentFill())
                                        .frame(height: 10)
                                }
                            }
                        }
                    }

                    GlassCard {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Top shift pairings")
                                .font(.headline)
                            Text("Works well with 8 teammates")
                                .foregroundStyle(.secondary)
                        }
                    }
                }
                .padding()
            }
            .navigationTitle("Insights")
        }
    }
}

struct ManageView: View {
    var body: some View {
        NavigationStack {
            List {
                Text("Team roster")
                Text("Role assignment per shift")
                Text("Coverage alerts")
            }
            .navigationTitle("Manage")
        }
    }
}

struct NotificationsView: View {
    @EnvironmentObject private var session: SessionStore

    var body: some View {
        NavigationStack {
            List {
                ForEach(session.notifications) { item in
                    VStack(alignment: .leading) {
                        Text(item.title).font(.headline)
                        Text(item.subtitle).font(.subheadline).foregroundStyle(.secondary)
                    }
                    .swipeActions {
                        Button("Dismiss", role: .destructive) {}
                    }
                }
            }
            .navigationTitle("Notifications")
            .toolbar {
                Button("Mark all read") {}
            }
        }
    }
}
