# app_cf_marvel

Esta aplicación está diseñada para consumir la API de Marvel y proporcionar a los usuarios información y detalles sobre cómics de Marvel. Utiliza patrones arquitectónicos como el Modelo-Vista-Controlador (MVC) y el patrón Provider para la gestión del estado reactivo. Además, integra funcionalidades avanzadas como autenticación OAuth2, notificaciones locales, compras dentro de la aplicación, y publicidad. La interfaz de usuario está optimizada con animaciones y transiciones fluidas para una experiencia de usuario mejorada.

## Directory Structure
```
|-- lib
|   |-- main.dart
|   |-- locator.dart
|   '-- lib
|       |-- data
|       |   |-- local
|       |   |    |-- database_app.dart
|       |   |    '-- tables.dart
|       |   |-- remote
|       |       |-- api.dart
|       |       '-- apiMarvel.dart
|       |-- main_store
|       |   '-- main_state.dart
|       |-- navigation
|       |   |-- navigation_app.dart
|       |   |-- transitions.dart
|       |   '-- route.dart
|       |-- model
|       |   |-- comics_model.dart
|       |   |-- events_model.dart
|       |   |-- series_model.dart
|       |   |-- session_model.dart
|       |   '-- user_model.dart
|       |-- repository
|       |   |-- comics_repo.dart
|       |   |-- series_repo.dart
|       |   |-- events_repo.dart
|       |   |-- session_repo.dart
|       |   '-- user_repo.dart
|       |-- res
|       |   |-- images
|       |   '-- theme
|       |       |-- light_color.dart
|       |       '-- theme.dart
|       |-- services
|       |   '-- notifications_service.dart
|       |-- util
|       |   |-- constants.dart
|       |   '-- validate.dart
|       |-- view
|       |   |-- comics_screen.dart
|       |   |-- favorites_screen.dart
|       |   |-- home_screen.dart
|       |   |-- login_screen.dart
|       |   |-- main_screen.dart
|       |   |-- notifications_screen.dart
|       |   '-- splash_screen.dart
|       |-- view_model
|       |   |-- comics
|       |       '-- comics_state.dart
|       |   |--session
|       |       '-- session_state.dart
|       |   |-- user
|       |       '-- user_state.dart
|       '-- widgets
|           |-- navigatorBar_widget.dart
|           |-- display_notification_widget.dart
|           |-- series_widget.dart
|           |-- events_widget.dart
|           '-- comics_widget.dart
|-- pubspec.yaml
|-- screenshots
|   |-- app-1.jpg
|   |-- app-2.jpg
|   |-- app-3.png
|   '-- app-4.png
'-- test



## Android Screenshots

  HomePage                 |    Detail Page        
:-------------------------:|:-------------------------:
![](https://github.com/TheAlphamerc/flutter_healthcare_app/blob/master/screenshots/screenshot_1.jpg?raw=true)|![](https://github.com/TheAlphamerc/flutter_healthcare_app/blob/master/screenshots/screenshot_2.jpg?raw=true)

  HomePage                 |    Detail Page      
:-------------------------:|:-------------------------:
![](https://github.com/TheAlphamerc/flutter_healthcare_app/blob/master/screenshots/screenshot_ios_1.png?raw=true)|![](https://github.com/TheAlphamerc/flutter_healthcare_app/blob/master/screenshots/screenshot_ios_2.png?raw=true)



