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
import Kingfisher

/// Specialized cell for dislpaying Events in a tableview.
class EventListTableViewCell: UITableViewCell, ReusableCell, NibProviding {

    // MARK: - nested types
    
    private struct Constants {
        static let cornerRadius: CGFloat = 10.0
    }
    
    // MARK: - outlets
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var locationLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var eventImageView: UIImageView!
    @IBOutlet private weak var favoriteImageView: UIImageView!
    
    // MARK: - private properties
    
    private var currentTask: RetrieveImageTask?
    
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
        eventImageView.kf.indicatorType = .activity
        eventImageView.image = nil
        favoriteImageView.image = nil
        
        eventImageView.layer.cornerRadius = Constants.cornerRadius
        favoriteImageView.layer.cornerRadius = Constants.cornerRadius
        
        currentTask?.cancel()
    }
    
    // MARK: - public
    
    func configure(with event: Event) {
        titleLabel.text = event.title
        locationLabel.text = event.location
        dateLabel.text = DateViewFormatter.format(event.date, style: .long)
        currentTask = eventImageView.kf.setImage(with: event.imageUrl, placeholder: #imageLiteral(resourceName: "placeholder"))
        favoriteImageView.image = event.favorited ? #imageLiteral(resourceName: "heart_filled") : nil
    }
}
