import Foundation

final class SessionViewModel: ObservableObject {
    @Published var isAuthenticated = false
    @Published var role: UserRole = .worker

    func signIn(as role: UserRole) {
        self.role = role
        isAuthenticated = true
    }

    func signOut() {
        isAuthenticated = false
    }
}
