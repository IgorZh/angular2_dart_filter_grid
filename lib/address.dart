class Address {
  String city;
  String street;

  Address(this.city, this.street);

  factory Address.fromJson(Map jsonAddress) => new Address(jsonAddress['city'], jsonAddress['street']);
}