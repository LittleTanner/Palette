//
//  PaletteTableViewCell.swift
//  Palette
//
//  Created by Kevin Tanner on 9/3/19.
//  Copyright © 2019 trevorAdcock. All rights reserved.
//

import UIKit

class PaletteTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    var unsplashPhoto: UnsplashPhoto? {
        didSet {
            // update
            updateViews()
        }
    }
    
    // MARK: - Lifecycle Methods
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        constrainViews()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        colorPaletteView.colors = [UIColor(named: "offWhite")!]
    }
    
    // MARK: - Helper Functions
    
    
    func updateViews() {
        guard let photo = unsplashPhoto else { return }
        // fetch image
        fetchAndSetImage(for: photo)
        
        // fetch the color palette
        fetchAndSetColors(for: photo)
    }
    
    func fetchAndSetImage(for photo: UnsplashPhoto) {
        UnsplashService.shared.fetchImage(for: photo) { (image) in
            DispatchQueue.main.async {
                self.paletteImageView.image = image
            }
        }
    }
    
    func fetchAndSetColors(for unsplashPhoto: UnsplashPhoto) {
        ImaggaService.shared.fetchColorsFor(imagePath: unsplashPhoto.urls.regular) { (colors) in
            DispatchQueue.main.async {
                guard let colors = colors else { return }
                
                // set colors for the color palette view
                self.colorPaletteView.colors = colors
            }
        }
    }
    
    // Step 2: Add to the view
    func addAllSubViews() {
        self.addSubview(paletteImageView)
        self.addSubview(titleLabel)
        self.addSubview(colorPaletteView)
    }
    
    // Step 3: Constrain Views
    func constrainViews() {
        addAllSubViews()
        
        let imageWidth = (contentView.frame.width - (SpacingConstants.outerHortizontalPadding * 2))
        
        paletteImageView.anchor(top: contentView.topAnchor, bottom: nil, leading: contentView.leadingAnchor, trailing: contentView.trailingAnchor, topPadding: SpacingConstants.outerVerticalPadding, bottomPadding: 0, leadingPadding: SpacingConstants.outerHortizontalPadding, trailingPadding: SpacingConstants.outerHortizontalPadding, height: imageWidth, width: imageWidth)
        
        titleLabel.anchor(top: paletteImageView.bottomAnchor, bottom: nil, leading: contentView.leadingAnchor, trailing: contentView.trailingAnchor, topPadding: SpacingConstants.verticalObjectBuffer, bottomPadding: 0, leadingPadding: SpacingConstants.outerHortizontalPadding, trailingPadding: SpacingConstants.outerHortizontalPadding, height: SpacingConstants.oneLineElementHeight, width: nil)
        
        colorPaletteView.anchor(top: titleLabel.bottomAnchor, bottom: contentView.bottomAnchor, leading: contentView.leadingAnchor, trailing: contentView.trailingAnchor, topPadding: SpacingConstants.verticalObjectBuffer, bottomPadding: SpacingConstants.outerVerticalPadding, leadingPadding: SpacingConstants.outerHortizontalPadding, trailingPadding: SpacingConstants.outerHortizontalPadding, height: SpacingConstants.twoLineElementHeight)
        
        colorPaletteView.clipsToBounds = true
        colorPaletteView.layer.cornerRadius = colorPaletteView.frame.height / 2
    }
    
    // Step 1: Define the view
    lazy var paletteImageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 12
        imageView.contentMode = .scaleAspectFill
        
        return imageView
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        
        return label
    }()
    
    // Add custom color palette view
    lazy var colorPaletteView: ColorPaletteView = {
        let view = ColorPaletteView()
        return view
    }()
}
