import PlaygroundSupport
import DonkeyFramework

let mapVC = MapViewController()
PlaygroundPage.current.liveView = mapVC

DonkeyWebservice().fetchHubs()
