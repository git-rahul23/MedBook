//
//  AppDataSource.swift
//  Medbook
//
//  Created by RAHUL RANA on 19/12/23.
//

import Foundation

struct ContentDataSource {
    
    // can make it more generic by configuring end points and base Urls
    // keeping it this way for now
    
    func fetchDocs(forQuery query:String, offset: Int) async -> Result<BookListingModel?, Error> {
        
        let urlRequest = URLRequest(url: URL(string: "https://openlibrary.org/search.json?title=\(query)&limit=10&offset=\(offset)")!)
        
        do {
            let data = try await self.performOperation(request: urlRequest, response: BookListingModel.self)
            return .success(data)
        } catch {
            return .failure(error)
        }
    }
    
    func fetchBookDetil(key: String) async -> Result<BookDetailModel?, Error> {
        
        let urlRequest = URLRequest(url: URL(string: "https://openlibrary.org\(key).json")!)
        
        do {
            let data = try await self.performOperation(request: urlRequest, response: BookDetailModel.self)
            return .success(data)
        } catch {
            return .failure(error)
        }
    }
    
    func fetchCountries() async -> Result<CountriesModel?, Error> {
        
        let urlRequest = URLRequest(url: URL(string: "https://api.first.org/data/v1/countries")!)
        
        do {
            let data = try await self.performOperation(request: urlRequest, response: CountriesModel.self)
            return .success(data)
        } catch {
            return .failure(error)
        }
    }
    
    func fetchCountry() async -> Result<IPCountryModel?, Error> {
        
        let urlRequest = URLRequest(url: URL(string: "http://ip-api.com/json")!)
        
        do {
            let data = try await self.performOperation(request: urlRequest, response: IPCountryModel.self)
            return .success(data)
        } catch {
            return .failure(error)
        }
    }
    
    private func performOperation<T: Decodable>(request: URLRequest, response: T.Type) async throws -> T {
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
           
            let decodedDdata = try JSONDecoder().decode(response.self, from: data)
            
            return decodedDdata
                
        } catch(let err) {
            throw err
        }
    }
}
