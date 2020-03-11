//
//  ViewController.swift
//  Cost Calculator
//
//  Created by Samuel Brasileiro on 02/03/20.
//  Copyright © 2020 Samuel Brasileiro. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UIScrollViewDelegate, UITextFieldDelegate{
    
    @IBOutlet weak var icone1: UIImageView!
    @IBOutlet weak var icone2: UIImageView!
    @IBOutlet weak var icone3: UIImageView!
    
    @IBOutlet weak var calcule: UIButton!
    
    @IBOutlet weak var text1: UITextField!
    @IBOutlet weak var text2: UITextField!
    @IBOutlet weak var text3: UITextField!
    
    @IBOutlet weak var pageControl: UIPageControl!
    
    @IBOutlet weak var scrollView: UIScrollView!{
        didSet{
            scrollView.delegate = self
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSlideScrollView()
        scrollView.isHidden = true
        pageControl.numberOfPages = 4
        pageControl.currentPage = 0
        text1.delegate = self
        text2.delegate = self
        text3.delegate = self
        text1.keyboardType = UIKeyboardType.decimalPad
        text2.keyboardType = UIKeyboardType.decimalPad
        text3.keyboardType = UIKeyboardType.decimalPad
        
  
        
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
        
        
    }
    @IBAction func ffffff(_ sender: Any) {
        text1.resignFirstResponder()
        text2.resignFirstResponder()
        text3.resignFirstResponder()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func calcular(_ sender: UIButton) {
        scrollView.isHidden = false
        text1.resignFirstResponder()
        text2.resignFirstResponder()
        text3.resignFirstResponder()
        if text1.text == "" || text2.text == "" || text3.text == "" {
            let alert = UIAlertController(title: "Atenção", message: "Por favor, digite todos os valores!", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Certo", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        else{
            
            let width = 414
            let energiaGeral = Int(text1.text!)! + Int(text2.text!)! + Int(text3.text!)!
            let result1 = Result(nome: "Geral", preco: String(format:"%.2f",estimarCusto(energia: energiaGeral)), recado: analisarUtilidade(energia: energiaGeral/3), image: "house")
            
            result1.frame = CGRect(x: 17, y: 0, width: width-34, height: 344)
            scrollView.addSubview(result1)
            
            let result2 = Result(nome: "Eletrônicos", preco: String(format:"%.2f",estimarCusto(energia: Int(text1.text!)!)), recado: analisarUtilidade(energia: Int(text1.text!)!), image: "tv")
            result2.frame = CGRect(x: (width + 17), y: 0, width: width-34, height: 344)
            scrollView.addSubview(result2)
            
            let result3 = Result(nome: "Climatização", preco: String(format:"%.2f",estimarCusto(energia: Int(text2.text!)!)), recado: analisarUtilidade(energia: Int(text2.text!)!), image: "snowflake")
            result3.frame = CGRect(x: 17 + width * 2, y: 0, width: width-34, height: 344)
            scrollView.addSubview(result3)
            
            let result4 = Result(nome: "Iluminação", preco: String(format:"%.2f",estimarCusto(energia: Int(text3.text!)!)), recado: analisarUtilidade(energia: Int(text3.text!)!), image: "light")
            result4.frame = CGRect(x: 17 + width * 3, y: 0, width: width-34, height: 344)
            scrollView.addSubview(result4)
            
        }
        
    }
    
    func estimarCusto(energia: Int)->Double{
        return (Double(energia) * 0.527 * 30.42)
    }
    func analisarUtilidade(energia:Int)->String{
        if Double(energia)/15 >= 1 {
            return "Você consumiu muita energia hoje neste meio. Diminua o ritmo para pagar menos no fim do mês!"
        } else if Double(energia)/15 <= 0.5{
            return "Está perfeitamente economizando energia, continue assim, por favor!"
        }
        else {
            return "Você consumiu muito mas não tanto hoje. Cuidado com consumos futuros."}
    }
    
    func setupSlideScrollView() {
        
        scrollView.contentSize = CGSize(width: scrollView.frame.width * CGFloat(4), height: scrollView.frame.height)
        scrollView.isPagingEnabled = true
        
        print("gerol")
        
        
        
        view.bringSubviewToFront(pageControl)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = round(scrollView.contentOffset.x/view.frame.width)
        pageControl.currentPage = Int(pageIndex)
        
    }
    
}

