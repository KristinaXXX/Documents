//
//  SettingsViewController.swift
//  My documents
//
//  Created by Kr Qqq on 30.10.2023.
//

import UIKit

class SettingsViewController: UIViewController, SettingsViewControllerDelegate {
    
    private let viewModel: SettingsViewModel
    
    private lazy var settingsTableView: UITableView = {
        let tableView = UITableView(
            frame: .zero,
            style: .grouped
        )
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(SettingsTableViewCell.self, forCellReuseIdentifier: SettingsTableViewCell.id)
        tableView.backgroundColor = .white
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableView.automaticDimension

        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = 0.0
        }
        return tableView
    }()
    
    init(viewModel: SettingsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        addSubviews()
        setupConstraints()
    }
    
    private func setupView() {
        view.backgroundColor = .white
        title = "Настройки"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func addSubviews() {
        view.addSubview(settingsTableView)
    }
    
    func setupConstraints() {
        
        let safeAreaLayoutGuide = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            settingsTableView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            settingsTableView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            settingsTableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            settingsTableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    func updateSetting(_ setting: Settings) {
        viewModel.updateSetting(setting)
    }

}

extension SettingsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return viewModel.countSettings()
        case 1:
            return viewModel.countSequeSettings()
        default:
            return 0
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

}

extension SettingsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: SettingsTableViewCell.id, for: indexPath) as! SettingsTableViewCell
            cell.delegate = self
            cell.update(viewModel.setting(at: indexPath.row))
            return cell
            
        case 1:
            let cell = UITableViewCell()
            var content = cell.defaultContentConfiguration()
            let contentCell = viewModel.sequeSetting(at: indexPath.row)
            content.text = contentCell.title
            cell.contentConfiguration = content
            cell.accessoryType = .disclosureIndicator
            return cell
            
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            tableView.deselectRow(at: indexPath, animated: false)
        case 1:
            viewModel.sequeAction(at: indexPath.row)
            tableView.deselectRow(at: indexPath, animated: false)
        default:
            return
        }
        
    }
}

protocol SettingsViewControllerDelegate: AnyObject {
    func updateSetting(_ setting: Settings)
}
