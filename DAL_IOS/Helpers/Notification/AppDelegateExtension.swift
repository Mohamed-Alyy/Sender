//
//  AppDelegateExtension.swift
//  Etihad-Member
//
//  Created by mohamed abdo on 3/20/19.
//  Copyright © 2019 Onnety. All rights reserved.
//


// MARK: - ...  Push Notification Helper & sound Handler
typealias SoundHandler = (Bool) -> Void
private let gcmMessageIDKey = "gcm.message_id"
// MARK: - ...  Notification Control functions
extension AppDelegate {
    // MARK: - ...  Did click on notification
    func notificationControl(notification: [AnyHashable: Any]) {
        let orderID = notification["subject_id"] as? String
        guard let type = notification["type"] as? String else { return }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            if orderID != nil {
                self.navigateToOrder(orderID: orderID?.int, type: type)
            }
        }
        
    }
    func navigateToOrder(orderID: Int?, type: String) {
        guard let scene = R.storyboard.orderDetailsStoryboard.orderDetailsVC() else { return }
        if type == "order_refused" || type == "order_finished" {
            scene.tab = .completed
        }else{
            scene.tab = .processing
        }
       
        scene.orderID = orderID
        
//        let view = UIApplication.topViewController() as? BaseController
        self.pushPop(scene)
        
    }
    
    func pushPop(_ scene: UIViewController) {
        let topVC = self.window?.rootViewController
        scene.modalPresentationStyle = .overFullScreen
        scene.view.backgroundColor = UIColor.black.withAlphaComponent(0.70)
        let transition = CATransition()
        transition.duration = 0.2
        transition.type = CATransitionType.fade
        topVC?.view.window?.layer.add(transition, forKey: kCATransition)
        topVC?.present(scene, animated: false, completion: nil)
    }
    func navigateToReservation(reservationID: Int?, tab: OrdersVC.Tab) {
        guard let scene = R.storyboard.reservationDetailsStoryboard.reservationDetailsVC() else { return }
        scene.tab = tab
        scene.reservationID = reservationID
        
        let view = UIApplication.topViewController() as? BaseController
        view?.pushPop(scene)
    }
    // MARK: - ...  Did present the notification
    func notificationControlWillPresent(notification: [AnyHashable: Any], closure: SoundHandler? = nil) {
        closure?(true)
    }
}
 


import Firebase
import FirebaseMessaging
import UserNotifications


extension AppDelegate {

   func registerForPushNotifications(application: UIApplication) {
       FirebaseApp.configure()
       //REMOTE NOTIFICATION
           if #available(iOS 10.0, *) {
               // For iOS 10 display notification (sent via APNS)
               UNUserNotificationCenter.current().delegate = self

               let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
           UNUserNotificationCenter.current().requestAuthorization(
                   options: authOptions,
                   completionHandler: {_, _ in })
           } else {
               let settings: UIUserNotificationSettings =
               UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
               application.registerUserNotificationSettings(settings)
           }
           application.registerForRemoteNotifications()
           Messaging.messaging().delegate = self
           let token = Messaging.messaging().fcmToken
           print("FCM token: \(token ?? "")")
          clearNotifications()
      }



    fileprivate
    func clearNotifications(){
            UIApplication.shared.applicationIconBadgeNumber = 0
            let center = UNUserNotificationCenter.current()
            center.removeAllDeliveredNotifications() // To remove all delivered notifications
            center.removeAllPendingNotificationRequests() // To remove all pending notifications which are notdelivered yet but scheduled.
    }

}


extension AppDelegate : MessagingDelegate {

func application(_ application: UIApplication,
             didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
    Messaging.messaging().apnsToken = deviceToken as Data
}

func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any]) {
    // Print full message.
    print(userInfo)

}




// MARK:- Messaging Delegates
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        print(" didReceiveRegistrationToken fcmToken", fcmToken)
        UserDefaults.standard.setValue(fcmToken, forKey: "DEVICE_TOKEN")
  }
}

extension AppDelegate {
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any],
                     fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        // If you are receiving a notification message while your app is in the background,
        // this callback will not be fired till the user taps on the notification launching the application.
        // TODO: Handle data of notification

        // With swizzling disabled you must let Messaging know about the message, for Analytics
        // Messaging.messaging().appDidReceiveMessage(userInfo)

        // Print message ID.
        if let messageID = userInfo[gcmMessageIDKey] {
            print("Message ID: \(messageID)")
        }

        // Print full message.
        print(userInfo)
        completionHandler(UIBackgroundFetchResult.newData)
    }


    func messaging(_ messaging: Messaging, didRefreshRegistrationToken fcmToken: String) {
        UserDefaults.standard.setValue(fcmToken, forKey: "DEVICE_TOKEN")
       print(fcmToken)

    }

}

@available(iOS 10, *)
extension AppDelegate : UNUserNotificationCenterDelegate {

    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo
        // Print message ID.
        if let messageID = userInfo[gcmMessageIDKey] {
            print("Message ID: \(messageID)")
        }
        notificationControl(notification: userInfo)
        // Print full message.
        //IF user Open Notification From Notification Center
        print(userInfo)
        completionHandler()
    }

    // This method will be called when app received push notifications in foreground
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void){

        let userInfo = notification.request.content.userInfo
        //
        // With swizzling disabled you must let Messaging know about the message, for Analytics
        // Messaging.messaging().appDidReceiveMessage(userInfo)

        // Print message ID.
        if let messageID = userInfo[gcmMessageIDKey] {
            print("Message ID: \(messageID)")
        }

        // Print full message.
        //IF user Open APP and Notification Arrived
        print(userInfo)

        completionHandler([UNNotificationPresentationOptions.alert,UNNotificationPresentationOptions.sound,UNNotificationPresentationOptions.badge])
    }

}
