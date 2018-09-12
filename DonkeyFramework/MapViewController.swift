import UIKit
import MapKit

public final class MapViewController: UIViewController {

    public init() {
        super.init(nibName: String(describing: MapViewController.self), bundle: Bundle(for: MapViewController.self))
        DonkeyWebservice().fetchHubs()
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
