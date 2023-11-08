//
//  ChecklistViewController.swift
//  trabalho-final
//
//  Created by Tabita Barbosa on 21/05/23.
//

import Foundation
import UIKit

enum ChecklistType {
    case airbus
    case boeing
}

class ChecklistViewController: UIViewController {
    var sections = [Section]()
    var type: ManufacturersType
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(type: ManufacturersType) {
        self.type = type
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.setupView()
    }
    
    func setupView() {
        navigationItem.title = "Checklist"
        if #available(iOS 16.0, *) {
            navigationItem.backAction?.title = "voltar"
        } else {
            // Fallback on earlier versions
        }
        self.setupHierarchy()
        self.setupConstraints()
        self.checklistPopulate(type: self.type)
        self.checklistTable.delegate = self
        self.checklistTable.dataSource = self
    }
    
    func checklistPopulate(type: ManufacturersType) {
        switch type {
        case .airbus:
            self.sections = [
                Section(name: "Cockpit Preparation", items: [
                    Item(name: "Gear Pins % Covers", complement: ""),
                    Item(name: "Fuel Quantitty", complement: "KG/LB"),
                    Item(name: "Seat Belts", complement: ""),
                    Item(name: "Adirs to NAV", complement: ""),
                    Item(name: "Baro Ref", complement: "(both)")
                ]),
                Section(name: "Before Start", items: [
                    Item(name: "Parking Brake", complement: ""),
                    Item(name: "T.O Speeds & Thrust", complement: "(both)"),
                    Item(name: "Windows Closed", complement: "(both)"),
                    Item(name: "Beacon", complement: ""),
                ]),
                Section(name: "After Start", items: [
                    Item(name: "Anti Ice", complement: ""),
                    Item(name: "Ecam Status", complement: ""),
                    Item(name: "Pitch trim", complement: "%"),
                    Item(name: "Rudder Trim to Neutral", complement: ""),
                ]),
                Section(name: "Taxi", items: [
                    Item(name: "Flight Control", complement: "(both)"),
                    Item(name: "Flaps Setting", complement: "(both)"),
                    Item(name: "Radar & PWS", complement: "On & Auto"),
                    Item(name: "Eng Model Sel", complement: ""),
                    Item(name: "Ecam Memo T.O no Blue", complement: ""),
                ]),
                Section(name: "Lineup", items: [
                    Item(name: "T.O RWY", complement: "(both)"),
                    Item(name: "TCAS", complement: ""),
                    Item(name: "Pack 1 & 2", complement: ""),
                ]),
                Section(name: "Approach", items: [
                    Item(name: "Baro Ref", complement: "(both)"),
                    Item(name: "Seat Belts", complement: ""),
                    Item(name: "Minimun", complement: ""),
                    Item(name: "Auto Brake", complement: ""),
                    Item(name: "Eng Mode Sel", complement: ""),
                ]),
                Section(name: "Landing", items: [
                    Item(name: "Go Around Alt", complement: "FT Set"),
                    Item(name: "Cabin Crew", complement: "advised"),
                    Item(name: "Ecam Memo LDG no Blue", complement: "")
                ]),
                Section(name: "After Landing", items: [
                    Item(name: "Radar & PWS", complement: "")
                ]),
                Section(name: "Parking", items: [
                    Item(name: "Park BRK or Chocks", complement: ""),
                    Item(name: "Engines", complement: ""),
                    Item(name: "Wing Lights", complement: ""),
                    Item(name: "Fuel Pumps", complement: ""),
                ]),
                Section(name: "Securing the Aircraft", items: [
                    Item(name: "Oxygen", complement: ""),
                    Item(name: "Emer Exit LT", complement: ""),
                    Item(name: "EFBs", complement: ""),
                    Item(name: "Batteries", complement: ""),
                ])
            ]
        case .boeing:
            self.sections = [
                Section(name: "Pre Flight", items: [
                    Item(name: "Parking Brakes", complement: ""),
                    Item(name: "Battery Switch", complement: "KG/LB"),
                    Item(name: "APU Generator", complement: ""),
                    Item(name: "APU Master Knob", complement: ""),
                    Item(name: "External Power", complement: "(both)")
                ]),
                Section(name: "Cockpit Preparation", items: [
                    Item(name: "Gear Pins % Covers", complement: ""),
                    Item(name: "Fuel Quantitty", complement: "KG/LB"),
                    Item(name: "Seat Belts", complement: ""),
                    Item(name: "Adirs to NAV", complement: ""),
                    Item(name: "Baro Ref", complement: "(both)")
                ]),
            ]
            //                                                                  "Landing Gear",
            //                                                                  "Flaps Lever",
            //                                                                  "Speedbrakes Lever",
            //                                                                  "Engine Pump Controls",
            //                                                                  "Fuel Pump Switches",
            //                                                                  "Engine Instruments",
            //                                                                  "Anti-Ice Controls",
            //                                                                  "Window Heating",
            //                                                                  "Altitude Setting",
            //                                                                  "IFR Clearance",
            //                                                                  "Fuel Quantity",
            //                                                                  "Beacon Lighting"]))
            //            self.items.append(ChecklistModel.init(checklistType: "Before Startup",
            //                                                  checklistItem: ["Seat belt sign",
            //                                                                  "Fuel quantity",
            //                                                                  "Engine throttle",
            //                                                                  "Engine area",
            //                                                                  "Auto-Breake setting"]))
            //            self.items.append(ChecklistModel.init(checklistType: "Engine Startup",
            //                                                  checklistItem: ["APU Master Knob Start",
            //                                                                  "APU Generator",
            //                                                                  "Engine EEC Modes",
            //                                                                  "Engine Starter Knob",
            //                                                                  "Engine Fuel Controls",
            //                                                                  "Engine Generators L1, R1",
            //                                                                  "APU Master Knob",
            //                                                                  "APU Generator",
            //                                                                  "External Power",
            //                                                                  "Auto-Breake setting"]))
            //            self.items.append(ChecklistModel.init(checklistType: "Before Taxi",
            //                                                  checklistItem: ["Parking Brakes",
            //                                                                  "Fuel Quantity",
            //                                                                  "Taxi Lights",
            //                                                                  "Navigation Lights",
            //                                                                  "Instrument Displays",
            //                                                                  "Taxi Clearence"]))
            //            self.items.append(ChecklistModel.init(checklistType: "Taxi",
            //                                                  checklistItem: ["Flight Directors",
            ////                                                                  "Parking Brakes"]))
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

extension ChecklistViewController {
    func setupHierarchy() {
        view.addSubview(self.checklistTable)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            view.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        self.checklistTable.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.checklistTable.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24.0),
            self.checklistTable.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            self.checklistTable.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -12.0),
            self.checklistTable.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension ChecklistViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].collapsed ? 0 : sections[section].items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: CollapsibleTableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell") as? CollapsibleTableViewCell ??
        CollapsibleTableViewCell(style: .default, reuseIdentifier: "cell")
        
        let item: Item = sections[indexPath.section].items[indexPath.row]
        
        cell.nameLabel.text = item.name
        cell.detailLabel.text = item.complement
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.backgroundColor = UIColor(named: "lightBlue")
        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.backgroundColor = .white
        tableView.cellForRow(at: indexPath)?.accessoryType = .none
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section].name
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "header") as? CollapsibleTableViewHeader ?? CollapsibleTableViewHeader(reuseIdentifier: "header")
        
        header.titleLabel.text = sections[section].name
        header.arrowLabel.text = ">"
        header.setCollapsed(sections[section].collapsed)
        
        header.section = section
        header.delegate = self
        
        return header
    }
}

extension ChecklistViewController: CollapsibleTableViewHeaderDelegate {
    
    func toggleSection(_ header: CollapsibleTableViewHeader, section: Int) {
        let collapsed = !sections[section].collapsed
        
        // Toggle collapse
        sections[section].collapsed = collapsed
        header.setCollapsed(collapsed)
        
        checklistTable.reloadSections(NSIndexSet(index: section) as IndexSet, with: .automatic)
    }
    
}
