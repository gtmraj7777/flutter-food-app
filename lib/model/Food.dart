
class Food
{
  String _foodImage;
  String _foodName;
  String _foodPrice;

  Food(this._foodImage, this._foodName, this._foodPrice);

  String get foodPrice => _foodPrice;

  set foodPrice(String value) {
    _foodPrice = value;
  }

  String get foodName => _foodName;

  set foodName(String value) {
    _foodName = value;
  }

  String get foodImage => _foodImage;

  set foodImage(String value) {
    _foodImage = value;
  }
}