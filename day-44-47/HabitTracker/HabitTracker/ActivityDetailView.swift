//
//  ActivityDetailView.swift
//  HabitTracker
//
//  Created by Tyler Milner on 9/10/23.
//

import SwiftUI

struct ActivityDetailView: View {
    @ObservedObject var activities: Activities
    let activity: Activity
    
    var body: some View {
        NavigationView {
            Form {
                Section("Description") {
                    Text(activity.description)
                }
                
                Section("Stats") {
                    HStack {
                        Text("Completed \(activity.completionCount) times")
                        
                        Spacer()
                        
                        Button {
                            completeActivity()
                        } label: {
                            Image(systemName: "plus")
                        }

                    }
                }
            }
            .navigationTitle(activity.title)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

private extension ActivityDetailView {
    func completeActivity() {
        guard let activityIndex = activities.activities.firstIndex(of: activity) else { return }
        
        var activity = activity
        activity.completionCount += 1
        activities.activities[activityIndex] = activity
    }
}

struct ActivityDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let activities = Activities()
        let activity = Activity(title: "Learning SwiftUI", description: "Completing the 100 Days of SwiftUI course.")
        activities.activities.append(activity)
        return ActivityDetailView(activities: activities, activity: activity)
    }
}
