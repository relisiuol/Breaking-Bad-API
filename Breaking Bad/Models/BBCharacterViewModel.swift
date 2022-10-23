//
//  BBCharacterViewModel.swift
//  Breaking Bad
//
//  Created by Louis Vedel on 22/10/2022.
//

import Foundation

class BBCharacterViewModel: ObservableObject {
    @Published var character: BBCharacter
    @Published var loading = false
    @Published var error = false
    @Published var death: BBCharacterDeath? = nil

    init(_ character: BBCharacter) {
        self.character = character
    }
    
    public func isPossiblyDead() -> Bool {
        return character.name.range(of: "&") == nil && // Fix for Marco & Leonel
               ["Deceased", "Presumed dead"].contains { $0 == character.status }
    }

    public func load() {
        guard !loading,
              death == nil,
              isPossiblyDead() else {
            return
        }
        loading.toggle()
        BBAPI.main.getDeathForCharacter(character) { death, error in
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.3) {
                self.error = error
                if let death = death {
                    self.death = death
                }
                self.loading.toggle()
            }
        }
    }
}
