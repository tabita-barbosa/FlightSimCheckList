//
//  ViewController.swift
//  FlightSimCheckList
//
//  Created by Tabita Barbosa on 07/11/23.
//

import Foundation
import UIKit

class ViewController: UIViewController {
    // MARK: VIEW CICLE
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func loadView() {
        self.view = homeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
 
    func setupView() {
        navigationItem.title = "home"
        self.view.backgroundColor = .white
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    lazy var homeView: HomeView = {
        let viewModel = HomeViewModel()
        let view = HomeView(viewModel: viewModel)
        view.delegate = self
        return view
    }()
    
//    func updateManufacturers(manufacturers: [ManufacturersModel] ) {
//        homeView.updateManufacturers(manufacturers: manufacturers)
//    }
//
//    func updateModels(models: [String]) {
//        homeView.updateModels(models: models)
//    }
}

extension ViewController: HomeViewDelegate {
    func didTapOpenChecklist() {
        //
    }
}
