// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "OneSignalFramework",
    products: [
        .library(
            name: "OneSignalFramework",
            targets: ["OneSignalFrameworkWrapper"]),
        .library(
            name: "OneSignalInAppMessages",
            targets: ["OneSignalInAppMessagesWrapper"]),
        .library(
            name: "OneSignalLocation",
            targets: ["OneSignalLocationWrapper"]),
        .library(
            name: "OneSignalExtension",
            targets: ["OneSignalExtensionWrapper"])
    ],
    targets: [
        .target(
            name: "OneSignalFrameworkWrapper",
            dependencies: [
                "OneSignalFramework",
                "OneSignalUser",
                "OneSignalNotifications",
                "OneSignalExtension",
                "OneSignalOutcomes",
                "OneSignalOSCore",
                "OneSignalCore"
            ],
            path: "OneSignalFrameworkWrapper"
        ),
        .target(
            name: "OneSignalInAppMessagesWrapper",
            dependencies: [
                "OneSignalInAppMessages",
                "OneSignalUser",
                "OneSignalNotifications",
                "OneSignalOutcomes",
                "OneSignalOSCore",
                "OneSignalCore"
            ],
            path: "OneSignalInAppMessagesWrapper"
        ),
        .target(
            name: "OneSignalLocationWrapper",
            dependencies: [
                "OneSignalLocation",
                "OneSignalUser",
                "OneSignalNotifications",
                "OneSignalOSCore",
                "OneSignalCore"
            ],
            path: "OneSignalLocationWrapper"
        ),
        .target(
            name: "OneSignalUserWrapper",
            dependencies: [
                "OneSignalUser",
                "OneSignalNotifications",
                "OneSignalExtension",
                "OneSignalOutcomes",
                "OneSignalOSCore",
                "OneSignalCore"
            ],
            path: "OneSignalUserWrapper"
        ),
        .target(
            name: "OneSignalNotificationsWrapper",
            dependencies: [
                "OneSignalNotifications",
                "OneSignalExtension",
                "OneSignalOutcomes",
                "OneSignalCore"
            ],
            path: "OneSignalNotificationsWrapper"
        ),
        .target(
            name: "OneSignalExtensionWrapper",
            dependencies: [
                "OneSignalExtension",
                "OneSignalOutcomes",
                "OneSignalCore"
            ],
            path: "OneSignalExtensionWrapper"
        ),
        .target(
            name: "OneSignalOutcomesWrapper",
            dependencies: [
                "OneSignalOutcomes",
                "OneSignalCore"
            ],
            path: "OneSignalOutcomesWrapper"
        ),
        .target(
            name: "OneSignalOSCoreWrapper",
            dependencies: [
                "OneSignalOSCore",
                "OneSignalCore"
            ],
            path: "OneSignalOSCoreWrapper"
        ),
        .binaryTarget(
          name: "OneSignalFramework",
          url: "https://github.com/salardstn/OneSignal-iOS-SDK/releases/download/5.0.2/OneSignalFramework.xcframework.zip",
          checksum: "7ca25c6e65b4f16447d44cf93d2f82628a50cff0a07c540f8783eb9f3d036c96"
        ),
        .binaryTarget(
          name: "OneSignalInAppMessages",
          url: "https://github.com/salardstn/OneSignal-iOS-SDK/releases/download/5.0.2/OneSignalInAppMessages.xcframework.zip",
          checksum: "d5581b0b9655d05d8bf47a21cf825aedcde2c7c268b2efa915075e585414c919"
        ),
        .binaryTarget(
          name: "OneSignalLocation",
          url: "https://github.com/salardstn/OneSignal-iOS-SDK/releases/download/5.0.2/OneSignalLocation.xcframework.zip",
          checksum: "6fbbfeb29c956bc4d0b0a30bcebf76774cd72067db4edfebb1fbaaa68575efea"
        ),
        .binaryTarget(
          name: "OneSignalUser",
          url: "https://github.com/salardstn/OneSignal-iOS-SDK/releases/download/5.0.2/OneSignalUser.xcframework.zip",
          checksum: "63d43c72cd5216a48eb02521aaa405b1e45b9757273bf6b8830fed52300b1a3b"
        ),
        .binaryTarget(
          name: "OneSignalNotifications",
          url: "https://github.com/salardstn/OneSignal-iOS-SDK/releases/download/5.0.2/OneSignalNotifications.xcframework.zip",
          checksum: "f37e1576bb387bafee455df5e9ff37d1a67aec40694a647a09a617e066969492"
        ),
        .binaryTarget(
          name: "OneSignalExtension",
          url: "https://github.com/salardstn/OneSignal-iOS-SDK/releases/download/5.0.2/OneSignalExtension.xcframework.zip",
          checksum: "8c38be1902296ffb8dea0c4ba185f82f58c46ff3eeab7b2845be1bffb3ad50c4"
        ),
        .binaryTarget(
          name: "OneSignalOutcomes",
          url: "https://github.com/salardstn/OneSignal-iOS-SDK/releases/download/5.0.2/OneSignalOutcomes.xcframework.zip",
          checksum: "109aa8ad20af0b4ddcabb9943c4952c9eb3ca3827e165c9f9be23cacc20f54cc"
        ),
        .binaryTarget(
          name: "OneSignalOSCore",
          url: "https://github.com/salardstn/OneSignal-iOS-SDK/releases/download/5.0.2/OneSignalOSCore.xcframework.zip",
          checksum: "c559b02ceb9aeeeee1ca38bae0bcf84b474d8874fab04a488ec1400adfbcdf1a"
        ),
        .binaryTarget(
          name: "OneSignalCore",
          url: "https://github.com/salardstn/OneSignal-iOS-SDK/releases/download/5.0.2/OneSignalCore.xcframework.zip",
          checksum: "febdd2d8b659a6c3df3e07819e9f7aa8141dd537dc87e46a45b11721d7f49b0c"
        )
    ]
)
