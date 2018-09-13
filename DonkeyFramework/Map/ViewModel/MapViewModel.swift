import Foundation

public protocol MapViewModelInput {
    var view: MapViewType? { get set }
    func viewDidLoad()
    func areaDidChange(area: Area)
    func didTapSearch()
}

public class MapViewModel {
    public weak var view: MapViewType?
    weak var coordinator: AppCoordinator?

    var hubMap = [Hub: HubAnnotation]()

    public init() {}

    fileprivate func handle(fetchedHubs: Set<Hub>) {
        let existingHubs = Set(hubMap.keys)
        let newHubs = fetchedHubs.subtracting(existingHubs)
        insertHubs(newHubs)

        let offscreenHubs = existingHubs.subtracting(fetchedHubs)
        removeHubs(offscreenHubs)
    }

    fileprivate func insertHubs(_ newHubs: Set<Hub>) {
        let newAnnotations = newHubs.compactMap { HubAnnotation(hub: $0) }
        newAnnotations.forEach { hubMap[$0.hub] = $0 }
        view?.add(hubAnnotations: newAnnotations)
    }

    fileprivate func removeHubs(_ oldHubs: Set<Hub>) {
        let offscreenAnnotations = oldHubs.compactMap { hubMap.removeValue(forKey: $0) }
        view?.remove(hubAnnotations: offscreenAnnotations)
    }
}

extension MapViewModel: MapViewModelInput {
    public func viewDidLoad() {}

    public func areaDidChange(area: Area) {
        Current.webservice.fetchHubs(area) { [weak self] (result) in
            switch result {
            case let .success(hubs):
                self?.handle(fetchedHubs: Set(hubs))
            case .failure:
                break
                // Show alert to the user
            }
        }
    }

    public func didTapSearch() {
        coordinator?.showSeachInterface()
    }
}

extension MapViewModel: MapInterface {
    func show(hub: Hub) {
        // Make sure that the new hub is marked on the map.
        // This is basically like handling fetch results.
        handle(fetchedHubs: Set([hub]))

        guard let annotation = hubMap[hub] else { return }
        view?.show(hubAnnotation: annotation)
    }
}
