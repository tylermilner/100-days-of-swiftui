//
//  ContentView.swift
//  HabitTracker
//
//  Created by Tyler Milner on 9/10/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var activities = Activities()
    @State private var showingAddActivity = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(activities.activities) { activity in
                    NavigationLink {
                        ActivityDetailView(activities: activities, activity: activity)
                    } label: {
                        Text(activity.title)
                    }
                }
            }
            .navigationTitle("Habit Tracker")
            .toolbar {
                Button {
                    showingAddActivity = true
                } label: {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $showingAddActivity) {
                AddActivityView(activities: activities)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let activity = Activity(title: "Learning SwiftUI", description: "Completing the 100 Days of SwiftUI course.")
        let activities = Activities()
        activities.activities = [activity]
        
        return ContentView(activities: activities)
    }
}
