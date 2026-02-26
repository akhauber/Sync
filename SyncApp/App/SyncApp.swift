import SwiftUI

@main
struct SyncApp: App {
    @StateObject private var session = SessionStore()

    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(session)
                .preferredColorScheme(nil)
        }
    }
}

struct RootView: View {
    @EnvironmentObject private var session: SessionStore

    var body: some View {
        Group {
            if session.currentUser == nil {
                LoginView()
            } else if session.currentUser?.isManager == true {
                ManagerTabView()
            } else {
                WorkerTabView()
            }
        }
        .background(SyncColors.background.ignoresSafeArea())
    }
}
