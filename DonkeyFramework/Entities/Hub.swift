import Foundation

public struct Hub: DonkeyType {
    // swiftlint:disable:next identifier_name
    public let id: Int
    public let name: String
    public let latitude: String
    public let longitude: String
    public let radius: Int
    public let thumbnailUrl: String
    public let availableBikesCount: Int
    public let countryCode: String
    public let currency: String
    public let prices: [String: Int]
}

extension Hub: Equatable {
    public static func == (lhs: Hub, rhs: Hub) -> Bool {
        return lhs.id == rhs.id
    }
}

extension Hub: Hashable {
    public var hashValue: Int {
        return id
    }
}
