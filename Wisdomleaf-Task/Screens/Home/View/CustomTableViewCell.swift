//
//  CustomTableViewCell.swift
//  Wisdomleaf-Task
//
//  Created by Dinesh Kumar on 22/04/23.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
    static let reuseIdentifier = "CustomTableViewCell"
    
    lazy var photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    lazy var idLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var authorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.alignment = .leading
        stack.distribution = .fill
        stack.axis = .vertical
        stack.spacing = 5
        return stack
    }()
    
    lazy var checkBoxButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "unchecked"), for: .normal)
        button.addTarget(self, action: #selector(checkBoxButtonAction), for: .touchUpInside)
        return button
    }()
    
    var isChecked: Bool = false {
        didSet {
            if isChecked {
                checkBoxButton.setImage(UIImage(named: "checkbox"), for: .normal)
            }else{
                checkBoxButton.setImage(UIImage(named: "unchecked"), for: .normal)
            }
        }
    }
    
    /// Closure to handle checkbox button tap action
    var didTapCheckbox: ((Bool) -> Void)? = nil
    
    /// Clear the photo image view when the cell is reused
    override func prepareForReuse() {
        super.prepareForReuse()
        photoImageView.image = nil
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
     
        addViewsAndConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addViewsAndConstraints() {
        stackView.addArrangedSubview(idLabel)
        stackView.addArrangedSubview(authorLabel)
        
        contentView.addSubview(photoImageView)
        contentView.addSubview(stackView)
        contentView.addSubview(checkBoxButton)
        
        NSLayoutConstraint.activate([
            photoImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            photoImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: .ratioWidth(10)),
            photoImageView.heightAnchor.constraint(equalToConstant: .ratioWidth(100)),
            photoImageView.widthAnchor.constraint(equalToConstant: .ratioWidth(100)),
            
            photoImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: .ratioHeight(5)),
            photoImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -.ratioHeight(5)),
            
            stackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: photoImageView.trailingAnchor, constant: .ratioWidth(10)),
            stackView.trailingAnchor.constraint(equalTo: checkBoxButton.leadingAnchor, constant: -.ratioWidth(5)),
            
            checkBoxButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            checkBoxButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -.ratioWidth(15)),
            checkBoxButton.heightAnchor.constraint(equalToConstant: .ratioWidth(40)),
            checkBoxButton.widthAnchor.constraint(equalToConstant: .ratioWidth(40)),
            
            authorLabel.widthAnchor.constraint(equalTo: stackView.widthAnchor),
        ])
    }
    
    @objc func checkBoxButtonAction() {
        isChecked.toggle()
        didTapCheckbox?(isChecked)
    }
    
    /// Configures the cell with the provided data.
    func configureCell(dataSource: PicsumPhotosModel) {
        idLabel.text = "ID : \(dataSource.id ?? "")"
        authorLabel.text = "Author : \(dataSource.author ?? "")"
        isChecked = dataSource.isChecked ?? false
        
        if let imageURL = URL(string: dataSource.downloadURL ?? "") {
            photoImageView.kf.indicatorType = .activity
            photoImageView.kf.setImage(with: imageURL, placeholder: nil)
        }
    }
}
