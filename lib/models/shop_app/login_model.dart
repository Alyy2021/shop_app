class ShopLoginModel
{
  bool status;
  String message;
  UserDate date;

  ShopLoginModel.fromJason(Map<String, dynamic> json)
  {
    status = json['status'];
    message = json['message'];
    date = json['date'] !=null ? UserDate.fromJason(json['date']) : null;

  }
}

class UserDate
{
  int id;
  String name;
  String email ;
  String phone ;
  String image ;
  int points ;
  int credit ;
  String token ;

  UserDate({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.image,
    this.points,
    this.credit,
    this.token,

});

  //named constructor
UserDate.fromJason(Map<String, dynamic> json)
{
id = json['id'];
name = json['name'];
email = json['email'];
phone = json['phone'];
image = json['image'];
points = json['points'];
credit = json['credit'];
token = json['token'];
}
}