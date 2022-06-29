//
//  HTTPClient.swift
//  mask
//
//  Created by Kai Fu Jhuang on 2022/6/29.
//

import Foundation

enum Result<T> {

    case success(T)

    case failure(Error)
}

// MARK: Error

enum STHTTPClientError: Error {

    case decodeDataFail

    case clientError(Data)

    case serverError

    case unexpectedError
}

// MARK: Method

enum STHTTPMethod: String {

    case GET

    case POST
    
}

protocol STRequest {
 
}

extension STRequest {

    func makeRequest() -> URLRequest {

        let urlString = Bundle.ValueForString(key: MaskConstant.urlKey)

        let url = URL(string: urlString)!

        let request = URLRequest(url: url)

        return request
    }
}

class HTTPClient {
    
    static let shared = HTTPClient()

    private let decoder = JSONDecoder()

    private let encoder = JSONEncoder()
    
    private init() { }
    
    func request(_ stRequest: URLRequest,
        completion: @escaping (Result<Data>) -> Void
    ) {

        URLSession.shared.dataTask(
            with: stRequest,
            completionHandler: { (data, response, error) in

            guard error == nil else {

                return completion(Result.failure(error!))
            }
                
            // swiftlint:disable force_cast
            let httpResponse = response as! HTTPURLResponse
            // swiftlint:enable force_cast
            let statusCode = httpResponse.statusCode
                
                print ("StatusCode=\(statusCode)")
            switch statusCode {
                
            case 200..<300:

                completion(Result.success(data!))

            case 400..<500:

                completion(Result.failure(STHTTPClientError.clientError(data!)))

            case 500..<600:

                completion(Result.failure(STHTTPClientError.serverError))

            default: return

                completion(Result.failure(STHTTPClientError.unexpectedError))
            }

        }).resume()
    }
    
    
    
    
}
