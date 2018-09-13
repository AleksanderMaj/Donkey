import Foundation

protocol HubsSearchViewModelInput {
    var view: HubSearchViewType? { get set }
    func search(query: String)
    func didSelectItem(atIndex: Int)
}

class HubsSearchViewModel: HubsSearchViewModelInput {
    weak var coordinator: AppCoordinator?
    weak var view: HubSearchViewType?
    private var throttleTimer: Timer?

    var hubs = [Hub]()

    func search(query: String) {
        throttleTimer?.invalidate()
        throttleTimer = Timer.scheduledTimer(withTimeInterval: 0.3, repeats: false, block: { [weak self] _ in
            Current.webservice.searchHubs(query) { [weak self] (result) in
                switch result {
                case let .success(results):
                    self?.handleSearchResults(results)
                case .failure:
                    // Display error to the user
                    break
                }
            }
        })
    }

    func didSelectItem(atIndex index: Int) {
        let hub = hubs[index]
        coordinator?.show(hub: hub)
    }

    private func handleSearchResults(_ hubs: [Hub]) {
        self.hubs = hubs
        DispatchQueue.main.async {
            self.view?.showResults(hubs.map { $0.name })
        }
    }
}
