//
//  ChecklistViewController.swift
//  trabalho-final
//
//  Created by Tabita Barbosa on 21/05/23.
//

import Foundation
import UIKit

class ChecklistViewController: UIViewController {
    
    var type: ManufacturersType
    var modelName: String
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(type: ManufacturersType, modelName: String) {
        self.type = type
        self.modelName = modelName
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func loadView() {
        self.view = checklistView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.setupView()
    }
    
    func setupView() {
        navigationItem.title = "\(type.name) - \(modelName)"
    }
    
    lazy var checklistView: ChecklistView = {
        let view = ChecklistView(type: self.type)
        return view
    }()
}
