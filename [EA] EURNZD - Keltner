//+------------------------------------------------------------------+
//|                                             EURNZD - KELTNER.mq4 |
//|                                           2019, Víctor E. Blanco |
//|                                        https://www.sagaquant.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2019, Víctor E. Blanco"
#property link      "https://www.sagaquant.com"
#property version   "1.00"
#property strict
input double lots = 0.01;
input double SL = 3;
input double TP = 2;
input int magic = 10;

/*

---- NOTAS ----

Modo de uso: EURNZD - M5

Sistema antitendencial basado en bandas de keltner con filtrado horario, adaptado a EURNZD.

Creado con fines didácticos, no se recomienda operarlo. 

No soy un gran entusiasta de los sistemas antitendenciales, pese a que a largo plazo suelen ganar más que los sistemas tendenciales (scalping),
se ven muy afectados por los cambios de volatilidad en mercado y noticias, por lo que hay que tener cuidado con el peso que se le asigna.

--- NOTES ---

Use mode: EURNZD - M5

Antitrend system based on keltner bands with hourly filter, adapted to EURNZD.

This was created for education purposes, use it at your own risk. 

I'm not a very keen about 'trading agaisnt the trend' systems, even though in the long term they tend to earn more than Trend Following scalping systems,
they are very affected by changes in market volatility and news, so we must be careful with the weights assigned to them in a portfolio.

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
/*

Bandas de Keltner:

Si el precio supera la banda alcista devuelve 2
Si el precio perfora la banda bajista devuelve 1

Si el precio no hace nada, devuelve 0

Keltner bands:

If price goes over the upper band, return 1
If price breaks the lower band, return 2

Else return 0
*/  
int keltner(int mode){  
double keltner_a = (iMA(NULL,0,21,0,0,0,1) - (iATR(NULL,0,21,1)*2.5));
double keltner_b = (iMA(NULL,0,21,0,0,0,1) + (iATR(NULL,0,21,1)*2.5));
int retorno = 0;
if(mode==2){
   if(Close[1]>keltner_b ){
      retorno = 2;
   }
}
if(mode==1){
   if(Close[1]<keltner_a ){
      retorno = 1;
   }
}
if(mode==1 && retorno==1){
   return 1;
}  
if(mode==2 && retorno==2){
   return 2;
}      
return 0; 
} 

//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
  {
//---
/*

Comprobar operaciones abiertas. Solo una por día

Check for open orders, one order per day

*/
   bool trade = true;
for(int i=0;i<OrdersTotal();i++){
   int orden = OrderSelect(i,SELECT_BY_POS,MODE_TRADES);
   if(OrderMagicNumber()==magic && OrderSymbol()==Symbol()){
      trade = false;
   }   
} 
for(int i=0;i<OrdersHistoryTotal();i++){
   int orden = OrderSelect(i,SELECT_BY_POS,MODE_TRADES);
   if(OrderMagicNumber()==magic && OrderSymbol()==Symbol() && TimeDay(OrderOpenTime())==TimeDay(Time[1]) 
   && TimeMonth(OrderOpenTime())==TimeMonth(Time[1]) && TimeYear(OrderOpenTime())==TimeYear(Time[1])){
      trade = false;
      break;
   }
   if(OrderMagicNumber()==magic && OrderSymbol()==Symbol() && TimeDay(OrderOpenTime())!=TimeDay(Time[1])
   && TimeMonth(OrderOpenTime())!=TimeMonth(Time[1]) && TimeYear(OrderOpenTime())!=TimeYear(Time[1])){
      break;
   }   
}   
/*

Solo se opera a las 19 hora Darwinex/ICMarkets - Una hora más que España

Only trade at 19. Darwinex/ICMarkets time, one hour more than Spain
*/
bool hora=false;

if(Hour()==19) hora=true;
   if(trade == true && hora==true ){
      if( keltner(1)==1 && keltner(1)!=0 && iMomentum(NULL,60,21,0,1)<100
  ){
        int openlong = OrderSend(Symbol(),OP_BUY,lots,Ask,10,Close[0]-(iATR(NULL,0,14,1)*SL)
         ,Close[0]+(iATR(NULL,0,14,1)*TP),NULL,magic,0,clrBlue);
      } 
      if( keltner(2)==2 && keltner(2)!=0 && iMomentum(NULL,60,21,0,1)>100
       ){
       int openshort = OrderSend(Symbol(),OP_SELL,lots,Bid,10
         ,Close[0]+(iATR(NULL,0,14,1)*SL),Close[0]-(iATR(NULL,0,14,1)*TP),NULL,magic,0,clrBlue); 


      }
   }
/*

Ningún sistema de ProjectEingana mantiene posiciones durante el cambio de día para evitar Swap y spreads aumentados.

No system of ProjectEingana holds positions overnight, in lieu of paying swaps and dealing with big spreads we just close the trade


*/   
   if(trade == false){
   
          for(int i=0;i<OrdersTotal();i++){
         int orden = OrderSelect(i,SELECT_BY_POS,MODE_TRADES);
        if(OrderType()==OP_BUY && TimeHour(Time[0])==23 && OrderSymbol()==Symbol() && OrderMagicNumber()==magic){
            int closelong = OrderClose(OrderTicket(),lots,Bid,10,clrWhite);
         }
         else if(OrderType()==OP_SELL && TimeHour(Time[0])==23 && OrderSymbol()==Symbol() && OrderMagicNumber()==magic){
            int closeshort = OrderClose(OrderTicket(),lots,Ask,10,clrWhite);
         }
      }
   }   
  }
