//
//  LocationSearchActivationView.swift
//  Uber-SwiftUI (iOS)
//
//  Created by Bhoopendra Umrao on 4/12/23.
//

import SwiftUI

struct LocationSearchActivationView: View {
    @Binding var mapState: MapState
    var body: some View {
        HStack {
            Rectangle()
                .fill(Color.black)
                .frame(width: 8, height: 8)
                .padding(.horizontal)
            Text("Where To ?")
                .foregroundColor(Color(.darkGray))
            Spacer()
        }
        .frame(width: UIScreen.main.bounds.width - 64, height: 50)
        .background(
            Rectangle()
                .fill(Color.white)
                .shadow(color: .black, radius: 6)
        )
        .onTapGesture {
            withAnimation(.spring()) {
                mapState = .locationSearch
            }
        }
    }
}

