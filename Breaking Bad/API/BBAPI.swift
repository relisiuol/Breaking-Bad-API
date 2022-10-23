//
//  BBAPI.swift
//  Breaking Bad
//
//  Created by Louis Vedel on 22/10/2022.
//

import Foundation

class BBAPI {
    public static var main = BBAPI()

    private static let url = "https://www.breakingbadapi.com/api/"

    private static let urlSession: URLSession = {
        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.allowsCellularAccess          = true
        sessionConfig.timeoutIntervalForRequest     = 10
        sessionConfig.timeoutIntervalForResource    = 10
        sessionConfig.httpMaximumConnectionsPerHost = 10
        sessionConfig.requestCachePolicy = NSURLRequest.CachePolicy.reloadIgnoringLocalCacheData
        return URLSession(configuration: sessionConfig)
    }()

    public func getCharacters(_ completed: @escaping ([BBCharacter]?) -> Void) {
        let url = URL(string: BBAPI.url + "characters")!
        BBAPI.urlSession.dataTask(with: url) {(data, response, error) in
            DispatchQueue.main.async {
                do {
                    if let charactersData = data {
                        let decodedData = try JSONDecoder().decode([BBCharacter].self, from: charactersData)
                        completed(decodedData)
                    } else {
                        completed(nil)
                    }
                } catch {
                    completed(nil)
                }
            }
        }.resume()
    }

    public func getDeathForCharacter(_ character: BBCharacter, completed: @escaping (BBCharacterDeath?, Bool) -> Void) {
        self.getDeathForName(
            // Fix for Tomás Cantillo that can be found only using a string without accent
            character.name.folding(options: .diacriticInsensitive, locale: .current)
        ) { characterDeath, error in
            if !error,
               let characterDeath = characterDeath {
                DispatchQueue.main.async {
                    completed(characterDeath, error)
                }
            } else {
                // Fix for some characters that can be found only using nickname
                self.getDeathForName(character.nickname) { characterDeath, error in
                    DispatchQueue.main.async {
                        completed(characterDeath, error)
                    }
                }
            }
        }
    }

    private func getDeathForName(_ name: String, completed: @escaping (BBCharacterDeath?, Bool) -> Void) {
        var url = URLComponents(string: BBAPI.url + "death")!
        url.queryItems = [URLQueryItem(name: "name", value: name)]
        BBAPI.urlSession.dataTask(
            with: url.url!
        ) {(data, response, error) in
            DispatchQueue.main.async {
                do {
                    if let deathsData = data {
                        let decodedData = try JSONDecoder().decode([BBCharacterDeath].self, from: deathsData)
                        if decodedData.count > 0,
                           let character = decodedData.first(where: { $0.death == name }) {
                            completed(character, false)
                        } else {
                            completed(nil, false)
                        }
                    } else {
                        completed(nil, true)
                    }
                } catch {
                    completed(nil, true)
                }
            }
        }.resume()
    }
}
