//
//  Model.swift
//  EmojiReader
//
//  Created by leila leila on 06.10.2021.
//

struct Emoji {
    let emoji: String
    let name: String
    let description: String
    var isFavorite: Bool
    
    static func getEmoji() -> [Emoji] {
        [
            Emoji(emoji: "🥰", name: "Love", description: "Let's love each other", isFavorite: false),
            Emoji(emoji: "⚽️", name: "Football", description: "Let's play football", isFavorite: false),
            Emoji(emoji: "🐱", name: "Cat", description: "Cat is the cutest animal", isFavorite: false)
        
        ]
    }
}
