//+------------------------------------------------------------------+
//|                                               deadswan_买2手.mq4 |
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
  if (TimeCurrent()>D'2014.02.10') //这里设定过期时间

   { 

      Alert("软件过期!请联系淘宝旺旺liuxiouqian2525400"); 

      return(0); 

   } 
int Ticket;
double zhisun=Ask-止损点数*Point;
double zhiying=Ask+止盈点数*Point;
if(止损点数==0)zhisun=0;
if(止盈点数==0)zhiying=0;
Ticket=OrderSend(Symbol(),OP_BUY,下单手数,Ask,30,zhisun,zhiying,注释,0,0,0);
      if(Ticket<0)
      {
      Print("多单入场失败"+GetLastError()); 
      }
      if(Ticket>0)
      {
      Print("多单入场成功"); 
      }

//----
   return(0);
  }
//+------------------------------------------------------------------+

