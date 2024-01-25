import Foundation

protocol GenericAPI {
    // all types that implement this protocol must contain their own session and a means to use it
    var session: URLSession { get }
    func fetch<T: Codable>(type: T.Type, with request: URLRequest) async throws -> T
}

extension GenericAPI {
    func fetch<T: Codable>(type: T.Type, with request: URLRequest) async throws -> T {
        let (data, response) = try await session.data(for: request)
        if let url = request.url?.absoluteString {
            if (url.contains("file")) {
                // we're in mock mode... don't check for HTTP errors
            } else {
                guard let httpResponse = response as? HTTPURLResponse else {
                    throw APIError.requestFailed(description: "Invalid response")
                }
                guard httpResponse.statusCode == 200 else {
                    throw APIError.responseUnsuccessful(description: "Status code: \(httpResponse.statusCode)")
                }
            }
        }
        do {
            let decoder = JSONDecoder()
            return try decoder.decode(type, from: data)
        } catch {
            debugPrint(error)
            throw APIError.jsonConversionFailure(description: error.localizedDescription)
        }
    }
}

