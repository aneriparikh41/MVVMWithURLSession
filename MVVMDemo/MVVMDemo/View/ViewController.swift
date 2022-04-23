//
//  ViewController.swift
//  MVVMDemo
//
//  Created by Aneri Parikh on 23/04/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var newsVM = NewsViewModel(service: Service())

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self

        newsVM.fetchNews()
        newsVM.newsPopulated = {[weak self] in
            guard let self = self else { return }
            DispatchQueue.executeOnMain {
                if self.newsVM.errorOccured {
                    self.presentAlert()
                } else {
                    self.tableView?.reloadData()
                }
            }

        }
    }

    func presentAlert() {
       let alert = UIAlertController(title: "Error", message: "Please Try Again Later", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: {[weak self] _ in
            self?.dismiss(animated: true, completion: nil)
        }))
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: {[weak self] _ in
            self?.newsVM.fetchNews()
        }))

        present(alert, animated: true, completion: nil)
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        newsVM.news?.news.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as? TableViewCell else {
            return UITableViewCell()
        }
        cell.configure(new: newsVM.news?.news[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
