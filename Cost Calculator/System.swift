//
//  Result.swift
//  Cost Calculator
//
//  Created by Samuel Brasileiro on 11/03/20.
//  Copyright © 2020 Samuel Brasileiro. All rights reserved.
//

import Foundation
import UIKit

enum Time: Int{
    case daily = 0
    case weekly = 1
    case monthly = 2
    case yearly = 3
    
    func getString()->String{
        switch self {
        case .daily:
            return "diária"
        case .weekly:
            return "semanal"
        case .monthly:
            return "mensal"
        case .yearly:
            return "anual"
        }
    }
    func getDays()->Double{
        switch self {
        case .daily:
            return 1
        case .weekly:
            return 7
        case .monthly:
            return 30.417
        case .yearly:
            return 365
        }
    }
}
class System{
    var name: String
    var energy: Int
    var note: String = ""
    var image: UIImage
    var time: Time
    init(name: String, image: String){
        self.name = name
        self.image = UIImage(systemName: image) ?? UIImage(systemName: "power")!
        self.energy = 0
        self.time = .monthly
    }
    
    func estimarCusto()->Double{
        return (Double(energy) * 0.527 * time.getDays())
    }
    func analisarUtilidade()->String{
        var div:Double = 15
        if name == "Geral"{
            div *= 3
        }
        
        if Double(energy)/div >= 1 {
            return "Você consumiu muita energia hoje neste meio. Diminua o ritmo para pagar menos no fim do mês!"
        } else if Double(energy)/div <= 0.5{
            return "Está perfeitamente economizando energia, continue assim, por favor!"
        }
        else {
            return "Você consumiu muito mas não tanto hoje. Cuidado com consumos futuros."}
    }
    func getImage() -> UIImage {
        return image
    }
    func setEnergy(energy: Int){
        self.energy = energy
    }
    func setTime(time: Time){
        self.time = time
    }
}
