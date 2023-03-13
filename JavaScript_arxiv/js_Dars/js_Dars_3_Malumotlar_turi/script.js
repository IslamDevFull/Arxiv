// JavaScript Malumotlar turi

/* 
JavaScript dinamik tarzda yozilgan 
yani malumotlar turi dinamik tarzda o'zgaradi.
O'zgaruvchanga tayinlash vaqtiga - yoki uning qiymatini
o'zgartirayotganda malumotlar turi aftomatik yoziladi
*/

let userName;  // o'zgaruvchan yaratdik

userName = "Dasturlash to'garagi"  // Satr (Строка) (String)

userName = 58;  // Son (Число) (Number)






// Typeof 

let userName;

console.log(typeof userName);

userName = "Dasturlash to'garagi";
console.log(typeof userName);

userName = 58;
console.log(typeof userName);






// JavaScript da 9 xel malumotlar turi mavjud

/*
1) Undefined
2) Null
3) Boolean
4) Number
5) Bigint
6) String
7) Symbol
8) object
9) function
*/






// 1) Undefinet - nomalum malumot turi

let userName;

console.log(userName);









// 2) Null - Malumot urnatilmagan obyektni chaqirish, yani malumot turi nomalum emas malumot yoq degani

let block = document.getElementById('.block');

console.log(block);







// 3) Boolean - Mantiqiy malumot turi
/*
Boolian bu faqat ikkita qiymatni olishi mumkin
true (Rost) va false (Yolg'on)
*/

let kayfiyatQanday = true;

if (kayfiyatQanday) {
    console.log('Zo`r :)');
}
else {
    console.log('Yomon :(');
}


// Misol

let trueFalse = 58 < 18;

console.log(trueFalse);







// Namber - Son va Kasrli sonlarni malumot turi

let userAge = 20;
let userHeight = 1.83;
console.log(userAge);
console.log(typeof userAge);
console.log(userHeight);
console.log(typeof userHeight);


// misol  (Infinite)

let getInfinite = 50 / 0;
console.log(getInfinite);
console.log(typeof getInfinite);


// misol 2  (NaN) matematicheski xato degan manoni anglatadi

let getInfinite = "Dasturlash"  / 0;
console.log(getInfinite);
console.log(typeof getInfinite);








// Bigint 
// Javascript number malumotlar turida ko'p raqam saqlay olmaydi yani 16 tadan ziyot 9800235486216548 
// 16 tadan ziyot bo'lsa malumot turi o'zgaradi yani Bigint bo'ladi

const bigInteger = 9800235486216548n;
console.log(typeof bigInteger);







// String 
// bizning malumotimiz matn bo'ganda , malumot turi satr bo'ladi yani String
// matnni yozish uchun qo'shtirnoq qo'yish shart 
// qo'shtirnoq qo'yishni 3 xil turi mavjud (" ") (' ') (` `)

let Dasturlash = "Hello World";
console.log(typeof Dasturlash);


// misol (Ikkita o'zgaruvchanni qo'shish (` `) qo'shtirnoqi orqali amalga oshiriladi)

let userAge = 27;
let userAgeInfo = `Mening yoshim : ${userAge}`;
console.log(userAgeInfo);