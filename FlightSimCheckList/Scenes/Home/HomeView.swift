//
//  HomeView.swift
//  FlightSimCheckList
//
//  Created by Tabita Barbosa on 07/11/23.
//

import Foundation
import UIKit

protocol HomeViewDelegate: AnyObject {
    func didTapOpenChecklist()
}

class HomeView: UIView, HomeViewModelProtocol {
    weak var delegate: HomeViewDelegate?
    private var viewModel: HomeViewModel
    
    private let darkBlueColor = UIColor(named: "darkBlue")
    private let lightBlueColor = UIColor(named: "lightBlue")
    private var manufacturersArray: [ManufacturersModel] = []
    private var modelsArray: [AirplaneModel] = []
    private var choosedManufacturer: ManufacturersType = .airbus
    private var choosedModel = String()
    private var type: ChecklistType?
    
    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
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
        self.setupDropdown()
        self.dismissPickerView()
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        self.addGestureRecognizer(tap)
    }
    
    func updateManufacturers(manufacturers: [ManufacturersModel] ) {
        self.manufacturersArray = manufacturers
        self.manufacturersPicker.reloadAllComponents()
    }
    
    func updateModels(models: [AirplaneModel]) {
        self.modelsArray = models
        self.modelsPicker.reloadAllComponents()
    }
    
    // MARK: VIEW COMPONENTS
    
    private lazy var contentStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
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
    
    // MARK: PICKER VIEW
    lazy var manufacturersTextField: UITextField = {
        let field = UITextField()
        field.backgroundColor = .systemGray
        field.borderStyle = .roundedRect
        return field
    }()
    
    lazy var manufacturersPicker: UIPickerView = {
        let picker = UIPickerView()
        return picker
    }()
    
    lazy var modelsTextField: UITextField = {
        let field = UITextField()
        field.backgroundColor = .systemGray
        field.borderStyle = .roundedRect
        return field
    }()
    
    lazy var modelsPicker: UIPickerView = {
        let picker = UIPickerView()
        return picker
    }()
    
    private func setupDropdown() {
        manufacturersTextField.inputView = manufacturersPicker
        manufacturersPicker.delegate = self
        manufacturersPicker.dataSource = self
        
        modelsTextField.inputView = modelsPicker
        manufacturersPicker.delegate = self
        manufacturersPicker.dataSource = self
    }
    
    @objc
    private func dismissPickerView() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let btnDone = UIBarButtonItem(title: "fechar",
                                      style: .done,
                                      target: self,
                                      action: #selector(self.dismissKeyboard))
        let btnPrevious = UIBarButtonItem(title: "<",
                                          style: .done,
                                          target: self,
                                          action: #selector(self.dismissKeyboard))
        let btnNext = UIBarButtonItem(title: ">",
                                      style: .done,
                                      target: self,
                                      action: #selector(self.dismissKeyboard))
        
        let spacebutton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        
        toolbar.setItems([btnPrevious, btnNext, spacebutton, btnDone], animated: true)
        toolbar.isUserInteractionEnabled = true
        self.manufacturersTextField.inputAccessoryView = toolbar
        self.modelsTextField.inputAccessoryView = toolbar
    }
    
    @objc
    private func dismissKeyboard() {
        self.endEditing(true)
    }
    
    // MARK: BUTTON
    
    lazy var chooseChecklistButton: UIButton = {
        let button = UIButton()
        button.setTitle("selecionar modelo", for: .normal)
        button.backgroundColor = darkBlueColor
        button.layer.cornerRadius = 8
        button.layer.borderWidth = 0.5
        button.setTitleColor(lightBlueColor, for: .selected)
        button.addTarget(self, action:#selector(self.didTapOpenChecklist), for: .touchUpInside)
        return button
    }()
    
    @objc
    func didTapOpenChecklist() {
        self.delegate?.didTapOpenChecklist()
        // choosedManufacturer
    }
    
}

extension HomeView {
    func setupHierarchy() {
        self.addSubview(self.contentStack)
        self.contentStack.addArrangedSubview(self.descriptionLabel)
        self.contentStack.addArrangedSubview(self.titleManufacturers)
        self.contentStack.addArrangedSubview(self.manufacturersTextField)
        self.contentStack.addArrangedSubview(self.modelsTextField)
        self.contentStack.addArrangedSubview(self.chooseChecklistButton)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            self.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        self.contentStack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentStack.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            contentStack.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            contentStack.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 24.0),
            contentStack.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -24.0)
        ])
    }
}

extension HomeView: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        let array = ["Airbus", "boeing"]
        if pickerView == manufacturersPicker {
            return array.count
        } else {
            return array.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let array = ["Airbus", "Boeing"]
        if pickerView == manufacturersPicker {
            let row = array[row]
            return row
            //        } else if pickerView == modelsPicker {
            //            let row = modelsArray[row]
            //            return row
        }
        let row = array[row]
        return row
    }
}
