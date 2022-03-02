class Product {
  final String name;
  final double price;
  final String imageURL;
  Product({
    required this.name,
    required this.price,
    required this.imageURL,
  });
  static List<Product> products = [
    Product(
        name: "perfume1",
       imageURL:
            'https://www.versace.com/dw/image/v2/ABAO_PRD/on/demandware.static/-/Sites-ver-master-catalog/default/dw80ac7ca3/original/90_R721010-R100MLS_RNUL_20_DylanBluePourHomme100ml-Fragrances-versace-online-store_3_8.jpg?sw=450&sh=632&sm=fit&sfrm=jpg',
        price: 200.0),
    Product(
        name: 'T-Shirt1',
        imageURL:
            'https://encrypted-tbn3.gstatic.com/shopping?q=tbn:ANd9GcS00Gg1rtbk8YZah_SYcoRYXA3LCK5KRG7xddUeQcItehwI1RKx21NY-_T5-sutPzxZUeRx0IVWmxMxI1CTng1IfL_LVS_fJgs17ujqSsgC&usqp=CAE',
        price: 300.0),
    Product(
        name: 'Shoe1',
        imageURL:
            'https://encrypted-tbn0.gstatic.com/shopping?q=tbn:ANd9GcSo6TSsKIgG4xHXzNm_oV8LT6aCnp0Ea8AHkW2wFh3KNNfx4af8lXtpVMMnhiWH3asHIh85XwLEiVbt2cb5ezyrTSC8Y6fznUumXapYyMrOThUrEcMMOfDL8to&usqp=CAE',
        price: 400.0),
    Product(
        name: 'Painting1',
        imageURL:
            'https://i.pinimg.com/736x/61/a4/4a/61a44a36932cac457713b1cb272cb838.jpg',
        price: 500.0),
    Product(
        name: 'Hoodie1',
        imageURL:
            'https://encrypted-tbn1.gstatic.com/shopping?q=tbn:ANd9GcTeifvJqu1ejejfyxAUBXgJGKgWHUJGAAlI5Mdu_9rzE1-wL6tEOof2F946P7OzlNIKbpAnlHvJ1dVsPCfGmtdG4TbFClh1jyROKUYJCLJS9MPrBdhJnjdvYg&usqp=CAE',
        price: 600.0),
  ];
}
