//
//  ContentView.swift
//  CoreDataProject
//
//  Created by Tyler Milner on 9/17/23.
//

import CoreData
import SwiftUI

//// One-to-many relationships with @FetchRequest and SwiftUI
//struct ContentView: View {
//    @Environment(\.managedObjectContext) var moc
//    @FetchRequest(sortDescriptors: []) var countries: FetchedResults<Country>
//
//    var body: some View {
//        VStack {
//            List {
//                ForEach(countries, id: \.self) { country in
//                    Section(country.wrappedFullName) {
//                        ForEach(country.candyArray, id: \.self) { candy in
//                            Text(candy.wrappedName)
//                        }
//                    }
//                }
//            }
//
//            Button("Add Examples") {
//                let candy1 = Candy(context: moc)
//                candy1.name = "Mars"
//                candy1.origin = Country(context: moc)
//                candy1.origin?.shortName = "UK"
//                candy1.origin?.fullName = "United Kingdom"
//
//                let candy2 = Candy(context: moc)
//                candy2.name = "KitKat"
//                candy2.origin = Country(context: moc)
//                candy2.origin?.shortName = "UK"
//                candy2.origin?.fullName = "United Kingdom"
//
//                let candy3 = Candy(context: moc)
//                candy3.name = "Twix"
//                candy3.origin = Country(context: moc)
//                candy3.origin?.shortName = "UK"
//                candy3.origin?.fullName = "United Kingdom"
//
//                let candy4 = Candy(context: moc)
//                candy4.name = "Toblerone"
//                candy4.origin = Country(context: moc)
//                candy4.origin?.shortName = "CH"
//                candy4.origin?.fullName = "Switzerland"
//
//                try? moc.save()
//            }
//        }
//    }
//}

// Dynamically filtering @FetchRequest with SwiftUI
struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @State private var lastNameFilter = "A"

    var body: some View {
        VStack {
            FilteredList(filterKey: "lastName", predicate: .beginsWith, filterValue: lastNameFilter) { (singer: Singer) in
                Text("\(singer.wrappedFirstName) \(singer.wrappedLastName)")
            }

            Button("Add Examples") {
                let taylor = Singer(context: moc)
                taylor.firstName = "Taylor"
                taylor.lastName = "Swift"

                let ed = Singer(context: moc)
                ed.firstName = "Ed"
                ed.lastName = "Sheeran"

                let adele = Singer(context: moc)
                adele.firstName = "Adele"
                adele.lastName = "Adkins"

                try? moc.save()
            }

            Button("Show A") {
                lastNameFilter = "A"
            }

            Button("Show S") {
                lastNameFilter = "S"
            }
        }
    }
}

//// Filtering @FetchRequest using NSPredicate
//struct ContentView: View {
//    @Environment(\.managedObjectContext) var moc
//    @FetchRequest(sortDescriptors: [], predicate: NSPredicate(format: "NOT name BEGINSWITH[c] %@", "e")) var ships: FetchedResults<Ship>
//
//    var body: some View {
//        VStack {
//            List(ships, id: \.self) { ship in
//                Text(ship.name ?? "Unknown name")
//            }
//
//            Button("Add Examples") {
//                let ship1 = Ship(context: moc)
//                ship1.name = "Enterprise"
//                ship1.universe = "Star Trek"
//
//                let ship2 = Ship(context: moc)
//                ship2.name = "Defiant"
//                ship2.universe = "Star Trek"
//
//                let ship3 = Ship(context: moc)
//                ship3.name = "Millennium Falcon"
//                ship3.universe = "Star Wars"
//
//                let ship4 = Ship(context: moc)
//                ship4.name = "Executor"
//                ship4.universe = "Star Wars"
//
//                try? moc.save()
//            }
//        }
//    }
//}

//// Ensuring Core Data objects are unique using constraints
//struct ContentView: View {
//    @Environment(\.managedObjectContext) var moc
//
//    @FetchRequest(sortDescriptors: []) var wizards: FetchedResults<Wizard>
//
//    var body: some View {
//        VStack {
//            List(wizards, id: \.self) { wizard in
//                Text(wizard.name ?? "Unknown")
//            }
//
//            Button("Add") {
//                let wizard = Wizard(context: moc)
//                wizard.name = "Harry Potter"
//            }
//
//            Button("Save") {
//                do {
//                    try moc.save()
//                } catch {
//                    print(error.localizedDescription)
//                }
//            }
//        }
//    }
//}

//// Conditional saving of NSManagedObjectContext
//struct ContentView: View {
//    @Environment(\.managedObjectContext) var moc
//
//    var body: some View {
//        Button("Save") {
//            if moc.hasChanges {
//                try? moc.save()
//            }
//        }
//    }
//}

//// Creating NSManagedObject subclasses
//// See Movie+CoreDataClass.swift and Movie+CoreDataProperties.swift
//struct ContentView: View {
//    var body: some View {
//        Text("")
//    }
//}

//// Why does \.self work for ForEach?
//struct Student: Hashable {
//    let name: String
//}
//
//struct ContentView: View {
//    let students = [Student(name: "Harry Potter"), Student(name: "Hermione Granger")]
//
//    var body: some View {
//        List {
//            ForEach(students, id: \.self) { student in
//                Text(student.name)
//            }
//        }
//    }
//}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
