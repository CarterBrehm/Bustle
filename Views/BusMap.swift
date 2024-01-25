import SwiftUI
import MapKit

struct BusMap: View {
    @Binding var position: MapCameraPosition
    @EnvironmentObject var fetcher: Fetcher
    
    var body: some View {
        Map(position: $position) {
            // UserAnnotation()
            ForEach(fetcher.vehicles) { vehicle in
                Annotation(vehicle.name, coordinate: vehicle.location) { Text("🚌").font(.largeTitle) }
            }
            ForEach(fetcher.vehicles.compactMap({$0.route}).filter({$0.enabled})) { route in
                if let coordinates = route.polyline.coordinates {
                    MapPolyline(coordinates: coordinates, contourStyle: .straight).stroke(route.color, style: StrokeStyle(lineWidth: 3, lineCap: .round, lineJoin: .round, dash: [7, 10]))
                }
            }
        }
    }
}
