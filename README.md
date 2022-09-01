#GarageApp

##Detail:

To make code loosely coupled I am using MVVM as an Architecture pattern
with a seprate controller for UI.

for Networking I have used Moya(Third Party Library).
Moya is a Swift network abstraction library. it provieds us with an abstraction to make network calls without directly communicating with Alamofire

##Local Storage
for Local Storage I have used Realm.
Realm is a crossplatform mobile database designed for mobile application.


### Why I opted for Realm?
- Realm is fast library to work with databases. Realm is faster than SQlite and CoreData.
- Realm databases files are CrossPlatform and can be shared among iOS and Android.
- Realm is simple and easy to use. Realm removes a lot of boilerplate code.
- Unlike many other library realm doesn't rely on Core data or SQLIte.
 
 
### ViewController
 - LoginViewController -> For Logging In.
 - SignUpViewController -> For creating new account in database.
 - DashboardViewController -> After Logging in , you can add car here and even delete them. you can also add Image.
 


 
