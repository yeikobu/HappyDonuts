//
//  MapView.swift
//  Happy Donuts
//
//  Created by Jacob Aguilar on 25-11-22.
//

import SwiftUI
import MapKit

struct LocationView: View {
    
    @StateObject var locationViewModel = LocationViewModel()
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack(alignment: .top) {
//            Map(coordinateRegion: self.$locationViewModel.userLocation, showsUserLocation: true)
//                .ignoresSafeArea()
            MapSelectionView()
                .environmentObject(locationViewModel)
            
            VStack {
                Button {
                    dismiss()
                } label: {
                    VStack {
                        Image(systemName: "chevron.compact.down")
                            .font(.system(size: 40, weight: .bold, design: .rounded))
                            .foregroundColor(.white)
                            .shadow(color: .black, radius: 2, x: 2, y: 2)
                    }
                }
                .padding(.vertical, 10)
                
                if self.locationViewModel.userHasLocation {
                    HStack {
                        VStack {
                            Image(systemName: "magnifyingglass")
                                .font(.system(size: 16, weight: .bold, design: .rounded))
                        }
                        .frame(width: 30, height: 42, alignment: .center)
                        .padding(.leading, 10)
                        
                        Divider()
                            .frame(width: 1, height: 32)
                            .background(Color("fontColor"))
                        
                        ZStack(alignment: .leading) {
                            if self.locationViewModel.searchedLocation.isEmpty {
                                Text(verbatim: "Busca una dirección")
                                    .font(.system(size: 18, weight: .bold, design: .rounded))
                            }
                            
                            TextField(" ", text: self.$locationViewModel.searchedLocation)
                                .font(.system(size: 18, weight: .bold, design: .rounded))
                                .keyboardType(.default)
                                .ignoresSafeArea(.keyboard, edges: .bottom)
                                .padding(.vertical, 10)
                        }
                        
                        if !self.locationViewModel.searchedLocation.isEmpty {
                            Button {
                                self.locationViewModel.searchedLocation = ""
                                self.locationViewModel.fetchedPlaces = []
                            } label: {
                                VStack {
                                    Image(systemName: "xmark")
                                        .foregroundColor(Color("fontColor"))
                                        .font(.system(size: 16, weight: .bold, design: .rounded))
                                }
                            }
                            .padding(.trailing, 10)
                        }
                    }
                    .background(
                        RoundedRectangle(cornerRadius: 15, style: .continuous)
                            .foregroundColor(Color("textField"))
                            .shadow(color: Color("shadow"), radius: 2, x: 2, y: 4)
                    )
                    .padding(.horizontal, 10)
                    
                    
                    if let places = locationViewModel.fetchedPlaces, !places.isEmpty {
                        ScrollView(showsIndicators: false) {
                            ForEach(places, id: \.self) { place in
                                HStack(spacing: 15) {
                                    Image(systemName: "mappin.circle.fill")
                                        .font(.system(size: 22, weight: .bold, design: .rounded))
                                        .padding(.leading, 10)
                                        .foregroundColor(Color("blue"))
                                    
                                    VStack(alignment: .leading, spacing: 8) {
                                        Text(place.name ?? "")
                                            .font(.system(size: 15, weight: .black, design: .rounded))
                                        
                                        Text(place.locality ?? "")
                                            .font(.system(size: 15, weight: .semibold, design: .rounded))
                                    }
                                    
                                    Spacer()
                                }
                                .frame(maxWidth: .infinity, minHeight: 70)
                                .onTapGesture {
                                    if let coordinate = place.location?.coordinate {
                                        locationViewModel.pickedLocation = .init(latitude: coordinate.latitude, longitude: coordinate.longitude)
                                        locationViewModel.mapView.region = .init(center: coordinate, latitudinalMeters: 500, longitudinalMeters: 500)
                                        print("Coordinate: \(coordinate)")
                                        locationViewModel.addDraggablePin(coordinate: coordinate)
                                        locationViewModel.updatePlaceMark(location: .init(latitude: coordinate.latitude, longitude: coordinate.longitude))
                                    }
                                }
                                
                                Divider()
                                    .foregroundColor(Color("fontColor"))
                                    .frame(height: 2)
                            }
                        }
                        .background(
                            RoundedRectangle(cornerRadius: 15)
                                .foregroundColor(Color("background"))
                                .shadow(color: Color("shadow"), radius: 5, x: 2, y: 4)
                        )
                        .padding(.horizontal, 20)
                        .frame(maxHeight: (CGFloat(locationViewModel.fetchedPlaces!.count) * 80))
                    } else {
                        Button {
                            if let coordinate = locationViewModel.userCurrentLocation?.coordinate {
                                locationViewModel.mapView.region = .init(center: coordinate, latitudinalMeters: 500, longitudinalMeters: 500)
                                print("Coordinate: \(coordinate)")
                                locationViewModel.addDraggablePin(coordinate: coordinate)
                                locationViewModel.updatePlaceMark(location: .init(latitude: coordinate.latitude, longitude: coordinate.longitude))
                            }
                        } label: {
                            Label {
                                Text("Usar la localización actual")
                            } icon: {
                                Image(systemName: "location.north.circle.fill")
                            }
                            .font(.system(size: 16, weight: .bold, design: .rounded))
                            .foregroundColor(.green)
                            .shadow(color: Color(.black), radius: 1, x: 2, y: 2)
                        }
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .padding(.top, 5)
                        .padding(.trailing, 10)
                    }

                }
            }
            
            if !self.locationViewModel.userHasLocation {
                VStack(alignment: .center, spacing: 10) {
                    Text("Localización NO aceptada")
                        .font(.system(size: 16, weight: .black, design: .rounded))
                        .padding(.top, 10)

                    Divider()

                    Text("Por favor, autoriza la localización para ubicarte en el mapa y poder enviar tu pedido a donde te encuentras ahora")
                        .font(.system(size: 12, weight: .bold, design: .rounded))
                        .padding(.top, 10)

                    Link(destination: URL(string: UIApplication.openSettingsURLString)!) {
                        VStack {
                            Text("Autorizar")
                                .font(.system(size: 16, weight: .black, design: .rounded))
                                .foregroundColor(Color("buttonTextColor"))
                        }
                        .padding(15)
                        .background(Color("blue"))
                        .cornerRadius(40)
                        .padding()
                    }

                }
                .background(
                    RoundedRectangle(cornerRadius: 35)
                        .foregroundColor(Color("background"))
                        .cornerRadius(20)
                        .shadow(color: Color("shadow"), radius: 5, x: 2, y: 4)
                )
                .padding(.horizontal, 30)
                .padding(.top, 300)
            }
        }
        .foregroundColor(Color("fontColor"))
    }
}

struct LocationView_Previews: PreviewProvider {
    static var previews: some View {
        LocationView()
    }
}
