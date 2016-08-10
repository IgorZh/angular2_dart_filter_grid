class Address implements Comparable<Address> {
  String city, street;

  Address(this.city, this.street);

  factory Address.fromJson(Map jsonAddress) =>
      new Address(jsonAddress['city'], jsonAddress['street']);

  @override String toString() {
    return [city, street].where((s) => s != null && s.isNotEmpty).join(', ');
  }

  int compareTo(Address other) {
    return toString().compareTo(other.toString());
  }
}