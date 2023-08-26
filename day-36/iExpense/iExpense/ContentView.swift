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

struct ContentView: View {
    @StateObject var expenses = Expenses()
    @State private var showingAddExpense = false
    
    private let currencyFormat: FloatingPointFormatStyle<Double>.Currency = .currency(code: Locale.current.currency?.identifier ?? "USD")
    
    var body: some View {
        NavigationView {
            List {
                ForEach(expenses.items) { item in
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
                .onDelete(perform: removeItems)
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
    
    func removeItems(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
