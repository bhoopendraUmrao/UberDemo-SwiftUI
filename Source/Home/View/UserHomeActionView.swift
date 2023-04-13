//
//  UserHomeActionView.swift
//  Uber-SwiftUI (iOS)
//
//  Created by Bhoopendra Umrao on 4/12/23.
//

import SwiftUI

struct UserHomeActionView: View {
    @Binding var mapState: MapState
    @EnvironmentObject var viewModel: LocationSearchViewModel
    var body: some View {
        Button {
            withAnimation(.spring()) {
                actionForState()
            }
        } label: {
            Image(systemName: imageForAction())
                .foregroundColor(.black)
                .padding()
                .background(.white)
                .clipShape(Circle())
                .shadow(color: .black, radius: 6)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private func actionForState() {
        switch mapState {
        case .noInput:
            print("No Action")
        case .locationSelected, .locationSearch:
            mapState = .noInput
            viewModel.selectedLocation = nil
            viewModel.route = nil
        }
    }
    
    private func imageForAction() -> String {
        switch mapState {
        case .noInput:
            return "line.3.horizontal"
        case .locationSelected,.locationSearch:
            return "arrow.left"
        }
    }
}

