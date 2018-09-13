import MapKit

public class HubAnnotation: NSObject, MKAnnotation {
    public var hub: Hub {
        didSet {
            updateInfo()
        }
    }
    public var coordinate: CLLocationCoordinate2D
    public var title: String?
    public var subtitle: String?

    init?(hub: Hub) {
        guard let coordinate = hub.toCoordinate() else { return nil }
        self.coordinate = coordinate
        self.hub = hub
        super.init()
        updateInfo()
    }

    private func updateInfo() {
        title = "\(hub.bikeCount())"
        subtitle = hub.name
    }
}

extension Hub {
    func toCoordinate() -> CLLocationCoordinate2D? {
        guard let lat = CLLocationDegrees(latitude),
            let long = CLLocationDegrees(longitude) else { return nil }

        return CLLocationCoordinate2D(latitude: lat, longitude: long)
    }
}
