//
//  PhoneBillOperationTableViewCell.swift
//  QPay
//
//  Created by Mohammed Hamad on 03/07/2023.
//  Copyright © 2023 Dev. Mohmd. All rights reserved.
//

import UIKit

protocol PhoneBillOperationTableViewCellDelegate : AnyObject {
    func didTapEdit  (_ cell : PhoneBillOperationTableViewCell)
    func didTapDelete(_ cell : PhoneBillOperationTableViewCell)
}

class PhoneBillOperationTableViewCell: UITableViewCell {
    
    @IBOutlet weak var amountLabel : UILabel!

    @IBOutlet weak var dateLabel    : UILabel!

    weak var delegate: PhoneBillOperationTableViewCellDelegate?
    
    var object : ScheduleRequests? {
        willSet {
            guard let data = newValue else { return }
            self.amountLabel.text = "Scheduled paymentis enable for QAR \(data._amount)"
            self.dateLabel.text   = "on \(data._scheduledDate)"
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}

extension PhoneBillOperationTableViewCell {
    
    @IBAction func editAction(_ sender: UIButton) {
        self.delegate?.didTapEdit(self)
    }
    
    @IBAction func deleteAction(_ sender: UIButton) {
        self.delegate?.didTapDelete(self)
    }
}
