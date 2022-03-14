// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ios-onboarding-kit",
    platforms: [
      .iOS(.v13)
        ],
    products: [
        .library(
            name: "ios-onboarding-kit",
            targets: ["ios-onboarding-kit"]),
    ],
    dependencies: [
      .package(url: "https://github.com/SnapKit/SnapKit", from: "5.0.0"),
    ],
    targets: [
        .target(
            name: "ios-onboarding-kit",
            dependencies: ["SnapKit"]),
        .testTarget(
            name: "ios-onboarding-kitTests",
            dependencies: ["ios-onboarding-kit"]),
    ],
    swiftLanguageVersions: [
        .v5
    ]
)
