abstract class MediaItem {
  String id;
  String title;
  double price;

  MediaItem(this.id, this.title, this.price);
  String getDetails();
}

mixin Downloadable{
  void download(String title) {
    print("Downloading: $title");
  }
}

class Audiobook extends MediaItem with Downloadable{
  double durationHours;
  String narrator;

  Audiobook(
      String id,
      String title,
      double price,
      this.durationHours,
      this.narrator,
      ):super(id, title, price);

  @override
  String getDetails(){
    return "$title $price $durationHours $narrator";
  }
}

class EBook extends MediaItem with Downloadable{
  double fileSizeMB;
  String author;

  EBook(
      String id,
      String title,
      double price,
      this.fileSizeMB,
      this.author,
      ):super(id, title, price);


  @override
  String getDetails(){
    return "$title $price $fileSizeMB $author";
  }
}

class ShoppingCart {
  List<MediaItem> _items = [];

  void addItem(MediaItem item) {
    _items.add(item);
  }

  double calculateTotalWithTax({double taxRate = 0.12}) {
    double total = _items.fold(0,(sum, item) => sum + item.price);

    return total + (total * taxRate);
  }

  List<MediaItem> filterByMaxPrice(double maxPrice) {
    return _items.where((item) => item.price <= maxPrice).toList();
  }

  void printReceipt() {
    for (MediaItem item in _items) {
      print(item.getDetails());

      if (item is Downloadable) {
        (item as Downloadable).download(item.title);
      }
    }
    print("Total with tax: \$${calculateTotalWithTax().toStringAsFixed(2)}");
  }
}

void main() {
  Audiobook audiobook1 = Audiobook("A01", "Harry Potter", 15.0, 8.5, "Jim Dale",);
  Audiobook audiobook2 = Audiobook("A02", "The Alchemist", 10.0, 6.0, "Jeremy Irons");

  EBook ebook1 = EBook("E01", "1984", 18.0, 4.5, "George Orwell");
  EBook ebook2 = EBook("E02", "The Little Prince", 7.0, 2.5, "Antoine de Saint-Exupery",);

  ShoppingCart cart = ShoppingCart();

  cart.addItem(audiobook1);
  cart.addItem(audiobook2);
  cart.addItem(ebook1);
  cart.addItem(ebook2);

  print("Items under \$15:");
  List<MediaItem> cheapItems = cart.filterByMaxPrice(15);
  for (MediaItem item in cheapItems) {
    print(item.getDetails());
  }
  print("");

  cart.printReceipt();
}