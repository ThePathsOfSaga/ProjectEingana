//+------------------------------------------------------------------+
//|                                       EURUSD SCALPER FINAL.mq4 |
//|                                           2019, Víctor E. Blanco |
//|                                        https://www.sagaquant.com |
//+------------------------------------------------------------------+
#property copyright "2019, Víctor E. Blanco"
#property link      "https://www.sagaquant.com"
#property version   "1.00"
#property strict
input int magic = 17;
input double lots = 0.01;
input double SL = 4;
input double TP = 6;

/* READ ME 

Timezone adapted to DARWINEX

Zona horaria adaptada a DARWINEX

*/


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
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
  {
//---
   bool trade = true;
   for(int i=0;i<OrdersTotal();i++){
      int order = OrderSelect(i,SELECT_BY_POS,MODE_TRADES);
      if(OrderSymbol()==Symbol() && OrderMagicNumber()==magic){
         trade = false;
      }
   }

   if(trade==true && Hour()==16 && TimeMinute(Time[0])==45 && DayOfWeek()!=4 && DayOfWeek()!=5 ){
      if( Close[1]>iHigh(NULL,1440,1) && iClose(NULL,1440,1)>iOpen(NULL,1440,1) ){
         int compra = OrderSend(NULL,OP_BUY,lots,Ask,10,Close[0]-(iATR(NULL,0,14,1)*SL),Close[0]+(iATR(NULL,0,14,1)*TP),
         "EURUSD Scalper",magic,0,clrGreen);
      }
      if( Close[1]<iLow(NULL,1440,1) && iClose(NULL,1440,1)<iOpen(NULL,1440,1) ){
         int venta = OrderSend(NULL,OP_SELL,lots,Bid,10,Close[0]+(iATR(NULL,0,14,1)*SL),Close[0]-(iATR(NULL,0,14,1)*TP),
         "EURUSD Scalper",magic,0,clrRed);
      }
   }
      if(trade==false && Hour()==17  ){
   
      for(int i=0;i<OrdersTotal();i++){
         int orderc = OrderSelect(i,SELECT_BY_POS,MODE_TRADES);
         if(OrderSymbol()==Symbol() && OrderMagicNumber()==magic){
            if(OrderType()==OP_BUY){
               int cierrelargos = OrderClose(OrderTicket(),OrderLots(),Bid,10,clrBlue);
            }
            if(OrderType()==OP_SELL){
               int cierrecortos = OrderClose(OrderTicket(),OrderLots(),Ask,10,clrBlue);
            }            
         }
      }
   
   }
     }
//+------------------------------------------------------------------+
