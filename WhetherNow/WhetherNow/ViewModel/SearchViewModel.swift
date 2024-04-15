//
//  SearchViewModel.swift
//  WhetherNow
//
//  Created by runku shanth kumar on 11/04/24.
//

import Foundation
import Combine
import CoreLocation

final class ContentViewModel: ObservableObject {
    private var cancellable: AnyCancellable?

    @Published var cityText = "" {
        didSet {
            searchForCity(text: cityText)
        }
    }

    @Published var viewData = [LocalSearchViewData]()

    var service: LocalSearchService
    
    init() {
//        New York
        let center = CLLocationCoordinate2D(latitude: 40.730610, longitude: -73.935242)
        service = LocalSearchService(in: center)
        
        cancellable = service.localSearchPublisher.sink { mapItems in
            self.viewData = mapItems.map({ LocalSearchViewData(mapItem: $0) })
        }
    }
    
    private func searchForCity(text: String) {
        service.searchCities(searchText: text)
    }
}
