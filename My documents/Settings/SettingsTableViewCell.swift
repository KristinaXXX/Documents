//
//  SettingsTableViewCell.swift
//  My documents
//
//  Created by Kr Qqq on 31.10.2023.
//

import UIKit

class SettingsTableViewCell: UITableViewCell {

    static let id = "SettingsTableViewCell"
    private var setting: Settings?
    weak var delegate: SettingsViewControllerDelegate?
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.body)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        return label
    }()
    
    private lazy var typeSwitch: UISwitch = {
        let typeSwitch = UISwitch()
        typeSwitch.isUserInteractionEnabled = true
        typeSwitch.translatesAutoresizingMaskIntoConstraints = false
        typeSwitch.addTarget(self, action: #selector(didEditTypeSwitch), for: .valueChanged)

        return typeSwitch
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        addSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        contentView.addSubview(nameLabel)
        contentView.addSubview(typeSwitch)        
    }
    
    func setupConstraints() {
        
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            nameLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        ])
        
        NSLayoutConstraint.activate([
            typeSwitch.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: 16),
            typeSwitch.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            typeSwitch.centerYAnchor.constraint(equalTo: nameLabel.centerYAnchor)
        ])
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.accessoryType = .none
    }
    
    func update(_ setting: Settings) {
        self.setting = setting
        nameLabel.text = setting.title
        typeSwitch.isOn = setting.enabled
    }
    
    @objc private func didEditTypeSwitch() {
        setting?.enabled = typeSwitch.isOn
        delegate?.updateSetting(setting!)
    }
}
