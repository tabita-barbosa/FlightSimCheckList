////
////  ViewController.swift
////  FlightSimCheckList
////
////  Created by Tabita Barbosa on 07/11/23.
////
//
//import UIKit
//
//class ViewController: UIViewController {
//
//    let dataArray = ["Airbus", "Maths", "History", "German", "Science"]
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        // Do any additional setup after loading the view.
//    }
//
//    override func viewWillDisappear(_ animated: Bool) {
//        //
//    }
//
//    override func viewWillAppear(_ animated: Bool) {
//        //
//    }
//
//    // nav
//    // title
//    // dropdown empresa e modelos -  UIPickerView
//    // botão para ir pra proxima pagina
//
//    lazy var companyPicker: UIPickerView = {
//        let picker = UIPickerView()
//        picker.delegate = self
//        picker.dataSource = self
//        return picker
//    }()
//
//    lazy var modelPicker: UIPickerView = {
//        let picker = UIPickerView()
//        picker.delegate = self
//        picker.dataSource = self
//        return picker
//    }()
//}
//

import Foundation
import UIKit

class ViewController: UIViewController {
    
    let manufactures = ["Airbus", "Boeing"]
    let lightBlueColor = UIColor(named: "lightBlue")
    var type: ChecklistType?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        if let selectedIndexPath = self.manufacturesTable.indexPathForSelectedRow {
//            self.manufacturesTable.deselectRow(at: selectedIndexPath, animated: animated)
//        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.setupView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
//        self.manufacturesTable.frame = view.bounds
    }
    
    func setupView() {
        navigationItem.title = "tela inicial"
        self.setupHierarchy()
        self.setupConstraints()
//        self.manufacturesTable.dataSource = self
//        self.manufacturesTable.delegate = self
//        self.manufacturesTable.reloadData()
    }
    
    private lazy var contentStack: UIStackView = {
       let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .equalSpacing
        stack.spacing = 20
        return stack
    }()
    
    private lazy var titleManufacturers: UILabel = {
        let label = UILabel()
        label.text = "Escolha a fabricante:"
        label.font = UIFont.boldSystemFont(ofSize: 18.0)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Faça o checklist do seu voo pelo app"
        label.font = UIFont.systemFont(ofSize: 16.0)
        label.textAlignment = .center
        return label
    }()
    
//    private lazy var manufacturesTable: UITableView = {
//        let table = UITableView()
//        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
//        return table
//    }()
//
//    func manufatureType(name: String) -> ChecklistType {
//
//        if name == "Airbus" {
//            type = .airbus
//        } else if name == "Boeing" {
//            type = .boeing
//        }
//
//        return type ?? .airbus
//    }
//
    lazy var manufacturesPicker: UIPickerView = {
        let picker = UIPickerView()
        picker.delegate = self
        picker.dataSource = self
        return picker
    }()
    
    lazy var modelPicker: UIPickerView = {
        let picker = UIPickerView()
        picker.delegate = self
        picker.dataSource = self
        return picker
    }()
    
    func didTapOpenChecklist(type: ChecklistType) {
        let checklistPage = ChecklistViewController(type: type)
        self.navigationController?.pushViewController(checklistPage, animated: true)
    }
}

extension ViewController {
    func setupHierarchy() {
        view.addSubview(self.contentStack)
        self.contentStack.addArrangedSubview(self.descriptionLabel)
        self.contentStack.addArrangedSubview(self.titleManufacturers)
        self.contentStack.addArrangedSubview(self.manufacturesPicker)
    }
     
    func setupConstraints() {
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            view.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        self.contentStack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentStack.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            contentStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            contentStack.heightAnchor.constraint(equalToConstant: 300.0),
            contentStack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 24.0),
            contentStack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -24.0)
        ])
    }
}

extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
       return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
       return manufactures.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
       let row = manufactures[row]
       return row
    }
}

//extension ViewController: UITableViewDataSource, UITableViewDelegate {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return companies.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
//
//        var content = cell.defaultContentConfiguration()
//        content.text = companies[indexPath.row]
//        content.textProperties.alignment = .center
//        cell.backgroundColor = lightBlueColor
//        cell.layer.cornerRadius = 10
//
//        cell.contentConfiguration = content
//        return cell
//    }
//
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let selected = companies[indexPath.row]
//        let type = self.manufatureType(name: selected)
//        self.didTapOpenChecklist(type: type)
//    }
//}
