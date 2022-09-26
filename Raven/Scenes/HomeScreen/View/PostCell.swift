//
//  PostCell.swift
//  Raven
//
//  Created by Jorge Torres on 25/09/22.
//

import UIKit
import RxSwift

class PostCell: UITableViewCell {
    static let cellID = "PostCell"

    private lazy var disposeBag = DisposeBag()//improve this by moving to DI

    //MARK: View
    private lazy var postTitleLabel: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.numberOfLines = 2
        lbl.font = UIFont.boldSystemFont(ofSize: 16)
        lbl.textAlignment = .natural
        lbl.translatesAutoresizingMaskIntoConstraints = false

        return lbl
    }()

    private lazy var postFooterLeftLabel: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.numberOfLines = 1
        lbl.font = UIFont.systemFont(ofSize: 16)
        lbl.textAlignment = .natural
        lbl.translatesAutoresizingMaskIntoConstraints = false

        return lbl
    }()

    private lazy var postFooterMidLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = " - "
        lbl.textColor = .black
        lbl.numberOfLines = 1
        lbl.font = UIFont.systemFont(ofSize: 16)
        lbl.textAlignment = .natural
        lbl.translatesAutoresizingMaskIntoConstraints = false

        return lbl
    }()

    private lazy var postFooterRightLabel: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.numberOfLines = 1
        lbl.font = UIFont.systemFont(ofSize: 16)
        lbl.textAlignment = .natural
        lbl.translatesAutoresizingMaskIntoConstraints = false

        return lbl
    }()

    private lazy var contentContainerView: UIStackView = {
        let footerStack = UIStackView(arrangedSubviews: [postFooterLeftLabel, postFooterMidLabel, postFooterRightLabel, UIView()])
        footerStack.axis = .horizontal
        let container = UIStackView(arrangedSubviews: [postTitleLabel, footerStack])
        container.axis = .vertical
        container.backgroundColor = .clear
        container.spacing = 8
        container.translatesAutoresizingMaskIntoConstraints = false

        return container
    }()

    //MARK: Model
    private var model : PostVM? {
        didSet {
            guard let post = model  else { return }
            postTitleLabel.text = post.dislplayTitle
            postFooterLeftLabel.text = post.author
            // TODOD: improve this listener by the minimum metric accoirding to his time: every second, or minute, or hour
            Observable<Int>.interval(.milliseconds(300), scheduler: MainScheduler.instance)
                .subscribe(onNext: { _ in
                    DispatchQueue.main.async { [weak self] in
                        self?.postFooterRightLabel.text = post.fixedDate
                    }
                })
                .disposed(by: disposeBag)
            
        }
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        backgroundColor = .clear
        contentView.addSubview(contentContainerView)

        NSLayoutConstraint.activate([
            contentContainerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            contentContainerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            contentContainerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
            contentContainerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
        ])

    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: false)
    }

    func configure(using data: PostVM) {
        model = data
        accessibilityIdentifier = String(format: "%@-%x", PostCell.cellID, data.hashValue)
    }
}
