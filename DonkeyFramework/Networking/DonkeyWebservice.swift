import Foundation
import Alamofire

public enum Result<A, E> {
    case success(A)
    case failure(E)
}

public enum DonkeyError: Error {
    case noData
}

public typealias DonkeyResult<A> = Result<A, Error>

public class DonkeyWebservice {
    public init() {}

    public var fetchHubs = fetchHubs(in:onComplete:)
    public var searchHubs = searchHubs(query:onComplete:)

}

private func fetchHubs(in area: Area, onComplete: @escaping (DonkeyResult<[Hub]>) -> Void) {
    Alamofire
        .request(HubsRouter.getHubs(in: area))
        .validate(statusCode: 200...299)
        .responseData(queue: DispatchQueue.global(qos: .userInitiated), completionHandler: { (response) in
            handleResponse(response: response, onComplete: onComplete)
        })
}

private func searchHubs(query: String, onComplete: @escaping (DonkeyResult<[Hub]>) -> Void) {
    let adminId = "878"
    Alamofire
        .request(HubsRouter.search(query: query, adminId: adminId))
        .validate(statusCode: 200...299)
        .responseData(queue: DispatchQueue.global(qos: .userInitiated), completionHandler: { (response) in
            handleResponse(response: response, onComplete: onComplete)
        })
}

private func handleResponse<A: DonkeyType>(response: DataResponse<Data>,
                                           onComplete: (DonkeyResult<[A]>) -> Void) {
    if let error = response.error {
        onComplete(.failure(error))
        return
    }
    guard let data = response.data else {
        onComplete(.failure(DonkeyError.noData))
        return
    }
    do {
        onComplete(.success(try [A].decode(data: data)))
    } catch {
        print(error.localizedDescription)
        onComplete(.failure(error))
    }
}
