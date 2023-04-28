//
//  DetailBookViewController.swift
//  OpenLibrary
//
//  Created by Дмитрий Пономаренко on 28.04.23.
//

import UIKit

class DetailBookViewController: UIViewController {

    @IBOutlet var detailImageView: UIImageView!
    @IBOutlet var detailTitleLabel: UILabel!
    @IBOutlet var detailDescriptionText: UITextView!
    @IBOutlet var detailDateLabel: UILabel!
    var titleBook = String()
    var descriptionBook = String()
    var dateBook = String()
    var imageBook = String()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        config()
        // Do any additional setup after loading the view.
    }
    
    //MARK: - Configurate View

    func config() {
        detailDescriptionText.isEditable = false
        navigationItem.title = titleBook
        detailImageView.setImage(with: imageBook)
        detailDescriptionText.text = descriptionBook
        detailDateLabel.text = "Publication date: \(dateBook)"
    }
    
}
