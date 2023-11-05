//
//  FriendDetailView.swift
//  Confriends
//
//  Created by Tyler Milner on 10/22/23.
//

import MapKit
import SwiftUI

struct FriendDetailView: View {
    @State private var mapRegion: MKCoordinateRegion
    
    private let defaultLocationCoordinate = CLLocationCoordinate2D(latitude: 0, longitude: 0)
    private let defaultCoordinateSpan = MKCoordinateSpan(latitudeDelta: 25, longitudeDelta: 25)
    
    let friend: Friend
    let image: UIImage?
    
    init(friend: Friend, image: UIImage?) {
        self.friend = friend
        self.image = image
        
        if let location = friend.location {
            self._mapRegion = State(initialValue: MKCoordinateRegion(center: location.coordinate, span: defaultCoordinateSpan))
        } else {
            self._mapRegion = State(initialValue: MKCoordinateRegion(center: defaultLocationCoordinate, span: defaultCoordinateSpan))
        }
    }
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack {
                    if let image = image {
                        HStack {
                            Spacer()
                            
                            Image(uiImage: image)
                                .resizable()
                                .scaledToFit()
                                .frame(maxWidth: geometry.size.width * 0.8)
                            
                            Spacer()
                        }
                    } else {
                        ZStack {
                            Circle()
                                .foregroundColor(.gray)
                                .frame(maxWidth: geometry.size.width * 0.6)
                            
                            Image(systemName: "person")
                                .resizable()
                                .scaledToFit()
                                .frame(maxWidth: geometry.size.width * 0.3)
                                .foregroundColor(.white)
                        }
                        .frame(maxWidth: .infinity) // Centers ZStack horizontally
                    }
                    
                    if let location = friend.location {
                        Map(coordinateRegion: $mapRegion, annotationItems: [location]) { location in
                            MapAnnotation(coordinate: location.coordinate) {
                                Image(systemName: "star.circle")
                                    .resizable()
                                    .foregroundColor(.red)
                                    .frame(width: 44, height: 44)
                                    .background(.white)
                                    .clipShape(Circle())
                            }
                        }
                        .frame(width: geometry.size.width * 0.9, height: geometry.size.width * 0.9)
                    }
                }
            }
        }
        .navigationTitle(friend.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    let friend = Friend(name: "John Doe", location: .example)
    return FriendDetailView(friend: friend, image: nil)
}
