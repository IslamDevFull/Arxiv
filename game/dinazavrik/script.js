const dino = document.getElementById("dino"); // dino degan O'zgaruvchan Yaratdik va uni html id dino ga uladik
const cactus = document.getElementById("cactus"); // cactuc degan O'zgaruvchan Yaratdik va uni html id cactus ga uladik

document.addEventListener("keydown",function(event) {
    jump();
});

/*function jump () {
    dino.classList.add("jump")
}*/

/////////////////////////////   

function jump () {
    if (dino.classList != "jump"){
        dino.classList.add("jump")
    }
    setTimeout( function(){
        dino.classList.remove("jump")
    },300)
}

//////////////////////////////

let isAlive = setInterval ( function(){
    let dinoTop = parseInt(window.getComputedStyle(dino).getPropertyValue("top"));
    let cactusLeft = parseInt(window.getComputedStyle(cactus).getPropertyValue("left"));
    if (cactusLeft < 20 && cactusLeft > 10 && dinoTop >= 140){
        alert("GAME OVER!!")
    }
}, 10)
