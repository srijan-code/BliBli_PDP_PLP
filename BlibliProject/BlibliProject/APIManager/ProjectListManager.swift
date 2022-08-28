//
//  ProjectListManager.swift
//  BlibliProject
//
//  Created by Srijan Kumar  on 23/07/22.
//

import Foundation
import UIKit

class ProjectListManager: UIViewController{
    var dataPassingThroughClosure: ((DataMain?) -> Void)?
    let companyURL = "https://www.blibli.com/backend/search/products"
    
    func fetchProductList(searchItem: String)
    {
        let urlString = "https://www.blibli.com/backend/search/products?searchTerm=\(searchItem)&start=0&itemPerPage=24" 
        performRequest(with: urlString)
    }
    
    func fetchProductListPagination(searchItem: String?, startPoint: Int)
    {
        if let searchItem = searchItem{
            let urlString = "https://www.blibli.com/backend/search/products?searchTerm=\(searchItem)&start=\(startPoint)&itemPerPage=24"
            performRequest(with: urlString)
        }
    }
    
    func performRequest(with urlString: String)
    {
        if let url = URL(string: urlString){
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url){
                [weak self] (data, response, error) in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
                if let safeData = data{
                    print("URL: \(urlString) succesful, withData: \(safeData)")
                    if let fetchedData = self?.parseJSON(safeData){
                        self?.dataPassingThroughClosure?(fetchedData)
                    }
                }
            }
            task.resume()
        } else {
            print("Failed to parse URL String: \(urlString)")
        }
    }
    
    func parseJSON(_ productData: Data) -> DataMain? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(DataMain.self, from: productData)
            return decodedData
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
}
