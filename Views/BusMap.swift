import SwiftUI
import MapKit

struct BusMap: View {
    @Binding var position: MapCameraPosition
    @EnvironmentObject var fetcher: Fetcher
    @State private var heading: Double = 0
    
    var body: some View {
        Map(position: $position) {
            UserAnnotation()
            
            // adding all the busses
            ForEach(fetcher.vehicles) { vehicle in
                Annotation(vehicle.name, coordinate: vehicle.location) {
                    BusMapIcon(vehicle: vehicle, mapHeading: $heading)
                }
            }
            
            // adding all of the route polylines
            ForEach(fetcher.vehicles.compactMap({$0.route}).filter({$0.enabled})) { route in
                if let coordinates = route.polyline.coordinates {
                    MapPolyline(coordinates: coordinates, contourStyle: .straight).stroke(route.color, style: StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .round, dash: [5, 10]))
                }
            }
            
            // adding all of the stops
            ForEach(Array(Set(fetcher.vehicles.flatMap({$0.route?.stops ?? Stops()})))) { stop in
                Marker(stop.name, monogram: Text(Constants.stopMonogram[stop.name] ?? "??"), coordinate: stop.location)
            }.annotationTitles(.hidden)
        }.mapControls {
            RefreshButton()
            MapUserLocationButton()
            MapCompass()
            MapPitchToggle()
            MapScaleView()
        }
        .mapStyle(MapStyle.standard(elevation: .realistic, pointsOfInterest: .excludingAll))
        .onMapCameraChange(frequency: .continuous) { context in
            heading = context.camera.heading
        }
    }
}
