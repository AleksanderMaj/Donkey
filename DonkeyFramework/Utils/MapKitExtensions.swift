import MapKit

extension MKMapView {
    var topLeftCoordinate: CLLocationCoordinate2D {
        return convert(.zero, toCoordinateFrom: self)
    }

    var radius: CLLocationDistance {
        let centerLocation = CLLocation(coordinate: centerCoordinate)
        let topLeftLocation = CLLocation(coordinate: topLeftCoordinate)
        return centerLocation.distance(from: topLeftLocation)
    }
}

extension CLLocation {
    convenience init(coordinate: CLLocationCoordinate2D) {
        self.init(latitude: coordinate.latitude,
                  longitude: coordinate.longitude)
    }
}
