//
//  BBCharacterView.swift
//  Breaking Bad
//
//  Created by Louis Vedel on 13/10/2022.
//

import SDWebImageSwiftUI
import SwiftUI

struct BBCharacterView: View {
    var character: BBCharacter
    var body: some View {
        ScrollView {
            GeometryReader { geometry in
                ZStack {
                    if geometry.frame(in: .global).minY <= 0 {
                        WebImage(url: URL(string: character.img))
                            .renderingMode(.original)
                            .resizable()
                            .background(Color.gray)
                            .aspectRatio(contentMode: .fill)
                            .frame(width: geometry.size.width, height: geometry.size.height)
                            .offset(y: geometry.frame(in: .global).minY/9)
                            .clipped()
                    } else {
                        WebImage(url: URL(string: character.img))
                            .renderingMode(.original)
                            .resizable()
                            .background(Color.gray)
                            .aspectRatio(contentMode: .fill)
                            .frame(width: geometry.size.width, height: geometry.size.height + geometry.frame(in: .global).minY)
                            .clipped()
                            .offset(y: -geometry.frame(in: .global).minY)
                    }
                }
            }
            .frame(height: 400)

            VStack(alignment: .leading) {
                Text(character.name)
                    .font(.title)
                HStack {
                    Text(character.nickname)
                    Spacer()
                    Text(character.portrayed)
                }
                .font(.subheadline)
                .foregroundColor(.secondary)

                Divider()

                HStack {
                    Text("Anniversaire")
                    Spacer()
                    Text(character.birthday)
                }
                .font(.subheadline)
                .foregroundColor(.secondary)

                Divider()
    
                Text(character.status)
                .font(.subheadline)
                .foregroundColor(.secondary)

                Divider()
            
                Text("Occupation\(character.occupation.count > 1 ? "s" : "") :")
                    .font(.title2)
                Text(character.occupation.count > 0 ? character.occupation.joined(separator: ", ") : "Pas d'occupation")
            }
            .padding()
        }
        .edgesIgnoringSafeArea(.top)
    }
}
