import Foundation

final class Client: GenericAPI {

    // client-owned URL session
    let session: URLSession

    // passing in a custom configuration
    init(configuration: URLSessionConfiguration) {
        self.session = URLSession(configuration: configuration)
    }

    // the default URLSessionConfiguration
    convenience init() {
        self.init(configuration: .default)
    }
}
