import Foundation

protocol HubsSearchViewModelInput {
    var view: HubSearchViewType? { get set }
    func search(query: String)
    func didSelectItem(atIndex: Int)
}

class HubsSearchViewModel: HubsSearchViewModelInput {
    weak var coordinator: MapCoordinator?
    weak var view: HubSearchViewType?

    var hubs = [Hub]()

    func search(query: String) {
        DonkeyWebservice().searchHubs(query: query) { [weak self] (hubs) in
            self?.handleSearchResults(hubs)
        }
    }

    func didSelectItem(atIndex index: Int) {
        let hub = hubs[index]
        coordinator?.show(hub: hub)
    }

    private func handleSearchResults(_ hubs: [Hub]) {
        self.hubs = hubs
        view?.showResults(hubs.map { $0.name }) 
    }
}
