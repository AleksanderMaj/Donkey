import Foundation

public protocol MapViewModelInput {
    var view: MapViewType? { get set }
    func viewDidLoad()
    func areaDidChange(area: Area)
    func didTapSearch()
}

public class MapViewModel {
    public weak var view: MapViewType?
    weak var coordinator: MapCoordinator?

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
        DonkeyWebservice().fetchHubs(in: area) { [weak self] (fetchedHubs) in
            self?.handle(fetchedHubs: Set(fetchedHubs))
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
        view?.show(hubAnnotations: [annotation])
    }
}
