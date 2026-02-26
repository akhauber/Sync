import SwiftUI

struct LoginView: View {
    @EnvironmentObject private var session: SessionViewModel
    @State private var employeeID = ""
    @State private var pin = ""

    var body: some View {
        GeometryReader { proxy in
            ZStack {
                SyncTheme.bg0.ignoresSafeArea()
                VStack(spacing: 20) {
                    Spacer()
                    GlassCard {
                        VStack(alignment: .leading, spacing: 16) {
                            Text("Sync")
                                .font(.largeTitle.weight(.semibold))
                            Text("Shift scheduling, calmly organized")
                                .foregroundStyle(.secondary)

                            SoftButton(title: "Sign in with Apple", isPrimary: true) {
                                session.signIn(as: .worker)
                            }

                            InsetWell {
                                TextField("Employee ID", text: $employeeID)
                            }
                            InsetWell {
                                SecureField("PIN", text: $pin)
                            }

                            HStack(spacing: 12) {
                                SoftButton(title: "Login Worker") { session.signIn(as: .worker) }
                                SoftButton(title: "Login Manager") { session.signIn(as: .manager) }
                            }
                        }
                    }
                    .padding(.horizontal, 20)
                    Spacer()
                }
                .frame(minHeight: proxy.size.height)
            }
        }
    }
}
