//
//  EmojiTableViewCell.swift
//  EmojiReader
//
//  Created by leila leila on 05.10.2021.
//

import UIKit

class EmojiTableViewCell: UITableViewCell {
    
    @IBOutlet weak var emojiLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    func setEmoji(object: Emoji) {
        emojiLabel.text = object.emoji
        nameLabel.text = object.name
        descriptionLabel.text = object.description
    }
    
}
