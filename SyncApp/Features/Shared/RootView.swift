import SwiftUI

struct RootView: View {
    @EnvironmentObject private var appState: AppState

    var body: some View {
        Group {
            if let session = appState.session {
                if session.user.primaryRole == .worker {
                    WorkerTabView()
                } else {
                    ManagerTabView()
                }
            } else {
                LoginView()
            }
        }
        .background(SyncColors.bg0.ignoresSafeArea())
    }
}
