//
//  BottomSheetView.swift
//  BinomTechTestTask
//
//  Created by Денис Набиуллин on 22.08.2023.
//

import Foundation
import UIKit

final class BottomSheetView: UIView {
    
    private let data: [InfoItemModel] = [
        InfoItemModel(imageName: Resources.StandardImageTitle.InfoTitle.wifi, labelText: "GPS"),
        InfoItemModel(imageName: Resources.StandardImageTitle.InfoTitle.calendar, labelText: "02.07.17"),
        InfoItemModel(imageName: Resources.StandardImageTitle.InfoTitle.clock, labelText: "14:00")
    ]
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = Resources.ConstantsSheetView.nameLabelText
        label.font = UIFont.boldSystemFont(ofSize: 18)
        return label
    }()
    
    private lazy var profileImageView: CustomImage = {
        var image = CustomImage(name: Resources.StandardImageTitle.profileImage)
        return image
    }()
    
    private lazy var viewHistoryButton: CustomButton = {
        let button = CustomButton()
        button.backgroundColor = .systemBlue
        button.setTitle(Resources.ConstantsSheetView.viewHistoryButtonTitle, for: .normal)
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    private lazy var networkDateTimeStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = Resources.ConstantsSheetView.networkDateTimeStackViewSpacing
        stack.alignment = .center
        return stack
    }()
    
    private lazy var userDetailsStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = Resources.ConstantsSheetView.userDetailsStackViewSpacing
        stack.alignment = .leading
        return stack
    }()
    
    private lazy var infoActionStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = Resources.ConstantsSheetView.infoActionStackViewSpacing
        stack.alignment = .leading
        return stack
    }()
    
    private lazy var mainStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.spacing = Resources.ConstantsSheetView.mainStackViewSpacing
        stack.alignment = .top
        return stack
    }()
    // MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        createUIElements()
        
        addSubview(mainStackView)
        
        setupConstraints()
        
        isHidden = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        addTopShadow()
    }
    // MARK: - setupView
    private func setupView() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .white
        
        userDetailsStackView.addArrangedSubview(nameLabel)
        userDetailsStackView.addArrangedSubview(networkDateTimeStackView)
        
        infoActionStackView.addArrangedSubview(userDetailsStackView)
        infoActionStackView.addArrangedSubview(viewHistoryButton)
        
        mainStackView.addArrangedSubview(profileImageView)
        mainStackView.addArrangedSubview(infoActionStackView)
    }
    
    private func createUIElements() {
        for item in data {
            let stackView = createStackView(withImage: item.imageName, labelText: item.labelText)
            
            networkDateTimeStackView.addArrangedSubview(stackView)
        }
        networkDateTimeStackView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func createStackView(withImage imageName: String, labelText: String) -> UIStackView {
        let imageView = UIImageView(image: UIImage(systemName: imageName))
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .systemBlue
        
        let label = UILabel()
        label.text = labelText
        label.textAlignment = .center
        
        let stackView = UIStackView(arrangedSubviews: [imageView, label])
        stackView.axis = .horizontal
        stackView.spacing = Resources.ConstantsSheetView.stackViewSpacing
        stackView.alignment = .center
        
        return stackView
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
// MARK: - setupConstraints
private extension BottomSheetView {
    func setupConstraints() {
        NSLayoutConstraint.activate([
            profileImageView.widthAnchor.constraint(equalTo: widthAnchor,
                                                    multiplier: Resources.ConstantsSheetView.profileImageWidthMultiplier),
            profileImageView.heightAnchor.constraint(equalTo: profileImageView.widthAnchor),
            
            viewHistoryButton.heightAnchor.constraint(equalToConstant: Resources.ConstantsSheetView.buttonHeight),
            viewHistoryButton.widthAnchor.constraint(equalTo: widthAnchor,
                                                     multiplier: Resources.ConstantsSheetView.viewHistoryButtonWidthMultiplier),
            
            mainStackView.topAnchor.constraint(equalTo: topAnchor, constant: 30),
            mainStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15)
        ])
    }
}
