import Foundation

struct User: Identifiable {
    enum RoleType: String, CaseIterable {
        case worker
        case manager
    }

    let id: UUID
    var name: String
    var primaryRole: RoleType
    var roles: [String]
    var location: String

    var isManager: Bool { primaryRole == .manager }
}

struct Shift: Identifiable {
    let id: UUID
    var date: Date
    var start: Date
    var end: Date
    var location: String
    var role: String
    var assigneeName: String
    var incentive: Decimal?
    var note: String?
    var isMarketplace: Bool
}

struct MoodCheckIn: Identifiable {
    let id: UUID
    var shiftId: UUID
    var emoji: String
    var preferencePrompt: String
    var preferenceChoice: String?
}

struct AppNotification: Identifiable {
    let id: UUID
    var title: String
    var subtitle: String
    var date: Date
    var isRead: Bool
}
