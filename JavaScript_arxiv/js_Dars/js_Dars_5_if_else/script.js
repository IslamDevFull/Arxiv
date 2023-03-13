
// if  Konstruksiyasi   (Shart yaratish konstruksiyasi)

let message = "Hello world";

// Cintaksis
if (2 > 1) {                  // Qavs ichidagi shart to'g'ri bo'lsa agar
    console.log(message);     // Figurali qavs ichidagi kod ishlasin
}


//Misol : Tekshiramis malumotlar turi bormi yoki yo'qmi
let userName;

if (userName === undefined) {       // Qiymatni tekshiradi
    console.log("O'zgaruvchan turi nomalum");
}
else {
    console.log("O'zgaruvchan turi malum ")
}

if (typeof userName === 'undefined') {    // Malumot turini tekshiradi
    console.log("O'zgaruvchan turi nomalum");
}
else {
    console.log("O'zgaruvchan turi malum ")
}



let kayfiyatQanday = true;

if (kayfiyatQanday) {
    console.log('Zo`r :)');
}
else {
    console.log('Yomon :(');
}