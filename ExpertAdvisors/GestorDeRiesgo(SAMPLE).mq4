//+------------------------------------------------------------------+
//|                                               GestorDeRiesgo.mq4 |
//|                        Copyright 2019, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2019, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict
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

   //Lectura de ordenes
   for(int i=0;i<OrdersTotal();i++){
   
      int orden = OrderSelect(i,SELECT_BY_POS,MODE_TRADES);
      
      if(OrderProfit()-AccountBalance()<AccountBalance()*0.97 && OrderProfit()<0){
         if(OrderType()==OP_BUY){
            int cierre_largos_riesgo = OrderClose(OrderTicket(),OrderLots(),Bid,10,clrRed);
            break;
         }
         if(OrderType()==OP_SELL){
            int cierre_cortos_riesgo = OrderClose(OrderTicket(),OrderLots(),Ask,10,clrRed);
            break;
         }
      }
      
      if(OrderProfit()+AccountBalance() > AccountBalance()*1.01){
         int order_modify_profit = OrderModify(OrderTicket(),OrderOpenPrice(),OrderOpenPrice(),OrderTakeProfit(),0,clrGreen);
         break;
      }
      
      if( OrderProfit()>0 && iClose(OrderSymbol(),PERIOD_W1,0)>iOpen(OrderSymbol(),PERIOD_W1,0) && OrderType()==OP_SELL){
         int cierre_cortos_rsi = OrderClose(OrderTicket(),OrderLots(),Ask,10,clrRed);
         break;
      }
      
      
   }

   
  }
//+------------------------------------------------------------------+
