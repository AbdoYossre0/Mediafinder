//
//  SeriesTableViewCell.swift
//  Media XXX
//
//  Created by abdoyossre on 8/25/20.
//  Copyright © 2020 abdoyossre. All rights reserved.
//

import UIKit
import SDWebImage

class MediaTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var longDescrptionLabel: UILabel!
    @IBOutlet weak var artWorkImageView: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
    }
    
    func configure(media: Media) {
        let mediaType = media.getType()
        if mediaType == MediaType.tvShow {
            self.nameLabel.text = media.artistName ?? ""
        } else {
            self.nameLabel.text = media.trackName ?? ""
        }
        if mediaType == MediaType.music {
            self.longDescrptionLabel.text = media.artistName ?? ""
        } else {
            self.longDescrptionLabel.text = media.longDescription ?? ""
        }
        // the var name not it is type
        if let artImageUrl = URL(string: media.artworkUrl100) {
            artWorkImageView.sd_setImage(with: artImageUrl, placeholderImage: UIImage(named: "placeholder.png") )
        }
    }
    
    @IBAction func buttonStartTapped(_ sender: UIButton) {
        UIView.animate(withDuration: 1, animations: {self.artWorkImageView.frame.origin.y -= 50
        }) {_ in
            UIView.animateKeyframes(withDuration: 1, delay: 0.25, options: [.autoreverse, .repeat], animations: { self.artWorkImageView.frame.origin.y += 50} )
            
        }
    }
    
    
    
    
}
