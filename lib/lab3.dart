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

  library.addBook(Book("Harry Potter", "J.K. Rowling", 5000));
  library.addBook(Book("1984", "George Orwell", 3500, isBorrowed: true));
  library.addBook(Book("The Hobbit", "J.R.R. Tolkien", 4500));
  library.addBook(Book("The Alchemist", "Paulo Coelho", 3000));

  print("Available books:");

  for (Book book in library.getAvailableBooks()) {
    print("${book.title} - ${book.author}");
  }

  print("Total value: ${library.getTotalValue()}");
}