//+------------------------------------------------------------------+
//|                                               deadswan_卖2手.mq4 |
//|                                      淘宝旺旺 liuxiaoqian2525400 |
//|                                             http://www.waihui.ru |
//+------------------------------------------------------------------+
#property copyright "淘宝旺旺 liuxiaoqian2525400"
#property link      "http://www.waihui.ru"
double 下单手数=2;
double 止损点数=600;
double 止盈点数=1000;
string 注释="赢家外汇论坛 www.yingjia.im QQ:29996044";
//+------------------------------------------------------------------+
//| script program start function                                    |
//+------------------------------------------------------------------+
int start()
  {
//----
int Ticket;
double zhisun=Bid+止损点数*Point;
double zhiying=Bid-止盈点数*Point;
if(止损点数==0)zhisun=0;
if(止盈点数==0)zhiying=0;
Ticket=OrderSend(Symbol(),OP_SELL,下单手数,Bid,30,zhisun,zhiying,注释,0,0,0);
      if(Ticket<0)
      {
      Print("空单入场失败"+GetLastError()); 
      }
      if(Ticket>0)
      {
      Print("空单入场成功"); 
      }

//----
   return(0);
  }
//+------------------------------------------------------------------+

