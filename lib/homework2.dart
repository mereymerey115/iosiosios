double balance = 5000;
void checkBalance({
  required String name,
  required double balance,
})=>
    print('$name balance: $balance');
double deposit({
  required double currentBalance,
  double? amount,
}){
  double money = amount??0.0;
  currentBalance = currentBalance+money;
  print('Deposit:$money');
  print('New balance:$currentBalance');
  return currentBalance;
}
double withdarw({
  required String name,
  required double currentBalance,
  double? amount,
  int? pinCode,
}){
  int pin = pinCode??0000;
  double money = amount??0.0;
  if(pin!=1234){
    print('Incorrect PIN');
    return currentBalance;
  }
  if(money>currentBalance){
    print('Insufficient funds');
    return currentBalance;
  }
  currentBalance = currentBalance - money;
  print('$name withdew:$money');
  print('New balance:$currentBalance');
  return currentBalance;
}
void main(){
  String name = "Merey";
  double balance = 5000;
   checkBalance(name: name, balance: balance);
   balance = deposit(currentBalance: balance, amount: 1000,);
   balance = withdarw(name: name, currentBalance: balance, amount: 2000, pinCode: 1234,);
   checkBalance(name: name, balance: balance);
}
