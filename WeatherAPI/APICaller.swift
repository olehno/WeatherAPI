//
//  APICaller.swift
//  WeatherAPI
//
//  Created by Артур Олехно on 11/11/2023.
//

import Foundation

struct Constatns {
    static let url = "https://weatherapi-com.p.rapidapi.com/current.json?"
    static let apiKey = "3023fad04bmsh1d311b6e4045f72p15ea3djsneee7dd81652c"
    static let hostKey = "weatherapi-com.p.rapidapi.com"
}

class APICaller {
    
    static let shared = APICaller()
    
    func getCircuits(query: String, completion: @escaping (Result<Weather, Error>) -> Void) {
        guard let url = URL(string: "\(Constatns.url)q=\(query)") else { return }
        var request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.addValue(Constatns.apiKey, forHTTPHeaderField: "X-RapidAPI-Key")
        request.addValue(Constatns.hostKey, forHTTPHeaderField: "X-RapidAPI-Host")
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data, error == nil else { return }
            do {
                let results = try JSONDecoder().decode(Weather.self, from: data)
                completion(.success(results))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
}
