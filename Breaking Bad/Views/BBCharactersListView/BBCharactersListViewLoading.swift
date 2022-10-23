//
//  BBCharactersListViewLoading.swift
//  Breaking Bad
//
//  Created by Louis Vedel on 22/10/2022.
//

import SwiftUI

struct BBCharactersListViewLoading: View {
    var body: some View {
        ProgressView()
            .padding(10)
        Text("loading")
            .font(.title3)
    }
}
