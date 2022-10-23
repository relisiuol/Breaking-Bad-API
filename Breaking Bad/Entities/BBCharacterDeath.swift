//
//  BBCharacterDeath.swift
//  Breaking Bad
//
//  Created by Louis Vedel on 22/10/2022.
//

import Foundation

final class BBCharacterDeath: Codable, Identifiable {
    public let id: Int
    public let death: String
    public let cause: String
    public let responsible: String
    public let last_words: String

    enum CodingKeys: String, CodingKey {
        case id = "death_id",
             death,
             cause,
             responsible,
             last_words
    }
}
