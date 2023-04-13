//
//  LocationSearchView.swift
//  Uber-SwiftUI (iOS)
//
//  Created by Bhoopendra Umrao on 4/12/23.
//

import SwiftUI

struct LocationSearchView: View {
    
    @State private var startLocation: String = ""
    
    @EnvironmentObject private var viewModel: LocationSearchViewModel
    
    @Binding var mapState: MapState
    
    var body: some View {
        VStack {
            HStack {
                VStack {
                    Circle()
                        .fill(Color(.systemGray3))
                        .frame(width: 6, height: 6)
                        
                    Rectangle()
                        .fill(Color(.systemGray4))
                        .frame(width: 1, height: 24)
                    Rectangle()
                        .fill(Color.theme.primaryTextColor)
                        .frame(width: 6, height: 6)
                }
                VStack {
                    TextField("Current Location", text: $startLocation)
                        .frame(height: 32)
                        .textFieldStyle(.roundedBorder)
                    
                    TextField("Destination Location", text: $viewModel.queryFragment)
                        .frame(height: 32)
                        .textFieldStyle(.roundedBorder)
                }
            }
            .padding(.horizontal)
            .padding(.top)
            
            Divider()
            
            List {
                ForEach(viewModel.result, id: \.self) { item in
                    LocationSearchResultView(resultItem: item)
                        .onTapGesture {
                            withAnimation(.spring()) {
                                viewModel.setSelected(item)
                                mapState = .locationSelected
                            }
                        }
                }
            }
            .listStyle(.plain)
        }
        .background(Color.theme.backgroundColor)
    }
}

struct LocationSearchView_Previews: PreviewProvider {
    static var previews: some View {
        LocationSearchView(mapState: .constant(.noInput))
            .environmentObject(LocationSearchViewModel())
    }
}
