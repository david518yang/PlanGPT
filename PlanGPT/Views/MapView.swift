//
//  MapView.swift
//  PlanGPT
//
//  Created by David Yang on 4/29/23.
//

import SwiftUI
import MapKit

struct Location: Identifiable {
    let id = UUID()
    let name: String
    let coordinate: CLLocationCoordinate2D
}

struct PlaceAnnotationView: View {
    var name: String
    
    var body: some View {
        VStack(spacing: 0) {
            Text(name)
                .font(.caption)
                .padding(5)
                .background(Color.white.opacity(0.8))
                .cornerRadius(15)
            
            Image(systemName: "mappin.circle.fill")
                .font(.title)
                .foregroundStyle(.white, .red)
            
            Image(systemName: "arrowtriangle.down.fill")
                .font(.caption)
                .foregroundColor(.red)
                .offset(x: 0, y: -5)
        }
        .shadow(radius: 10)
    }
}

struct MapView: View {
    var days: [Day]
    @State private var mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 39.8712, longitude: -103.771556), span: MKCoordinateSpan(latitudeDelta: 30, longitudeDelta: 30))
    @State private var locations: [Location] = []
    
    var body: some View {
        Map(coordinateRegion: Binding<MKCoordinateRegion>(
            // This binding is a workaround for a known bug found on Stack overflow
            get: { mapRegion },
            set: { _ in }
        ), annotationItems: locations) { location in
            MapAnnotation(coordinate: location.coordinate) {
                PlaceAnnotationView(name: location.name)
            }
        }
        .frame(height: 200)
        .onAppear {
            setupLocationsAndMapRegion()
        }
    }
    
    private func setupLocationsAndMapRegion() {
        let latitudeArray = days.map { day in
            return day.latitude
        }
        let longitudeArray = days.map { day in
            return day.longitude
        }
        
        if let latitudeMax = latitudeArray.max(), let latitudeMin = latitudeArray.min(),
           let longitudeMax = longitudeArray.max(), let longitudeMin = longitudeArray.min() {
            let latitudeRange = latitudeMax - latitudeMin
            let longitudeRange = longitudeMax - longitudeMin
            
            mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: latitudeArray.reduce(0, +)/Double(latitudeArray.count), longitude: longitudeArray.reduce(0, +)/Double(longitudeArray.count)), span: MKCoordinateSpan(latitudeDelta: latitudeRange+5, longitudeDelta: longitudeRange+5))
            
            locations = populateLocations(days: days)
        }
    }
    
    private func populateLocations (days: [Day]) -> [Location] {
        return days.map { day in
            return Location(name:day.location,
                            coordinate: CLLocationCoordinate2D(latitude:day.latitude, longitude: day.longitude))
        }
    }
    
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView(days: [Day(day:0,food:"food",location:"location",sightseeing:"sightseeing", latitude: 34.1017, longitude: -118.3403)])
    }
}
