class Jogador{
    PVector posicao;
    int cor_R = 0, cor_G = 0, cor_B = 0;
    int cor_stroke_R = 0, cor_stroke_G  = 0, cor_stroke_B = 0; //preto
    float massa ;  //área do círculo proporcional à massa do jogador
    float direcao; // direção para onde o jogador está virado, em radianos
    float velAng;
    float aceLin;
    int nPlayer;
    
    Jogador(){
      posicao = new PVector(0.0,0.0); //definir 
      massa = 1;
      direcao = 0.0;
      aceLin = 0;
      velAng= 0;
    }
    

    //public void desenha(){
    //  
    //  pushMatrix();
    //  translate(posicao.x, posicao.y);
    //  
    //  
    //  fill(cor_R, cor_G, cor_B); // preto
    //  stroke(cor_stroke_R,cor_stroke_G,cor_stroke_B); //azul se sou eu , vermelho se é o outro
    //  //line(0, 0, direcao, direcao); 
    //  //ellipse(0, 0,massa,massa);
    //  rotate(radians(direcao));
    //  arc(0, 0, massa, massa, 0, HALF_PI+HALF_PI, PIE);
    //  
    //  
    //  popMatrix();
    //}


    public void desenha() {
      pushMatrix();
      translate(posicao.x, posicao.y);

      fill(cor_R, cor_G, cor_B); // preto
      stroke(cor_stroke_R, cor_stroke_G, cor_stroke_B); // azul se sou eu, vermelho se é o outro

      // Desenhar o chapéu indicando a direção
      float chapéuTamanho = massa / 3;
      float chapéuDireção = direcao;

      pushMatrix();
      rotate(radians(chapéuDireção));
      fill(cor_stroke_R, cor_stroke_G, cor_stroke_B);
      noStroke();
      triangle(0, -massa / 2 - chapéuTamanho, -chapéuTamanho / 2, -massa / 2, chapéuTamanho / 2, -massa / 2);
      popMatrix();

      // Desenhar o círculo do avatar
      stroke(cor_stroke_R, cor_stroke_G, cor_stroke_B);
      ellipse(0, 0, massa, massa);

      popMatrix();
    }

    

    
    public void setPosicao(float x, float y) {
		posicao.x = x;
		posicao.y = y;
    } 
    public void setDirecao(float d){
        direcao = d;
    }
    public void setMassa(float m){
      massa = m;
    }
    public void setCor(int n){
      if(n == 1){
        cor_stroke_B = 255;
        cor_stroke_R = 0;
      }
      else{
        cor_stroke_R = 255;
        cor_stroke_B = 0;
      }
    }
   
    public void setAceLin(float a){
        aceLin = a;
    }
    public void setVelAng(float v){
        velAng = v;
    }

}

class Bola{
    PVector posicao;
    int cor_R , cor_G , cor_B; // verdes e azuis aumentam velocidade e aceleraçao respetivamente, vermelho retira os bonus
    int tipo; //verde ou azul da bonus, vermelho retira bonus
    float massa ;  //tem um tam fixo definido na sua criação, podendo existir objectos de vários tam
    
    public Bola(int t, float x, float y, float m){
      posicao = new PVector(x,y); //definir 
      tipo = t;
      massa = m;
    }
    
    void desenha(){
		pushMatrix();
		translate(posicao.x, posicao.y);
		if( tipo==1 ) fill( 0, 255, 0);
    else if (tipo == 2) fill(0, 0, 255);
		else if (tipo ==3 ) fill(255,0,0);
    noStroke();
		ellipse(0,0, massa, massa); 
		popMatrix();
  	} 
    
    public void setPosicao(float x, float y) {
      posicao.x = x;
      posicao.y = y;
    }
    public void setMassa(float m){
      massa = m;
    }
    
    public void setTipo(int t){
      tipo = t;
    }
    
}
