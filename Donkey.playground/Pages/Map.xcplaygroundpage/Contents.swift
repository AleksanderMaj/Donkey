import PlaygroundSupport
import DonkeyFramework

let mapVC = MapViewController(viewModel: MapViewModel())
PlaygroundPage.current.liveView = mapVC

DonkeyWebservice().searchHubs(query: "Piotr", adminId: "878") { (results) in
    print(results)
}
