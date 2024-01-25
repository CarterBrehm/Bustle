import Foundation

protocol GenericAPI {
    // all types that implement this protocol must contain their own session and a means to use it
    var session: URLSession { get }
    func fetch<T: Codable>(type: T.Type, with request: URLRequest) async throws -> T
}

extension GenericAPI {
    func fetch<T: Codable>(type: T.Type, with request: URLRequest) async throws -> T {
        let (data, response) = try await session.data(for: request)

        do {
            let decoder = JSONDecoder()
            return try decoder.decode(type, from: data)
        } catch {
            debugPrint(error)
            throw APIError.jsonConversionFailure(description: error.localizedDescription)
        }
    }
}

