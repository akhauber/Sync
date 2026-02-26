import SwiftUI

struct ProfileView: View {
    @EnvironmentObject private var session: SessionStore

    var body: some View {
        NavigationStack {
            List {
                if let user = session.currentUser {
                    Section("Identity") {
                        Text(user.name)
                        Text(user.location)
                        Text(user.roles.joined(separator: ", "))
                            .foregroundStyle(.secondary)
                    }
                }

                Section("Preferences") {
                    Toggle("Push notifications", isOn: .constant(true))
                    Text("Availability")
                    if session.currentUser?.isManager == true {
                        Text("Insights dashboard")
                    } else {
                        Text("Trade history")
                    }
                }

                Button("Sign out", role: .destructive) {
                    session.signOut()
                }
            }
            .navigationTitle("Profile")
        }
    }
}
