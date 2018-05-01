# Purse :handbag:

A fashionable accessory to persist data to disk.

## Features 
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg)](https://github.com/Carthage/Carthage)
[![Build Status](https://travis-ci.org/hkellaway/Purse.svg?branch=develop)](https://travis-ci.org/hkellaway/Purse)

:lipstick: Persisting `Codable` objects to disk<br />
:lipstick: Retrieving `Codable` objects from disk

## Getting Started

[Download Purse](https://github.com/hkellaway/Purse/archive/master.zip) and perform a `pod install` on the included `Demo` app to see Purse in action

### Swift Version

Purse is currently compatible with Swift 4.0.

### Installation with CocoaPods

```ruby
pod 'Purse', '0.1.0'
```

### Installation with Carthage

```
github "hkellaway/Purse"
```

## Usage

### Codable

Let's say we have the following `Codable` model:

``` swift
struct Test: Codable {
    let id: Int
    let name: String
}
```

We can persist the model to the `/tmp` directory on disk by calling the following:

``` swift
let test1 = Test(id: 1, name: "Test 1")
try Purse.shared.persist(test1, to: .temporary, fileName: "test1.json")
```

Similarly, we could retrieve the model from disk by calling:

```swift
let test1 = try Purse.shared.retrieve(from: .temporary, fileName: "test1.json", as: Test.self)
```

## Advanced

### Persisting in Other Formats But JSON

When persisting `Codable` objets to disk, Purse uses JSON as the format by default. If your data is in a different format that can be transformed to `Data`, you can create your own object that conforms to `DataConverter` then parameterize Purse with it:

```swift
Purse.shared.dataConverter = MyDataConverter()
```

## Credits

Purse was created by [Harlan Kellaway](http://harlankellaway.com).

## License

Purse is available under the MIT license. See the [LICENSE](https://raw.githubusercontent.com/hkellaway/Purse/master/LICENSE) file for more info.
