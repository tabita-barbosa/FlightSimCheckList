//
//  ChecklistView.swift
//  FlightSimCheckList
//
//  Created by Tabita Barbosa on 08/11/23.
//

import Foundation
import UIKit

class ChecklistView: UIView {
    var sections = [Section]()
    var type: ManufacturersType
    
    init(type: ManufacturersType) {
        self.type = type
        super.init(frame: .zero)
        backgroundColor = .white
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        self.setupHierarchy()
        self.setupConstraints()
        self.checklistPopulate(type: self.type)
        self.checklistTable.delegate = self
        self.checklistTable.dataSource = self
    }
    
    func checklistPopulate(type: ManufacturersType) {
        switch type {
        case .airbus:
            self.sections = mockerDataAirbus
        case .boeing:
            self.sections = mockedDataBoeing
        }
        
        self.checklistTable.reloadData()
    }
    
    private lazy var checklistTable: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        table.allowsMultipleSelection = true
        return table
    }()
}

extension ChecklistView {
    func setupHierarchy() {
        self.addSubview(self.checklistTable)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            self.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        self.checklistTable.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.checklistTable.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 24.0),
            self.checklistTable.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            self.checklistTable.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -12.0),
            self.checklistTable.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension ChecklistView: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.sections.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section].name
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].collapsed ? 0 : sections[section].items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let commonCell: CustomTableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell") as? CustomTableViewCell ?? CustomTableViewCell(style: .default, reuseIdentifier: "cell")
        
        let inputCell: CustomWithTextTableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell") as? CustomWithTextTableViewCell ?? CustomWithTextTableViewCell(style: .default, reuseIdentifier: "cell")
        
        let item: Item = sections[indexPath.section].items[indexPath.row]
        
        if item.hasInput {
            inputCell.nameLabel.text = item.name
            inputCell.detailLabel.text = item.complement
            return inputCell
        } else {
            commonCell.nameLabel.text = item.name
            return commonCell
        }
    }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        let cell = tableView.cellForRow(at: indexPath)
        
        if cell is CustomWithTextTableViewCell {
            return nil
        } else {
            return indexPath
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.backgroundColor = .white
        tableView.cellForRow(at: indexPath)?.accessoryType = .none
    }
}
