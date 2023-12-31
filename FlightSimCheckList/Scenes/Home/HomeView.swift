//
//  HomeView.swift
//  FlightSimCheckList
//
//  Created by Tabita Barbosa on 07/11/23.
//

import Foundation
import UIKit

protocol HomeViewDelegate: AnyObject {
    func didTapOpenChecklist(type: ManufacturersType, modelName: String)
}

class HomeView: UIView {
    weak var delegate: HomeViewDelegate?
    private var viewModel: HomeViewModel
    
    private let mediumPurpleColor = UIColor(named: "mediumPurple")
    
    private var manufacturersArray = ["Airbus", "Boeing"]
    private var modelsArray: [String] = []
    
    private var choosedManufacturer = String()
    private var choosedModel = String()
    
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
        let tapLink = UITapGestureRecognizer(target: self, action: #selector(self.onClicLabel(sender:)))
        titleManufacturers.isUserInteractionEnabled = true
        titleManufacturers.addGestureRecognizer(tapLink)
    }
    
    // MARK: VIEW COMPONENTS
    
    private lazy var upperContent: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .equalSpacing
        stack.spacing = 20
        return stack
    }()
    
    private lazy var middleContent: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .equalSpacing
        stack.spacing = 10
        return stack
    }()
    
    private lazy var lowerContent: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .equalSpacing
        stack.spacing = 100
        return stack
    }()
    
    private lazy var titleManufacturers: UILabel = {
        let label = UILabel()
        label.text = "Fligh Simulator Checklist"
        label.font = UIFont.boldSystemFont(ofSize: 20.0)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "faça o checklist do seu voo!"
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
            modelsArray = ["A320"]
        } else if manufacturer == "Boeing" {
            modelsArray = ["737 Max"]
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
        button.backgroundColor = mediumPurpleColor
        button.layer.cornerRadius = 8
        button.layer.borderWidth = 0.5
        button.addTarget(self, action:#selector(self.didTapOpenChecklist), for: .touchUpInside)
        return button
    }()
    
    @objc
    private func didTapOpenChecklist() {
        self.delegate?.didTapOpenChecklist(type: validateType(), modelName: choosedModel)
    }
 
    private func validateType() -> ManufacturersType {
        if self.choosedManufacturer == "Airbus" {
            return .airbus
        } else {
            return .boeing
        }
    }
    
    // MARK: contributions
    private lazy var infosLink: UILabel = {
        let label = UILabel()
        let attributedString = NSMutableAttributedString(string: "para informações sobre o projeto acesse: FlightSimCheckList no Github.")
        attributedString.addAttribute(.link, value: "https://github.com/tabita-barbosa/FlightSimCheckList.git", range: NSRange(location: 41, length: 18))
        label.attributedText = attributedString
        label.font = UIFont.systemFont(ofSize: 16)
        label.numberOfLines = 0
        label.textAlignment = .natural
        return label
    }()
    
    @objc
    private func onClicLabel(sender:UITapGestureRecognizer) {
        openUrl(urlString: "https://github.com/tabita-barbosa/FlightSimCheckList.git")
    }

    private func openUrl(urlString:String!) {
        let url = URL(string: urlString)!
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url)
        }
    }
}

extension HomeView {
    func setupHierarchy() {
        self.addSubview(self.upperContent)
        self.addSubview(self.middleContent)
        self.addSubview(self.lowerContent)
        self.upperContent.addArrangedSubview(self.titleManufacturers)
        self.upperContent.addArrangedSubview(self.descriptionLabel)
        self.middleContent.addArrangedSubview(self.manufacturersHelperLabel)
        self.middleContent.addArrangedSubview(self.manufacturersTextField)
        self.middleContent.addArrangedSubview(self.modelsHelperLabel)
        self.middleContent.addArrangedSubview(self.modelsTextField)
        self.lowerContent.addArrangedSubview(self.chooseChecklistButton)
        self.lowerContent.addArrangedSubview(self.infosLink)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            self.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        self.upperContent.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            upperContent.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 24),
            upperContent.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 24.0),
            upperContent.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -24.0)
        ])
        
        self.middleContent.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            middleContent.topAnchor.constraint(equalTo: self.upperContent.bottomAnchor, constant: 24),
            middleContent.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 24.0),
            middleContent.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -24.0)
        ])
        
        self.lowerContent.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            lowerContent.topAnchor.constraint(equalTo: self.middleContent.bottomAnchor, constant: 24),
            lowerContent.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 24.0),
            lowerContent.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -24.0)
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
            modelsTextField.isEnabled = true
            getModels(manufacturer: manufacturersArray[row])
        } else if pickerView == modelsPicker {
            modelsTextField.text = modelsArray[row]
            choosedModel = modelsArray[row]
        }
    }
}
