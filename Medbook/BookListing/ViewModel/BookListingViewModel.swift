//
//  BookListingViewModel.swift
//  Medbook
//
//  Created by RAHUL RANA on 19/12/23.
//

import Combine
import SwiftUI

class ViewModel: ObservableObject {
    
    private var cancellables: Set<AnyCancellable> = []
    private let dataSource = ContentDataSource()
    
    @Published var docs: [Book]?
    @Published var searchString: String = "time"
    
    @Published var shouldScrollToTop: Bool = false
    
    @Published var sortOption: BookSortOptions = .title {
        didSet {
            sortDocs(with: sortOption)
        }
    }
    
   
    init() {
        $searchString
            .debounce(for: .seconds(0.5), scheduler: RunLoop.main)
            .removeDuplicates()
            .sink { [weak self] queryString in
                guard queryString.count > 0 else {
                    self?.docs = nil
                    return
                }
                
                guard queryString.count >= 3 else {
                    self?.docs = nil
                    return
                }
                self?.fetchData()
            }
            .store(in: &cancellables)
    }
    
    
    private func fetchData() {
        Task {
            
            let result = await dataSource.fetchDocs(forQuery: searchString, offset: (docs?.count ?? 0))
            
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    self.docs = (self.docs ?? []) + (response?.docs ?? [])
                }
            case .failure(let err):
                print(err)
            }
        }
    }
    
    private func sortDocs(with sortOption: BookSortOptions) {
        
        switch sortOption {
        case .title:
            self.docs = self.docs?.sorted(by: { ($0.title ?? "") < ($1.title ?? "")})
        case .average:
            self.docs = self.docs?.sorted(by: { ($0.ratingsAverage ?? 0) > ($1.ratingsAverage ?? 0)})
        case .hits:
            self.docs = self.docs?.sorted(by: { ($0.ratingsCount ?? 0) > ($1.ratingsCount ?? 0)})
        }
        
        self.shouldScrollToTop.toggle()
    }
    
    public func loadMore() {
        self.fetchData()
    }
    
}
