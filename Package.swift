// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.
import PackageDescription

let package = Package(
    name: "RxModel",
    platforms: [
        .iOS(.v11)
    ],
    products: [
        .library(name: "RxModel", targets: ["RxModel"])
    ],
    dependencies: [
        .package(url: "https://github.com/ReactiveX/RxSwift.git", .upToNextMajor(from: "5.1.0"))
    ],
    targets: [
        .target(name: "RxModel", dependencies: ["RxSwift"], path: "RxModel")
    ]
)
