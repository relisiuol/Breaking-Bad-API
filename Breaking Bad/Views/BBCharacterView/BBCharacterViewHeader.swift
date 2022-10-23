//
//  BBCharacterViewHeader.swift
//  Breaking Bad
//
//  Created by Louis Vedel on 22/10/2022.
//

import SDWebImageSwiftUI
import SwiftUI

struct BBCharacterViewHeader: View {
    @Binding var character: BBCharacter

    var body: some View {
        GeometryReader { parentGeometry in
            ZStack {
                GeometryReader { geometry in
                    WebImage(url: URL(string: character.img))
                        .renderingMode(.original)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .background(Color.gray)
                        .blur(radius: 25)
                        .frame(
                            width: geometry.size.width,
                            height: (
                                geometry.frame(in: .global).minY <= 0 ?
                                geometry.size.height :
                                geometry.size.height + geometry.frame(in: .global).minY
                            )
                        )
                        .clipped()
                        .offset(
                            y: (
                                geometry.frame(in: .global).minY <= 0 ?
                                geometry.frame(in: .global).minY / 9 :
                                -geometry.frame(in: .global).minY
                            )
                        )
                }
                WebImage(url: URL(string: character.img))
                    .renderingMode(.original)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .background(Color.gray)
                    .frame(width: 100, height: 100)
                    .clipShape(Circle())
                    .overlay {
                        Circle().stroke(.white, lineWidth: 4)
                    }
                    .shadow(radius: 7)
                    .offset(y: (parentGeometry.safeAreaInsets.top + 20))
            }
        }
        .frame(height: 180)
    }
}
