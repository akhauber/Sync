import SwiftUI

struct LoginView: View {
    @EnvironmentObject private var appState: AppState
    @State private var employeeID = ""
    @State private var pin = ""
    @State private var error: String?

    var body: some View {
        NavigationStack {
            VStack(spacing: 24) {
                Spacer()
                GlassCard {
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Sync")
                            .font(.largeTitle.weight(.semibold))
                        Text("Shift scheduling that feels calm.")
                            .foregroundStyle(SyncColors.textSecondary)

                        SoftButton(title: "Sign in with Apple", icon: "applelogo") {
                            appState.signIn(as: .worker)
                        }

                        Text("Employee ID + PIN")
                            .font(.subheadline.weight(.semibold))
                        InsetWell {
                            TextField("Employee ID", text: $employeeID)
                        }
                        InsetWell {
                            SecureField("PIN", text: $pin)
                        }

                        SoftButton(title: "Manager Demo", isPrimary: false) {
                            appState.signIn(as: .manager)
                        }

                        if let error {
                            Text(error)
                                .font(.footnote)
                                .foregroundStyle(SyncColors.destructive)
                        }
                    }
                }
                Spacer()
            }
            .padding()
        }
    }
}
