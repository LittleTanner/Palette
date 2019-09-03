//
//  PaletteListViewController.swift
//  Palette
//
//  Created by Kevin Tanner on 9/3/19.
//  Copyright © 2019 trevorAdcock. All rights reserved.
//

import UIKit

class PaletteListViewController: UIViewController {

    // MARK: - Properties
    
    var photos: [UnsplashPhoto] = []
    
    var buttons: [UIButton] {
        return [randomButton, featuredButton, doubleRanbowButton]
    }

    var safeArea: UILayoutGuide {
        return self.view.safeAreaLayoutGuide
    }
    
    override func loadView() {
        super.loadView()
        addAllSubviews()
        setupStackView()
        tableView.anchor(top: buttonStackView.bottomAnchor, bottom: safeArea.bottomAnchor, leading: safeArea.leadingAnchor, trailing: safeArea.trailingAnchor, topPadding: 8, bottomPadding: 0, leadingPadding: 0, trailingPadding: 0)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .white
        configureTableView()
        activateButtons()
        selectButton(featuredButton)
        searchForCategory(.featured)
    }
    
    // MARK: - Helper Functions

    // MARK: - Part 2 of programmic constraints: Add to the view
    func addAllSubviews() {
        self.view.addSubview(featuredButton)
        self.view.addSubview(randomButton)
        self.view.addSubview(doubleRanbowButton)
        self.view.addSubview(buttonStackView)
        self.view.addSubview(tableView)
    }
    
    func setupStackView() {
        buttonStackView.translatesAutoresizingMaskIntoConstraints = false
        
        buttonStackView.addArrangedSubview(featuredButton)
        buttonStackView.addArrangedSubview(randomButton)
        buttonStackView.addArrangedSubview(doubleRanbowButton)

        // Set Constraints
        buttonStackView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 0).isActive = true
        buttonStackView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 16).isActive = true
        buttonStackView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -16).isActive = true
    }
    
    func configureTableView() {
        // delegate, data source
        tableView.delegate = self
        tableView.dataSource = self
        
        // register our custom cell
        tableView.register(PaletteTableViewCell.self, forCellReuseIdentifier: "colorCell")
        
        // do any editing to tableView properties
        tableView.allowsSelection = false
    }
    
    func activateButtons() {
        buttons.forEach({ $0.addTarget(self, action: #selector(searchButtonTapped(sender:)), for: .touchUpInside) })
    }
    
    func searchForCategory(_ unsplashRoute: UnsplashRoute) {
        UnsplashService.shared.fetchFromUnsplash(for: unsplashRoute) { (photos) in
            DispatchQueue.main.async {
                guard let photos = photos else { return }
                self.photos = photos
                self.tableView.reloadData()
            }
        }
    }
    
    func selectButton(_ button: UIButton) {
        buttons.forEach({ $0.setTitleColor(UIColor.lightGray, for: .normal) })
        button.setTitleColor(UIColor(named: "devmountainBlue"), for: .normal)
    }
    
    @objc func searchButtonTapped(sender: UIButton) {
        selectButton(sender)
        switch sender {
        case featuredButton:
            searchForCategory(.featured)
        case randomButton:
            searchForCategory(.random)
        case doubleRanbowButton:
            searchForCategory(.doubleRainbow)
        default:
            print("Route not found")
        }
    }
    
    // MARK: - Views (Step 1 of programmic constraints: Define the view)

    let featuredButton: UIButton = {
        let button = UIButton()
        
        button.setTitle("Featured", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.contentHorizontalAlignment = .center
        
        return button
    }()
    
    let randomButton: UIButton = {
        let button = UIButton()
        
        button.setTitle("Random", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.contentHorizontalAlignment = .center
        
        return button
    }()
    
    let doubleRanbowButton: UIButton = {
        let button = UIButton()
        
        button.setTitle("Double Rainbow", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.contentHorizontalAlignment = .center
        
        return button
    }()
    
    let buttonStackView: UIStackView = {
        let stackView = UIStackView()
        
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .equalCentering
        
        return stackView
    }()
    
    let tableView: UITableView = {
        let tableView = UITableView()
        
        
        
        return tableView
    }()


} // End of class


extension PaletteListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "colorCell", for: indexPath) as? PaletteTableViewCell
    
        let photo = photos[indexPath.row]
//        cell.paletteImageView.backgroundColor = .red
        cell?.unsplashPhoto = photo
        
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let imageViewSpacing: CGFloat = (view.frame.width - (SpacingConstants.outerHortizontalPadding * 2))
        let titleLabelSpacing: CGFloat = SpacingConstants.oneLineElementHeight
        let colorPaletteViewSpacing: CGFloat = SpacingConstants.twoLineElementHeight
        let verticalPadding: CGFloat = (3 * SpacingConstants.verticalObjectBuffer)
        let outerVerticalPadding: CGFloat = (2 * SpacingConstants.outerVerticalPadding)
        return imageViewSpacing + titleLabelSpacing + colorPaletteViewSpacing + verticalPadding + outerVerticalPadding
    }
}
