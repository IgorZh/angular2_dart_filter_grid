class Address implements  Comparable<Address> {
  String city;
  String street;

  Address(this.city, this.street);

  factory Address.fromJson(Map jsonAddress) => new Address(jsonAddress['city'], jsonAddress['street']);

  String toString(){
    return '$city, $street';
  }

  int compareTo(Address other){
    return toString().compareTo(other.toString());
  }
}