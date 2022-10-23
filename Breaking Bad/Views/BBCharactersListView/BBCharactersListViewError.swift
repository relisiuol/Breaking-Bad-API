//
//  BBCharactersListViewError.swift
//  Breaking Bad
//
//  Created by Louis Vedel on 22/10/2022.
//

import SwiftUI

struct BBCharactersListViewError: View {
    var buttonAction: () -> Void

    var body: some View {
        Text("failed")
            .padding(10)
        Button {
            buttonAction()
        } label: {
            Text("retry")
        }
            .font(.title3)
    }
}
