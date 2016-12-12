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
    
    static let sharedInstance = iBeacon()
    
    
    fileprivate let locationManager = CLLocationManager()
    fileprivate let uuids = [
        "D947DF5D-2FB7-417E-B34B-2D1F72A8DE40"
    ]
    fileprivate var beaconRegions = [CLBeaconRegion]()
    
    func requestAlwaysAutorization() {
        
        self.locationManager.delegate = self
//        // 取得精度の設定.
//        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
//        
//        // 取得頻度の設定.(1mごとに位置情報取得)
//        self.locationManager.distanceFilter = 1
     
        if #available(iOS 8, *) {
            self.locationManager.requestAlwaysAuthorization()
        }
        
        if #available(iOS 9, *) {
            self.locationManager.allowsBackgroundLocationUpdates = true
        }
        
    }
    
    // MARK: Private
    fileprivate func registerRegions() {
        
        // 重複登録チェック
        if !self.beaconRegions.isEmpty { return }
        
        self.uuids.forEach { (uuid) in
            let uuidStr :UUID! = UUID(uuidString: uuid)
            
            // BeaconのIfentifierを設定.
            let identifierStr: String = "ibeacon Demo"
            
            let region = CLBeaconRegion(proximityUUID: uuidStr,
                                        major: CLBeaconMajorValue(1),
                                        minor: CLBeaconMajorValue(1),
                                        identifier: identifierStr)
            
            // ディスプレイがOffでもイベントが通知されるように設定(trueにするとディスプレイがOnの時だけ反応).
            region.notifyEntryStateOnDisplay = false
            
            // 入域通知の設定.
            region.notifyOnEntry = true
            
            // 退域通知の設定.
            region.notifyOnExit = true
            
            self.beaconRegions.append(region)
            self.locationManager.startMonitoring(for: region)
        }
    }

}

extension iBeacon: CLLocationManagerDelegate {
    
    // 領域に入った際に通知する
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        // Rangingを始める
        print("didEnterRegion")
        self.locationManager.startRangingBeacons(in: region as! CLBeaconRegion)
    }
    
    // 領域から出た際に通知する
    func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
        
        print("didExitRegion")
        self.locationManager.stopRangingBeacons(in: region as! CLBeaconRegion)
    }
    
    // 領域監視開始
    func locationManager(_ manager: CLLocationManager, didStartMonitoringFor region: CLRegion) {
        print("didStartMonitoringFor")
        
        self.locationManager.requestState(for: region)
    }
    
    func locationManager(_ manager: CLLocationManager, didDetermineState state: CLRegionState, for region: CLRegion) {
     
        
        switch state {
        case .inside:
            
            print("CLRegionStateInside:")
            self.locationManager.startRangingBeacons(in: region as! CLBeaconRegion)
            break
        case .outside:
            print("CLRegionStateOutside:")
            break
        default:
            break
        }
    }
    
    // 領域内でのビーコン受信
    func locationManager(_ manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], in region: CLBeaconRegion) {
        print("受信")
        
        if !beacons.isEmpty {
            print(beacons)
        }
    }
    
    // 位置情報取得ができたら
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        if status == .authorizedAlways || status == .authorizedWhenInUse {
            self.registerRegions()
        }
        
        // TODO: 許可されていない場合のエラー処理
    }

}

