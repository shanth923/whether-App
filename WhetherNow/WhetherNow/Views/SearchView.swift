//
//  SearchView.swift
//  WhetherNow
//
//  Created by runku shanth kumar on 11/04/24.
//

import Foundation
import SwiftUI


struct SearchView: View {
    
    @StateObject private var viewModel = ContentViewModel()
    @ObservedObject var whetherViewModel: WheaterViewModel
    
    @Binding var searchCity: Bool
    
    public init(whetherViewModel: WheaterViewModel, searchCity: Binding<Bool>) {
        self.whetherViewModel = whetherViewModel
        self._searchCity = searchCity
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            TextField("Enter City", text: $viewModel.cityText)
            Divider()
            
            Text("Results")
                .font(.title)
            List(viewModel.viewData) { item in
                VStack(alignment: .leading) {
                    Text(item.title)
                    Text(item.subtitle)
                        .foregroundColor(.secondary)
                }
                .onTapGesture {
                    searchCity = false
                    Task {
                      let _  =   try await whetherViewModel.getCurrentWeather(latitude: item.lattitude, longitude: item.longitude)
                        let _  =   try await whetherViewModel.getNextThreeDaysWhether(zip: item.postalCode, countryCode: item.countryCode)
                    }
                }
            }
        }
        .padding(.horizontal)
        .padding(.top)
        .ignoresSafeArea(edges: .bottom)
    }
}

#Preview {
    SearchView(whetherViewModel: WheaterViewModel(), searchCity: .constant(false))
}
