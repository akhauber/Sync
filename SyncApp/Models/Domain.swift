import Foundation

enum UserRole: String, CaseIterable, Identifiable {
    case worker
    case manager

    var id: String { rawValue }
}

struct User: Identifiable {
    let id: UUID
    let name: String
    let primaryRole: UserRole
    let roles: [String]
    let location: String

    static func mock(role: UserRole) -> User {
        User(
            id: UUID(),
            name: role == .worker ? "Maya Rivera" : "Daniel Kim",
            primaryRole: role,
            roles: role == .worker ? ["Server", "Host"] : ["Manager"],
            location: "Downtown"
        )
    }
}

struct Shift: Identifiable {
    let id = UUID()
    let day: String
    let timeRange: String
    let hours: Double
    let location: String
    let role: String
    let countdown: String
    var isPosted: Bool = false
}

struct MarketplaceShift: Identifiable {
    let id = UUID()
    let poster: String
    let posterRole: String
    let date: String
    let time: String
    let location: String
    let roleTag: String
    let message: String?
    let incentive: String?
    var isTaken: Bool = false
}

struct AppNotification: Identifiable {
    let id = UUID()
    let title: String
    let subtitle: String
    let timestamp: String
    var isRead: Bool = false
}
