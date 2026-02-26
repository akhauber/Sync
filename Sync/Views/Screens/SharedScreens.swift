import SwiftUI

struct MarketplaceView: View {
    @State private var showClaimSheet = false

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    Text("Pick up open shifts from teammates.")
                        .foregroundStyle(.secondary)
                    HStack {
                        FilterChip(title: "Role", selected: false)
                        FilterChip(title: "Date", selected: true)
                        FilterChip(title: "Evening", selected: false)
                    }
                    ForEach(0..<4, id: \.self) { _ in
                        GlassCard {
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Taylor · Server")
                                    .font(.headline)
                                Text("Fri 4:00 PM – 10:00 PM · Downtown")
                                    .foregroundStyle(.secondary)
                                Text("Can anyone cover, family event.")
                                    .font(.subheadline)
                                HStack {
                                    SoftButton(title: "Decline") {}
                                    SoftButton(title: "Claim", isPrimary: true) { showClaimSheet = true }
                                }
                            }
                        }
                    }
                }
                .padding()
            }
            .navigationTitle("Marketplace")
            .sheet(isPresented: $showClaimSheet) {
                ClaimConfirmationSheet()
            }
        }
    }
}

struct ClaimConfirmationSheet: View {
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 16) {
                Text("Confirm Shift Claim")
                    .font(.title3.weight(.semibold))
                GlassCard {
                    VStack(alignment: .leading, spacing: 6) {
                        Text("Fri 4:00 PM – 10:00 PM")
                        Text("Downtown · Server")
                            .foregroundStyle(.secondary)
                        Text("Incentive: $20")
                            .foregroundStyle(SyncTheme.success)
                    }
                }
                SoftButton(title: "Confirm & Claim", isPrimary: true) {}
                SoftButton(title: "Cancel") {}
                Spacer()
            }
            .padding()
            .presentationDetents([.medium])
        }
    }
}

struct ProfileView: View {
    @EnvironmentObject private var session: SessionViewModel
    let isManager: Bool

    var body: some View {
        NavigationStack {
            List {
                Section("Identity") {
                    Label("Alex Parker", systemImage: "person.fill")
                    Text(isManager ? "Manager" : "Worker")
                    Text(isManager ? "Location: Downtown" : "Roles: Server, Host")
                }
                Section("Preferences") {
                    Toggle("Push Notifications", isOn: .constant(true))
                    if !isManager {
                        NavigationLink("Availability") { AvailabilityView() }
                        NavigationLink("Trade History") { Text("Trade history") }
                    } else {
                        NavigationLink("Team Management") { Text("Manage team") }
                        NavigationLink("Insights") { InsightsView() }
                    }
                }
                Section {
                    Button("Sign Out", role: .destructive) {
                        session.signOut()
                    }
                }
            }
            .navigationTitle("Profile")
        }
    }
}
