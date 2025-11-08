//
//  DetailView.swift
//  Remember Names
//
//  Created by Mohsin khan on 06/11/2025.
//

import SwiftUI
import MapKit

struct DetailView: View {
    let person : Person
    var body: some View {
        ScrollView {
                    VStack(spacing: 20) {
                        Text(person.name)
                            .font(.largeTitle)
                            .bold()
                        
                        if let uiImage = UIImage(data: person.photo) {
                            Image(uiImage: uiImage)
                                .resizable()
                                .scaledToFill() 
                                .frame(width: 250, height: 250)
                                .clipShape(Circle())
                                .shadow(radius: 10)
                                                   
                        }

                        if let lat = person.latitude, let lon = person.longitude {
                            Map(initialPosition: .region(
                                MKCoordinateRegion(
                                    center: CLLocationCoordinate2D(latitude: lat, longitude: lon),
                                    span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
                                )
                            )) {
                                Marker(person.name, coordinate: CLLocationCoordinate2D(latitude: lat, longitude: lon))
                            }
                            .frame(height: 300)
                            .clipShape(RoundedRectangle(cornerRadius: 15))
                        } else {
                            Text("No location available")
                                .foregroundColor(.secondary)
                        }
                    }
                    .padding()
                }
    }
}

#Preview {
    DetailView(person: Person(name: "Ali", photo: Data()))
}
