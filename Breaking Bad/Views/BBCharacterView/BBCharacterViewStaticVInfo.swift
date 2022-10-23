//
//  BBCharacterViewStaticVInfo.swift
//  Breaking Bad
//
//  Created by Louis Vedel on 22/10/2022.
//

import SwiftUI

struct BBCharacterViewStaticVInfo: View {
    var label: String
    var info: String
    var noDivider: Bool = false

    var body: some View {
        Text(
            LocalizedStringKey(label)
        ).font(.body)

        Spacer()

        Text(info)
            .font(.subheadline)
            .foregroundColor(.secondary)

        if !noDivider {
            Divider()
        }
    }
}
