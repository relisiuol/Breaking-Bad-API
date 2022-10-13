//
//  BBCharacterRow.swift
//  Breaking Bad
//
//  Created by Louis Vedel on 13/10/2022.
//

import SDWebImageSwiftUI
import SwiftUI

struct BBCharacterRow: View {
    var character: BBCharacter

    var body: some View {
        HStack(alignment: .center) {
            WebImage(
                url: URL(string: character.img)
            )
            .renderingMode(.original)
            .resizable()
            .background(Color.gray)
            .aspectRatio(contentMode: .fill)
            .frame(width: 60, height: 60)
            .cornerRadius(30)
            VStack(alignment: .leading) {
                Text(character.name)
                    .font(Font.headline)
                    .lineLimit(1)
                Text(character.nickname)
                    .font(Font.subheadline)
                    .lineLimit(1)
            }
        }
    }
}

