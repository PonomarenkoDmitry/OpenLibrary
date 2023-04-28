//
//  BooksViewController.swift
//  OpenLibrary
//
//  Created by Дмитрий Пономаренко on 28.04.23.
//

import UIKit

class BooksViewController: UIViewController {
    
    @IBOutlet var booksTableView: UITableView!
    
    let viewModel = BooksViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        config()
    }
    
        //MARK: - Configurate View
    func config() {
        booksTableView.register(UINib(nibName: "BookCell", bundle: nil), forCellReuseIdentifier: "BookCell")
        fetchData()
        observerEvent()
    }
    
    func fetchData() {
        viewModel.fetchBooks()
    }
    
    func observerEvent() {
        viewModel.eventHandler = { [weak self] event in
            switch event {
            case .loading:
                print("Product loading........")
            case .dataLoaded:
                print("Data loaded........")
                DispatchQueue.main.async {
                    self?.booksTableView.reloadData()
                }
            case .stopLoading:
                print("Stop loading.........")
            case .error(let error):
                print(error)
            }
        }
    }
}

    //MARK: - DataSourse Methods

extension BooksViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.books.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "BookCell") as? BookCell else {
            return UITableViewCell()
        }
        
        cell.titleLabel.text = viewModel.books[indexPath.row].title
        cell.dateLabel.text = "Publication date: \(String(viewModel.books[indexPath.row].created.value.dropLast(16)))"
        cell.coverImageView.setImage(with: "https://covers.openlibrary.org/b/id/\(viewModel.books[indexPath.row].covers.first ?? 0)-M.jpg")
        return cell
    }
}

    //MARK: - Delegate Methods

extension BooksViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToDetail", sender: self)
    }
    
    //MARK: - Segue data
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToDetail" {
            let destinaionVC = segue.destination as! DetailBookViewController
            if let indexPath = booksTableView.indexPathForSelectedRow {
                destinaionVC.imageBook = "https://covers.openlibrary.org/b/id/\(viewModel.books[indexPath.row].covers.first ?? 0)-L.jpg"
                destinaionVC.descriptionBook = viewModel.books[indexPath.row].description
                destinaionVC.dateBook = String(viewModel.books[indexPath.row].created.value.dropLast(16))
                destinaionVC.titleBook = viewModel.books[indexPath.row].title
            }
        }
    }
}
