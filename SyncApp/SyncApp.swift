import SwiftUI

@main
struct SyncApp: App {
    @StateObject private var appState = AppState()

    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(appState)
                .preferredColorScheme(appState.preferredColorScheme)
        }
    }
}

final class AppState: ObservableObject {
    @Published var session: Session?
    @Published var preferredColorScheme: ColorScheme? = nil

    func signIn(as role: UserRole) {
        session = Session(user: User.mock(role: role))
    }

    func signOut() {
        session = nil
    }
}

struct Session {
    let user: User
}
