import SwiftUI

struct RootView: View {
    @EnvironmentObject private var session: SessionViewModel

    var body: some View {
        Group {
            if session.isAuthenticated {
                if session.role == .worker {
                    WorkerTabView()
                } else {
                    ManagerTabView()
                }
            } else {
                LoginView()
            }
        }
    }
}
