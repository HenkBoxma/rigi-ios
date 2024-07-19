// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "Rigi",
    platforms: [
        .iOS(.v12)
    ],
    products: [
        .library(
            name: "Rigi",
            targets: ["RigiTarget"]
        ),
    ],
    targets: [
        .binaryTarget(
            name: "RigiBinary",
            path: "./Rigi/Frameworks/Rigi.xcframework"
        ),
        .target(
            name: "RigiTarget",
            dependencies: ["RigiBinary"],
            path: "./Rigi",
            resources: [
                .process("Resources/Assets.xcassets"),
                .copy("../../bin") // Adjust the path to include bin directory correctly
            ]
        ),
    ],
    swiftLanguageVersions: [.v5]
)
