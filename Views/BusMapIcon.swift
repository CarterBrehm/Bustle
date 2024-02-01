import SwiftUI

struct BusMapIcon: View {
    var vehicle: Vehicle
    @Binding var mapHeading: Double
    var body: some View {
        let busRotation = vehicle.heading == 0 ? 0 : Double(vehicle.heading) - mapHeading - 90
        Text("🚌")
            .font(.system(size: 32))
            .rotationEffect(Angle(degrees: busRotation))
            //.scaleEffect(CGSize(width: 1.0, height: busRotation.magnitude > 180 ? -1.0 : 1.0))
    }
}
