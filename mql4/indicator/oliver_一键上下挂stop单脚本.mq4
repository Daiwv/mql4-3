//+------------------------------------------------------------------+
//|                                deadswan_һ�����¹�STOP���ű�.mq4 |
//|                                      �Ա����� liuxiaoqian2525400 |
//|                                             http://www.waihui.ru |
//+------------------------------------------------------------------+
#property copyright "�Ա����� liuxiaoqian2525400"
#property link      "http://www.waihui.ru"
#property show_inputs
double ���ּ۸�=0;
extern bool �Ƿ��buystop=true;
extern bool �Ƿ��sellstop=true;
extern double ��һ�����ּ۾���=200;
extern double �������=250;
extern int �µ�����=1;
extern double ÿ������=0.5;
extern int ֹ�����=400;
extern int ֹӯ����=700;
extern int ����ƫ�Ƶ���=10;
string ע��="Ӯ�������̳ www.yingjia.im QQ:29996044";
//+------------------------------------------------------------------+
//| script program start function                                    |
//+------------------------------------------------------------------+
int start()
  {
//----
  if (TimeCurrent()>D'2014.02.10') //�����趨����ʱ��

   { 

      Alert("�������!����ϵ�Ա�����liuxiouqian2525400"); 

      return(0); 

   } 

  int Ticket;
  int Ticket1;
  if(���ּ۸�==0){���ּ۸�=Close[0];}
  for(int i=0;i<=�µ�����-1;i++){
  double �Ҷ�۸�=���ּ۸�+��һ�����ּ۾���*Point+�������*Point*i;
  double �ҿռ۸�=���ּ۸�-��һ�����ּ۾���*Point-�������*Point*i;
  if(�Ƿ��buystop){
  Ticket=OrderSend(Symbol(),OP_BUYSTOP,ÿ������,�Ҷ�۸�,����ƫ�Ƶ���,�Ҷ�۸�-ֹ�����*Point,�Ҷ�۸�+ֹӯ����*Point,ע��,0,0,0);
      if(Ticket<0)
      {
      Print("�Ҷ൥�볡ʧ��"+GetLastError()); 
      }}
  if(�Ƿ��sellstop){
  Ticket1=OrderSend(Symbol(),OP_SELLSTOP,ÿ������,�ҿռ۸�,����ƫ�Ƶ���,�ҿռ۸�+ֹ�����*Point,�ҿռ۸�-ֹӯ����*Point,ע��,0,0,0); 
      if(Ticket1<0)
     {
     Print("�ҿյ��볡ʧ��"+GetLastError()); 
     }}
   }
   
//----
   return(0);
  }
//+------------------------------------------------------------------+

