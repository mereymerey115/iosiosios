void processOrder({
  required String orderId,
  required double itemPrice,
  String? promoCode,
  double? deliveryFee,
}){
  double finalDeliveryFee = deliveryFee??500;
  double discount = 0;

  if(promoCode=='SAVE'){
    discount = itemPrice*0.10;
  }
  double finalTotal = itemPrice - discount + finalDeliveryFee;
  print('Order ID: $orderId');
  print('Item price: $itemPrice');
  print('Promo code: ${promoCode??"None"}');
  print('Discount:$discount');
  print('Delivery fee: $finalDeliveryFee');
  print('Final total: $finalTotal');
}
void main(){
  processOrder(orderId: '001', itemPrice: 7000, promoCode: 'SAVE10',);
}