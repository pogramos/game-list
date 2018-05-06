// swift-tools-version:4.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Game List",
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        .package(url: "https://github.com/kylef/Stencil.git", from: "0.11.0")
    ]
)
