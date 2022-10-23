//
//  BBCharacterViewStaticHInfo.swift
//  Breaking Bad
//
//  Created by Louis Vedel on 22/10/2022.
//

import SwiftUI

struct BBCharacterViewStaticHInfo: View {
    var label: String
    var info: String

    var body: some View {
        HStack {
            Text(
                LocalizedStringKey(label)
            ).font(.body)
            Spacer()
            Text(info)
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
        Divider()
    }
}
