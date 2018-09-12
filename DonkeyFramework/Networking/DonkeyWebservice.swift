import Foundation
import Alamofire

public class DonkeyWebservice {
    public init() {}

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
}
