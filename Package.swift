// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "OMKit",
    platforms: [
        .macOS(.v12),
        .iOS(.v15)
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "OMKit",
            targets: ["OMKit"]),
    ],
    dependencies: [
        .package(url: "https://github.com/FluidGroup/Texture.git", branch: "muukii/cleanup-spm"),
        .package(url: "https://github.com/ra1028/DifferenceKit.git", exact: "1.3.0"),
        .package(url: "https://github.com/sindresorhus/Defaults.git", exact: "8.2.0")
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "OMKit",
        dependencies: [
            .product(name: "AsyncDisplayKit", package: "Texture"),
            .product(name: "DifferenceKit", package: "DifferenceKit"),
            .product(name: "Defaults", package: "Defaults")
        ]),
        .testTarget(
            name: "OMKitTests",
            dependencies: ["OMKit"]),
    ]
)
