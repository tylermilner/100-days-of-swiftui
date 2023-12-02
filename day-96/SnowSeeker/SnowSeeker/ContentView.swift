//
//  ContentView.swift
//  SnowSeeker
//
//  Created by Tyler Milner on 11/20/23.
//

import SwiftUI

extension View {
    @ViewBuilder func phoneOnlyNavigationView() -> some View {
        if UIDevice.current.userInterfaceIdiom == .phone {
            self.navigationViewStyle(.stack)
        } else {
            self
        }
    }
}

struct ContentView: View {
    let resorts: [Resort] = Bundle.main.decode("resorts.json")
    
    enum FilterSort {
        case `default`, alphabetical, country
    }
    
    @StateObject var favorites = Favorites()
    @State private var searchText = ""
    
    @State private var filterSort: FilterSort = .default
    @State private var isShowingSortDialog = false
    
    var body: some View {
        NavigationView {
            List(filteredResorts) { resort in
                NavigationLink {
                    ResortView(resort: resort)
                } label: {
                    HStack {
                        Image(resort.country)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 40, height: 25)
                            .clipShape(RoundedRectangle(cornerRadius: 5))
                            .overlay(
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(.black, lineWidth: 1)
                            )
                        
                        VStack(alignment: .leading) {
                            Text(resort.name)
                                .font(.headline)
                            Text("\(resort.runs) runs")
                                .foregroundColor(.secondary)
                        }
                        
                        if favorites.contains(resort) {
                            Spacer()
                            Image(systemName: "heart.fill")
                                .accessibilityLabel("This is a favorite resort")
                                .foregroundColor(.red)
                        }
                    }
                }
            }
            .navigationTitle("Resorts")
            .searchable(text: $searchText, prompt: "Search for a resort")
            .toolbar {
                Button {
                    isShowingSortDialog = true
                } label: {
                    Label("Sort", systemImage: "arrow.up.arrow.down")
                }
            }
            .confirmationDialog("Sort", isPresented: $isShowingSortDialog) {
                Button("Default") {
                    filterSort = .default
                }
                
                Button("Alphabetical") {
                    filterSort = .alphabetical
                }
                
                Button("Country") {
                    filterSort = .country
                }
            }
            
            WelcomeView()
        }
        .environmentObject(favorites)
        // Force default navigation stack on all phones, even 15 Pro Max in landscape (i.e. don't show WelcomeView)
//        .phoneOnlyNavigationView()
    }
    
    var sortedResorts: [Resort] {
        switch filterSort {
        case .default:
            return resorts
        case .alphabetical:
            return resorts.sorted { $0.name < $1.name }
        case .country:
            return resorts.sorted { $0.country < $1.country }
        }
    }
    
    var filteredResorts: [Resort] {
        if searchText.isEmpty {
            return sortedResorts
        } else {
            return sortedResorts.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
        }
    }
}

#Preview {
    ContentView()
}
