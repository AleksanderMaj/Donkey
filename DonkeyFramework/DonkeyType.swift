import Foundation

protocol DonkeyType: Codable {}

extension DonkeyType {
    static func decode(data: Data) throws -> Self {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return try decoder.decode(Self.self, from: data)
    }

    func encode() throws -> Data {
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        return try encoder.encode(self)
    }
}

// Make the Array type conditionally conform to DonkeyType
extension Array: DonkeyType where Element: DonkeyType {
    static func decode(data: Data) throws -> Array {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return try decoder.decode(Array.self, from: data)
    }
}

