// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "MattiUI",
    // Declared to match the @available(iOS 15/16, macOS 12/13...) annotations
    // used throughout the components. Without this, SwiftPM would try to
    // resolve/build the package for platforms (watchOS, tvOS, etc.) that
    // were never actually verified to work.
    platforms: [
        .iOS(.v15),
        .macOS(.v12),
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
        .target(
            name: "MattiUI",
            dependencies: []),
        .testTarget(
            name: "MattiUITests",
            dependencies: ["MattiUI"]),
    ]
)
