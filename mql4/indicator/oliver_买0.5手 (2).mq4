//+------------------------------------------------------------------+
//|                                            deadswan_��0.5��.mq4 |
//|                                      �Ա����� liuxiaoqian2525400 |
//|                                             http://www.waihui.ru |
//+------------------------------------------------------------------+
#property copyright "�Ա����� liuxiaoqian2525400"
#property link      "http://www.waihui.ru"
double �µ�����=0.5;
double ֹ�����=400;
double ֹӯ����=1000;
string ע��="Ӯ�������̳ www.yingjia.im QQ:29996044";
//+------------------------------------------------------------------+
//| script program start function                                    |
//+------------------------------------------------------------------+
int start()
  {
//----
int Ticket;
double zhisun=Ask-ֹ�����*Point;
double zhiying=Ask+ֹӯ����*Point;
if(ֹ�����==0)zhisun=0;
if(ֹӯ����==0)zhiying=0;
Ticket=OrderSend(Symbol(),OP_BUY,�µ�����,Ask,30,zhisun,zhiying,ע��,0,0,0);
      if(Ticket<0)
      {
      Print("�൥�볡ʧ��"+GetLastError()); 
      }
      if(Ticket>0)
      {
      Print("�൥�볡�ɹ�"); 
      }

//----
   return(0);
  }
//+------------------------------------------------------------------+

