import Foundation

struct Hub: DonkeyType {
    //swiftlint:ignore:next identifier_name
    let id: Int
    let name: String
    let latitude: String
    let longitude: String
    let radius: Int
    let thumbnailUrl: String
    let availableBikesCount: Int
    let countryCode: String
    let currency: String
    let prices: [String: Int]
}
