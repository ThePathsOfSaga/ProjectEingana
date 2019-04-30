//+------------------------------------------------------------------+
//|                                      AAAAAAA Keltner Inverso.mq4 |
//|                                           2019, Víctor E. Blanco |
//|                                        https://www.sagaquant.com |
//+------------------------------------------------------------------+
#property copyright "2019, Víctor E. Blanco"
#property link      "https://www.sagaquant.com"
#property version   "1.00"
#property strict
input int magic = 17;
input double lots = 0.10;
input double SL = 4;
input double TP = 6;
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
    double keltner = iMA(NULL,0,21,0,0,0,1) + (iATR(NULL,0,14,1)*2);
    if(Close[1]>keltner){
      return true;
    }else{
      return false;
    }
  }
  bool venta(){ 
    double keltner = iMA(NULL,0,21,0,0,0,1) - (iATR(NULL,0,14,1)*2);
    if(Close[1]<keltner){
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
      int order = OrderSelect(i,SELECT_BY_POS,MODE_TRADES);
      if(OrderSymbol()==Symbol() && OrderMagicNumber()==magic){
         trade = false;
      }
   }
   if(trade==true && Hour()==13){
      if(compra()==true && iRSI(NULL,1440,2,0,1)>20){
         int compra = OrderSend(NULL,OP_BUY,lots,Ask,10,Close[0]-(iATR(NULL,0,14,1)*SL),Close[0]+(iATR(NULL,0,14,1)*TP),
         "Keltner Inverso pauta EURAUD",magic,0,clrGreen);
      }
      if(venta()==true && iRSI(NULL,1440,2,0,1)<80){
         int venta = OrderSend(NULL,OP_SELL,lots,Bid,10,Close[0]+(iATR(NULL,0,14,1)*SL),Close[0]-(iATR(NULL,0,14,1)*TP),
         "Keltner Inverso pauta EURAUD",magic,0,clrRed);
      }
   }
   if(trade==false && Hour()==17){
   
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
