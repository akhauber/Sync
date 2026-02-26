import Foundation

enum UserRole: String, CaseIterable, Codable {
    case worker
    case manager
}

enum ShiftRole: String, CaseIterable, Identifiable, Codable {
    case server
    case host
    case bar
    case expo

    var id: String { rawValue }
    var label: String { rawValue.capitalized }
}

struct Shift: Identifiable, Hashable {
    let id: UUID
    var date: Date
    var start: Date
    var end: Date
    var location: String
    var role: ShiftRole
    var postedToMarketplace: Bool
    var incentive: Decimal?
}

struct AvailabilityDay: Identifiable {
    let id = UUID()
    let weekday: String
    var isAvailable: Bool
    var start: Date
    var end: Date
    var preferredWindow: PreferredWindow
    var notes: String
}

enum PreferredWindow: String, CaseIterable, Identifiable {
    case morning = "Morning"
    case afternoon = "Afternoon"
    case evening = "Evening"

    var id: String { rawValue }
}

struct MarketplacePost: Identifiable {
    let id: UUID
    let posterName: String
    let posterRole: ShiftRole
    let shift: Shift
    let message: String?
}

struct NotificationItem: Identifiable {
    let id = UUID()
    let title: String
    let subtitle: String
    let date: Date
    var isRead: Bool
}
