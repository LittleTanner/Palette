//
//  ColorPaletteView.swift
//  Palette
//
//  Created by Kevin Tanner on 9/3/19.
//  Copyright © 2019 trevorAdcock. All rights reserved.
//

import UIKit

class ColorPaletteView: UIView {

    var colors: [UIColor] {
        didSet {
            // build our bricks
            buildsColorBricks()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupViews()
    }
    
    init(colors: [UIColor] = [], frame: CGRect = .zero) {
        self.colors = colors
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        self.addSubview(colorStackView)
        colorStackView.anchor(top: topAnchor, bottom: bottomAnchor, leading: leadingAnchor, trailing: trailingAnchor, topPadding: 0, bottomPadding: 0, leadingPadding: 0, trailingPadding: 0)
        buildsColorBricks()
    }
    
    private func buildsColorBricks() {
        resetBricks()
        
        for color in self.colors {
            let colorBrick = self.generateColorBrick(for: color)
            self.addSubview(colorBrick)
            self.colorStackView.addArrangedSubview(colorBrick)
        }
        self.layoutIfNeeded()
    }
    
    
    private func generateColorBrick(for color: UIColor) -> UIView {
        
        let view = UIView()
        view.backgroundColor = color
        return view
    }
    
    private func resetBricks() {
        for subView in colorStackView.arrangedSubviews {
            self.colorStackView.removeArrangedSubview(subView)
        }
    }
    
    
    lazy var colorStackView: UIStackView = {
       
        let stackView = UIStackView()
        
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        
        return stackView
    }()

}
