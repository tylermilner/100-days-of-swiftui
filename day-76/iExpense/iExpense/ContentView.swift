//
//  ContentView.swift
//  iExpense
//
//  Created by Tyler Milner on 8/26/23.
//

import SwiftUI

struct ExpenseAmount: ViewModifier {
    let amount: Double
    
    func body(content: Content) -> some View {
        var foregroundColor: Color
        var font: Font
        
        switch amount {
        case ..<10:
            foregroundColor = .green
            font = .title3
        case 10..<100:
            foregroundColor = .yellow
            font = .title2
        default:
            foregroundColor = .red
            font = .title
        }
        
        return content
            .foregroundColor(foregroundColor)
            .font(font)
    }
}

struct ExpenseView: View {
    let item: ExpenseItem
    let currencyFormat: FloatingPointFormatStyle<Double>.Currency
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(item.name)
                    .font(.headline)
                Text(item.type)
            }
            
            Spacer()
            
            Text(item.amount, format: currencyFormat)
                .modifier(ExpenseAmount(amount: item.amount))
        }
    }
}

struct ContentView: View {
    @StateObject var expenses = Expenses()
    @State private var showingAddExpense = false
    
    private let currencyFormat: FloatingPointFormatStyle<Double>.Currency = .currency(code: Locale.current.currency?.identifier ?? "USD")
    
    var body: some View {
        NavigationView {
            List {
                Section("Personal") {
                    ForEach(expenses.personalExpenses) { item in
                        ExpenseView(item: item, currencyFormat: currencyFormat)
                    }
                    .onDelete(perform: removePersonalItems)
                }
                
                Section("Business") {
                    ForEach(expenses.businessExpenses) { item in
                        ExpenseView(item: item, currencyFormat: currencyFormat)
                    }
                    .onDelete(perform: removeBusinessItems)
                }
            }
            .navigationTitle("iExpense")
            .toolbar {
                Button {
                    showingAddExpense = true
                } label: {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $showingAddExpense) {
                AddView(expenses: expenses, currencyFormat: currencyFormat)
            }
        }
    }
    
    private func removePersonalItems(at offsets: IndexSet) {
        removeItems(at: offsets, in: expenses.personalExpenses)
    }
    
    private func removeBusinessItems(at offsets: IndexSet) {
        removeItems(at: offsets, in: expenses.businessExpenses)
    }
    
    private func removeItems(at offsets: IndexSet, in expensesSubset: [ExpenseItem]) {
        let transformedOffsets = transformedOffsets(from: offsets, in: expensesSubset)
        expenses.items.remove(atOffsets: transformedOffsets)
    }
    
    private func transformedOffsets(from offsets: IndexSet, in expensesSubset: [ExpenseItem]) -> IndexSet {
        // Transform the offsets to their appropriate positions in the main `items` array
        var transformedOffsets = IndexSet()
        
        offsets.forEach { index in
            let itemToRemove = expensesSubset[index]
            if let itemIndexInExpenses = expenses.items.firstIndex(where: { $0.id == itemToRemove.id }) {
                transformedOffsets.insert(itemIndexInExpenses)
            } else {
                fatalError("Unable to find \(itemToRemove) in main expenses array")
            }
        }
        
        return transformedOffsets
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
