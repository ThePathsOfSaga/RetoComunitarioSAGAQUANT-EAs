//+------------------------------------------------------------------+
//|                                              EstudioRupturas.mq4 |
//|                        Copyright 2019, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2019, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict
input int magic = 10; // MAGIC NUMBER
input int SL_MODE = 0; // MODO SL: 0 - VOL | 1 - PIPS
input double SL = 5; // SL (Volatilidad o Pips)
input double TP = 5; // TP 
input double lots = 0.01; // LOTAJE
input bool lo_allow = true; // LARGOS PERMITIDOS
input bool so_allow = true; // CORTOS PERMITIDOS
input bool antiten = true; // MODO ANTITENDENCIAL
input bool tend = true; // MODO TENDENCIAL
input int stoch_long_p = 5; // PERIODO LARGO STOCH
input int stoch_short_p = 3; // PERIODO CORTO STOCH
input int trig_long = 30; // GATILLO STOCH LARGOS
input int trig_short = 70; // GATILLO STOCH CORTOS

int hora = 0;
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
//---
   
//---
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
//---
   
  }
  
  bool compra(){
      
      bool retorno = false;
      bool bol_anti = false;
      bool bol_ten = false;
      int cont = 0;
  //Tendencia bajista - Antitendencial
  if(antiten==true){
  for(int i=1;i<7;i++){
   if(Close[i]<iBands(NULL,0,20,2,0,0,MODE_LOWER,i)){
      cont++;
      if(cont>0){
         bol_anti=true;
      break;}
   }
  }
  
  if(iMA(NULL,0,21,0,0,0,1)<iMA(NULL,0,21,0,0,0,50) && bol_anti==true 
  && iStochastic(NULL,0,stoch_long_p,stoch_short_p,stoch_short_p,0,0,MODE_SIGNAL,1)<iStochastic(NULL,0,stoch_long_p,stoch_short_p,stoch_short_p,0,0,0,1)
  && iStochastic(NULL,0,stoch_long_p,stoch_short_p,stoch_short_p,0,0,MODE_SIGNAL,2)>iStochastic(NULL,0,stoch_long_p,stoch_short_p,stoch_short_p,0,0,0,2) 
  && iStochastic(NULL,0,stoch_long_p,stoch_short_p,stoch_short_p,0,0,0,1)>trig_long && Close[1]>iBands(NULL,0,20,2,0,0,MODE_LOWER,1)){
      retorno = true;
  }
  
}
  if(tend==true){
  for(int i=2;i<8;i++){
   if(Close[i]>iBands(NULL,0,20,2,0,0,MODE_UPPER,i)){
      cont++;
      if(cont>0){
         bol_ten=true;
      break;}
   }
  }
  
  if(iMA(NULL,0,21,0,0,0,1)>iMA(NULL,0,21,0,0,0,50) && bol_ten==true 
  && iStochastic(NULL,0,stoch_long_p,stoch_short_p,stoch_short_p,0,0,MODE_SIGNAL,1)<iStochastic(NULL,0,stoch_long_p,stoch_short_p,stoch_short_p,0,0,0,1)
  && iStochastic(NULL,0,stoch_long_p,stoch_short_p,stoch_short_p,0,0,MODE_SIGNAL,2)>iStochastic(NULL,0,stoch_long_p,stoch_short_p,stoch_short_p,0,0,0,2) 
  && iStochastic(NULL,0,stoch_long_p,stoch_short_p,stoch_short_p,0,0,0,1)>trig_long ){
      retorno = true;
  }
  
}  
  
  
  return retorno;
  }
  bool venta(){
      bool retorno = false;
      bool bol_anti = false;
      bool bol_ten = false;
      int cont = 0;
      //Tendencia bajista - Retorno

  if(antiten==true){
      for(int i=1;i<7;i++){
         if(Close[i]>iBands(NULL,0,20,2,0,0,MODE_UPPER,i)){
         cont++;
         if(cont>0){
         bol_anti=true;
         break;}
      }
  }
  
      if(iMA(NULL,0,21,0,0,0,1)>iMA(NULL,0,21,0,0,0,50) && bol_anti==true 
      && iStochastic(NULL,0,stoch_long_p,stoch_short_p,stoch_short_p,0,0,MODE_SIGNAL,1)>iStochastic(NULL,0,stoch_long_p,stoch_short_p,stoch_short_p,0,0,0,1)
      && iStochastic(NULL,0,stoch_long_p,stoch_short_p,stoch_short_p,0,0,MODE_SIGNAL,2)<iStochastic(NULL,0,stoch_long_p,stoch_short_p,stoch_short_p,0,0,0,2) 
      && iStochastic(NULL,0,stoch_long_p,stoch_short_p,stoch_short_p,0,0,0,1)<trig_short && Close[1]<iBands(NULL,0,20,2,0,0,MODE_UPPER,1) ){
      retorno = true;
  }
  }
  if(tend==true){
      for(int i=2;i<8;i++){
         if(Close[i]<iBands(NULL,0,20,2,0,0,MODE_LOWER,i)){
         cont++;
         if(cont>0){
         bol_ten=true;
         break;}
      }
  }
  
      if(iMA(NULL,0,21,0,0,0,1)<iMA(NULL,0,21,0,0,0,50) && bol_ten==true 
      && iStochastic(NULL,0,stoch_long_p,stoch_short_p,stoch_short_p,0,0,MODE_SIGNAL,1)>iStochastic(NULL,0,stoch_long_p,stoch_short_p,stoch_short_p,0,0,0,1)
      && iStochastic(NULL,0,stoch_long_p,stoch_short_p,stoch_short_p,0,0,MODE_SIGNAL,2)<iStochastic(NULL,0,stoch_long_p,stoch_short_p,stoch_short_p,0,0,0,2) 
      && iStochastic(NULL,0,stoch_long_p,stoch_short_p,stoch_short_p,0,0,0,1)<trig_short ){
      retorno = true;
  }
  }

  return retorno;  

  
  }
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
  {
//---
   bool trade = true;
   for(int i=0;i<OrdersTotal();i++){
   
      int orden_seleccionada = OrderSelect(i,SELECT_BY_POS,MODE_TRADES);
      if(OrderSymbol()==Symbol() && OrderMagicNumber()==magic){
         trade = false;
         break;
      }
      
   }
   
   if(trade==true ){
   
      if(compra()==true && lo_allow == true){
      if(SL_MODE==0){
         int compra = OrderSend(NULL,OP_BUY,lots,Ask,10,Close[0]-(iATR(NULL,0,21,1)*SL),
         Close[0]+(iATR(NULL,0,21,1)*TP),"RayScalper",magic,0,clrGreen);
         hora = Hour();
         }else{
         int compra = OrderSend(NULL,OP_BUY,lots,Ask,10,Close[0]-SL*10*Point,
         Close[0]+TP*10*Point,"RayScalper",magic,0,clrGreen);
         hora = Hour();         
         }
      }
     if(venta()==true  && so_allow == true){
      if(SL_MODE==0){
         int venta = OrderSend(NULL,OP_SELL,lots,Bid,10,Close[0]+(iATR(NULL,0,21,1)*SL),
         Close[0]-(iATR(NULL,0,21,1)*TP),"RayScalper",magic,0,clrRed);
         hora = Hour();}
         else{
         int venta = OrderSend(NULL,OP_SELL,lots,Bid,10,Close[0]+SL*10*Point,
         Close[0]-TP*10*Point,"RayScalper",magic,0,clrRed);
         hora = Hour();         
         }
      }
   
   }

  }
//+------------------------------------------------------------------+
