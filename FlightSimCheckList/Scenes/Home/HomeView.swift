//
//  HomeView.swift
//  FlightSimCheckList
//
//  Created by Tabita Barbosa on 07/11/23.
//

import Foundation
import UIKit

protocol HomeViewDelegate: AnyObject {
    func didTapOpenChecklist(type: ManufacturersType)
}

class HomeView: UIView {
    weak var delegate: HomeViewDelegate?
    private var viewModel: HomeViewModel
    
    private let darkBlueColor = UIColor(named: "darkBlue")
    private let lightBlueColor = UIColor(named: "lightBlue")
    
    private var manufacturersArray = ["Airbus", "Boeing"]
    private var modelsArray: [String] = []
    
    private var choosedManufacturer = String()
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
    
    // MARK: VIEW COMPONENTS
    
    private lazy var contentStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fill
        stack.spacing = 10
        return stack
    }()
    
    private lazy var titleManufacturers: UILabel = {
        let label = UILabel()
        label.text = "Escolha abaixo para visualizar o checklist \n"
        label.font = UIFont.boldSystemFont(ofSize: 18.0)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Faça o checklist do seu voo!"
        label.font = UIFont.systemFont(ofSize: 18.0)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    // MARK: PICKER VIEW
    private lazy var manufacturersHelperLabel: UILabel = {
        let label = UILabel()
        label.text = "fabricante:"
        label.font = UIFont.systemFont(ofSize: 16.0)
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    private lazy var manufacturersTextField: UITextField = {
        let field = UITextField()
        field.backgroundColor = .systemGray4
        field.borderStyle = .roundedRect
        field.placeholder = "clique para selecionar"
        field.text = manufacturersArray.first(where: { manufacturer in
            return manufacturer == choosedManufacturer
        })
        return field
    }()
    
    private lazy var manufacturersPicker: UIPickerView = {
        let picker = UIPickerView()
        return picker
    }()
    
    private lazy var modelsHelperLabel: UILabel = {
        let label = UILabel()
        label.text = "modelo:"
        label.font = UIFont.systemFont(ofSize: 16.0)
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    private lazy var modelsTextField: UITextField = {
        let field = UITextField()
        field.backgroundColor = .systemGray4
        field.borderStyle = .roundedRect
        field.isEnabled = false
        field.placeholder = "clique para selecionar"
        field.text = modelsArray.first(where: { model in
            return model == choosedModel
        })
        return field
    }()
    
    private lazy var modelsPicker: UIPickerView = {
        let picker = UIPickerView()
        return picker
    }()
    
    private func setupDropdown() {
        manufacturersTextField.inputView = manufacturersPicker
        manufacturersPicker.delegate = self
        manufacturersPicker.dataSource = self
        
        modelsTextField.inputView = modelsPicker
        modelsPicker.delegate = self
        modelsPicker.dataSource = self
    }
    
    private func getModels(manufacturer: String) -> [String] {
        if manufacturer == "Airbus" {
            modelsArray = ["A320", "A321"]
        } else if manufacturer == "Boeing" {
            modelsArray = ["737 MAX", "777"]
        }
        
        return modelsArray
    }
    
    @objc
    private func dismissPickerView() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let btnDone = UIBarButtonItem(title: "ok",
                                      style: .done,
                                      target: self,
                                      action: #selector(self.dismissKeyboard))
        let spacebutton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolbar.setItems([spacebutton, btnDone], animated: true)
        toolbar.isUserInteractionEnabled = true
        self.manufacturersTextField.inputAccessoryView = toolbar
        self.modelsTextField.inputAccessoryView = toolbar
    }
    
    @objc
    private func dismissKeyboard() {
        self.endEditing(true)
    }
    
    // MARK: BUTTON
    
    private lazy var chooseChecklistButton: UIButton = {
        let button = UIButton()
        button.setTitle("visualizar checklist", for: .normal)
        button.backgroundColor = darkBlueColor
        button.layer.cornerRadius = 8
        button.layer.borderWidth = 0.5
        button.setTitleColor(lightBlueColor, for: .selected)
        button.addTarget(self, action:#selector(self.didTapOpenChecklist), for: .touchUpInside)
        return button
    }()
    
    @objc
    private func didTapOpenChecklist() {
        self.delegate?.didTapOpenChecklist(type: validateType())
    }
 
    private func validateType() -> ManufacturersType {
        if self.choosedManufacturer == "Airbus" {
            return .airbus
        } else {
            return .boeing
        }
    }
}

extension HomeView {
    func setupHierarchy() {
        self.addSubview(self.contentStack)
        self.contentStack.addArrangedSubview(self.descriptionLabel)
        self.contentStack.addArrangedSubview(self.titleManufacturers)
        self.contentStack.addArrangedSubview(self.manufacturersHelperLabel)
        self.contentStack.addArrangedSubview(self.manufacturersTextField)
        self.contentStack.addArrangedSubview(self.modelsHelperLabel)
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
        if pickerView == manufacturersPicker {
            return manufacturersArray.count
        } else {
            return modelsArray.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == manufacturersPicker {
            return manufacturersArray[row]
        } else if pickerView == modelsPicker {
            return modelsArray[row]
        }
        return manufacturersArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == manufacturersPicker {
            manufacturersTextField.text = manufacturersArray[row]
            choosedManufacturer = manufacturersArray[row]
            dismissKeyboard()
            modelsTextField.isEnabled = true
            getModels(manufacturer: manufacturersArray[row])
        } else if pickerView == modelsPicker {
            modelsTextField.text = modelsArray[row]
            choosedModel = modelsArray[row]
            dismissKeyboard()
        }
    }
}
