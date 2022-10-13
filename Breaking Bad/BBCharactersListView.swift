//
//  ContentView.swift
//  Breaking Bad
//
//  Created by Louis Vedel on 13/10/2022.
//

import SDWebImageSwiftUI
import SwiftUI

struct BBCharactersListView: View {
    @ObservedObject var fetch = FetchBBCharacter()

    var body: some View {
        VStack {
            NavigationView {
                List(fetch.characters) { character in
                    NavigationLink {
                        BBCharacterView(character: character)
                    } label: {
                        BBCharacterRow(character: character)
                    }
                }
            }
        }
    }
}

struct BBCharactersListView_Previews: PreviewProvider {
    static var previews: some View {
        BBCharactersListView()
    }
}
