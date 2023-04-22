//
//  Extension+Helper.swift
//  Wisdomleaf-Task
//
//  Created by Dinesh Kumar on 22/04/23.

import UIKit
import Kingfisher

extension UIImageView {
    func loadKingfisherImage(url: String) {
        self.kf.cancelDownloadTask()
        self.kf.indicatorType = .activity
        self.kf.setImage(with: ImageResource(downloadURL: URL(string: url)!, cacheKey: url)) { result in
            switch result {
            case .success(let value):
                self.image = value.image
            case .failure(let error):
                print("Failed to load image: \(error.localizedDescription)")
            }
        }
    }
}

extension CGFloat {
    static func ratioHeight(_ height: CGFloat) -> CGFloat{
        return UIScreen.main.bounds.size.height * (height/812)
    }
    
    static func ratioWidth(_ width: CGFloat) -> CGFloat{
        return UIScreen.main.bounds.size.width * (width/375)
    }
}

extension UIViewController {
    
    func showAlert(title: String = "", message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertStyle: UIAlertAction.Style = title.isEmpty ? .destructive : .default
        alert.addAction(UIAlertAction(title: "OK", style: alertStyle, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
