//
//  NewsTableViewCell.swift
//  NewsDemo
//
//  Created by Zülal Sarıoğlu on 7.02.2024.
//

import UIKit
import SDWebImage

class NewsTableViewCell: UITableViewCell {

    @IBOutlet weak var newsImage: UIImageView!
    @IBOutlet weak var newsLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func configure(with article : Article) {
        newsLabel.text = article.title
        if let imageURLString = article.urlToImage,  let imageUrl = URL(string: imageURLString) {
            newsImage.sd_setImage(with: imageUrl , placeholderImage: UIImage(named: "placeholder"))
        }else {
            // Resim URL'si yoksa veya geçersizse, yerine bir yer tutucu resim göster
            newsImage.image = UIImage(named: "placeholder")
        }
    }
    
}
