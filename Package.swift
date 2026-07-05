// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.
// Bumped from 5.7 to 6.0: `.v18` (iOS) and `.v15` (macOS) in `platforms` below
// don't exist as enum cases before tools-version 6.0 — using them under 5.7
// would fail with "type 'SupportedPlatform.IOSVersion' has no member 'v18'".

import PackageDescription

let package = Package(
    name: "MattiUI",
    // Declared to match the @available(iOS 18, macOS 15...) annotations used
    // throughout the components. Without this, SwiftPM would try to
    // resolve/build the package for platforms (watchOS, tvOS, etc.) that
    // were never actually verified to work.
    platforms: [
        .iOS(.v18),
        .macOS(.v15),
    ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "MattiUI",
            targets: ["MattiUI"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        //
        // swift-tools-version 6.0 defaults targets to the Swift 6 language
        // mode, which turns on strict concurrency checking — a much stricter
        // compiler pass that this codebase has never been checked against.
        // Pinning back to `.v5` gets us the new platform-version enum cases
        // without also taking on an unrelated wave of concurrency errors in
        // the same change.
        .target(
            name: "MattiUI",
            dependencies: [],
            swiftSettings: [.swiftLanguageMode(.v5)]),
        .testTarget(
            name: "MattiUITests",
            dependencies: ["MattiUI"],
            swiftSettings: [.swiftLanguageMode(.v5)]),
    ]
)
