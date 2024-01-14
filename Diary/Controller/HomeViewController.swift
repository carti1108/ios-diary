//
//  Diary - ViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit

enum Section {
    case main
}

final class HomeViewController: UIViewController {
    private let tableView = UITableView()
    private var diaryData: [Diary] = Diary.sampleData
    private var dataSource: UITableViewDiffableDataSource<Section, Diary>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        dataSource = UITableViewDiffableDataSource(tableView: tableView, cellProvider: { tableView, indexPath, itemIdentifier in
            guard let cell = tableView.dequeueReusableCell(withIdentifier: DiaryItemCell.reuseIdentifier) as? DiaryItemCell else {
                return UITableViewCell()
            }
            
            guard let diaryData = self.diaryData[safe: indexPath.row] else {
                return UITableViewCell()
            }
            
            cell.configure(with: diaryData)
            
            return cell
        })
        updateSnapshot()
        configureUI()
        autoLayoutInit()
    }
    
    private func updateSnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Diary>()
        snapshot.appendSections([.main])
        snapshot.appendItems(
            diaryData,
            toSection: .main
        )
        
        dataSource?.apply(snapshot)
    }
    
    @objc private func touchUpPlusButton() {
        let diaryDetailViewController = DiaryDetailViewController()
        let newDiary: Diary = .init(
            title: "",
            body: "",
            createdAt: Date(),
            id: UUID()
        )
        diaryData.append(newDiary)
        updateSnapshot()
        diaryDetailViewController.forwardingDiaryData(diary: newDiary)
        
        self.navigationController?.pushViewController(
            diaryDetailViewController,
            animated: true
        )
    }
}

extension HomeViewController {
    private func configureUI() {
        navigationItemInit()
        tableInit()
        autoLayoutInit()
    }
    
    private func navigationItemInit() {
        let rightItemButton = UIBarButtonItem(
            image: UIImage(systemName: "plus"),
            style: .plain,
            target: self,
            action: #selector(touchUpPlusButton)
        )
        
        self.navigationItem.title = "일기장"
        self.navigationItem.rightBarButtonItem = rightItemButton
    }
    
    private func tableInit() {
        tableView.register(
            DiaryItemCell.self,
            forCellReuseIdentifier: DiaryItemCell.reuseIdentifier
        )
        
        self.view.addSubview(tableView)
    }
    
    private func autoLayoutInit() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let diaryDetailViewController = DiaryDetailViewController()
        diaryDetailViewController.forwardingDiaryData(diary: diaryData[indexPath.row])
        
        self.navigationController?.pushViewController(
            diaryDetailViewController,
            animated: true
        )
    }
}

extension HomeViewController {
    func saveCoreData() {
        
    }
}
