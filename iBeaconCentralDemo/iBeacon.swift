//
//  iBeacon.swift
//  iBeaconCentralDemo
//
//  Created by yamaguchi on 2016/12/12.
//  Copyright © 2016年 h.yamaguchi. All rights reserved.
//

import UIKit
import CoreLocation

class iBeacon: NSObject {
    
    fileprivate static let sharedInstance = iBeacon()
    
    
    fileprivate let locationManager = CLLocationManager()
    fileprivate let uuids = [""]
    
    func requestAlwaysAutorization() {
        
        self.locationManager.delegate = self
     
        if #available(iOS 8, *) {
            self.locationManager.requestAlwaysAuthorization()
        }
        
        if #available(iOS 9, *) {
            self.locationManager.allowsBackgroundLocationUpdates = true
        }
    }

}

extension iBeacon: CLLocationManagerDelegate {
    
    // 領域に入った際に通知する
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        
    }
    
    // 領域から出た際に通知する
    func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
        
    }
    
    // 領域監視開始
    func locationManager(_ manager: CLLocationManager, didStartMonitoringFor region: CLRegion) {
        
    }
    
    func locationManager(_ manager: CLLocationManager, didDetermineState state: CLRegionState, for region: CLRegion) {
        
    }
    
    // 領域内でのビーコン受信
    func locationManager(_ manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], in region: CLBeaconRegion) {
        
    }
    
    // 位置情報取得ができたら
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        if status == .authorizedAlways || status == .authorizedWhenInUse {
            
            
        }
        
        // TODO: 許可されていない場合のエラー処理
    }

}

