//
//  MessageCell.swift
//  SwiftBootcamp
//
//  Created by Manish Sharma on 02/03/19.
//  Copyright © 2019 Manish Sharma. All rights reserved.
//

import UIKit

class MessageCell: UITableViewCell {
    @IBOutlet weak var messageBg: UIView!
    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var lblSender: UILabel!
    @IBOutlet weak var lblMessageBody: UILabel!
}
