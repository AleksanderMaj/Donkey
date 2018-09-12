import Foundation
import Alamofire

enum HubsRouter: URLRequestConvertible {
    case getHubs(in: Area)

    func asURLRequest() throws -> URLRequest {
        var urlRequest = try URLRequest(url: url, method: method)
        urlRequest.addValue("application/com.donkeyrepublic.v2", forHTTPHeaderField: "Accept")
        urlRequest.addValue("ksDutdcJzrdn8KgqWL9C", forHTTPHeaderField: "Authorization")
        return try encoding.encode(urlRequest, with: params)
    }

    var url: URL {
        let baseURL = URL(string: "https://staging.donkey.bike")
        switch self {
        case .getHubs:
            return URL(string: "/api/public/availability/hubs", relativeTo: baseURL)!
        }
    }

    var method: HTTPMethod {
        switch self {
        case .getHubs:
            return .get
        }
    }

    var encoding: ParameterEncoding {
        switch self {
        case .getHubs:
            return URLEncoding.default
        }
    }

    var params: Parameters {
        switch self {
        case let .getHubs(in: area):
            return area.toParams()
        }
    }
}
