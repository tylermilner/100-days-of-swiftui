//
//  AddActivityView.swift
//  HabitTracker
//
//  Created by Tyler Milner on 9/10/23.
//

import SwiftUI

struct AddActivityView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var activities: Activities
    @State private var title = ""
    @State private var description = ""
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Title", text: $title)
                
                TextField("Description", text: $description)
            }
            .navigationTitle("Add Activity")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .automatic) {
                    Button("Save") {
                        saveActivity()
                        dismiss()
                    }
                }
            }
        }
    }
}

private extension AddActivityView {
    func saveActivity() {
        let activity = Activity(title: title, description: description)
        activities.activities.append(activity)
    }
}

struct AddActivityView_Previews: PreviewProvider {
    static var previews: some View {
        let activities = Activities()
        return AddActivityView(activities: activities)
    }
}
