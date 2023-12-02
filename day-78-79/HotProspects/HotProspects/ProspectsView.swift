//
//  ProspectsView.swift
//  HotProspects
//
//  Created by Tyler Milner on 11/8/23.
//

import CodeScanner
import SwiftUI
import UserNotifications

struct ProspectsView: View {
    enum FilterType {
        case none, contacted, uncontacted
    }
    
    enum FilterSort {
        case name, mostRecent
    }
    
    @EnvironmentObject var prospects: Prospects
    @State private var isShowingScanner = false
    
    @State private var filterSort: FilterSort = .name
    @State private var isShowingSortDialog = false
    
    let filter: FilterType
    
    var body: some View {
        NavigationView {
            List {
                ForEach(sortedProspects) { prospect in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(prospect.name)
                                .font(.headline)
                            Text(prospect.emailAddress)
                                .foregroundColor(.secondary)
                        }
                        
                        Spacer()
                        
                        if filter == .none {
                            let contacted = prospect.isContacted
                            Image(systemName: contacted ? "person.fill.checkmark" : "person.fill.xmark")
                                .foregroundColor(contacted ? .green : .blue)
                        }
                    }
                    .swipeActions {
                        if prospect.isContacted {
                            Button {
                                prospects.toggle(prospect)
                            } label: {
                                Label("Mark Uncontacted", systemImage: "person.crop.circle.badge.xmark")
                            }
                            .tint(.blue)
                        } else {
                            Button {
                                prospects.toggle(prospect)
                            } label: {
                                Label("Mark Contacted", systemImage: "person.crop.circle.fill.badge.checkmark")
                            }
                            .tint(.green)
                            
                            Button {
                                addNotification(for: prospect)
                            } label: {
                                Label("Remind Me", systemImage: "bell")
                            }
                            .tint(.orange)
                        }
                    }
                }
            }
            .navigationTitle(title)
            .toolbar {
                Button {
                    isShowingScanner = true
                } label: {
                    Label("Scan", systemImage: "qrcode.viewfinder")
                }
                
                Button {
                    isShowingSortDialog = true
                } label: {
                    Label("Sort", systemImage: "arrow.up.arrow.down")
                }
            }
            .sheet(isPresented: $isShowingScanner) {
                // Add simulated data at random
                let simulatedScans = [
                    "John Doe\njohndoe@example.com",
                    "Jane Doe\njanedoe@example.com",
                    "Paul Hudson\npaul@hackingwithswift.com"
                ]
                let simulatedData = simulatedScans.randomElement()!
                
                CodeScannerView(codeTypes: [.qr], simulatedData: simulatedData, completion: handleScan)
            }
            .confirmationDialog("Sort", isPresented: $isShowingSortDialog) {
                Button("Name") {
                    filterSort = .name
                }
                
                Button("Most Recent") {
                    filterSort = .mostRecent
                }
            }
        }
    }
    
    var title: String {
        switch filter {
        case .none:
            return "Everyone"
        case .contacted:
            return "Contacted people"
        case .uncontacted:
            return "Uncontacted people"
        }
    }
    
    var filteredProspects: [Prospect] {
        switch filter {
        case .none:
            return prospects.people
        case .contacted:
            return prospects.people.filter { $0.isContacted }
        case .uncontacted:
            return prospects.people.filter { !$0.isContacted }
        }
    }
    
    var sortedProspects: [Prospect] {
        switch filterSort {
        case .name:
            return filteredProspects.sorted { $0.name < $1.name }
        case .mostRecent:
            return filteredProspects.sorted { $0.dateAdded < $1.dateAdded }
        }
    }
    
    func handleScan(result: Result<ScanResult, ScanError>) {
        isShowingScanner = false
        
        switch result {
        case .success(let result):
            let details = result.string.components(separatedBy: "\n")
            guard details.count == 2 else { return }
            
            let person = Prospect()
            person.name = details[0]
            person.emailAddress = details[1]
            prospects.add(person)
        case .failure(let error):
            print("Scanning failed: \(error.localizedDescription)")
        }
    }
    
    func addNotification(for prospect: Prospect) {
        let center = UNUserNotificationCenter.current()
        
        let addRequest = {
            let content = UNMutableNotificationContent()
            content.title = "Contact \(prospect.name)"
            content.subtitle = prospect.emailAddress
            content.sound = UNNotificationSound.default
            
            var dateComponents = DateComponents()
            dateComponents.hour = 9
//            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
            // For testing...schedule the notification in 5 seconds instead of at a specific time
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
            
            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
            center.add(request)
        }
        
        center.getNotificationSettings { settings in
            if settings.authorizationStatus == .authorized {
                addRequest()
            } else {
                center.requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                    if success {
                        addRequest()
                    } else {
                        print("D'oh!")
                    }
                }
            }
        }
    }
}

#Preview {
    ProspectsView(filter: .none)
        .environmentObject(Prospects())
}
