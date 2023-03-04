//
//  ViewController.swift
//  Sphinx Solutions Machine Test
//
//  Created by Admin on 04/03/23.
//

import UIKit
import MapKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var populationTableView: UITableView!
    @IBOutlet weak var userCollectionView: UICollectionView!
    @IBOutlet weak var mapView: MKMapView!
    
    var users:[DataModelUser] = [DataModelUser]()
    var populationsData = [PopulationData]()
    
    var locationManager: CLLocationManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableViewAndCollectionView()
        userFetchData()
        fetchPopulationData()
        setMapView()
    }
    private func setMapView(){
        let latitude:CLLocationDegrees = 18.563860
        let longitude:CLLocationDegrees = 73.777261
        let letDelta:CLLocationDegrees = 0.01
        let lonDelta:CLLocationDegrees = 0.01
        let location:CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
        let span:MKCoordinateSpan = .init(latitudeDelta: letDelta, longitudeDelta: lonDelta)
        let region:MKCoordinateRegion = .init(center: location, span: span)
        self.mapView.setRegion(region, animated: true)
        
        let annotation:MKPointAnnotation = MKPointAnnotation()
        annotation.coordinate = location
        annotation.title = "Sphinx Solutions"
        self.mapView.addAnnotation(annotation)
    }
    private func setTableViewAndCollectionView(){
        populationTableView.delegate = self
        populationTableView.dataSource = self
        let tableNib = UINib(nibName: "PopulationTableViewCell", bundle: nil)
        populationTableView.register(tableNib, forCellReuseIdentifier: "PopulationTableViewCell")
        
        userCollectionView.delegate = self
        userCollectionView.dataSource = self
        let collectionNib = UINib(nibName: "UserCollectionViewCell", bundle: nil)
        userCollectionView.register(collectionNib, forCellWithReuseIdentifier: "UserCollectionViewCell")
    }
    private func userFetchData(){
        let url = URL(string: "https://gorest.co.in/public/v2/users")
        var urlRequest = URLRequest(url: url!)
        urlRequest.httpMethod = "GET"
        let session = URLSession(configuration: .default)
        let dataTask = session.dataTask(with: urlRequest){ data,response,error in
            if(error == nil){
                do{
                    let jsonData = try JSONSerialization.jsonObject(with: data!) as! [[String:Any]]
                    for eachData in jsonData{
                        let id = eachData["id"] as! Int
                        let name = eachData["name"] as! String
                        let gender = eachData["gender"] as! String
                        let userObject = DataModelUser(id: id, name: name, gender: gender)
                        self.users.append(userObject)
                    }
                    print("Usrs:-",self.users.count)
                    DispatchQueue.main.async {
                        self.userCollectionView.reloadData()
                    }
                }
                catch{
                    print("User Data Not Fetch")
                }
            }
        }
        dataTask.resume()
    }

    private func fetchPopulationData(){
        let url = URL(string: "https://datausa.io/api/data?drilldowns=Nation&measures=Population")
        let request = URLRequest(url: url!)
        let dataTask = URLSession.shared.dataTask(with: request){
            data,response,error in
            if(error == nil){
                do{
                    let jsonData = try JSONDecoder().decode(DataModelPopulation.self, from: data!)
                    self.populationsData = jsonData.data
                    print("Population Data:-",self.populationsData.count)
                    DispatchQueue.main.async {
                        self.populationTableView.reloadData()
                    }
                }
                catch{
                    
                }
            }
        }
        dataTask.resume()
    }
}

extension HomeViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return populationsData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = populationsData[indexPath.row]
        let cell = populationTableView.dequeueReusableCell(withIdentifier: "PopulationTableViewCell", for: indexPath) as! PopulationTableViewCell
        cell.year.text = data.year
        cell.population.text = String(data.population)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}

extension HomeViewController:UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return users.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.userCollectionView.dequeueReusableCell(withReuseIdentifier: "UserCollectionViewCell", for: indexPath) as! UserCollectionViewCell
        let data = users[indexPath.row]
        cell.id.text = String(data.id)
        cell.name.text = data.name
        cell.gender.text = data.gender
        cell.layer.borderColor = .init(genericCMYKCyan: 0, magenta: 0, yellow: 0, black: 1, alpha: 1)
        cell.layer.borderWidth = 1.5
        cell.layer.cornerRadius = 20
        return cell
    }
   
}

extension HomeViewController:UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellHeight = collectionView.frame.height
        let cellwidth = self.view.frame.width/2
        return CGSize(width: cellwidth, height: cellHeight)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

