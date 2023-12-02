//
//  AddressView.swift
//  CupcakeCorner
//
//  Created by Tyler Milner on 9/14/23.
//

import SwiftUI

struct AddressView: View {
    @ObservedObject var orderData: OrderData
    
    var body: some View {
        Form {
            Section {
                TextField("Name", text: $orderData.order.name)
                TextField("Street address", text: $orderData.order.streetAddress)
                TextField("City", text: $orderData.order.city)
                TextField("Zip", text: $orderData.order.zip)
            }
            
            Section {
                NavigationLink {
                    CheckoutView(orderData: orderData)
                } label: {
                    Text("Check out")
                }
            }
            .disabled(orderData.order.hasValidAddress == false)
        }
        .navigationTitle("Delivery details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct AddressView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            AddressView(orderData: OrderData())
        }
    }
}
