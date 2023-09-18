//
//  FilteredList.swift
//  CoreDataProject
//
//  Created by Tyler Milner on 9/17/23.
//

import CoreData
import SwiftUI

struct FilteredList<T: NSManagedObject, Content: View>: View {
    enum Predicate: String {
        case beginsWith = "BEGINSWITH"
    }
    
    @FetchRequest var fetchRequest: FetchedResults<T>
    let content: (T) -> Content
    
    var body: some View {
        List(fetchRequest, id: \.self) { item in
            self.content(item)
        }
    }
    
    // Use @ViewBuilder to allow multiple views to be provided as 'content'
    init(filterKey: String, predicate: Predicate, filterValue: String, @ViewBuilder content: @escaping (T) -> Content) {
        _fetchRequest = FetchRequest<T>(sortDescriptors: [], predicate: NSPredicate(format: "%K \(predicate) %@", filterKey, filterValue))
        self.content = content
    }
}

//struct FilteredList_Previews: PreviewProvider {
//    static var previews: some View {
//        FilteredList()
//    }
//}
