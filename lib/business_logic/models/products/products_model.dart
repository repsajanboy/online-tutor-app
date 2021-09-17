class Products {
  int lesson;
  int price;
  String plan;

  Products({this.lesson, this.price, this.plan});

  Products.fromJson(Map json)
      : lesson = json['lesson'],
        price = json['price'],
        plan = json['plan'];

  Map toJson() => {'lesson': lesson, 'price': price, 'plan': plan};
}

List<Products> productsL = [
  Products(lesson: 2, price: 20, plan: 'price_1HkSwsH7pFPEXwBcD63pWie5'),
  Products(lesson: 4, price: 40, plan: 'price_1HkSwzH7pFPEXwBctZILDEKp'),
  Products(lesson: 6, price: 60, plan: 'price_1HkSx6H7pFPEXwBcJkOT0vtG')
];

List<Products> productsLTest = [
  Products(lesson: 2, price: 20, plan: 'price_1HkSfJH7pFPEXwBckMVhxvhP'),
  Products(lesson: 4, price: 40, plan: 'price_1HkSr8H7pFPEXwBcFiHubMID'),
  Products(lesson: 6, price: 60, plan: 'price_1HkSwBH7pFPEXwBcqOQkY1pr')
];

List<Products> productsB = [
  Products(lesson: 4, price: 49, plan: 'plan_GZkGLhem449VsL'),
  Products(lesson: 8, price: 89, plan: 'plan_GZkGAdqhn5P6St'),
  Products(lesson: 16, price: 159, plan: 'plan_GZkFLT8XGQpWus')
];

List<Products> productsBTest = [
  Products(lesson: 4, price: 49, plan: 'plan_GZkEzvyB5nrR8U'),
  Products(lesson: 8, price: 89, plan: 'plan_GZkER4iW1Mkd6R'),
  Products(lesson: 16, price: 159, plan: 'plan_GZk7q5QknDafnU')
];

class SubsPlan {
  String plan;

  SubsPlan(this.plan);

  SubsPlan.fromJson(Map json)
      : plan = json['plan'];

  Map toJson() => {'plan': plan,};
}