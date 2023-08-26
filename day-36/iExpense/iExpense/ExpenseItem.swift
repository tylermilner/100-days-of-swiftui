//
//  ExpenseItem.swift
//  iExpense
//
//  Created by Tyler Milner on 8/26/23.
//

import Foundation

struct ExpenseItem: Identifiable {
    let id = UUID()
    let name: String
    let type: String
    let amount: Double
}
