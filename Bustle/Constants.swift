//
//  Constants.swift
//  Bustle
//
//  Created by Carter Brehm on 8/18/23.
//

import Foundation
import _MapKit_SwiftUI

struct Constants {
    static let origin =  MapCameraPosition.region(MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 41.252445, longitude: -96.018061), span: MKCoordinateSpan(latitudeDelta: 0.03, longitudeDelta: 0.03)))
    static let court = CLLocationCoordinate2D(latitude: 41.2427869882, longitude: -96.0120084743)
    static let crossing = CLLocationCoordinate2D(latitude: 41.24434, longitude: -96.013123)
    static let baseUrl = "https://unomaha.ridesystems.net/Services/JSONPRelay.svc/"
    static let stopMetadata = ["Scott Crossing": "SX",
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
}
