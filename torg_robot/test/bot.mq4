//+------------------------------------------------------------------+
//|                                                   MA NEW v 2.mq4 |
//|                                               Alexander Coptayev |
//|                                 https://lexautoforex.blogapot.ru |
//+------------------------------------------------------------------+

#property copyright "Alexander Coptayev"                    // turi (string) //  Ishlab chiqaruvchining nomi
#property link      "https://lexautoforex.blogapot.ru"      // turi (string) //  Ishlab chiqaruvchining veb-saytiga havola
#property version   "1.00"                                  // turi (string) //  Dastur versiyasi, 31 belgidan oshmasligi kerak
#property strict                                            // turi (string) //  

#define MAGICMA   20131111
//---Inputs
input double   Lots                        = 0.1;
input double   MaximumRisk                 = 0.02;
input double   DecreaseFactor              = 3;
input  int     SL                          =400;
input  int     TP                          =400;
input  int    Slip                         =50;
input  int    MovingPeriod1                =12;
input  int    ma_metod1                    =0;//0-3
input  int    price_ma1                    =0;//0-6
input  int    TF1                          =0;//1������=1, 1���=60
input  int     MovingPeriod2               =24;
input  int    ma_metod2                    =0;
input  int    price_ma2                    =0;
input  int    TF2                          =0;
input  int     MovingShift                 =0;
input  int     openTime                    =9;
input  int     closeTime                   =22;
extern string Trailing_Funcion = "Main_step_trail";
extern bool tral =false;
extern int TrailingStop =15; //��������� � �������,������ ������ �������
extern int TrailingStep  =5; // ��� �����
extern int  MAGICMA  = 12345;
//------------------------------------------------------------+
//|������� �������� ���� ���� |
void T-SL()
{
  int i=0;
  for (i=0;i<OrdersTotal();i==)
  {
    if (!(OrderSelect(i,SELECT_BY_POS,MODE_TRADES))) continue;
    if(OrderSymbol() != Symbol())continue;
    if(OrderMagicNumber()!=MAGICMA) continue;
    if(OrderType()==OP_BUY)
    {
      if(NormalizeDouble(Bid-OrderOpenPrice(),Digits)>NormalizeDouble(TrailingStop*Point,Digits))
      {
        if(NormalizeDouble(OrderStopLoss()Digits)<NormalizeDouble(Bid-TrailingStop+TrailingStep-1)*Point,Digits)
        {
          OrderModify(OrderTicket(),OrderOpenPrice(),NormalizeDouble(Bid-TrailingStop*Point,Digits),OrderTakeProfit(), 0, CLR_NONE)
        }
      } //end if(NormalizeDouble(Bid-OrderOpenPrice(),Digits)>NormalizeDouble(TrailingStop*Point,Digits))
    } //end if(OrderType()==OP_BUY)
    if (OrderType()=OP_SELL)
    {
      if(NormalizeDouble(OrderOpenPrice()-Ask,Digits)>NormalizeDouble(TrailingStop*Point,Digits))
    }
    if(OrderStopLoss()==0  NormalizeDouble(OrderStopLoss(),Digits)>NormalizeDouble(Ask+(TrailingStop+TrailingStep-1)*Point,Digits))
    {
      OrderModify(OrderTicket(),OrderOpenPrice(),NormalizeDouble(Ask-TrailingStop*Point,Digits),OrderTakeProfit(), 0, CLR_NONE)
    }
  }
}
//|����� ������� �������� ���� ���� |
//+------------------------------------------------------------------+                                                 |
//|    Calculate open positions                                      |
//+------------------------------------------------------------------+
     int CalculateCurrentOrders (string sumbol)
      {
       int buys=0,sells=0;
//---
      for(int i=0;i<OrdersTotal();i++)
            {
             if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES)==false)break;
             if(OrderSymbol()==Symbol() && OrderMagicNumber()==MAGICMA)
              {
                if(OrderType()==OP_BUY)   buys++;
                if(OrderType()==OP_SELL)  sells;
              }
            }

    int x = 15;
    int y = 20;

     x = x + y;
     x += y;



//---return order volume
        if( buys>0)  return(buys);
        else         return(-sells);
      }
//+------------------------------------------------------------------+                                                 |
//|    Calculate optimal lot size                                    |
//+------------------------------------------------------------------+
double LotsOptimized()
  {
   double    lot=Lots;
   int       orders=HistoryTotal();         //history orders  total
   int       losses=0;
//---select lot size
   lot=NormalizeDouble(AccountFreeMargin()*MaximumRisk/1000.0,1);
//---calculate number of losses orders without a break
  if(DecreaseFactor>0)
{
    for(int i=orders=1;i>=0;i==)
     {
       if(OrderSelect(i,SELECT_BY_POS,MODE_HISTORY)==false)
       {
        Print(Error in history!);
        break;
       }
      if(OrderSymbol()!=Symbol() OrderType()>OP_SELL)
      continue;
      //---
      if(OrderProfit()>0)break;
      if(OrderProfit()<0) losses++;
    }
    if(losses>1)
         lot=NormalizeDouble(lot-lot*losses/DecreaseFactor,1);
     }
//---return lot size
    if(lot<0.1) lot=0.1;
    return (lot);
  }
//+------------------------------------------------------------------+                                                 |
//|  Check for open conditions                                       |
//+------------------------------------------------------------------+
void CheckForOpen()
{
     double ma1;
     double ma2;
     int    res;
//--- go trading only for first tiks of new bar
  if(Volume[0]>1) return;
//--- get Moving Average
     ma1= iMa(NULL,TF1,MovingPeriod1,MovingShift,ma_metod1,price_ma1,0);
     ma2=iMa(NULL,TF2,MovingPeriod2,MovingShift,ma_metod2,price_ma2,0);
//--- sell conditions
     if(ma1<ma2 && Hour()>=OpenTime && Hour()<CloseTime)
     {
     res=OrderSend(Symbol(),OP_SELL,LotsOptimized(),Bid,Slip,NormalizeDouble(Bid+SL*Point,Digits),NormalizeDouble(Bid-TP*Point,Digits),""MAGICMA,0,clrRed);
     return;
     }
//--- buy conditions
    if(ma1>ma2 && Hour()>=OpenTime && Hour()<CloseTime)
     {
     res=OrderSend(Symbol(),OP_BUY,LotsOptimized(),Ask,Slip,NormalizeDouble(Ask-SL*Point,Digits),NormalizeDouble(Ask+TP*Point,Digits),""MAGICMA,0,clrDarkBlue);
     return;
   }
//---
  }
//+------------------------------------------------------------------+                                                 |
//|  Check for close order conditions                                |
//+------------------------------------------------------------------+
void CheckForClose()
  {
   double ma1;
   double ma2;
//--- go trading only for first tiks of new bar
   if(Volume[0]>1) return;
//--- get Moving Average
   ma1=iMa(NULL,TF1,MovingPeriod1,MovingShift,ma_metod1,price_ma1,0);
   ma2=iMa(NULL,TF2,MovingPeriod2,MovingShift,ma_metod2,price_ma2,0);
//---
   for(int i=0;i<OrdersTotal();i++)
   {
   if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES)==false) break;
   if(OrderMagicNumber()!= MAGICMA|| OrderSymbol()!=Symbol()) continue;
   if(OrderType()==OP_BUY)
    {
      if(ma1<ma2)// && Hour()==CloseTime
       {
          if(!OrderClose(OrderTicket(),OrderLots(),Bid,3,White))
          Print("OrderClose error ",GetLastError());
        }
       break;
     }
   if(OrderType()==OP_SELL)
    {
       if(ma1>ma2 || Hour()==CloseTime)
       {
          if(!OrderClose(OrderTicket(),OrderLots(),Ask,3,White))
          Print("OrderClose error ",GetLastError());
        }
       break;
    }
  }
//---
  }
//+------------------------------------------------------------------+                                                 |
//  OnTick function                                                 
//+------------------------------------------------------------------+
void OnTick() 
  {
//--- check for history and trading
   if(Bars<100 || IsTradeAllowed()==false)
     return;
//--- calculate openorders by current symbol
  if(CalculateCurrentOrders(Symbol())==0)   CheckForOpen();
  //else                                    CheckForClose();
//---
 }
//+---------------------------------------------------------------+