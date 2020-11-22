# meli-mobile-challenge

![Swift](https://img.shields.io/badge/Swift-5.0-orange.svg)

Desarrollar una app que utilice las APIs de Mercado Libre con dos secciones, Para lograr esto, Mercado Libre posee APIs abiertas a la comunidad para que cualquier desarrollador las consuma y pueda tener búsquedas y compras en su aplicación.

- Campo de Busqueda: buscador de los productor segun una palabra.
- Detalle de un producto: En el detalle del producto podra ver la descripción general de cada producto (Nombre, Fotos, Precio y Descripción).

# Arquitectura
Se usó como arquitectura del proyecto MVVM.

# Dependencias de Terceros (CocoaPods)

- Moya/RxSwift -> Aqui viene incluido Alamofire para el networking, Moya para la capa de Servicios y RxSwfit para la programación Reactiva.
- RxCocoa -> Programacion reactiva del lado de Uikit.
- RxCodable -> Es una capa de RxSwift para Codable.
- RxDataSources -> Es una capa de RxSwift y RxCocoa para los protocolos y delegados de TableView y CollectionView.
- IQKeyboardManagerSwift -> Permite que el teclado del telefono no solape los elementos editable de la pantalla (ej: TextField).
- R.swift -> Ayuda a obtenner los recursos del sistema y autocompletados como imágenes, fuentes y segues en proyectos Swift.
- Kingfisher -> Todo lo relacion con la descarga y almacenamiento en cache de las imagenes.
- NVActivityIndicatorView -> Es una colección de impresionantes animaciones de carga.

# Instalacion
- Abrir el terminal.
- Ir a la raiz del Proyecto.
- Ejecutar el comando 'pod install'.
- Abrir el archivo 'meli-mobile-challenge.xcworkspace'.
- Ejecutar el proyecto.
