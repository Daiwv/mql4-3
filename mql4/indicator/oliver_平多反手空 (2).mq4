//+------------------------------------------------------------------+
//|                                          deadswan_ƽ�෴�ֿ�.mq4 |
//|                                      �Ա����� liuxiaoqian2525400 |
//|                                             http://www.waihui.ru |
//+------------------------------------------------------------------+
#property copyright "�Ա����� liuxiaoqian2525400"
#property link      "http://www.waihui.ru"
//double �µ�����=1;
double ֹ�����=400;
double ֹӯ����=1000;
string ע��="Ӯ�������̳ www.yingjia.im QQ:29996044";
//+------------------------------------------------------------------+
//| script program start function                                    |
//+------------------------------------------------------------------+
int start()
  {
//----
double �µ�����=�������();   
ƽ���();   
int Ticket;
double zhisun=Bid+ֹ�����*Point;
double zhiying=Bid-ֹӯ����*Point;
if(ֹ�����==0)zhisun=0;
if(ֹӯ����==0)zhiying=0;
Ticket=OrderSend(Symbol(),OP_SELL,�µ�����,Bid,30,zhisun,zhiying,ע��,0,0,0);
      if(Ticket<0)
      {
      Print("�յ��볡ʧ��"+GetLastError()); 
      }
      if(Ticket>0)
      {
      Print("�յ��볡�ɹ�"); 
      }

//----
   return(0);
  }
//+------------------------------------------------------------------+
void ƽ���()
{
 int total = OrdersTotal();
 for(int i=total-1;i>=0;i--)
 {
  if( OrderSelect(i, SELECT_BY_POS, MODE_TRADES)){
   if(OrderSymbol()==Symbol()&&OrderType()==OP_BUY){
   bool result = false;
   result = OrderClose( OrderTicket(), OrderLots(), MarketInfo(OrderSymbol(), MODE_BID), 300, Red );
   if(result)  Print(Symbol()+"ƽ�൥�ɹ�����");
   if(result == false)
   {
     Print("Order " , OrderTicket() , " failed to close. Error:" , GetLastError() );
   }
 }}}
}
double �������()
{
double s;
 for(int i=OrdersTotal()-1;i>=0;i--)
 {
  OrderSelect(i, SELECT_BY_POS, MODE_TRADES);
  if(OrderSymbol()==Symbol()&&OrderType()==OP_BUY)
    {     
    if(s<OrderLots())s=OrderLots();
     
    }
 } return(s);

}