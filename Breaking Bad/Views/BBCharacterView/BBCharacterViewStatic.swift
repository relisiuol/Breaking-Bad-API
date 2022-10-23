//
//  BBCharacterViewStatic.swift
//  Breaking Bad
//
//  Created by Louis Vedel on 22/10/2022.
//

import SwiftUI

struct BBCharacterViewStatic: View {
    @Binding var character: BBCharacter

    var body: some View {
        Text(character.name)
            .font(.title)

        Divider()

        BBCharacterViewStaticHInfo(label: "nickname", info: character.nickname)

        BBCharacterViewStaticHInfo(label: "birthday", info: character.birthday)

        BBCharacterViewStaticHInfo(label: "status", info: character.status)

        BBCharacterViewStaticHInfo(label: "actor", info: character.portrayed)

        if character.occupation.count > 0 {
            Text(
                "occupation-count \(character.occupation.count)",
                tableName: "Plurals"
            ).font(.title2)

            Spacer()

            Text(character.occupation.joined(separator: ", "))
                .foregroundColor(.secondary)
        } else {
            Text("no-occupation")
                .foregroundColor(.secondary)
        }
    }
}
