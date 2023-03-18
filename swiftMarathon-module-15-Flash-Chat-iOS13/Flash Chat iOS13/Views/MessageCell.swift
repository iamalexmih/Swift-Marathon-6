//
//  MessageCell.swift
//  Flash Chat iOS13
//
//  Created by Алексей Попроцкий on 18.03.2023.
//  Copyright © 2023 Angela Yu. All rights reserved.
//

import UIKit

class MessageCell: UITableViewCell {

    @IBOutlet weak var messageBubble: UIView!
    @IBOutlet weak var lbl: UILabel!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var companionAvatarImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Изменять радиус в зависимости от высоты ячейки. Высота ячеки будет зависеть от длинны сообщения, в таком случае текст может занимать несколько строк.
        messageBubble.layer.cornerRadius = messageBubble.frame.size.height / 5
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
