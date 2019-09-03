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
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "colorCell")
        
        // do any editing to tableView properties
        tableView.allowsSelection = false
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

} // End of class


extension PaletteListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "colorCell", for: indexPath)
    
        
        cell.backgroundColor = .red
        
        return cell
    }
    
    
}
