//
//  RatingTableViewCell.swift
//  Enterprise
//
//  Created by user on 11/28/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit

class RatingTableViewCell: UITableViewCell, UITextViewDelegate {

    @IBOutlet weak var ratingTxtView: UITextView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        ratingTxtView.delegate = self
    }
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            ratingTxtView.resignFirstResponder()
            return false
        }
        return true
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
