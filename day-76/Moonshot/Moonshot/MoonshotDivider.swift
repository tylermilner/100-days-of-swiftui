//
//  MoonshotDivider.swift
//  Moonshot
//
//  Created by Tyler Milner on 8/27/23.
//

import SwiftUI

struct MoonshotDivider: View {
    var body: some View {
        Rectangle()
            .frame(height: 2)
            .foregroundColor(.lightBackground)
            .padding(.vertical)
    }
}

struct MoonshotDivider_Previews: PreviewProvider {
    static var previews: some View {
        MoonshotDivider()
    }
}
