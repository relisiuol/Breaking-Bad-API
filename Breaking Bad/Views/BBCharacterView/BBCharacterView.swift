//
//  BBCharacterView.swift
//  Breaking Bad
//
//  Created by Louis Vedel on 13/10/2022.
//

import SDWebImageSwiftUI
import SwiftUI

struct BBCharacterView: View {
    @ObservedObject var model: BBCharacterViewModel

    var body: some View {
        ScrollView {
            BBCharacterViewHeader(character: $model.character)
            
            VStack(alignment: .leading) {
                BBCharacterViewStatic(character: $model.character)
                
                if model.isPossiblyDead() {

                    Divider()
                    Text("death-title")
                        .font(.title2)
                    Spacer()
                    
                    if model.loading {
                        HStack(alignment: .center) {
                            Spacer()
                            ProgressView()
                            Spacer()
                        }
                    } else if let death = model.death {
                        BBCharacterViewStaticVInfo(
                            label: "death-responsible",
                            info: death.responsible
                        )
                        BBCharacterViewStaticVInfo(
                            label: "death-cause",
                            info: death.cause
                        )
                        BBCharacterViewStaticVInfo(
                            label: "death-last_words",
                            info: death.last_words,
                            noDivider: true
                        )
                    } else if model.error {
                        HStack(alignment: .center) {
                            Spacer()
                            Button {
                                model.load()
                            } label: {
                                Text("retry")
                            }
                            Spacer()
                        }
                    } else {
                        HStack(alignment: .center) {
                            Spacer()
                            Text("no-death-info")
                            Spacer()
                        }
                    }
                }
            }
            .clipped()
            .padding()
        }
        .edgesIgnoringSafeArea(.top)
        .onAppear() {
            model.load()
        }
    }
}
