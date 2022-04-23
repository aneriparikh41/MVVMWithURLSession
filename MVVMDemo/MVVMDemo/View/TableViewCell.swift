//
//  TableViewCell.swift
//  MVVMDemo
//
//  Created by Aneri Parikh on 23/04/22.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var desc: UILabel!
    @IBOutlet weak var imgView: UIImageView!

    var currentNews: NewsInfo?

    func configure(new: NewsInfo?) {
        guard let new = new else {return}
        currentNews = new
        self.title.text = new.title
        self.desc.text = new.desc
        ImageDownloader.shared.download(urlString: new.imageURL) {[weak self] image, url in
            if new.imageURL == self?.currentNews?.imageURL {
                DispatchQueue.executeOnMain {
                    self?.imgView.image = image
                }
            }
        }
    }
}
