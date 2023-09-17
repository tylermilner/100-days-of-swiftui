//
//  ContentView.swift
//  CoreDataProject
//
//  Created by Tyler Milner on 9/17/23.
//

import SwiftUI

// Ensuring Core Data objects are unique using constraints
struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    
    @FetchRequest(sortDescriptors: []) var wizards: FetchedResults<Wizard>
    
    var body: some View {
        VStack {
            List(wizards, id: \.self) { wizard in
                Text(wizard.name ?? "Unknown")
            }
            
            Button("Add") {
                let wizard = Wizard(context: moc)
                wizard.name = "Harry Potter"
            }
            
            Button("Save") {
                do {
                    try moc.save()
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
}

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
