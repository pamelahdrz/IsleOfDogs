//
//  DogsCell.swift
//  Konfio Dogs
//
//  Created by Pamela Hernández on 16/11/23.
//

import UIKit
import SnapKit
import Kingfisher

protocol DogsTableViewCell {
    func configure(with data: DogsModel)
}

class DogsCell: UITableViewCell {
    
    static let id: String = "DogsCell.cell"
    
    private lazy var dogImage: UIImageView = {
        let image = UIImageView()
        image.clipsToBounds = true
        image.layer.cornerRadius = UIGeneral.cornerRadius
        image.backgroundColor = .systemGray4
        image.contentMode = .scaleToFill
        return image
    }()
    
    private lazy var dogName: UILabel = {
        let label = UILabel()
        label.numberOfLines = 10
        label.textColor = UIGeneral.black
        label.font = .boldSystemFont(ofSize: 20)
        label.adjustsFontForContentSizeCategory = true
        label.textAlignment = .left
        return label
    }()
    
    private lazy var dogDescription: UILabel = {
        let label = UILabel()
        label.numberOfLines = 10
        label.textColor = UIGeneral.gray
        label.font = .systemFont(ofSize: 13, weight: UIFont.Weight.regular)
        label.adjustsFontForContentSizeCategory = true
        label.textAlignment = .left
        return label
    }()
    
    private lazy var dogAge: UILabel = {
        let label = UILabel()
        label.numberOfLines = 10
        label.textColor = UIGeneral.black
        label.font = .systemFont(ofSize: 13, weight: UIFont.Weight.bold)
        label.textAlignment = .left
        return label
    }()
    
    override init(
        style: UITableViewCell.CellStyle,
        reuseIdentifier: String?
    ) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.isUserInteractionEnabled = true
        self.drawCellView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init not working")
    }
}

extension DogsCell: DogsTableViewCell {
    
    func configure(with data: DogsModel) {
        if let dogName = data.name, let dogDescription = data.description, let dogAge = data.age {
            self.dogName.text = dogName
            self.dogDescription.text = dogDescription
            self.dogAge.text = "Almost \(dogAge.toString) years"
        }
        
        if let url = data.imageURL {
            let resource = KF.ImageResource(downloadURL: url, cacheKey: url.cacheKey)
            self.dogImage.kf.indicatorType = .activity
            self.dogImage.kf
                .setImage(
                    with: resource,
                    options: [
                        .fromMemoryCacheOrRefresh,
                        .transition(.fade(UIGeneral.transitionDuration))
                    ])
        }
    }
    
    private func drawCellView() {
        
        let viewBack = UIView()
        self.addSubview(viewBack)
        viewBack.backgroundColor = .white
        viewBack.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(UIGeneral.paddingThirtyFive)
            make.bottom.equalToSuperview().inset(UIGeneral.paddingTwenty)
            make.horizontalEdges.equalToSuperview().inset(UIGeneral.paddingFifty)
            make.bottom.equalToSuperview().inset(UIGeneral.paddingTwenty)
        }
        
        self.addSubview(self.dogImage)
        self.dogImage.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(UIGeneral.paddingTwenty)
            make.width.equalTo(self.dogImage.snp.height).multipliedBy(4.0/6.0)
            make.width.height.equalTo(UIGeneral.imageHeightRatio).priority(.required)
            make.bottom.equalToSuperview().inset(UIGeneral.paddingTwenty)
            make.top.equalToSuperview().inset(UIGeneral.paddingTwenty)
        }
        
        let view = UIView()
        self.addSubview(view)
        view.clipsToBounds = true
        view.layer.cornerRadius = UIGeneral.cornerRadius
        view.backgroundColor = .white
        view.snp.makeConstraints { make in
            make.left.equalTo(self.dogImage.snp.right)
            make.top.equalToSuperview().inset(UIGeneral.paddingThirtyFive)
            make.bottom.equalToSuperview().inset(UIGeneral.paddingTwenty)
            make.right.equalToSuperview().inset(UIGeneral.paddingTwenty)
        }
        
        view.addSubview(self.dogName)
        self.dogName.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(UIGeneral.paddingTwenty)
            make.top.equalToSuperview().inset(UIGeneral.paddingFifteen)
        }
        
        view.addSubview(self.dogDescription)
        self.dogDescription.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(UIGeneral.paddingTwenty)
            make.top.equalTo(self.dogName.snp.bottom).inset(-UIGeneral.paddingTen)
        }
        
        view.addSubview(self.dogAge)
        self.dogAge.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(UIGeneral.paddingTwenty)
            make.top.equalTo(self.dogDescription.snp.bottom).inset(-UIGeneral.paddingTwenty)
        }
        
        let view2 = UIView()
        view.addSubview(view2)
        view2.backgroundColor = .white
        view2.snp.makeConstraints { make in
            make.top.equalTo(self.dogAge.snp.bottom)
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
}

