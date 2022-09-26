// swift-tools-version:5.0

import PackageDescription

let package = Package(
        name: "TestRxAlamofire",

        dependencies: [
            .package(url: "https://github.com/RxSwiftCommunity/RxAlamofire.git",
                     from: "6.1.2"),
        ],

        targets: [
            .target(
                    name: "TestRxAlamofire",
                    dependencies: ["RxAlamofire"])
        ]
)
