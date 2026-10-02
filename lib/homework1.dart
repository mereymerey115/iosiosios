void main(){
  for(int i=1; i<=10; i++){
    for(int j=1; j<=10; j++){
      print("$i*$j=${i*j}");
    }
  }



  int day = 28;
  int month = 2;
  int year = 2000;
  int daysInMonth;
  if(month==2){
    if(year%400==0||(year%4==0&&year%100!=0)){
      daysInMonth=29;
    }else{
      daysInMonth=28;
    }
  }else if(month==4||month==6||month==9||month==11){
    daysInMonth=30;
  }else{
    daysInMonth=31;
  }

  if(month<1||month>12||day<1||day>daysInMonth){
    print("invalid");
  }else{
    if(day<daysInMonth){
      day++;
    }else{
      day=1;
      if(month<12){
        month++;
      }else{
        month=1;
        year++;
      }
    }
  }
  print("$day.$month.$year");




  String t = "merey";
  int count = 0;
  for(int i=0; i<t.length; i++){
    String m = t[i];
    if(m=="a"||m=="e"||m=="i"||m=="u"||m=="o"){
      count++;
    }
  }print(count);





  List<int> numbers = [5,8,15,19,1];
  int min = numbers[0];
  int max = numbers[0];
  for(int i=0; i<numbers.length; i++){
    if(numbers[i]>max){
      max = numbers[i];
    }else if(numbers[i]<min){
      min = numbers[i];
    }
  }
  print("$min, $max");



  int number = 5;
  bool isPrime = true;
  if(number<2){
    isPrime=false;
  }
  for(int i=2; i<number; i++){
    if(number%i==0){
      isPrime=false;
    }
  }
  if(isPrime){
    print("prime");
  }else{
    print("prime emes");
  }
}