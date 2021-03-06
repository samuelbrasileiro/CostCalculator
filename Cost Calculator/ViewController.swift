//
//  ViewController.swift
//  Cost Calculator
//
//  Created by Samuel Brasileiro on 02/03/20.
//  Copyright © 2020 Samuel Brasileiro. All rights reserved.
//

import UIKit
var systems: [System] = []

class MainViewController: UIViewController, UIScrollViewDelegate, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource, UITableViewDelegate, UITableViewDataSource{
    
    
    
    let pickerData = ["Diário", "Semanal", "Mensal", "Anual"]
    var dataList: [String] = []
    @IBOutlet weak var calcule: UIButton!
    
    @IBOutlet var adicionarLabel: UIButton!
    
    @IBOutlet weak var pageControl: UIPageControl!
    
    var pickerView = UIPickerView()
    var tableView = UITableView()
    
    var scrollView = UIScrollView(){
        didSet{
            scrollView.delegate = self
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSlideScrollView()
        setupHelpButton()
        pageControl.numberOfPages = 4
        pageControl.currentPage = 0

        tableView.delegate = self
        tableView.dataSource = self
        calcule.frame = CGRect(x: self.view.frame.width/2 - 60, y: self.view.frame.height - 330, width: 120, height: 48)
        calcule.layer.cornerRadius = 5
        calcule.layer.masksToBounds = true
        adicionarLabel.frame = CGRect(x: 0, y: self.view.frame.height - 360, width: 160, height: 30)
        self.view.bringSubviewToFront(calcule)
        let gesture = UITapGestureRecognizer(target: self, action: #selector(tap(_:)))
        self.view.addGestureRecognizer(gesture)
        
        scrollView.isHidden = true
        
        tableView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height - 360)
        
        tableView.register(UINib(nibName: "SystemTableViewCell", bundle: nil), forCellReuseIdentifier: "SystemTableViewCell")
        
        
        self.view.addSubview(tableView)
        self.view.addSubview(scrollView)
        
        
        systems = []
        
        systems.append(System(name: "Estúdio", image: "guitars"))
        systems.append(System(name: "Aquecedor", image: "flame"))
        systems.append(System(name: "Home Teather",  image: "hifispeaker"))
        systems.append(System(name: "Iluminação", image: "lightbulb"))
        dataList = ["","","",""]
        
        tableView.reloadData()
        
    }
    
    
    @IBAction func calcular(_ sender: UIButton) {
        
        self.view.endEditing(true)
        
        if isTextLeft() {
            let alert = UIAlertController(title: "Atenção", message: "Por favor, digite todos os valores!", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Certo", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        else{
            setupSlideScrollView()
            createAlertPicker()
        }
        
    }
    
    @IBAction func add(_ sender: Any) {
        var name = "Default"
        let alert = UIAlertController(title: "Novo sistema", message: "Dê um nome para o sistema", preferredStyle: .alert)

        alert.addTextField { (textField) in
            textField.placeholder = "Escreva aqui"
        }

        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
            let textField = alert?.textFields![0]
            name = textField!.text ?? "Default"
            systems.append(System(name: name, image: ""))
            self.dataList.append("")
            let alert = UIAlertController(title: "Novo sistema", message: "Escolha uma imagem", preferredStyle: .alert)
            
            
            let vc = UIViewController()
            vc.preferredContentSize = CGSize(width: 250,height: 100)
            
            
            
            
            
            
            
            let imageNames = ["flame", "gamecontroller", "tv", "printer", "wifi", "guitars", "lightbulb", "sun.min", "power", "hifispeaker", "wrench", "snow"]
            for index in 0..<imageNames.count{
                var yMultiplier = 0
                var xSubtrier = 0
                if index > 5{
                    yMultiplier = 1
                    xSubtrier = 6
                }
                let button = UIButton(frame: CGRect(x: 10 + (index - xSubtrier) * 40, y: yMultiplier * 40, width: 20, height: 20))
                button.imageView?.contentMode = .scaleAspectFit
                button.tintColor = .darkGray
                button.setImage(UIImage(systemName: imageNames[index]), for: .normal)
                button.addTarget(self, action: #selector(self.buttonDismiss(_:)), for: .touchUpInside)
                vc.view.addSubview(button)
            }
            alert.setValue(vc, forKey: "contentViewController")
            
            
            self.present(alert,animated: true, completion: nil)
            
            
            
        }))

        self.present(alert, animated: true, completion: nil)
    }
    
    @objc func buttonDismiss(_ sender: UIButton){
        systems[systems.count - 1].image = sender.imageView!.image!
        tableView.reloadData()
        self.dismiss(animated: true, completion: nil)
    }
    
    func isTextLeft() -> Bool{
        
        for cell in allCells {
            if cell.textField.text == ""{
                return true
            }
        }
        
        return false
    }
    
    func sumTexts() -> Int{
        var sum: Int = 0
        for index in 0..<allCells.count{
            let cell = allCells[index]
            sum += Int(cell.textField!.text!)!
        }
        return sum
    }
    
    
    //MARK:- SCROLL VIEW
    func revealScrollView(){
        let width = self.view.frame.width
        
        
        let energiaGeral = sumTexts()
        
        let selectedTime = Time(rawValue: pickerView.selectedRow(inComponent: 0))!
                
        for index in 0..<allCells.count{
            let cell = allCells[index]
            systems[index].setEnergy(energy: Int(cell.textField!.text!)!)
            systems[index].setTime(time: selectedTime)
            
        }
        
        let geral = System(name: "Geral", image: "house")
        geral.setEnergy(energy: energiaGeral)
        geral.setTime(time: selectedTime)
        geral.isGeral = true
        let geralView = ResultView(system: geral)
        geralView.frame = CGRect(x: 17, y: 40, width: width-34, height: 250)
        scrollView.addSubview(geralView)
        
        for index in 0..<systems.count{
            let resultView = ResultView(system: systems[index])
            resultView.frame = CGRect(x: 17 + (width * CGFloat(index + 1)), y: 40, width: width-34, height: 250)
            scrollView.addSubview(resultView)
        }
        
    }
    func getAllCells() -> [UITableViewCell] {

       var cells = [UITableViewCell]()
       // assuming tableView is your self.tableView defined somewhere
       for i in 0...tableView.numberOfSections-1
       {
        for j in 0...tableView.numberOfRows(inSection: i)-1
           {
            if let cell = tableView.cellForRow(at: NSIndexPath(row: j, section: i) as IndexPath) {

                  cells.append(cell)
               }

           }
       }
    return cells
    }
    
    func setupHelpButton(){
        self.navigationItem.setRightBarButton(UIBarButtonItem(image: UIImage(systemName: "questionmark.circle"), style: .done, target: self, action: #selector(helpAlert)), animated: true)
    }
    @objc func helpAlert(){
        let alert = UIAlertController(title: "Como funciona?", message: "Você, com a ajuda de nosso dispositivo, recupera as quantidades de kWh gastas no último dia de cada sistema e escreva-as no app, para descobrir o rendimento!", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true)
    }
    
    func setupSlideScrollView() {
        for view in scrollView.subviews{
            view.removeFromSuperview()
        }
        scrollView.isHidden = false
        scrollView.contentSize = CGSize(width: scrollView.frame.width * CGFloat(systems.count + 1), height: scrollView.frame.height)
        scrollView.isPagingEnabled = true
        
        scrollView.frame = CGRect(x: self.view.frame.width, y: self.view.frame.height - 302, width: self.view.frame.width, height: 302)
        pageControl.numberOfPages = systems.count + 1
        UIView.animateKeyframes(withDuration: 4, delay: 1, options: [.beginFromCurrentState,.calculationModeDiscrete], animations: {
            self.scrollView.frame.origin = CGPoint(x: 0, y: self.view.frame.height - 302)
            
        })
        
        view.bringSubviewToFront(pageControl)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if self.scrollView == scrollView{
            let pageIndex = round(scrollView.contentOffset.x / view.frame.width)
            pageControl.currentPage = Int(pageIndex)
        }
        
    }
    //MARK:- PICKER VIEW
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {

    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    func createAlertPicker(){
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
    
    //MARK:- TABLE VIEW
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return systems.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 105;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "SystemTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? SystemTableViewCell  else {
            fatalError("The dequeued cell is not an instance of SystemTableViewCell.")
        }
        
        if !allCells.contains(cell) { allCells.append(cell) }
        let system = systems[indexPath.row]
        cell.textField.delegate = self
        cell.name.text = system.name
        cell.icone.image = system.getImage()
        cell.textField.tag = indexPath.row
        cell.textField.text = dataList[indexPath.row]
        cell.selectionStyle = .none
        
        return cell
    }
    
    @objc func tap(_ sender: UIGestureRecognizer){
        view.endEditing(true)
    }
    
    private var allCells = [SystemTableViewCell]()

    
    //MARK:- TEXT FIELD
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {

        if textField.text != ""{

            dataList[textField.tag] = textField.text!
        }
        return true
    }
    
}

