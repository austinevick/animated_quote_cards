List<String> images = [
  'images/img1.jpg',
  'images/img2.jpg',
  'images/img3.jpg',
  'images/img4.jpg'
];

List<Cards> cards = [
  Cards(bgImage: 'images/img1.jpg', name: 'Colored light background'),
  Cards(bgImage: 'images/img2.jpg', name: 'Dark Waterfall background'),
  Cards(bgImage: 'images/img3.jpg', name: 'Light fox background'),
  Cards(bgImage: 'images/img4.jpg', name: 'Beautiful flower background'),
];

class Cards {
  final String bgImage;
  final String name;

  Cards({required this.bgImage, required this.name});
}
