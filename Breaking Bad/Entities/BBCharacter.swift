//
//  BBCharacter.swift
//  Breaking Bad
//
//  Created by Louis Vedel on 13/10/2022.
//

import Foundation

final class BBCharacter: Codable, Identifiable {
    public let id: Int
    public let name: String
    public let birthday: String
    public let occupation: [String]
    public let img: String
    public let status: String
    public let nickname: String
    public let portrayed: String
    public let category: String

    enum CodingKeys: String, CodingKey {
        case id = "char_id",
             name,
             birthday,
             occupation,
             img,
             status,
             nickname,
             portrayed,
             category
    }
}
