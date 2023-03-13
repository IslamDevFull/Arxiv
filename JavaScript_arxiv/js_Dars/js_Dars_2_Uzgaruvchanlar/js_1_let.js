
// let  Uzgaruvchan yaratish

// Uzgaruvchaning Kaleti

let;        // ( let be ) , ( Пусть ) , ( Bo'lsin )

/*
o'zgaruvchan nomi faqat 
harflardan iborat bo'lishi mumkin,
*/


// uzgaruvchaning ismi harflar bilan boshlanishi kerak son bilan emas
// biror bir belgi bilan boshlasa ham bo'ladi
// $ _ 

// To'g'ri 
let age;
let info123;
let $size;
let _color;


// noto'g'ri
let 123info;
let my-age;



// o'zgaruvchanlarning ismini manolik qo'yish maslaxat beriladi

let x12st15;    // manosiz

let name;       // manolik
let age;        // manolik


// o'zgaruvchaning nomi ikki yoki uch manolik bo'lsa agar  
// lowerCamelCase uslubini qo'lash maslahat beriladi

let sizeLeft;           // lowerCamelCase
let leftSidebar;        // lowerCamelCase
let boxCub;             // lowerCamelCase




// boshqa harflar

let имя;
let фамилия;
let あかさ;
let あかさあかさ;





// kaletli so'zlani o'zgaruvchan ismga ishlatib bo'lmaydi
/*
let let;
let break;
let for;
*/







// O'zgaruvchanga qiymat berish

let myStyle = 'Back and';


let myStyle;

myStyle = 'Back and';






// bir qatordagi o'zgaruvchan
let myName = 'Islom', myAge = 27, myStyle = 'full stack';

// ko'p qatorlik o'zgaruvchan
let myName = 'Islom',
myAge = 27,
myStyle = 'full stack';

// alohida berilgan o'zgaruvchan
let myName = 'Islom';
let myAge = 27;
let myStyle = 'full stack';




// qiymatni o'zgartirish
let myAge = 26;

myAge = 27;





// qiymatini boshqa o'zgaruvchanga o'rnatish;
let myAge = 26;

let myNewAge = 27;

myAge = myNewAge

console.log(myAge);


 




// Murakab tartib

/* let */ myAge = 27;
console.log(myAge);

"use strict"

let myAge = 27;
console.log(myAge);




// O'zgaruvchan yaratgandan keyin 
// O'zgaruvchanni ishlatish kerak
console.log(myAge);

let myAge = 18;




// O'zgaruvchaning Ko'rinish chegaralari
    // misol
function testBlock() {
    let myAge = 27;
}
testBlock();

console.log(myAge);


    // misol 2
let myAge = 25;

function testBlock() {
    let myAge = 27;
}
testBlock();

console.log(myAge);





// Kaletni qayta yozish
let myAge = 27;
let myAge = 25;




// O'zgaruvchan aylanmani ichida
for (let i = 0; i < 3; i++) {
    console.log(i); // Bu erda alohida uzgaruvchan
}

for (let i = 0; i < 3; i++) {
    console.log(i); // Bu erda xam alohida uzgaruvchan
}




let islom = "Amirbek";

console.log(islom);