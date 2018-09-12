import Foundation
import Alamofire

public class DonkeyWebservice {
    public init() {}

    public func fetchHubs() {
        let parameters: Parameters = [
            "location": "55.666101,12.581971",
            "radius": 1000
        ]
        let headers: HTTPHeaders = [
            "Accept": "application/com.donkeyrepublic.v2",
            "Content-Type": "application/json",
            "Authorization": "ksDutdcJzrdn8KgqWL9C"
        ]

        Alamofire
            .request("https://staging.donkey.bike/api/public/availability/hubs",
                     parameters: parameters,
                     headers: headers)
            .responseData(completionHandler: { (response) in
                guard let data = response.data else { return }
                do {
                    let hubs = try [Hub].decode(data: data)
                    print(hubs)
                } catch {
                    print(error.localizedDescription)
                }
            })

    }
}
