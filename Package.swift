// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CommonKit",
    platforms: [.iOS(.v14)],
    products: [
        .library(
            name: "CommonKit",
            targets: ["CommonKit"]
        )
    ],
    dependencies: [],
    targets: [
        .target(
            name: "CommonKit",
            dependencies: []
        ),
        .testTarget(
            name: "CommonKitTests",
            dependencies: ["CommonKit"]
        )
    ]
)
