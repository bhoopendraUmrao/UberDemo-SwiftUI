//
//  TripView.swift
//  Uber-SwiftUI (iOS)
//
//  Created by Bhoopendra Umrao on 4/12/23.
//

import SwiftUI

struct TripView: View {
    @State var startLocation = ""
    @State var destinationLocation = ""
    @State var selectedRide: VeichelType = .uberX
    @EnvironmentObject private var viewModel: LocationSearchViewModel
    
    var body: some View {
        VStack {
            Capsule()
                .fill(Color.gray)
                .frame(width: 60, height: 10, alignment: .center)
                .padding(.top, 8)
            // Location
            HStack {
                VStack {
                    Circle()
                        .fill(Color(.systemGray3))
                        .frame(width: 6, height: 6)
                        
                    Rectangle()
                        .fill(Color(.systemGray4))
                        .frame(width: 1, height: 24)
                    Rectangle()
                        .fill(Color.theme.secondaryBackgroundColor)
                        .frame(width: 6, height: 6)
                }
                
                VStack(alignment: .leading) {
                    Text("Current Location")
                        .fontWeight(.medium)
                        .frame(height: 32)
                    
                    Text("Destination Location")
                        .fontWeight(.semibold)
                        .frame(height: 32)
                        
                }
                Spacer()
                VStack(alignment: .trailing) {
                    Text(getTime(from: Date()))
                        .fontWeight(.medium)
                        .frame(height: 32)
                    
                    Text(getTime(from: Date().addingTimeInterval(viewModel.route?.expectedTravelTime ?? 0)))
                        .fontWeight(.semibold)
                        .frame(height: 32)
                        
                }
            }
            .padding(.horizontal)
            
            Divider()
                .padding(.vertical, 8)
            
            // Suggested Rides
            VStack(alignment: .leading) {
                Text("Suggested Rides")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.gray)
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(VeichelType.allCases) { type in
                            VStack {
                                Image(type.image)
                                    .resizable()
                                    .padding(.top, 16)
                                    .frame(width: 80, height: 80)
                                Group {
                                    Text(type.title)
                                        .font(.system(size: 14, weight: .bold))
                                    Text("$44.25")
                                        .padding(.bottom,8)
                                        .font(.system(size: 14, weight: .bold))
                                }
                                .foregroundColor(selectedRide == type ? .white : Color.theme.primaryTextColor)
                            }
                            .padding()
                            .frame(width: 115, height: 130)
                            .scaleEffect(selectedRide == type ? 1.20 : 1.0)
                            .padding(.bottom, 8)
                            .background(selectedRide == type ? .blue : Color.theme.secondaryBackgroundColor)
                            .cornerRadius(10)
                            .onTapGesture {
                                withAnimation(.spring()) {
                                    selectedRide = type
                                }
                            }
                        }
                    }
                }
            }
            .padding(.horizontal)
            
            Divider()
                .padding(.vertical, 8)
            
            // Payment info
            HStack {
                Text("Visa")
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(.blue)
                    .foregroundColor(.white)
                    .cornerRadius(6)
                    .padding(.leading)
                Text("*** 12345")
                    .font(.system(size: 16, weight: .bold))
                Spacer()
                Image(systemName: "chevron.right")
                    .imageScale(.medium)
                    .padding()
            }
            .frame(height: 50)
            .background(Color.theme.secondaryBackgroundColor)
            .cornerRadius(10)
            .padding(.horizontal)
            
            Button {
                
            } label: {
                Text("CONFIRM RIDE")
                    .font(.system(size: 16, weight: .bold))
                    .frame(width: UIScreen.main.bounds.width - 32, height: 50)
                    .background(.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding(.vertical, 16)
        }
        .background(Color.theme.backgroundColor)
        .cornerRadius(16)
        .ignoresSafeArea()
    }
    
    private func getTime(from date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm a"
        let time = formatter.string(from: date)
        return time
    }
}

struct TripView_Previews: PreviewProvider {
    static var previews: some View {
        TripView()
            .environmentObject(LocationSearchViewModel())
    }
}
