function getRandom(min,max){
    return Math.floor(Math.random()*(max-min+1))+min;
};
let button = document.getElementById('btn');
let button2 = document.getElementById('refresh');
let img1 = document.getElementById('gif1');
let arr = ['向上水餃','紅豆食堂','森記快餐店','攎胃專家','鼎元食堂','香福記','珍繕坊','向陽樓','食代鋪','就要醬滷','蓬萊快餐','無名麻辣','老蕭牛肉麵'
    ,'九州拉麵店','來來','斗六門','三民煮藝','阿婆炒飯','小阿姨','力軒屋','二水臭豆腐','紅辣椒','億品鍋','養雞場','美地食堂','蔣氏咖哩'
    ,'炒飯英雄','松鶴拉麵','嚴發鐵板便當','傻瓜麵','拌麵堂','小魚兒食堂','小辣椒','鹿港洪控肉飯','A炊米飯','吉祥自助餐','麻川家','小餅屋'
    ,'清一色','東香來','黑盒子','今後屋','Mak&May kitchen','福建炒麵','大滷桶','腦子有丼','燒肉188','石二鍋','客家湯圓'
    ,'億品豆花','大麻粉圓','學甲人紅豆餅','溫蒂廚房','碗裏','鄭二家','純粹咖哩','刁民酸菜魚','辛德里咖哩','一生懸命'];
button2.style.display = 'none';

var input = document.getElementById("btn");
input.addEventListener("keypress", function(event) {
  if (event.key === "Enter") {
    event.preventDefault();
    document.getElementById("btn").click();
  }
});
button.addEventListener('click', () => {
    const result = document.getElementById('output');
    var music = new Audio('audio3.mp3');
    music.play();
    result.innerHTML = '<br>今晚 我想來點:'+arr[getRandom(0,58)];
    button.style.display = 'none';
    button2.style.display = 'block';
});
const reloadtButton = document.querySelector("#reload");
    function reload() {
        reload = location.reload();
    }
    reloadButton.addEventListener("click", reload, false);