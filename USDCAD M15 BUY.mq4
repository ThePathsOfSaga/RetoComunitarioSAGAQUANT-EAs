//+------------------------------------------------------------------+
//|                                              EstudioRupturas.mq4 |
//|                        Copyright 2019, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2019, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict
input int magic = 10;
int opt_hora = 13;
int opt_c = 3;
int opt_p = 4;
input double SL = 5;
input double TP = 8;
input double lots = 0.01;
bool acotar = true;

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
  
      double minimo_actual = Low[iLowest(NULL,0,MODE_LOW,opt_p,2)];
      double minimo_anterior = Low[iLowest(NULL,0,MODE_LOW,opt_p,3)];
      
      if(Close[1]<minimo_actual && Close[2]>minimo_anterior){
         return true;
      }else{
         return false;
      }
  
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
   
   if(trade==true && Hour()==opt_hora){
   
      if(compra()==true ){
         int compra = OrderSend(NULL,OP_BUY,lots,Ask,10,Close[0]-(iATR(NULL,0,21,1)*SL),
         Close[0]+(iATR(NULL,0,21,1)*TP),"Keltner inverso",magic,0,clrGreen);
      }
    
   }
   if(trade==false && acotar==true){
   
      for(int i=0;i<OrdersTotal();i++){
      
         int orden_acotar = OrderSelect(i,SELECT_BY_POS,MODE_TRADES);
         if(OrderSymbol()==Symbol() && OrderMagicNumber()==magic){
            if(Hour()==opt_hora+opt_c){
               if(OrderType()==OP_BUY){
                  int cierre_largos = OrderClose(OrderTicket(),OrderLots(),Bid,10,clrWhite); 
               }
               if(OrderType()==OP_SELL){
                  int cierre_cortos = OrderClose(OrderTicket(),OrderLots(),Ask,10,clrWhite);
               }
            }
         
         }
      }
   
   
   }
  }
//+------------------------------------------------------------------+
