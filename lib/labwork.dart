void proccessOrder({
  required String orderId,
  required double itemPrice,
  String?promoCode,
  double?deliveryFee
}){
  double finalDeliveryFee = deliveryFee??500;
  if(finalDeliveryFee<1000){
    finalDeliveryFee = 1000;
  }
  if(itemPrice>4000){
    finalDeliveryFee=finalDeliveryFee*0.12+finalDeliveryFee;
  }
  double discount = 0;
  if(promoCode=="SAVE10"){
    discount = itemPrice*0.10;
  }
  double total = itemPrice-discount+finalDeliveryFee;
  print(orderId);
  print(itemPrice);
  print(promoCode);
  print(finalDeliveryFee);
  print(total);
}
void main(){
  proccessOrder(orderId: "01", itemPrice: 5000, promoCode:"SAVE10", deliveryFee: 300);
}