//
//  FetchBBCharacters.swift
//  Breaking Bad
//
//  Created by Louis Vedel on 13/10/2022.
//

import Foundation

class BBCharactersListViewModel: ObservableObject {
    @Published var loading = false
    @Published var search = ""
    @Published var characters = [BBCharacter]()

    init() {
        load()
    }

    public func load() {
        guard !loading,
              characters.isEmpty else {
            return
        }
        loading.toggle()
        search = ""
        BBAPI.main.getCharacters { characters in
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.3) {
                if let characters = characters {
                    self.characters = characters
                }
                self.loading.toggle()
            }
        }
    }

    func filteredCharacters() -> [BBCharacter] {
        if search.isEmpty {
            return characters
        }
        return characters.filter {
            $0.name.lowercased().range(
                of: search.trimmingCharacters(in: .whitespacesAndNewlines).lowercased(),
                options: .caseInsensitive
            ) != nil ||
            $0.nickname.lowercased().range(
                of: search.trimmingCharacters(in: .whitespacesAndNewlines).lowercased(),
                options: .caseInsensitive
            ) != nil
        }
    }
}
