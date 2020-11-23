# meli-mobile-challenge

![Swift](https://img.shields.io/badge/Swift-5.0-orange.svg)

Desarrollar una app que utilice las APIs de Mercado Libre con dos secciones, para lograr esto, Mercado Libre posee APIs abiertas a la comunidad para que cualquier desarrollador las consuma y pueda tener búsquedas y compras en su aplicación.

- **Campo de Busqueda**: buscador de los productor segun un query.
- **Detalle de un producto**: En el detalle del producto podra ver la descripción general de cada busqueda (Nombre, Fotos, Precio y Descripción).

# Arquitectura
Se usó como arquitectura de proyecto MVVM, en particular con un enfoque reactivo.

# Dependencias de Terceros (CocoaPods)

- **Moya/RxSwift** -> Aqui viene incluido Alamofire para el networking, Moya para la capa de servicios y RxSwfit para la programación reactiva.
- **RxCocoa** -> Programacion reactiva del lado de UIKit.
- **RxCodable** -> Es una capa de RxSwift para Codable.
- **RxDataSources** -> Es una capa de RxSwift y RxCocoa para los protocolos y delegados de TableView y CollectionView.
- **IQKeyboardManagerSwift** -> Permite que el teclado del telefono no solape los elementos editable de la pantalla (ej: TextField).
- **R.swift** -> Ayuda a obtenner los recursos del sistema y autocompletados como imágenes, fuentes y segues en proyectos Swift.
- **Kingfisher** -> Todo lo relacion con la descarga y almacenamiento en cache de las imagenes.
- **NVActivityIndicatorView** -> Es una colección de impresionantes animaciones de carga.

# Instalación
- Clonar el repositorio.
- Abrir el terminal.
- Ir a la raiz del proyecto.
- Ejecutar el comando 'pod install'.
- Abrir el archivo 'meli-mobile-challenge.xcworkspace'.
- Insertar el archivo R.generated dentro de la carperta 'Suporting File' en Xcode como una refencia del original.
- Ejecutar la aplicación.

# Vistas
![Screen_1](https://github.com/venganza147/meli-mobile-challenge/blob/main/meli-mobile-challenge/img/Screen_1.png)
![Screen_2](https://github.com/venganza147/meli-mobile-challenge/blob/main/meli-mobile-challenge/img/Screen_2.png)

