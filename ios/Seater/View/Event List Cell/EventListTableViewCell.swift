//
//  EventListTableViewCell.swift
//  Seater
//
//  Created by David Messing on 10/13/18.
//  Copyright © 2018 davemess. All rights reserved.
//

import UIKit
import AppUI
import SeaterKit

/// Specialized cell for dislpaying Events in a tableview.
class EventListTableViewCell: UITableViewCell, ReusableCell, NibProviding {

    // MARK: - outlets
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var locationLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var eventImageView: UIImageView!
    @IBOutlet private weak var favoriteImageView: UIImageView!
    
    // MARK: - overrides
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
        prepareForReuse()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        titleLabel.text = nil
        locationLabel.text = nil
        dateLabel.text = nil
        eventImageView.image = nil
        favoriteImageView.image = nil
    }
    
    // MARK: - public
    
    func configure(with event: Event) {
        titleLabel.text = event.title
        locationLabel.text = event.location
        dateLabel.text = DateViewFormatter.format(event.date, style: .long)
        favoriteImageView.image = event.favorited ? #imageLiteral(resourceName: "heart_filled") : #imageLiteral(resourceName: "heart_outline")
    }
}
