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
}

extension ViewController: HomeViewDelegate {
    func didTapOpenChecklist(type: ManufacturersType, modelName: String) {
        let controller = ChecklistViewController(type: type, modelName: modelName)
        self.navigationController?.pushViewController(controller, animated: false)
    }
}
