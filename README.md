# Sync iOS App (SwiftUI)

This repository contains a SwiftUI implementation scaffold for **Sync**, a calm, tactile shift scheduling app with role-based flows for workers and managers.

## Implemented
- Warm, soft-ui design primitives (`GlassCard`, `SoftButton`, `FilterChip`, `EmojiMoodScale`)
- Role-aware app entry and tab structures
- Worker surfaces: My Schedule, Marketplace, Availability, Profile
- Manager surfaces: Schedule, Manage, Notifications, Profile
- Insights layer and post-shift check-in sheet components
- Mock domain models and session store for local prototyping

## Structure
- `SyncApp/App` – app bootstrapping and root routing
- `SyncApp/DesignSystem` – palette, radius, glass surface styling
- `SyncApp/Components` – reusable UI controls
- `SyncApp/Features` – screen-level feature views
- `SyncApp/Models` – domain model structs
- `SyncApp/Services` – session and mock data provider

## Notes
This is an iOS SwiftUI scaffold intended to be dropped into an Xcode iOS target.
