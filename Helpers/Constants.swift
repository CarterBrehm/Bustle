import Foundation
import _MapKit_SwiftUI

struct Constants {
    static let origin =  MapCameraPosition.region(MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 41.2426841, longitude: -96.0106684), span: MKCoordinateSpan(latitudeDelta: 0.03, longitudeDelta: 0.03)))
        static let baseUrl = "https://unomaha.ridesystems.net/Services/JSONPRelay.svc/"
        static let stopMonogram = ["Scott Crossing": "SX",
                                   "Scott Hall": "SH",
                                   "Scott Court": "SC",
                                   "Mammel Hall": "MH",
                                   "PKI": "PKI",
                                   "Newman Center": "NC",
                                   "Pacific St. Garage": "PG",
                                   "Maverick Village/University Village": "MUV",
                                   "H&K": "H&K",
                                   "Criss Library": "CL",
                                   "Milo Bail Student Center": "MB",
                                   "UNMC": "UNMC"
                                    ]
        static let stopDetailText = ["Durango Route": "Operates from 7am to 7pm, Mon-Thur, while classes are in session.",
                                     "Maverick Route": "Operates from 7am to 7pm, Mon-Thur, while classes are in session. When the ADA bus has no scheduled pickups/dropoffs, it will assist with this route.",
                                     "Durango Route Evening & Early Morning": "Operates from 5:30am-7am & 7pm-10:30pm, Mon-Thur, while classes are in session.",
                                     "Evening & Friday": "Operates from 7am to 6pm, Fri, while classes are in session. When the ADA bus has no scheduled pickups/dropoffs, it will assist with this route.",
                                     "Scheduled ADA": "Provides dedicated transportation for ADA riders on campus, based on the location/destination of the rider. Assists with other routes as described."
                                      ]
        static let routeShortName = ["Durango Route": "Durango",
                                     "Maverick Route": "Maverick",
                                     "Durango Route Evening & Early Morning" :"Morning & Evening",
                                     "Scheduled ADA": "ADA"
                                    ]
}
