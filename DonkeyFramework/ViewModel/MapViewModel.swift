import Foundation

public protocol MapViewModelInput {
    var view: MapViewType? { get set }
    func viewDidLoad()
    func areaDidChange(area: Area)
}

public class MapViewModel {
    public weak var view: MapViewType?

    var hubMap = [Hub: HubAnnotation]()

    public init() {}

    fileprivate func handle(fetchedHubs: Set<Hub>) {
        let existingHubs = Set(hubMap.keys)
        let newHubs = fetchedHubs.subtracting(existingHubs)

        let newAnnotations = newHubs.compactMap { HubAnnotation(hub: $0) }
        newAnnotations.forEach {
            hubMap[$0.hub] = $0
        }

        view?.add(hubAnnotations: newAnnotations)

        let offscreenHubs = existingHubs.subtracting(fetchedHubs)
        let offscreenAnnotations = offscreenHubs.compactMap { hubMap.removeValue(forKey: $0) }
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
}
