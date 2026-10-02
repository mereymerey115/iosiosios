void checkBalance({
  required String name,
  required double balance
})=>print("$name, $balance");
double deposit({
  required double currentBalance,
  double?amount
}){
  double money = amount??0.0;
  currentBalance = currentBalance+money;
  print(money);
  print(currentBalance);
  return currentBalance;
}
double withdraw({
  required double currentBalance,
  double?amount,
  int?pinCode
}){
  int pin = pinCode??1234;
  double money = amount??0.0;
  if(pin!=1234){
    ("incorrect");
    return currentBalance;
  }
  if(money>currentBalance){
    ("aqsha az ");
    return currentBalance;
  }

  print(money);
  print(currentBalance);
  return currentBalance;
}
void main(){
  double balance = 5000;
  checkBalance(name: "Merey", balance: balance);
  balance = deposit(currentBalance: balance, amount: 500);
  balance = withdraw(currentBalance: balance, pinCode: 1234, amount: 200);
  checkBalance(name: "Merey", balance: balance);
}