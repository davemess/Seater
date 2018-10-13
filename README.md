![Swift](http://img.shields.io/badge/swift-4.2-brightgreen.svg)
<!--[![Build Status](https://travis-ci.org/davemess/PermissionsKit.svg?branch=develop)](https://travis-ci.org/davemess/PermissionsKit)-->
<!--[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)-->
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
![Platform Version](https://cocoapod-badges.herokuapp.com/p/arek/badge.png)

# Seater
```
A sample app demonstrating usage of the SeatGeek api.
```

## Requirements
* Xcode 10.1 (beta 2)
* iOS 12.1
* Swift 4.2 
<!--* Carthage (current version `0.18-19-g743fa0f`)-->
<!--* Fastlane (current version is `2.105.1`)-->

## Usage
#### Setup
1. Clone the repo.
```
git clone git@github.com:davemess/Seater.git
```
2. **Optional:** Update Carthage dependencies.
```
carthage update --platform iOS
```
3. Open using Xcode. Build and run the Development scheme. There are multiple schemes (Development, Staging, etc.) included with the project.

#### Branching
Gitflow is the guiding branch strategy. In addition to feature and bug branches, there are long-lived branches:
* `develop` bleeding-edge development and merge-branch for feature work
* `master` App Store distribution; releases should be marked with tags

#### Configurations
User-defined configuration settings can be found in the xcconfig files in `Configurations` directory.

#### Distribution

<!--##### Beta-->
<!--Fastlane support is included. To distribute to beta, use the following steps:-->
<!--1. Switch to `develop`-->
<!--2. Increment the `APP_BUNDLE_VERSION` in `Configurations/Base.xcconfig`. This needs to be updated or ITC will reject the beta build.-->
<!--3. Commit the updated bundle version.-->
<!--3. Push the beta via-->
<!--```-->
<!--fastlane beta-->
<!--```-->

##### Release
Similar to above but also update the `APP_VERSION` in `Configurations/Base.xcconfig`.


### License

Seater is available under the MIT license. See the LICENSE file for more info.

### Acknowledgements
Powered by ![](./assets/seatgeek.png)

---

## TODO

- [ ] List View
- [ ] Detail View
- [ ] Search
- [ ] Persistence
