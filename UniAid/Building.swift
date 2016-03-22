//
//  Building.swift
//  UniAid
//
//  Created by igor epshtein on 2016-03-22.
//  Copyright © 2016 igor epshtein. All rights reserved.
//

import Foundation
class Building
{
    var BuildingName:String = ""
    var cordinates:Cordinates
    let buldings = ["Dentistry Building","Goldberg Computer Science Building","Howe Hall","Boulden Building","Burbidge Building","Chase Building","Chemical Engineering","Chemistry","Kenneth C. Rowe Management Building","Killam Library","Life Sciences Centre","Marion McCain Arts and Social Sciences","Mona Campbell Building","Dalhousie Arts Centre","Dalplex","Sir James Dunn Building","Student Union Building","Weldon Law Building","Tupper Building"]
    
    let cordinatesList = [Cordinates(latitude: 44.6387618, longtitude: -63.5854412),Cordinates(latitude: 44.6374003, longtitude: -63.5871739),Cordinates(latitude: 44.6382655, longtitude: -63.5917475),Cordinates(latitude: 45.3718393, longtitude: -63.257868),Cordinates(latitude: 44.6365812, longtitude: -63.5916555),Cordinates(latitude: 44.6370699, longtitude: -63.593213),Cordinates(latitude: 44.6429707, longtitude: -63.5738101),Cordinates(latitude: 44.6363473, longtitude: -63.5952967),Cordinates(latitude: 44.6370501, longtitude: -63.5881444),Cordinates(latitude: 44.6374114, longtitude: -63.5911993),Cordinates(latitude: 44.6358898, longtitude: -63.5938238),Cordinates(latitude: 44.6376222, longtitude: -63.589626),Cordinates(latitude: 44.6389783, longtitude: -63.5906257),Cordinates(latitude: 44.6380153, longtitude: -63.58854),Cordinates(latitude: 44.6340218, longtitude: -63.5912548),Cordinates(latitude: 44.6378279, longtitude: -63.5934248),Cordinates(latitude: 44.6367578, longtitude: -63.588961),Cordinates(latitude: 44.6381758, longtitude: -63.5874964),Cordinates(latitude: 44.6394053, longtitude: -63.5837703)]
    
    
    init (BuildingName:String) {
        self.BuildingName = BuildingName
        self.cordinates = cordinatesList[buldings.indexOf(BuildingName)!]
    }
    //sda
}

