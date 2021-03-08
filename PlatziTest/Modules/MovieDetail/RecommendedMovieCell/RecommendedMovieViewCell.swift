//
//  RecommendedMovieViewCell.swift
//  PlatziTest
//
//  Created by Jose Gutierrez on 08/03/21.
//

import UIKit

class RecommendedMovieViewCell: UICollectionViewCell {
    static let identifier = "RecommendedMovieViewCell"
    
    override func layoutSubviews() {
        backgroundColor = .green
        layer.borderWidth = 2
        layer.borderColor = Colors.border.cgColor
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
