//+------------------------------------------------------------------+
//|                                      deadswan_�޸Ĺҵ�����EA.mq4 |
//|                                      �Ա����� liuxiaoqian2525400 |
//|                                             http://www.waihui.ru |
//+------------------------------------------------------------------+
#property copyright "�Ա����� liuxiaoqian2525400"
#property link      "http://www.waihui.ru"
extern int ʱ��ѡ��=2;
extern string ʱ��ѡ�����="1Ϊƽ̨ʱ�䣬2Ϊ����ʱ��";
extern int ֹͣʱ��ʱ=12;
extern int ֹͣʱ���=34;
extern int ֹͣʱ����=18;
extern double �ҵ�����=500;
int sj;

//+------------------------------------------------------------------+
//| expert initialization function                                   |
//+------------------------------------------------------------------+
int init()
  {
//----
//----
   return(0);
  }
//+------------------------------------------------------------------+
//| expert deinitialization function                                 |
//+------------------------------------------------------------------+
int deinit()
  {
//----
   
//----
   return(0);
  }
//+------------------------------------------------------------------+
//| expert start function                                            |
//+------------------------------------------------------------------+
int start()
  {
//----
if (TimeCurrent()>D'2019.01.31') //�����趨����ʱ��

   { 

      Alert("�������!����ϵ�Ա�����liuxiouqian2525400"); 

      return(0); 

   } 
if(�޸�ʱ��())�޸Ĺҵ�();
//----
   return(0);
  }
//+------------------------------------------------------------------+
void �޸Ĺҵ�()
{
 int cnt, total;
 total=OrdersTotal();
 for(cnt=total-1;cnt>=0;cnt--)
  {
   OrderSelect(cnt, SELECT_BY_POS, MODE_TRADES);
      if(OrderType()==OP_BUYLIMIT&&OrderSymbol()==Symbol()){
      double zhisun=OrderOpenPrice()-OrderStopLoss();
      double zhiying=OrderTakeProfit()-OrderOpenPrice();
bool chenggong= OrderModify(OrderTicket(),Close[0]-�ҵ�����*Point,Close[0]-zhisun-�ҵ�����*Point,Close[0]-�ҵ�����*Point+zhiying,0,CLR_NONE);
       if (chenggong)Print("���ţ�"+OrderTicket()+"�޸Ĺҵ��ɹ�");
       if (chenggong==false)Print("���ţ�"+OrderTicket()+"�޸Ĺҵ�ʧ��"+GetLastError());
      }
      if(OrderType()==OP_SELLSTOP&&OrderSymbol()==Symbol()){
      zhisun=OrderStopLoss()-OrderOpenPrice();
      zhiying=OrderOpenPrice()-OrderTakeProfit();
      chenggong= OrderModify(OrderTicket(),Close[0]-�ҵ�����*Point,Close[0]+zhisun-�ҵ�����*Point,Close[0]-�ҵ�����*Point-zhiying,0,CLR_NONE);
       if (chenggong)Print("���ţ�"+OrderTicket()+"�޸Ĺҵ��ɹ�");
       if (chenggong==false)Print("���ţ�"+OrderTicket()+"�޸Ĺҵ�ʧ��"+GetLastError());
      }
      
      if(OrderType()==OP_BUYSTOP&&OrderSymbol()==Symbol()){
      zhisun=OrderOpenPrice()-OrderStopLoss();
       zhiying=OrderTakeProfit()-OrderOpenPrice();
       chenggong= OrderModify(OrderTicket(),Close[0]+�ҵ�����*Point,Close[0]-zhisun+�ҵ�����*Point,Close[0]+�ҵ�����*Point+zhiying,0,CLR_NONE);
       if (chenggong)Print("���ţ�"+OrderTicket()+"�޸Ĺҵ��ɹ�");
       if (chenggong==false)Print("���ţ�"+OrderTicket()+"�޸Ĺҵ�ʧ��"+GetLastError());
      }
      if(OrderType()==OP_SELLLIMIT&&OrderSymbol()==Symbol()){
      zhisun=OrderStopLoss()-OrderOpenPrice();
      zhiying=OrderOpenPrice()-OrderTakeProfit();
      chenggong= OrderModify(OrderTicket(),Close[0]+�ҵ�����*Point,Close[0]+zhisun+�ҵ�����*Point,Close[0]+�ҵ�����*Point-zhiying,0,CLR_NONE);
       if (chenggong)Print("���ţ�"+OrderTicket()+"�޸Ĺҵ��ɹ�");
       if (chenggong==false)Print("���ţ�"+OrderTicket()+"�޸Ĺҵ�ʧ��"+GetLastError());
      }
      
      
   }   
}
bool �޸�ʱ��()
{
if(ʱ��ѡ��==1&&Hour()==ֹͣʱ��ʱ&&Minute()==ֹͣʱ���&&Seconds()>=ֹͣʱ����)
{
return(false);
}
if(ʱ��ѡ��==1&&Hour()==ֹͣʱ��ʱ&&Minute()>ֹͣʱ���)
{
return(false);
}
if(ʱ��ѡ��==1&&Hour()>ֹͣʱ��ʱ)
{
return(false);
}
if(ʱ��ѡ��==2&&TimeHour(TimeLocal())==ֹͣʱ��ʱ&&TimeMinute(TimeLocal())==ֹͣʱ���&&TimeSeconds(TimeLocal())>=ֹͣʱ����)
{
return(false);
}
if(ʱ��ѡ��==2&&TimeHour(TimeLocal())==ֹͣʱ��ʱ&&TimeMinute(TimeLocal())>ֹͣʱ���)
{
return(false);
}
if(ʱ��ѡ��==2&&TimeHour(TimeLocal())>ֹͣʱ��ʱ)
{
return(false);
}
else return(true);
}