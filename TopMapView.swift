//
//  TopMapView.swift
//  Bustle
//
//  Created by Carter Brehm on 9/5/23.
//

import SwiftUI
import MapKit

struct TopMapView: View {
    @Binding var mapCameraPosition: MapCameraPosition
    var mapCameraBounds: MapCameraBounds
    @Binding var selectedMapFeature: MapFeature?
    @Namespace var mapScope
    var busses: [Vehicle]
    var stops: [Stop]
    var routes: [Route]
    var body: some View {
        Map(position: $mapCameraPosition, bounds: mapCameraBounds, interactionModes: .all, selection: $selectedMapFeature, scope: mapScope) {
            UserAnnotation()
            ForEach(busses) { bus in
//                Marker(bus.name, systemImage: "bus", coordinate: bus.location)
                Annotation(bus.name, coordinate: bus.location) {
                    BusMapIcon()
                }
            }
            ForEach(stops) { stop in
                Marker(stop.name, monogram: Text(Constants.stopMonogram[stop.name] ?? "??"), coordinate: stop.location)
            }
            ForEach(routes) { route in
                if let coordinates = route.polyline.coordinates {
                    MapPolyline(coordinates: coordinates, contourStyle: .straight).stroke(route.color, style: StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .round, dash: [5,10]))
                }
            }
        }.mapControls {
            MapUserLocationButton(scope: mapScope)
            MapCompass(scope: mapScope)
            MapPitchToggle(scope: mapScope)
            MapScaleView(scope:mapScope)
        }
        .mapStyle(MapStyle.standard(elevation: .realistic, pointsOfInterest: .excludingAll))
    }
}
