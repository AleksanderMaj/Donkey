import Foundation
import Alamofire

public class DonkeyWebservice {
    public init() {}

    private let adminId = "878"

    public func fetchHubs(in area: Area, onComplete: @escaping ([Hub]) -> Void) {
        Alamofire
            .request(HubsRouter.getHubs(in: area))
            .responseData(completionHandler: { (response) in
                guard let data = response.data else { return }
                do {
                    onComplete(try [Hub].decode(data: data))
                } catch {
                    print(error.localizedDescription)
                }
            })
    }

    public func searchHubs(query: String, onComplete: @escaping ([Hub]) -> Void) {
        Alamofire
            .request(HubsRouter.search(query: query, adminId: adminId))
            .responseData(completionHandler: { (response) in
                guard let data = response.data else { return }
                String(data: data, encoding: .utf8).flatMap { print($0) }
                do {
                    onComplete(try [Hub].decode(data: data))
                } catch {
                    print(error.localizedDescription)
                }
            })
    }
}
