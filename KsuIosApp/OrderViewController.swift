//
//  OrderViewController.swift
//  
//
//  Created by Harry Shen on 2017/9/19.
//
//

import UIKit

class OrderViewController: BaseController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet var tableView: UITableView!
    
    var orders = [Order]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        parseData()
        
    }
    
    //MARK: - Parse JSON
    
    func parseData() {
        
        let jsonUrlString = "http://120.114.101.129/Swift/Order.php"
        guard let url = URL(string: jsonUrlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            
            guard let data = data else { return }
            
            do {
                
                let orderResults = try JSONDecoder().decode([Order].self, from: data)
                
                for order in orderResults {
                    let orderId = order.order_id
                    let ksuId = order.ksuid
                    let orderTime = order.order_time
                    let status = order.status
                    let orderDetail = order.order_detail
                    
                    self.orders.append(Order(order_id: orderId, ksuid: ksuId, order_time: orderTime, status: status, order_detail: orderDetail))
                    
                }
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
            catch let jsonErr {
                print("Json Serializing Error:", jsonErr)
            }
        }.resume()
        
    }
    
    //MARK: - Table data source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return orders.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! OrderDetailTableViewCell
        let order = orders[indexPath.row]
        cell.idLabel.text = "No. \(order.order_id)"
        cell.statusLabel.text = order.status
        cell.timeLabel.text = order.order_time
        
        //cell選擇特效
        cell.selectionStyle = .none
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You Selected \(indexPath.row)")
        
        let indexPath = tableView.indexPathForSelectedRow!
        let orderDetail = self.storyboard?.instantiateViewController(withIdentifier: "OrderDetailViewController") as! OrderDetailViewController
        navigationController?.pushViewController(orderDetail, animated: true)
        orderDetail.order = orders[indexPath.row] as Order

    }
    
    //MARK: - Segue
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if (segue.identifier == "showOrderDetail") {
//            if let indexPath = tableView.indexPathForSelectedRow {
//                let destinationController = segue.destination as! OrderDetailViewController
//                destinationController.order = orders[indexPath.row]
//            }
//        }
//    }

}
