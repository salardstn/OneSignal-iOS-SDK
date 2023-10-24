// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "OneSignal",
    products: [
        .library(
            name: "OneSignal",
            targets: ["OneSignalWrapper"]),
        .library(
            name: "OneSignalExtension",
            targets: ["OneSignalExtensionWrapper"])
    ],
    targets: [
        .target(
            name: "OneSignalWrapper",
            dependencies: [
                "OneSignal",
                "OneSignalExtension",
                "OneSignalOutcomes",
                "OneSignalCore"
            ],
            path: "OneSignalWrapper"
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
        .binaryTarget(
          name: "OneSignal",
          url: "https://github.com/salardstn/OneSignal-iOS-SDK/releases/download/3.12.6/OneSignal.xcframework.zip",
          checksum: "fb160e1a2cf5076a6e3f0260b0a86a6efe8023019df9b415c8b95fa1e9bdbc23"
        ),
        .binaryTarget(
          name: "OneSignalExtension",
          url: "https://github.com/salardstn/OneSignal-iOS-SDK/releases/download/3.12.6/OneSignalExtension.xcframework.zip",
          checksum: "66aa8ea326e64a61c2244c1c93695098d69f39e4f23df11e7a9c02adfad3860a"
        ),
        .binaryTarget(
          name: "OneSignalOutcomes",
          url: "https://github.com/salardstn/OneSignal-iOS-SDK/releases/download/3.12.6/OneSignalOutcomes.xcframework.zip",
          checksum: "6359ada42bd78440dc9ff6ce5f27e93b9b656f7fe911653d7f3a53d71a4d8866"
        ),
        .binaryTarget(
          name: "OneSignalCore",
          url: "https://github.com/salardstn/OneSignal-iOS-SDK/releases/download/3.12.6/OneSignalCore.xcframework.zip",
          checksum: "9d258dd9ffecf8b7e706401e2c3e143d7c1a255ae9df0a5084f059a69610dead"
        )
    ]
)
