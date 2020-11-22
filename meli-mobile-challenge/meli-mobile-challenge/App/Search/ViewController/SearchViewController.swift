//
//  ViewController.swift
//  meli-mobile-challenge
//
//  Created by Ernesto Colmenarez on 15/11/20.
//

import UIKit
import SwiftUI
import RxSwift
import RxCocoa

class SearchViewController: BaseViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    var list = BehaviorRelay<[SearchItemModel]>(value: [])
    var searchViewModel = SearchViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        /* Setup delegates */
        tableView.delegate = self
        searchBar.delegate = self
    }
    
    override func registerNib() {
        tableView.register(UINib(nibName: R.nib.productCell.name, bundle: nil), forCellReuseIdentifier: R.nib.productCell.identifier)
    }
    
    override func setup() {
        view.backgroundColor = R.color.yelowMeli()
        
        searchBar.barTintColor = R.color.yelowMeli()
        searchBar.backgroundImage = UIImage()
        searchBar.searchTextField.backgroundColor = UIColor.white
        searchBar.delegate = self
    }
    
    override func bindData() {
        list.bind(to: tableView.rx.items) { (tableView, row, element) in
            let indexPath = IndexPath(row: row, section: 0)
            let cell = tableView.dequeueReusableCell(withIdentifier:R.nib.productCell.identifier, for: indexPath) as! ProductCell
            cell.configure(with: element)
            let backgroundView = UIView()
            backgroundView.backgroundColor = UIColor.clear
            cell.selectedBackgroundView = backgroundView
            return cell
        }
        .disposed(by: disposeBag)
    }
    
    override func subscriptionData() {
        self.searchViewModel.responseAllList.subscribe(onNext: { (products) in
            self.list.accept(products.results ?? [])
        }).disposed(by: disposeBag)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == R.segue.searchViewController.goToDetail.identifier, let detaillViewController = segue.destination as? DetailViewController, let searchItemModel = sender as? SearchItemModel {
            detaillViewController.productId = searchItemModel.id
        }
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.searchViewModel.getAllProducts.onNext(searchText)
    }
}

extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: R.segue.searchViewController.goToDetail.identifier, sender: list.value[indexPath.row])
    }
}
