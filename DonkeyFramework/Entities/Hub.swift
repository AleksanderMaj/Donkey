import Foundation

public struct Hub: DonkeyType {
    // swiftlint:disable:next identifier_name
    public let id: Int
    public let name: String
    public let latitude: String
    public let longitude: String
    public let radius: Int
    private var availableBikesCount: Int?
    private var bikesCount: Int?

    func bikeCount() -> Int {
        return availableBikesCount ?? bikesCount ?? 0
    }
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
