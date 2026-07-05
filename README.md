# MattiUI

[![CI](https://github.com/techguy0711/MattiUI/actions/workflows/ci.yml/badge.svg)](https://github.com/techguy0711/MattiUI/actions/workflows/ci.yml)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

MattiUI is in early beta, please do not use in production just yet.

# What is MattiUI?
MattiUI is a Material UI library for SwiftUI. At MattiUI we write material design components using Apple's own SwiftUI, which means everything is just the right amount of Apple design and Material design. Our goal is to bring Material design to SwiftUI without interrupting the native feel of SwiftUI and Apple's design styles.

# Requirements
iOS 15+ / macOS 12+, Swift 5.7+.

# Running tests locally
```
swift test
```
CI runs `swift build` + `swift test` for the package, and an `xcodebuild` pass against the sample app on every push/PR to `main` (see `.github/workflows/ci.yml`).

# How to contribute
Thank you for wanting to contribute to MattiUI. Create your own branch, make your changes there, then open a PR with a descriptive title and a link to the relevant GitHub issue if applicable. Please make sure `swift test` passes locally before opening a PR.

# License
MattiUI is available under the MIT license. See [LICENSE](LICENSE) for details.
