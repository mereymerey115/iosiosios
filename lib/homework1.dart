void main(){
  //Task1
  for(int i=1; i<=10; i++){
    for(int j=1; j<=10; j++){
      print("$i*$j=${i*j}");
    }
  }

  //Task2
  int day = 5;
  int month = 9;
  int year = 2026;
  bool leapYear = (year%400==0)||(year%4==0&&year%100!=0);
  int daysInMonth;

  if(month==2){
    if(leapYear){
      daysInMonth = 29;
    }
    else{
      daysInMonth = 28;
    }
  }
  else if(month==4||month==6||month==9||month==11){
    daysInMonth = 30;
  }
  else{
    daysInMonth = 31;
  }

  if(day<1||day>daysInMonth){
    print("invalid date");
  }
  else{
    day++;
  }

  if(day>daysInMonth){
    day = 1;
    month++;
    if(month>12){
      month = 1;
      month++;
    }
  }
  print("$day.$month.$year");

  //Task3
  String t = "flutter mobile development";
  int count = 0;
  for(int i=0; i<t.length; i++){
    String m = t[i];
    if(m=='a'||m=='e'||m=='i'||m=='o'||m=='u'){
      count++;
    }
  }
  print(count);

  //Task4
  List<int> numbers = [14, 88, 3, 42, 99, 12, 67];
  int max = numbers[0];
  int min = numbers[0];
  for(int i=1; i<numbers.length; i++){
    if(numbers[i]<min){
      min=numbers[i];
    }
    if(numbers[i]>max){
      max=numbers[i];
    }
  }
  print("max:$max");
  print("min:$min");

  //Task5
  int number = 3;
  bool isPrime = true;
  if(number<2){
    isPrime = false;
  }
  for(int i=2; i<number; i++){
    if(number%i==0){
      isPrime = false;
    }
  }
  if(isPrime){
    print("prime");
  }
  else{
    print("prime emes");
  }


}