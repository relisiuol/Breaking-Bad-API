//
//  FetchBBCharacter.swift
//  Breaking Bad
//
//  Created by Louis Vedel on 13/10/2022.
//

import Foundation

class FetchBBCharacter: ObservableObject {
    @Published var characters = [BBCharacter]()
    init() {
        let url = URL(string: "https://www.breakingbadapi.com/api/characters")!
        URLSession.shared.dataTask(with: url) {(data, response, error) in
            do {
                if let charactersData = data {
                    // 3.
                    let decodedData = try JSONDecoder().decode([BBCharacter].self, from: charactersData)
                    DispatchQueue.main.async {
                        self.characters = decodedData
                    }
                } else {
                    print("Pas de données ?")
                }
            } catch {
                print("Erreur ?")
            }
        }.resume()
    }
}
