class Trip{
  String name;
  String image;

  Trip(this.image,this.name);
}
List<Trip> trip = tripData .map((item)=>Trip(item['image'],item['name'] ))
    .toList();

var tripData = [
  {
    "name": "Canada",
    "image": "assets/images/c.jpg",
  },
  {
    "name": "Bali, Indonesia",
    "image": "assets/images/b.jpg",
  },
  {
    "name": "Venice, Italy... Europe",
    "image": "assets/images/v.jpg",
  },


];