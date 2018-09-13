import PlaygroundSupport
import DonkeyFramework

private func mockFetchHubs(in area: Area, onComplete: @escaping (DonkeyResult<[Hub]>) -> Void) {
    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
        onComplete(.failure(DonkeyError.noData))
    }
}

//Current.webservice.fetchHubs = mockFetchHubs(in:onComplete:)

let mapVC = MapViewController(viewModel: MapViewModel())
PlaygroundPage.current.liveView = mapVC
