//
//  ViewController.swift
//  ApiCAllingSecondProgram
//
//  Created by MANSI SAVANI on 02/03/23.
//

import UIKit
import Alamofire

class ViewController: UIViewController {
    var arrProducts: ElecronicsProducts!
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        configerTableView()
        // Do any additional setup after loading the view.
    }
//    private func setUp(){
//
//        AF.request( "https://dummyjson.com/products/search?q=Laptop",method: .get).responseData { [self]
//            response in
//            debugPrint("response\(response)")
//            if response.response?.statusCode == 200 {
//                guard let apiData = response.data else {return}
//                do{
//                    let productDetails = try JSONDecoder().decode(ElecronicsProducts.self, from: apiData)
//                    print(productDetails)
//                    arrProducts = productDetails
//                    tableView.reloadData()
//                }catch{
//                    print(error.localizedDescription)
//                }
//            }else{
//                print("tame ky locho karo")
//            }
//        }
//    }

    private func setup(){
        AF.request("https://dummyjson.com/products/search?q=Laptop",method: .get).responseData{ [self]
            responce in
            debugPrint("responce\(responce)")
            if responce.response?.statusCode == 200{
                guard let apiData = responce.data else {return}
                do{
                    let productDetails = try JSONDecoder().decode(ElecronicsProducts.self, from: apiData)
                    print(productDetails)
                    arrProducts = productDetails
                    tableView.reloadData()
                }catch{
                    print(error.localizedDescription)
                }
            }else{
                print("tame kyy locho karo")
            }
        }
        
    }
        
    private func configerTableView(){
        
        let nibFile: UINib = UINib(nibName: "ProdectDetailsTableViewCell", bundle: nil)
        tableView.register(nibFile, forCellReuseIdentifier: "cell")
        tableView.separatorStyle = .none
        
    }
 

}

// MARK: - Welcome
struct ElecronicsProducts: Codable {
    let products: [Product]
    let total, skip, limit: Int
}

// MARK: - Product
struct Product: Codable {
    let id: Int
    let title, description: String
    let price: Int
    let discountPercentage, rating: Double
    let stock: Int
    let brand, category: String
    let thumbnail: String
    let images: [String]
}


extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrProducts?.products.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ProdectDetailsTableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ProdectDetailsTableViewCell
        cell.nameLable.text = arrProducts.products[indexPath.row].thumbnail
        return cell
    }
    
    
    
}
           
