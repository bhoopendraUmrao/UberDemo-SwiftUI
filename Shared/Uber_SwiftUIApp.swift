//
//  Uber_SwiftUIApp.swift
//  Shared
//
//  Created by Bhoopendra Umrao on 4/12/23.
//

import SwiftUI

@main
struct Uber_SwiftUIApp: App {
    @StateObject var locationViewModel = LocationSearchViewModel()
    var body: some Scene {
        WindowGroup {
            UberHomeView()
                .environmentObject(locationViewModel)
        }
    }
}
