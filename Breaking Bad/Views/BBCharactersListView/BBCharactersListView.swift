//
//  ContentView.swift
//  Breaking Bad
//
//  Created by Louis Vedel on 13/10/2022.
//

import SwiftUI

struct BBCharactersListView: View {
    @ObservedObject var model = BBCharactersListViewModel()

    var body: some View {
        NavigationView {
            VStack {
                if model.loading {
                    BBCharactersListViewLoading()
                } else if model.characters.isEmpty {
                    BBCharactersListViewError(buttonAction: model.load)
                } else {
                    List(
                        model.filteredCharacters()
                    ) { character in
                        NavigationLink {
                            BBCharacterView(model: BBCharacterViewModel(character))
                        } label: {
                            BBCharacterRow(character: character)
                        }
                    }
                    .refreshable {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                            self.model.characters.removeAll()
                            self.model.load()
                        }
                    }
                    .searchable(text: $model.search)
                }
            }
            .navigationBarTitleDisplayMode(.large)
            .navigationTitle("Breaking Bad")
            .statusBarHidden(false)
        }.onAppear() {
            UINavigationBar.appearance().tintColor = .label
            UIBarButtonItem.appearance().tintColor = .label
            UIBarButtonItem.appearance().setTitleTextAttributes([
                NSAttributedString.Key.foregroundColor: UIColor.label
            ], for: .normal)
        }
    }
}

struct BBCharactersListView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            BBCharactersListView()
                .previewDisplayName("Portrait")
                .previewInterfaceOrientation(.portrait)
            BBCharactersListView()
                .previewDisplayName("Landscape")
                .previewInterfaceOrientation(.landscapeLeft)
        }
    }
}
