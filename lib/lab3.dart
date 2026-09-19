class Book {
  String title;
  String author;
  double price;
  bool isBorrowed;

  Book(this.title, this.author, this.price, {this.isBorrowed = false});
}

class Library {
  List<Book> _books = [];

  void addBook(Book book) {
    _books.add(book);
  }

  List<Book> getAvailableBooks() {
    return _books.where((book) => book.isBorrowed == false).toList();
  }

  double getTotalValue() {
    return _books.fold(0.0, (total, book) => total + book.price);
  }
}

void main() {
  Library library = Library();

  library.addBook(Book("Culpa Mia", "Mercedes Ron", 5000));
  print("Available books:");

  for (Book book in library.getAvailableBooks()) {
    print("${book.title} - ${book.author}");
  }

  print("Total value: ${library.getTotalValue()}");
}