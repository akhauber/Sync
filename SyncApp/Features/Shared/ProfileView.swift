import SwiftUI

struct ProfileView: View {
    @EnvironmentObject private var appState: AppState

    var body: some View {
        NavigationStack {
            List {
                Section("Identity") {
                    Text("Name: \(appState.session?.user.name ?? "")")
                    Text("Role: \(appState.session?.user.primaryRole.rawValue.capitalized ?? "")")
                    Text("Location: \(appState.session?.user.location ?? "")")
                    Text("Assigned roles: \(appState.session?.user.roles.joined(separator: ", ") ?? "")")
                }

                Section("Preferences") {
                    Label("Notifications", systemImage: "bell.badge")
                    Label("Availability", systemImage: "calendar.badge.clock")
                }

                Button("Sign Out", role: .destructive) {
                    appState.signOut()
                }
            }
            .navigationTitle("Profile")
        }
    }
}
