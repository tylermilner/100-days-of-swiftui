//
//  Expenses.swift
//  iExpense
//
//  Created by Tyler Milner on 8/26/23.
//

import Foundation

class Expenses: ObservableObject {
    @Published var items = [ExpenseItem]()
}
