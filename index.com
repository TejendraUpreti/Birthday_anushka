<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>For My Love Betu Ji❤️</title>

<style>
body {
    margin: 0;
    background: linear-gradient(to right, #ff758c, #ff7eb3);
    font-family: Arial;
    text-align: center;
    color: white;
    overflow: hidden;
}

.container {
    position: absolute;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
}

button {
    padding: 12px 25px;
    border-radius: 30px;
    border: none;
    margin: 5px;
    font-size: 16px;
    cursor: pointer;
}

.hidden { display: none; }

img {
    width: 250px;
    border-radius: 20px;
}

/* Floating */
.item {
    position: absolute;
    animation: float 5s linear infinite;
}
@keyframes float {
    0% {transform: translateY(100vh);}
    100% {transform: translateY(-10vh);}
}
</style>

</head>

<body>

<div class="container">

<h1>Hey My Love ❤️</h1>
<button onclick="start()">Tap for Surprise 💖</button>

<div id="content" class="hidden">

<h2 id="msg"></h2>

<!-- Slideshow -->
<img id="slide" src="photo1.jpg">

<!-- Countdown -->
<div id="countdown"></div>

<!-- Video -->
<video id="video" width="250" controls class="hidden">
  <source src="video.mp4" type="video/mp4">
</video>

<br>

<button onclick="sendLove()">Send Love 💌</button>

<h3 id="final" class="hidden">Will you always be mine? 💍❤️</h3>

</div>

</div>

<audio id="music" loop>
<source src="song.mp3" type="audio/mpeg">
</audio>

<script>
let tap = 0;

function start() {
    tap++;
    document.getElementById("content").classList.remove("hidden");
    document.getElementById("music").play();

    if (tap == 1) {
        flowers();
        typeText();
        slideshow();
        countdown();
        checkLocation();
    }

    else if (tap == 2) {
        stars();
        document.getElementById("video").classList.remove("hidden");
    }

    else if (tap == 3) {
        document.getElementById("final").classList.remove("hidden");
    }
}

// 🌸 Flowers
function flowers() {
    setInterval(()=>{
        let f = document.createElement("div");
        f.className="item";
        f.innerHTML="🌸";
        f.style.left=Math.random()*100+"vw";
        document.body.appendChild(f);
        setTimeout(()=>f.remove(),5000);
    },300);
}

// ✨ Stars
function stars() {
    setInterval(()=>{
        let s = document.createElement("div");
        s.className="item";
        s.innerHTML="✨";
        s.style.left=Math.random()*100+"vw";
        document.body.appendChild(s);
        setTimeout(()=>s.remove(),5000);
    },300);
}

// 💌 Typewriter
let text="You are my everything ❤️";
let i=0;
function typeText(){
    if(i<text.length){
        document.getElementById("msg").innerHTML+=text[i];
        i++;
        setTimeout(typeText,50);
    }
}

// 📸 Slideshow
let imgs=["photo1.jpg","photo2.jpg","photo3.jpg"];
let idx=0;
function slideshow(){
    setInterval(()=>{
        idx=(idx+1)%imgs.length;
        document.getElementById("slide").src=imgs[idx];
    },2000);
}

// 🎂 Countdown
function countdown(){
    let bday=new Date("2026-05-21");
    setInterval(()=>{
        let now=new Date();
        let diff=bday-now;
        let d=Math.floor(diff/(1000*60*60*24));
        document.getElementById("countdown").innerHTML="Birthday in "+d+" days 🎂";
    },1000);
}

// 📍 Location Check (simple)
function checkLocation(){
    if(navigator.geolocation){
        navigator.geolocation.getCurrentPosition(pos=>{
            let lat=pos.coords.latitude.toFixed(2);
            let lon=pos.coords.longitude.toFixed(2);

            // 👉 Apna location daalo
            if(lat!="27.00" || lon!="78.00"){
                alert("Open this surprise at home ❤️");
            }
        });
    }
}

// 📲 WhatsApp Button
function sendLove(){
    let msg="I Love You ❤️";
    window.open("https://wa.me/?text="+encodeURIComponent(msg));
}
</script>

</body>
</html>