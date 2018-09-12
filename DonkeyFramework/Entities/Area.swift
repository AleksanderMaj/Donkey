import Foundation
import CoreLocation

public struct Area: DonkeyType {
    init(location: CLLocationCoordinate2D, radius: Double) {
        self.location = "\(location.latitude),\(location.longitude)"
        self.radius = Int(radius)
    }

    var location: String
    var radius: Int

    func toParams() -> [String: Any] {
        return ["location": location, "radius": radius]
    }
}
