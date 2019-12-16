window.onload = function(){
    var col , 
        row , 
        lei_n , // 雷数
        lei_flag = 0, // 类标记数量
        mount = 0,
        save_num = 0, // 不是雷被点开的数量
        setTime,
        useTime = 0,
        lock = true;
        map = [];
        
    var mysaolei = document.getElementById("mysaolei"), // 存储地图位置信息
        begin = document.getElementById("begin"),
        again = document.getElementById("again"),
        time = document.getElementById("time"),
        leave = document.getElementById("leave"),
        col_v = document.getElementById("col"),
        row_v = document.getElementById("row"),
        lei_v = document.getElementById("lei");

    var reg = /^\d+$/;

    col_v.addEventListener('input',function(){       
        if(reg.test(col_v.value) ){
            if(col_v.value < 1 ){
                col_v.value = 1;
            }else if(col_v.value > 40){
                col_v.value = 40;
            }
        }else{
            col_v.value = '';
        }
    })
    row_v.addEventListener('input',function(){       
        if(reg.test(row_v.value) ){
            if(Number(row_v.value)  < 1 ){
                row_v.value = 1;
            }else if(Number(row_v.value) > 30){
                row_v.value = 30;
            }
        }else{
            row_v.value = '';
        }
    })
    lei_v.addEventListener('input',function(){       
        if(reg.test(lei_v.value) ){
            if(Number(lei_v.value) < 1 ){
                lei_v.value = 1;
            }else if(Number(lei_v.value) > 1200){
                lei_v.value = 1200;
            }
        }else{
            lei_v.value = '';
        }
    })
    begin.onclick = function(){
        col =  col_v.value || 10;
        row =  row_v.value || 10;
        lei_n =  lei_v.value || 10;
        if((col * row) < lei_n){
            alert("雷太多了，格子放不下了！");
            return false;            
        }
        this.style.display = "none";
        again.style.display = "block";
        init();
        
    }
    again.onclick = function(){
        col =  col_v.value || 10;
        row =  row_v.value || 10;
        lei_n =  lei_v.value || 10;
        if((col * row) < lei_n){
            alert("雷太多了，格子放不下了！");
            return false;            
        }
        map = [];
        lei_flag = 0;
        save_num = 0;
        mount = 0;
        useTime = 0;
        clearInterval(setTime);
        mysaolei.innerHTML = '';        
        init();
    }

    function createMap(){ // 创建地图数组
        for(var i = 0; i < row; i ++){
            map[i] = [];
            for(var j = 0; j < col; j ++){
                map[i][j] = {'x' : i ,'y' : j , 'num' : 0 , 'flag' : false , 'lei': false}
            }
        }
        createLei();  
        computeNum();   
    }

    function createLei(){
        lei_map = 0; // 雷以创建个数
        for(;;){
            var randomX = parseInt(Math.random() * row);
            var randomy = parseInt(Math.random() * col);
            if(lei_map == lei_n){
                return
            }else if(!map[randomX][randomy].lei){
                map[randomX][randomy].lei = true;
                lei_map ++;
            }
        }
    }

    function computeNum(){ // 数组负值
        for(var i = 0; i < row; i ++){            
            for(var j = 0; j < col; j ++){                
                if(map[i][j].lei){                
                    if(map[i-1] && map[i-1][j-1] && !map[i-1][j-1].lei){map[i-1][j-1].num ++};
                    if(map[i-1] && map[i-1][j]   && !map[i-1][j].lei  ){map[i-1][j].num ++};
                    if(map[i-1] && map[i-1][j+1] && !map[i-1][j+1].lei){map[i-1][j+1].num ++};
                    if(map[i]   && map[i][j-1]   && !map[i][j-1].lei  ){map[i][j-1].num ++};
                    if(map[i]   && map[i][j+1]   && !map[i][j+1].lei  ){map[i][j+1].num ++};
                    if(map[i+1] && map[i+1][j-1] && !map[i+1][j-1].lei){map[i+1][j-1].num ++};
                    if(map[i+1] && map[i+1][j]   && !map[i+1][j].lei  ){map[i+1][j].num ++};
                    if(map[i+1] && map[i+1][j+1] && !map[i+1][j+1].lei){map[i+1][j+1].num ++};
                }
            }
        }
    }

    function mapInBox(){ // 地图展示
        mysaolei.style.width = col * 27 + 2 + 'px';
        mysaolei.style.height = row * 27 + 2 + 'px';         
        mysaolei.oncontextmenu = function(){return false}; // 禁止右键菜单事件
        for(var i = 0; i < row; i ++){
            for(var j = 0; j < col; j ++){
                var temp =  createSquare(map[i][j]);
                mysaolei.appendChild(temp);
            }
        }
    }

    function createSquare(obj){ // 创建单元格 
        var square = document.createElement('div');
        square.style.top = obj.x * 25 + (obj.x + 1) * 2 + 'px';
        square.style.left = obj.y * 25 + (obj.y + 1) * 2 + 'px';
        square.num = obj.num;
        square.flag = obj.flag;
        square.lei = obj.lei;
        square.index = [obj.x, obj.y];
        square.eq = obj.x * row + obj.y;
        square.addEventListener('mousedown',click);
        return square;
    }

    function click(event){ // 点击事件
        if(!lock){return false}
        var e = event || window.event; 
        if(e.which == 1){
            leftClick(this);
        }
        if(e.which == 3) {
            rightClick(this)
        }
    }
    function leftClick(self){ // 左键事件
        if(!self.className){
            if(self.lei){
                self.classList.add("lei");
                gameOver();
            }else{
                // console.log(self.eq);
                var x = self.index[0];
                var y = self.index[1];
                self.classList.add("save");
                save_num ++ ;
                if(self.num !=0 ){                    
                    self.innerHTML = self.num;
                }else if (self.num == 0){
                    for( var i = x - 1 ; i < x + 2; i ++){
                        for(var j = y - 1; j < y + 2;j ++){
                            var arr = [i,j];
                            if(mysaolei.children[i*col + j] && (mysaolei.children[i*col + j].index[0] == arr[0] && mysaolei.children[i*col + j].index[1] == arr[1])){
                                leftClick(mysaolei.children[i*col + j]);
                            }
                        }
                    }
                }
                isGameWin();
            }
        }
    }
    function rightClick(self){ // 右键事件
        if(self.classList.contains("flag") || !self.className){
            self.classList.toggle("flag");
            self.flag = !self.flag;
            lei_flag = self.flag ? lei_flag + 1 : lei_flag - 1;
            if(lei_n == lei_flag){ 
                for(var i = 0; i < mysaolei.children.length; i++){
                    if ((mysaolei.children[i].flag + mysaolei.children[i].lei) == 2){
                        mount += 1;
                    }
                }
                if(mount != lei_n){
                    mount = 0
                }
            }
        }
        showLeaveLei();
        isGameWin();
    }

    function gameOver(){ // 游戏结束事件
        for(var i = 0; i < mysaolei.children.length; i++){
            if(mysaolei.children[i].lei){
                mysaolei.children[i].classList.add("lei");
            }            
        }
        lock = false;
        clearInterval(setTime);
        setTimeout(function(){
            alert("触雷啦~~~!");
        },500)
    }
    function isGameWin(){
        if(mount == lei_n || save_num == (row * col - lei_n)){
            lock = false;
            clearInterval(setTime);
            alert('恭喜你过关过关啦！');
            map = [];
            lei_flag = 0;
            save_num = 0;
            mount = 0;
        }
    }
    function showLeaveLei(){
        leave.innerHTML = lei_n - lei_flag + '个';
    }
    function init(){
        lock = true;
        createMap();           
        // console.log(map);        
        mapInBox();
        showLeaveLei();
        setTime = setInterval(function(){
            useTime += 0.5;
            time.innerHTML = parseInt(useTime) + 's';
        },500)
    }  
}