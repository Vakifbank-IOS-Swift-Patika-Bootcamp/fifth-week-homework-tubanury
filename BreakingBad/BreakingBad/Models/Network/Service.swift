//
//  Service.swift
//  BreakingBad
//
//  Created by Tuba N. Yıldız on 24.11.2022.
//

import Foundation

class Service {
    
    public static let shared = Service()
    
    enum Endpoints {
        static let base = "https://www.breakingbadapi.com/api/"
        
        case characters
        case episodes
        case quotes (name: String)
        var stringValue: String {
            switch self {
            case .characters:
                return Endpoints.base + "characters"
            case .episodes:
                return Endpoints.base + "episodes?series=Breaking+Bad"
            case .quotes(name: let name) :
                return Endpoints.base + "quote?author=" + name.replacingOccurrences(of: " ", with: "+")
            }
            
        }
        
        var url: URL {
            return URL(string: stringValue)!
        }
    }
    
    @discardableResult
    class func taskForGETRequest<ResponseType: Decodable>(url: URL, responsetType: ResponseType.Type, completion: @escaping (ResponseType?, Error?) -> Void) -> URLSessionDataTask {
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                    completion(nil, error)
                }
                return
            }
            let decoder = JSONDecoder()
            do {
                let responseObject = try decoder.decode(ResponseType.self, from: data)
                DispatchQueue.main.async {
                    completion(responseObject, nil)
                }
            } catch {
                do {
                    let errorResponse = try decoder.decode(BaseResponse.self, from: data) as Error
                    DispatchQueue.main.async {
                        completion(nil, errorResponse)
                    }
                } catch {
                    DispatchQueue.main.async {
                        completion(nil, error)
                    }
                }
            }
        }
        task.resume()
        return task
    }
    
    class func getAllCharacters(completion: @escaping (CharactersResponse?, Error?) -> Void) {
        taskForGETRequest(url: Endpoints.characters.url, responsetType: CharactersResponse.self) { response, error in
            if let response = response {
                completion(response, nil)
            } else {
                completion(nil, error)
            }
        }
    }
    
    class func getAllEpisodes(completion: @escaping (EpisodesResponse?, Error?) -> Void) {
        taskForGETRequest(url: Endpoints.episodes.url, responsetType: EpisodesResponse.self) { response, error in
            if let response = response {
                completion(response, nil)
            } else {
                completion(nil, error)
            }
        }
    }
    
    class func getAllQuotesByCharacter(name: String, completion: @escaping (QuotesResponse?, Error?) -> Void) {
        taskForGETRequest(url: Endpoints.quotes(name: name).url, responsetType: QuotesResponse.self) { response, error in
            if let response = response {
                completion(response, nil)
            } else {
                completion(nil, error)
            }
        }
    }
    
    
    
    
}
