//
//  ViewController.swift
//  iBeaconCentralDemo
//
//  Created by yamaguchi on 2016/12/12.
//  Copyright © 2016年 h.yamaguchi. All rights reserved.
//

import UIKit
import CoreBluetooth
import CoreLocation

class ViewController: UIViewController {
    
    fileprivate let locationManager = CLLocationManager()
    fileprivate var beacon: CLBeaconRegion?
    fileprivate var peripheralManager: CBPeripheralManager?


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        

        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "送信",
                                                                 style: .done,
                                                                 target: self,
                                                                 action: #selector(startAdvertising))
        
        iBeacon.sharedInstance.requestAlwaysAutorization()
        
//        self.peripheralManager = CBPeripheralManager()
//        self.peripheralManager?.delegate = self;
        
        
//        self.locationManager.requestAlwaysAuthorization()
    }


    func startAdvertising() {
        
    }
}

extension ViewController: CBPeripheralManagerDelegate {
    
    func peripheralManagerDidUpdateState(_ peripheral: CBPeripheralManager) {
        NSLog("発信")
        let uuid = NSUUID(uuidString: "D947DF5D-2FB7-417E-B34B-2D1F72A8DE40")
        self.beacon = CLBeaconRegion(proximityUUID: uuid as! UUID, major: 1, minor: 1, identifier: "ibeacon Demo")
        
        
        //        let peripheralData = self.beacon?.peripheralData(withMeasuredPower: nil) as? [String : Any]
        
        let peripheralData = self.beacon!.peripheralData(withMeasuredPower: nil)  as NSDictionary as! Dictionary<String, Any>
        self.peripheralManager!.startAdvertising(peripheralData)

    }
    
    func peripheralManagerDidStartAdvertising(_ peripheral: CBPeripheralManager, error: Error?) {
        print("peripheralManagerDidStartAdvertising")
    
    }
    
    func peripheralManager(_ peripheral: CBPeripheralManager, didAdd service: CBService, error: Error?) {
        if (error != nil) {
            print("サービス追加失敗！ error: \(error)")
            return
        }
        
        print("サービス追加成功！")
        
    }
    
    func peripheralManager(_ peripheral: CBPeripheralManager, central: CBCentral, didSubscribeTo characteristic: CBCharacteristic) {
        
        print("サービス追加成功！")
    }
}
