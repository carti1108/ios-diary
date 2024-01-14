//
//  DiaryDetailViewController.swift
//  Diary
//
//  Created by Kiseok on 2024/01/03.
//

import UIKit

final class DiaryDetailViewController: UIViewController {
    private let textView = UITextView()
    private var diaryDetail: Diary = .init(
        title: "",
        body: "",
        createdAt: Date(),
        id: UUID()
    )
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        textView.keyboardDismissMode = .interactive
    }
    
    func forwardingDiaryData(diary: Diary) {
        diaryDetail = diary
    }
}

extension DiaryDetailViewController {
    private func configureUI() {
        self.view.addSubview(textView)
        
        textView.text = (diaryDetail.title) + "\n\n" + (diaryDetail.body)
        
        navigationItemInit()
        autoLayoutInit()
    }
    
    private func navigationItemInit() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy년 MM월 dd일"
        
        let title = diaryDetail.createdAt
        
        self.navigationItem.title = dateFormatter.string(from: title)
    }
    
    private func autoLayoutInit() {
        textView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            textView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            textView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            textView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            self.view.keyboardLayoutGuide.topAnchor.constraint(equalTo: textView.bottomAnchor)
        ])
    }
}
