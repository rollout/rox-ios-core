// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "ROX",
  platforms: [.iOS(.v8), .tvOS(.v10)],
  products: [
    // Products define the executables and libraries a package produces, and make them visible to other packages.
    .library(
      name: "ROXCore",
      targets: ["ROXCore"]),
    .library(
      name: "ROX",
      targets: ["ROX"]),
  ],
  dependencies: [
    // Dependencies declare other packages that this package depends on.
    // .package(url: /* package url */, from: "1.0.0"),
  ],
  targets: [
    // Targets are the basic building blocks of a package. A target can define a module or a test suite.
    // Targets can depend on other targets in this package, and on products in packages this package depends on.
    .binaryTarget(name: "ROXCore",
                  path: "ROXCore.xcframework"),
    .target(
      name: "ROX",
      dependencies: ["ROXCore"],
      path: "RoxSdk/RoxSdk",
      exclude: [
        "Info.plist",
        "RoxSdk.h"
      ])
  ]
)
