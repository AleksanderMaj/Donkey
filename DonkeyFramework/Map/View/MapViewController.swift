import UIKit
import MapKit

public protocol MapViewType: class {
    func remove(hubAnnotations: [MKAnnotation])
    func add(hubAnnotations: [MKAnnotation])
    func show(hubAnnotations: [MKAnnotation])
}

public final class MapViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    var viewModel: MapViewModelInput

    public init(viewModel: MapViewModelInput) {
        self.viewModel = viewModel
        super.init(nibName: String(describing: MapViewController.self),
                   bundle: Bundle(for: MapViewController.self))
        self.viewModel.view = self
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        viewModel.viewDidLoad()
        handleAreaChange()
    }

    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    private func setUp() {
        mapView.delegate = self
    }

    fileprivate func handleAreaChange() {
        let area = Area(location: mapView.centerCoordinate, radius: mapView.radius)
        viewModel.areaDidChange(area: area)
    }

    @IBAction func showSearch(_ sender: UIButton) {
        viewModel.didTapSearch()
    }
}

extension MapViewController: MapViewType {
    public func remove(hubAnnotations: [MKAnnotation]) {
        mapView.removeAnnotations(hubAnnotations)
    }

    public func add(hubAnnotations: [MKAnnotation]) {
        mapView.addAnnotations(hubAnnotations)
        print("TOTAL: \(mapView.annotations.count)")
    }

    public func show(hubAnnotations: [MKAnnotation]) {
        mapView.showAnnotations(hubAnnotations, animated: true)
    }
}

extension MapViewController: MKMapViewDelegate {
    public func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        handleAreaChange()
    }

    public func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let annotationView = mapView.dequeueReusableAnnotationView(
            withIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier,
            for: annotation)
        annotationView.displayPriority = .required
        return annotationView
    }
}
