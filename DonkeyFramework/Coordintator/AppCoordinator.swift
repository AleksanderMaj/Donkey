import Foundation

//swiftlint:disable:next identifier_name
public var Current = Environment()

public final class AppCoordinator {
    weak var rootNC: UINavigationController?
    weak var map: MapInterface?

    public init() {}

    public func start(in window: UIWindow) {
        let viewModel = MapViewModel()
        map = viewModel
        viewModel.coordinator = self
        let mapVC = MapViewController(viewModel: viewModel)
        let mapNC = UINavigationController(rootViewController: mapVC)
        window.rootViewController = mapNC
        window.makeKeyAndVisible()
        rootNC = mapNC
    }

    public func showSeachInterface() {
        let viewModel = HubsSearchViewModel()
        viewModel.coordinator = self
        let searchVC = HubSearchViewController(viewModel: viewModel)
        rootNC?.pushViewController(searchVC, animated: true)
    }

    func show(hub: Hub) {
        rootNC?.popViewController(animated: true)
        map?.show(hub: hub)
    }
}
