//
//  DetailsViewController.swift
//  CRUDExampleApp
//
//  Created by dejan kraguljac on 02/01/2019.
//  Copyright © 2019 ReRoot. All rights reserved.
//

import UIKit
import Alamofire

enum DetailsType {
    case creation
    case editing
    
    var navTitle: String {
        switch self {
        case .creation:
            return "Dodavanje"
        case .editing:
            return "Izmjena"
        }
    }
}

final class DetailsViewController: ViewController {
    
    //MARK: Static labels
    
    private let staticIdLabel: UILabel = {
        
        let l = UILabel(frame: .zero)
        l.text = "ID: "
        l.font = UIFont.systemFont(ofSize: 12)
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    private let staticNameLabel: UILabel = {
        
        let l = UILabel(frame: .zero)
        l.font = UIFont.systemFont(ofSize: 12)
        l.text = "Ime: "
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    private let staticLastNameLabel: UILabel = {
        
        let l = UILabel(frame: .zero)
        l.font = UIFont.systemFont(ofSize: 12)
        l.text = "Prezime: "
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    private let staticEmailLabel: UILabel = {
        
        let l = UILabel(frame: .zero)
        l.font = UIFont.systemFont(ofSize: 12)
        l.text = "E-mail: "
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    private let staticPositionLabel: UILabel = {
        
        let l = UILabel(frame: .zero)
        l.font = UIFont.systemFont(ofSize: 12)
        l.text = "Uloga: "
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    private let staticLoginDateLabel: UILabel = {
        
        let l = UILabel(frame: .zero)
        l.font = UIFont.systemFont(ofSize: 12)
        l.text = "Zadnji login: "
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    //MARK: Properties
    
    private let idLabel: UILabel = {
        
        let t = UILabel(frame: .zero)
        t.translatesAutoresizingMaskIntoConstraints = false
        return t
    }()
    
    private let nameTextField: TextField = {
        
        let t = TextField(frame: .zero)
        t.returnKeyType = .done
        t.placeholder = "Ime "
       // t.borderStyle = .roundedRect
        t.translatesAutoresizingMaskIntoConstraints = false
        return t
    }()
    private let lastNameTextField: TextField = {
        
        let t = TextField(frame: .zero)
        t.returnKeyType = .done
        t.placeholder = "Prezime "
        t.translatesAutoresizingMaskIntoConstraints = false
        return t
    }()
    
    private let loginDateTextField: TextField = {
        
        let t = TextField(frame: .zero)
        t.returnKeyType = .done
        t.translatesAutoresizingMaskIntoConstraints = false
        return t
    }()
    
    private let emailTextField: TextField = {
        
        let t = TextField(frame: .zero)
        t.returnKeyType = .done
        t.placeholder = "E-mail "
        t.translatesAutoresizingMaskIntoConstraints = false
        return t
    }()
    
    private let positionTextField: TextField = {
        
        let t = TextField(frame: .zero)
        t.returnKeyType = .done
        t.placeholder = "Uloga "
        t.translatesAutoresizingMaskIntoConstraints = false
        return t
    }()
    
    private let stackView: UIStackView = {
       
        let s = UIStackView(frame: .zero)
        s.translatesAutoresizingMaskIntoConstraints = false
        s.backgroundColor = .white
        return s
        
    }()
    
    private let deleteButton: UIButton = {
       
        let b = UIButton(frame: .zero)
        b.translatesAutoresizingMaskIntoConstraints = false
        b.backgroundColor = UIColor.red
        b.layer.cornerRadius = 6.0
        b.clipsToBounds = true
        b.setTitle("Obriši", for: .normal)
        return b
    }()
    
    private let addButton: UIButton = {
        
        let b = UIButton(frame: .zero)
        b.translatesAutoresizingMaskIntoConstraints = false
        b.backgroundColor = UIColor.blue
        b.layer.cornerRadius = 6.0
        b.clipsToBounds = true
        b.setTitle("Dodaj", for: .normal)
        return b
    }()
    
    var doneActionHandler: (() -> Void)!
    
    var type: DetailsType = .editing
    var vm: StudentViewModel?
    var updatedVM: StudentViewModel?
    
    var isEditingMode: Bool = false {
        didSet {
            nameTextField.isUserInteractionEnabled = isEditingMode
            lastNameTextField.isUserInteractionEnabled = isEditingMode
            emailTextField.isUserInteractionEnabled = isEditingMode
            positionTextField.isUserInteractionEnabled = isEditingMode
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        isEditingMode = false
        title = self.type.navTitle
        self.loadViews()
    }
    
    
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    convenience init(viewModel: StudentViewModel, type: DetailsType = .editing, completion: @escaping (() -> Void)) {
        self.init(nibName: nil, bundle: nil)
        self.vm = viewModel
        self.updatedVM = viewModel
        self.doneActionHandler = completion
        self.type = type
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func loadViews() {
        view.addSubview(stackView)
        stackView.addArrangedSubview(staticIdLabel)
        stackView.addArrangedSubview(idLabel)
        stackView.addArrangedSubview(staticNameLabel)
        stackView.addArrangedSubview(nameTextField)
        stackView.addArrangedSubview(staticLastNameLabel)
        stackView.addArrangedSubview(lastNameTextField)
        stackView.addArrangedSubview(staticEmailLabel)
        stackView.addArrangedSubview(emailTextField)
        stackView.addArrangedSubview(staticPositionLabel)
        stackView.addArrangedSubview(positionTextField)
        stackView.addArrangedSubview(staticLoginDateLabel)
        stackView.addArrangedSubview(loginDateTextField)
        
        if type == .editing {
            addBarButtonItems()
            stackView.addArrangedSubview(deleteButton)
        } else {
            isEditingMode = true
            stackView.addArrangedSubview(addButton)
        }
        setupConstraints()
    }
    
    private func setupConstraints() {
        stackView.snp.makeConstraints { maker in
            maker.leading.equalTo(view.safeAreaLayoutGuide).offset(16)
            maker.trailing.equalTo(view.safeAreaLayoutGuide).offset(-16)
            maker.top.equalTo(view.safeAreaLayoutGuide).offset(16)
        }
        setupViews()
    }
    
    private func setupViews() {
        
        idLabel.text = vm?.id
        nameTextField.text = vm?.name
        nameTextField.delegate = self
        lastNameTextField.text = vm?.lastName
        lastNameTextField.delegate = self
        emailTextField.text = vm?.email
        emailTextField.delegate = self
        positionTextField.text = vm?.position
        positionTextField.delegate = self
        loginDateTextField.text = vm?.loginDate
        loginDateTextField.isUserInteractionEnabled = false
        
        loginDateTextField.isHidden = self.type != .editing
        staticLoginDateLabel.isHidden = self.type != .editing
        staticIdLabel.isHidden = self.type != .editing
        idLabel.isHidden = self.type != .editing
        deleteButton.isHidden = self.type != .editing
        
        view.backgroundColor = .white
        
        stackView.spacing = 8
        stackView.setCustomSpacing(16, after: idLabel)
        stackView.setCustomSpacing(16, after: nameTextField)
        stackView.setCustomSpacing(16, after: lastNameTextField)
        stackView.setCustomSpacing(16, after: emailTextField)
        stackView.setCustomSpacing(16, after: positionTextField)
        stackView.setCustomSpacing(16, after: loginDateTextField)
        
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.axis = .vertical
        
        deleteButton.addTarget(self, action: #selector(deleteButtonTapped(_:)), for: .touchUpInside)
        
        addButton.addTarget(self, action: #selector(addButtonTapped(_:)), for: .touchUpInside)
    }
    
    @objc func deleteButtonTapped(_ sender: UIButton) {
        
        self.resignAllResponders()
        if let v = updatedVM, let id = Int(v.id) {
            Alamofire.request(StudentRouter.delete(id: id)).responseJSON { [weak self] (response) in
                
                guard let self = self, let d = response.data else { return }
                
                if let dataString = String(data: d, encoding: String.Encoding.utf8), dataString == "OK" {
                    self.showAlert(title: "Wohooo", subtitle: "Upješno ste uklonili unos!")
                }
            }
        }
    }
    
    @objc func addButtonTapped(_ sender: UIButton) {
        self.resignAllResponders()
        if let v = updatedVM {
            Alamofire.request(StudentRouter.create(name: v.name, lastName: v.lastName, email: v.email, position: v.position)).responseJSON { [weak self] (response) in
                
                guard let self = self, let d = response.data else { return }
                
                if let dataString = String(data: d, encoding: String.Encoding.utf8), dataString == "OK" {
                    self.showAlert(title: "Wohooo", subtitle: "Upješno ste dodali unos!")
                }
            }
        }
    }
    
    private func resignAllResponders() {
        nameTextField.resignFirstResponder()
        lastNameTextField.resignFirstResponder()
        loginDateTextField.resignFirstResponder()
        emailTextField.resignFirstResponder()
        positionTextField.resignFirstResponder()
    }
}

extension DetailsViewController {
    
    private func addBarButtonItems() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(startEditing(sender:)))
    }
    
    @objc func startEditing(sender: UIBarButtonItem) {
        isEditingMode = true
        self.resignAllResponders()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(save(sender:)))
        
    }
    
    @objc func save(sender: UIBarButtonItem) {
        isEditingMode = false
        self.resignAllResponders()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(startEditing(sender:)))
        
        if let v = updatedVM, let id = Int(v.id), vm != updatedVM {
            Alamofire.request(StudentRouter.update(id: id, name: v.name, lastName: v.lastName, email: v.email, position: v.position)).responseJSON { [weak self] (response) in
                
                guard let self = self, let d = response.data else { return }
                
                if let dataString = String(data: d, encoding: String.Encoding.utf8), dataString == "OK" {
                    self.showAlert(title: "Wohooo", subtitle: "Uspješno ste promijenili unos")
                }
            }
        }
    }
    
    private func showAlert(title: String?, subtitle: String?) {
        
        let alert = UIAlertController(title: title, message: subtitle, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "woooot!?!?", style: .cancel, handler: {[weak self] _ in
            
            guard let self = self else { return }
            self.doneActionHandler?()
            
        }))
        self.present(alert, animated: true, completion: nil)
        
    }
    
}

extension DetailsViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if let t = textField.text {
            switch textField {
            case nameTextField:
                updatedVM?.name = t
            case lastNameTextField:
                updatedVM?.lastName = t
            case emailTextField:
                updatedVM?.email = t
            case positionTextField:
                updatedVM?.position = t
            default:
                print("nothing")
            }
        }
        
    }
}
