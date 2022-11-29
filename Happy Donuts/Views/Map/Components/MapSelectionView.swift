//
//  MapSelectionView.swift
//  Happy Donuts
//
//  Created by Jacob Aguilar on 26-11-22.
//

import SwiftUI
import MapKit

struct MapSelectionView: View {
    
    @EnvironmentObject var locationViewModel: LocationViewModel
    
    var body: some View {
        ZStack {
            MapViewHelper()
                .environmentObject(locationViewModel)
                .ignoresSafeArea()
            
            if let place = locationViewModel.pickedPlaceMark {
                VStack(spacing: 15) {
                    Text("Confirma tu ubicación")
                        .font(.system(size: 18, weight: .black, design: .rounded))
                        
                    HStack(spacing: 15) {
                        Image(systemName: "mappin.circle.fill")
                            .font(.system(size: 35, weight: .bold, design: .rounded))
                            .padding(.leading, 10)
                            .foregroundColor(Color(.red))
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text(place.name ?? "")
                                .font(.system(size: 15, weight: .black, design: .rounded))
                            
                            Text(place.locality ?? "")
                                .font(.system(size: 15, weight: .semibold, design: .rounded))
                        }
                        
                        Spacer()
                    }
                    .frame(maxWidth: .infinity, minHeight: 70, alignment: .leading)
                    .padding(.vertical, 10)
                    
                    Button {
                        locationViewModel.selectedLocation = "\(place.name ?? ""), \(place.locality ?? "")"
                        print("Localizacion: \(locationViewModel.selectedLocation)")
                    } label: {
                        Text("Confirmar")
                            .frame(maxWidth: .infinity)
                            .foregroundColor(Color("buttonTextColor"))
                            .font(.system(size: 16, weight: .bold, design: .rounded))
                            .padding(.vertical, 12)
                            .background{
                                RoundedRectangle (cornerRadius: 30, style: .continuous)
                                    .fill(Color("blue"))
                            }
                            .overlay(alignment: .trailing) {
                                Image(systemName: "arrow.right")
                                    .padding(.trailing)
                                    .foregroundColor(Color("buttonTextColor"))
                                    .font(.system(size: 16, weight: .bold, design: .rounded))
                            }
                    }

                }
                .foregroundColor(Color("fontColor"))
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 35, style: .continuous)
                        .fill(Color("background"))
                        .shadow(color: Color("shadow"), radius: 2, x: 2, y: 4)
                )
                .frame(maxHeight: .infinity, alignment: .bottom)
                .padding(.horizontal, 10)
            }
        }
        .onDisappear {
            locationViewModel.pickedLocation = nil
            locationViewModel.pickedPlaceMark = nil
            locationViewModel.mapView.removeAnnotations(locationViewModel.mapView.annotations)
        }
    }
}

struct MapSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        MapSelectionView()
    }
}

// Mark: UIKit MapView
struct MapViewHelper: UIViewRepresentable {
    
    @EnvironmentObject var locationViewModel: LocationViewModel
    
    func makeUIView(context: Context) -> MKMapView {
        return locationViewModel.mapView
    }
    
    func updateUIView(_ uiView: MKMapView, context: UIViewRepresentableContext<MapViewHelper>) {
//        let coords = CLLocationCoordinate2D(latitude: -33.47, longitude: -70.64)
//        let span = MKCoordinateSpan(latitudeDelta: 0.3, longitudeDelta: 0.3)
//        let region = MKCoordinateRegion(center: coords, span: span)
//
//        uiView.setRegion(region, animated: false)
    }
}
