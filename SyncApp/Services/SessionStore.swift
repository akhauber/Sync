import Foundation
import SwiftUI

final class SessionStore: ObservableObject {
    @Published var currentUser: User?
    @Published var shifts: [Shift] = MockData.shifts
    @Published var notifications: [AppNotification] = MockData.notifications

    func loginAsWorker() {
        currentUser = User(id: UUID(), name: "Riley Cruz", primaryRole: .worker, roles: ["Server", "Host"], location: "Downtown")
    }

    func loginAsManager() {
        currentUser = User(id: UUID(), name: "Jordan Lee", primaryRole: .manager, roles: ["Manager"], location: "Downtown")
    }

    func signOut() {
        currentUser = nil
    }
}

enum MockData {
    static var shifts: [Shift] {
        let now = Date()
        return [
            Shift(id: UUID(), date: now, start: now, end: now.addingTimeInterval(60*60*8), location: "Main Dining", role: "Server", assigneeName: "Riley", incentive: nil, note: "Patio coverage", isMarketplace: false),
            Shift(id: UUID(), date: now.addingTimeInterval(60*60*24), start: now.addingTimeInterval(60*60*24*1+60*60*9), end: now.addingTimeInterval(60*60*24*1+60*60*17), location: "Bar", role: "Bartender", assigneeName: "Morgan", incentive: 35, note: "Need close", isMarketplace: true)
        ]
    }

    static var notifications: [AppNotification] {
        [
            AppNotification(id: UUID(), title: "Shift trade completed", subtitle: "A Thursday close shift was claimed.", date: .now, isRead: false),
            AppNotification(id: UUID(), title: "Coverage gap detected", subtitle: "Saturday evening is understaffed.", date: .now, isRead: false)
        ]
    }
}
