//
//  CheckoutView.swift
//  CupcakeCorner
//
//  Created by Tyler Milner on 9/14/23.
//

import SwiftUI

struct CheckoutView: View {
    @ObservedObject var orderData: OrderData
    
    @State private var confirmationMessage = ""
    @State private var showingConfirmation = false
    
    @State private var errorAlertMessage = ""
    @State private var showingErrorAlert = false
    
    var body: some View {
        ScrollView {
            VStack {
                AsyncImage(url: URL(string: "https://hws.dev/img/cupcakes@3x.jpg"), scale: 3) { image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    ProgressView()
                }
                .frame(height: 233) // Reserve known image height ahead of time to keep height from jumping around
                
                Text("Your total is \(orderData.order.cost, format: .currency(code: "USD"))")
                    .font(.title)
                
                Button("Place Order") {
                    Task {
                        await placeOrder()
                    }
                }
                .padding()
            }
        }
        .navigationTitle("Checkout")
        .navigationBarTitleDisplayMode(.inline)
        .alert("Thank you!", isPresented: $showingConfirmation) {
            Button("OK") { }
        } message: {
            Text(confirmationMessage)
        }
        .alert("Error!", isPresented: $showingErrorAlert) {
            Button("OK") { }
        } message: {
            Text(errorAlertMessage)
        }
    }
    
    func placeOrder() async {
        guard let encoded = try? JSONEncoder().encode(orderData.order) else {
            print("Failed to encode order")
            return
        }
        
        let url = URL(string: "https://reqres.in/api/cupcakes")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        
        do {
            let (data, _) = try await URLSession.shared.upload(for: request, from: encoded)
            
            let decodedOrder = try JSONDecoder().decode(Order.self, from: data)
            confirmationMessage = "Your order for \(decodedOrder.quantity)x \(Order.types[decodedOrder.type].lowercased()) cupcakes is on its way!"
            showingConfirmation = true
        } catch {
            print("Checkout failed.")
            
            errorAlertMessage = error.localizedDescription
            showingErrorAlert = true
        }
    }
}

struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutView(orderData: OrderData())
    }
}
