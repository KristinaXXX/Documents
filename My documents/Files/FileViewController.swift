//
//  ViewController.swift
//  My documents
//
//  Created by Kr Qqq on 28.10.2023.
//

import UIKit

class FileViewController: UIViewController {

    private let viewModel: FileViewModel
    private let fileManagerService: FileManagerService
    private var needShowFileSize: Bool = false
    private lazy var filesTableView: UITableView = {
        let tableView = UITableView(
            frame: .zero
        )
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .white
        return tableView
    }()
    
    private lazy var imagePicker: ImagePicker = {
            let imagePicker = ImagePicker()
            imagePicker.delegate = self
            return imagePicker
        }()
    
    private lazy var addFolderBarButtonItem: UIBarButtonItem = {
        return createTabButton(imageName: "folder.badge.plus", selector: #selector(addFolderPressed))
    }()
    
    private lazy var addImageBarButtonItem: UIBarButtonItem = {
        return createTabButton(imageName: "plus", selector: #selector(addImagePressed))
    }()
    
    init(viewModel: FileViewModel) {
        fileManagerService = FileManagerService()
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        title = "Documents"
    }
    
    init(viewModel: FileViewModel, fileManagerService: FileManagerService) {
        self.viewModel = viewModel
        self.fileManagerService = fileManagerService
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
    
    override func viewWillAppear(_ animated: Bool) {
        fileManagerService.loadContents()
        needShowFileSize = fileManagerService.needShowFileSize()
        filesTableView.reloadData()
    }
    
    private func addSubviews() {
        view.addSubview(filesTableView)
    }
    
    func setupConstraints() {

        let safeAreaLayoutGuide = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            filesTableView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            filesTableView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            filesTableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            filesTableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func setupView() {
        navigationItem.rightBarButtonItems = [addImageBarButtonItem, addFolderBarButtonItem]
        view.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    @objc private func addFolderPressed() {

        let alert = UIAlertController(title: "Create new folder", message: nil, preferredStyle: .alert)
        alert.addTextField()
        alert.textFields![0].placeholder = "Folder name"
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alert.addAction(UIAlertAction(title: "Create", style: .default, handler: { [weak self] _ in
            self?.fileManagerService.createDirectory(name: alert.textFields![0].text ?? "New folder")
            self?.filesTableView.reloadData()
        }))
        self.present(alert, animated: true)

    }
    
    @objc private func addImagePressed() {
        imagePicker.photoGalleryAsscessRequest()
    }
}

extension FileViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fileManagerService.contentsOfDirectory().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell()
        var content = cell.defaultContentConfiguration()
        let contentFile = fileManagerService.contentsOfDirectory()[indexPath.row]
        content.text = contentFile.name
        if needShowFileSize {
            content.secondaryText = contentFile.size
        }
        cell.contentConfiguration = content
        cell.accessoryType = (contentFile.type == .folder) ? .disclosureIndicator : .none
        return cell
        
    }
}

extension FileViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let contentFile = fileManagerService.contentsOfDirectory()[indexPath.row]
        switch contentFile.type {
        case .folder:
            let fileManagerService = FileManagerService(pathForFolder: fileManagerService.getPath(at: indexPath.row))
            let nextViewController = FileViewController(viewModel: viewModel, fileManagerService: fileManagerService)
            nextViewController.title = contentFile.name
            navigationController?.pushViewController(nextViewController, animated: true)
           
        default:
            ()
        }
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            fileManagerService.removeContent(at: indexPath.row)
            tableView.reloadData()
        }
    }
}

extension FileViewController: ImagePickerDelegate {

    func imagePicker(_ imagePicker: ImagePicker, didSelect image: UIImage) {
        imagePicker.dismiss()
        fileManagerService.createFile(image: image)
        filesTableView.reloadData()
    }

    func cancelButtonDidClick(on imageView: ImagePicker) { imagePicker.dismiss() }
    func imagePicker(_ imagePicker: ImagePicker, grantedAccess: Bool, to sourceType: UIImagePickerController.SourceType) {
        guard grantedAccess else { return }
        imagePicker.present(parent: self, sourceType: sourceType)
    }
}

