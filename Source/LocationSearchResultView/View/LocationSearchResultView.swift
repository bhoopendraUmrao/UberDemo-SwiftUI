//
//  LocationSearchResultView.swift
//  Uber-SwiftUI (iOS)
//
//  Created by Bhoopendra Umrao on 4/12/23.
//

import SwiftUI
import MapKit

struct LocationSearchResultView: View {
    let resultItem: MKLocalSearchCompletion
    var body: some View {
        HStack {
            Image(systemName: "mappin.circle.fill")
                .resizable()
                .foregroundColor(.blue)
                .tint(.white)
                .frame(width: 40, height: 40)
            VStack(alignment: .leading) {
                Text(resultItem.title)
                    .font(.body)
                    .foregroundColor(Color.theme.primaryTextColor)
                    .padding(.top, 8)
                Text(resultItem.subtitle)
                    .font(.system(size: 15))
                    .foregroundColor(.gray)
            }
        }
    }
}

