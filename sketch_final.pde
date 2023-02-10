void setup() {
  size(700, 700); //画面サイズ
}
float r = random(0,255);//赤の色味
float g = random(0,255);//緑の色味
float b = random(0,255);//青の色味
float x1 = random(-200,200);//x
float y1 = random(-200,200);//y
int L1=200; //アーム1の長さ
int L2=150; //アーム2の長さ
float A1; //アーム1の角度
float A2; //アーム2の角度

void draw() {
  background(128); //背景はグレー
  float x0 = 359;// 画面の中心をx=0とした時の原点
  float y0 = 350;// 画面の中心をy=0とした時の原点
  float x = mouseX-x0; // 画面の中心を0とした時のマウスのx座標
  float y = mouseY-y0;// 画面の中心を0とした時のマウスのy座標

  noStroke();
  fill(150);
  ellipse(x0, y0, 2*abs(L1+L2), 2*abs(L1+L2)); //アームの最大距離の円を描く
  fill(128);
  ellipse(x0, y0, 2*abs(L1-L2), 2*abs(L1-L2)); //アームの最小距離の円を描く
  
  pushMatrix();
  translate(x0,y0);
  translate(x1,y1);//画面の中心を原点とした時に点がランダムに現れる位置
  noStroke();
  fill(r,g,b);//ランダムな色
  ellipse(0,0,20,20);
  popMatrix();


  //アーム1の計算
  float acos1 = sq(x)+sq(y)+sq(L1)-sq(L2); 
  float acos2 = 2*L1*sqrt(sq(x)+sq(y));
  //アーム1の角度を逆運動学で算出
  if (mouseX >= x0) { //atanの範囲が-π/2〜π/2 なので場合分けして計算
    A1 = acos(acos1/acos2)+atan(y/x);
  } else {
    A1 = acos(acos1/acos2)+atan(y/x)+PI;
  }
  //アーム1の線を描画。
  stroke(0, 0, 255);
  strokeWeight(40);
  line(x0,y0,x0+L1*cos(A1), y0+L1*sin(A1)); 

  //アーム2の計算
  float acos3 = sq(L1)+sq(L2)-(sq(x)+sq(y));
  float acos4 = 2*L1*L2;
  float x2 = x0+L1*cos(A1);
  float y2 = y0+L1*sin(A1);
  A2 = PI+acos(acos3/acos4);
 //アーム2の線を描画。
  stroke(0, 255, 0);
  line(x2, y2, x2+ L2*cos(A1+A2), y2+ L2*sin(A1+A2)); 
  
  // アームの先端を表示.目標の点と同じ位置の時は同じ色に,そうでないときは赤.
if(x1-10<x&&x<x1+10&&y1-10<y&&y<y1+10){
  stroke(r,g,b);
  strokeWeight(40);
  rect( mouseX-5, mouseY-5, 11, 11 );
}else{
  stroke(255, 0, 0);
  strokeWeight(20);
  rect( mouseX-5, mouseY-5, 11, 11 ); 
}
}
