//
//  HomeScreenVC.swift
//  Raven
//
//  Created by Jorge Torres on 25/09/22.
//

import UIKit

class HomeScreenVC: UIViewController {

    // MARK: - Properties
    enum TableSection {
        case postSection
    }

    private var dataSource: HomeTableDataSource?
    private var posts: [PostVM] = [PostVM]()

    // MARK: - UI Def
    private(set) lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.layer.zPosition = -1
        refreshControl.addTarget(self, action: #selector(reloadDataAction), for: .valueChanged)

        return refreshControl
    }()

    private(set) lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(PostCell.self, forCellReuseIdentifier: PostCell.cellID)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        view.addSubview(tableView)

        return tableView
    }()

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
    }

    // MARK: - UI setup
    func setView() {
        tableView.refreshControl = refreshControl
        tableView.separatorStyle = .singleLine

        tableView.delegate = self
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.heightAnchor.constraint(equalTo: view.heightAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
        ])

        dataSource = HomeTableDataSource(tableView: tableView, cellProvider: { [weak self] tableView, indexPath, model -> UITableViewCell? in
            guard let _ = self else { return UITableViewCell() }
            guard let cell = tableView.dequeueReusableCell(withIdentifier: PostCell.cellID, for: indexPath) as? PostCell else { return UITableViewCell() }
            cell.configure(using: model)

            return cell
        })
        dataSource?.delegate = self
    }


    func updateDatasource(insertData: [PostVM]) {
        var snapshot = NSDiffableDataSourceSnapshot<TableSection, PostVM>()
        snapshot.appendSections([.postSection])
        snapshot.appendItems(insertData)
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.dataSource?.apply(snapshot, animatingDifferences: false)
        }
    }

    // MARK: - User events
    @objc func reloadDataAction(_ sender: Any) {
        self.refreshControl.endRefreshing()
    }

    func rowSelected(using model: PostVM) {
    }
}

// MARK: - HomeScreenVC Extensions
extension HomeScreenVC: UITableViewDelegate, BaseDiffableDataSourceDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        guard let data = dataSource?.itemIdentifier(for: indexPath) else {
            return
        }
        rowSelected(using: data)
    }
    
    @objc func saveModelDeleted(at indexPath: IndexPath) {
//        posts.remove(at: indexPath.row)
    }
}

protocol BaseDiffableDataSourceDelegate: AnyObject {
    func saveModelDeleted(at indexPath: IndexPath)
}

class HomeTableDataSource : UITableViewDiffableDataSource<HomeScreenVC.TableSection, PostVM> {

    weak var delegate: BaseDiffableDataSourceDelegate! = nil

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        super.tableView(tableView, commit: editingStyle, forRowAt: indexPath)
        guard editingStyle == .delete else {return}
//        guard let id = self.itemIdentifier(for: indexPath) else { return }
//        var snap = self.snapshot()
//        snap.deleteWithSections([id])
//        self.apply(snap)
        self.delegate.saveModelDeleted(at: indexPath)
    }
}

