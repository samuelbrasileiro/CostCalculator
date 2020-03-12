//
//  ViewController.swift
//  Cost Calculator
//
//  Created by Samuel Brasileiro on 02/03/20.
//  Copyright © 2020 Samuel Brasileiro. All rights reserved.
//

import UIKit
var systems: [System] = []

class MainViewController: UIViewController, UIScrollViewDelegate, UIPickerViewDelegate, UIPickerViewDataSource, UITableViewDelegate, UITableViewDataSource{


    
    let pickerData = ["Diário", "Semanal", "Mensal", "Anual"]
    
    @IBOutlet weak var icone1: UIImageView!
    @IBOutlet weak var icone2: UIImageView!
    @IBOutlet weak var icone3: UIImageView!
    
    @IBOutlet weak var calcule: UIButton!
    
    @IBOutlet weak var text1: UITextField!
    @IBOutlet weak var text2: UITextField!
    @IBOutlet weak var text3: UITextField!
    
    @IBOutlet weak var pageControl: UIPageControl!
    
    var pickerView = UIPickerView()
    var tableView = UITableView()
    
    @IBOutlet weak var scrollView: UIScrollView!{
        didSet{
            scrollView.delegate = self
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSlideScrollView()
        //setupTableView()
        pageControl.numberOfPages = 4
        pageControl.currentPage = 0
        
        tableView.delegate = self
        tableView.dataSource = self
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(tap(_:)))
        self.view.addGestureRecognizer(gesture)
        
        text1.keyboardType = UIKeyboardType.decimalPad
        text2.keyboardType = UIKeyboardType.decimalPad
        text3.keyboardType = UIKeyboardType.decimalPad
        
        scrollView.isHidden = true
        
        icone1.layer.masksToBounds = false
        icone1.layer.backgroundColor = CGColor(srgbRed: 158/256, green: 189/256, blue: 221/256, alpha: 1)
        icone1.layer.cornerRadius = icone1.frame.height/4
        icone1.clipsToBounds = true
        
        icone2.layer.masksToBounds = false
        icone2.layer.backgroundColor = CGColor(srgbRed: 158/256, green: 189/256, blue: 221/256, alpha: 1)
        icone2.layer.cornerRadius = icone1.frame.height/4
        icone2.clipsToBounds = true
        
        icone3.layer.masksToBounds = false
        icone3.layer.backgroundColor = CGColor(srgbRed: 158/256, green: 189/256, blue: 221/256, alpha: 1)
        icone3.layer.cornerRadius = icone1.frame.height/4
        icone3.clipsToBounds = true
        
        
        tableView.frame = CGRect(x: 0, y: 10, width: self.view.frame.width, height: 400)
        
        tableView.register(UINib(nibName: "SystemTableViewCell", bundle: nil), forCellReuseIdentifier: "SystemTableViewCell")
        
        
        self.view.addSubview(tableView)
        
        
        systems = []
        systems.append(System(name: "Geral", image: "house"))
        systems.append(System(name: "Eletrônicos",  image: "tv"))
        systems.append(System(name: "Climatização", image: "snow"))
        systems.append(System(name: "Iluminação", image: "lightbulb"))
        
        tableView.reloadData()
        
    }
    
    
    @IBAction func calcular(_ sender: UIButton) {

        self.view.endEditing(true)
        
        if text1.text == "" || text2.text == "" || text3.text == "" {
            let alert = UIAlertController(title: "Atenção", message: "Por favor, digite todos os valores!", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Certo", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        else{
            setupSlideScrollView()
            let vc = UIViewController()
            vc.preferredContentSize = CGSize(width: 250,height: 180)
            pickerView = UIPickerView(frame: CGRect(x: 0, y: -100, width: 250, height: 300))
            pickerView.delegate = self
            pickerView.dataSource = self
            vc.view.addSubview(pickerView)
            let editRadiusAlert = UIAlertController(title: "Deseja estimar o cálculo para que tempo?", message: "", preferredStyle: .alert)
            editRadiusAlert.setValue(vc, forKey: "contentViewController")
            editRadiusAlert.addAction(UIAlertAction(title: "Feito", style: .default, handler: {_ in
                self.revealScrollView()
            }))
            self.present(editRadiusAlert, animated: true)
            
            
            
        }
        
    }
    
    func revealScrollView(){
        let width = 414
        
        
        let energiaGeral = Int(text1.text!)! + Int(text2.text!)! + Int(text3.text!)!
        
        let selectedTime = Time(rawValue: pickerView.selectedRow(inComponent: 0))!
        systems.insert(System(name: "Geral", image: "house"), at: 0)
        systems[0].setEnergy(energy: energiaGeral)
        for index in 0..<systems.count{
            systems[index].setTime(time: selectedTime)
        }
        print(selectedTime)
        let cellIdentifier = "SystemTableViewCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: ) as? SystemTableViewCell  else {
            fatalError("The dequeued cell is not an instance of SystemTableViewCell.")
        }
        
        for index in 0..<systems.count{
            let resultView = ResultView(system: systems[index])
            resultView.frame = CGRect(x: 17 + (width * index), y: 0, width: width-34, height: 344)
            scrollView.addSubview(resultView)
        }
        
    }
    
    
    func setupSlideScrollView() {
        for view in scrollView.subviews{
            view.removeFromSuperview()
        }
        scrollView.isHidden = false
        scrollView.contentSize = CGSize(width: scrollView.frame.width * CGFloat(4), height: scrollView.frame.height)
        scrollView.isPagingEnabled = true
        
        print("gerol")
        
        
        
        view.bringSubviewToFront(pageControl)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = round(scrollView.contentOffset.x/view.frame.width)
        pageControl.currentPage = Int(pageIndex)
        
    }
    //MARK:- PICKER VIEW
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //selectPicker = row
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    //MARK:- TABLE VIEW
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        systems.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 105;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "SystemTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? SystemTableViewCell  else {
            fatalError("The dequeued cell is not an instance of SystemTableViewCell.")
        }
        
        let system = systems[indexPath.row]
        cell.name.text = system.name
        cell.icone.image = system.getImage()
        
        return cell
    }
    
    @objc func tap(_ sender: UIGestureRecognizer){
        view.endEditing(true)
    }
    
}

