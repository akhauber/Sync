import SwiftUI

struct LoginView: View {
    @EnvironmentObject private var session: SessionStore
    @State private var employeeId = ""
    @State private var pin = ""
    @State private var showingError = false

    var body: some View {
        VStack(spacing: 24) {
            Spacer()
            VStack(spacing: 10) {
                Text("Sync")
                    .syncTitle()
                Text("Shift scheduling, without friction")
                    .foregroundStyle(.secondary)
            }

            GlassCard {
                VStack(spacing: 12) {
                    SoftButton(title: "Sign in with Apple", systemImage: "apple.logo", isPrimary: true) {
                        session.loginAsWorker()
                    }

                    Text("or")
                        .font(.footnote)
                        .foregroundStyle(.secondary)

                    TextField("Employee ID", text: $employeeId)
                        .textFieldStyle(.roundedBorder)
                    SecureField("PIN", text: $pin)
                        .textFieldStyle(.roundedBorder)

                    HStack {
                        SoftButton(title: "Worker Login") {
                            guard !employeeId.isEmpty, !pin.isEmpty else {
                                showingError = true
                                return
                            }
                            session.loginAsWorker()
                        }
                        SoftButton(title: "Manager Login") {
                            session.loginAsManager()
                        }
                    }
                }
            }
            .padding(.horizontal, 20)

            if showingError {
                Text("Enter employee ID and PIN.")
                    .font(.footnote)
                    .foregroundStyle(SyncColors.destructive)
            }
            Spacer()
        }
        .padding()
    }
}
