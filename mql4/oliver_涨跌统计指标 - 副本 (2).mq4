//+------------------------------------------------------------------+
//|                                        deadswan_�ǵ�ͳ��ָ��.mq4 |
//|                                      �Ա����� liuxiouqian2525400 |
//|                                             http://www.waihui.ru |
//+------------------------------------------------------------------+
#property copyright "�Ա����� liuxiouqian2525400"
#property link      "http://www.waihui.ru"

#property indicator_chart_window
#property indicator_buffers 3

extern string ������ʼ="18:00";
extern string ��������="03:30";
extern string ŷ����ʼ="03:30";
extern string ŷ������="08:30";
extern string ������ʼ="08:30";
extern string ��������="15:00";
extern double ��������=3;
double ������[];
double ŷ����[];
double ������[];
//+------------------------------------------------------------------+
//| expert initialization function                                   |
//+------------------------------------------------------------------+
int init()
  {
//----
IndicatorBuffers(3);
SetIndexBuffer(0,������);
SetIndexBuffer(1,ŷ����);
SetIndexBuffer(2,������);
   
//----
   return(0);
  }
//+------------------------------------------------------------------+
//| expert deinitialization function                                 |
//+------------------------------------------------------------------+
int deinit()
  {
//----
   ObjectsDeleteAll();
   
//----
   return(0);
  }
//+------------------------------------------------------------------+
//| expert start function                                            |
//+------------------------------------------------------------------+
int start()
  {
//----
if (TimeCurrent()>D'2014.02.28') //�����趨����ʱ��

   { 

      Alert("�������!����ϵ�Ա�����liuxiouqian2525400"); 

      return(0); 

   } 
   int limit;
   int counted_bars=IndicatorCounted();
//---- last counted bar will be recounted
   if(counted_bars>0) counted_bars--;
   limit=Bars-counted_bars;
//---- main loop
//double k=iBarShift(NULL,30,StrToTime("2014.1.04 20:30:20"));
//Print("k:",k);
//Print("kj:",iOpen(NULL,30,k));

   for(int i=1; i<limit; i++)
   {
if(StrToTime(TimeToStr(Time[i],TIME_DATE)+" "+������ʼ)>StrToTime(TimeToStr(Time[i],TIME_DATE)+" "+��������))
{
������[i]=iOpen(NULL,30,iBarShift(NULL,30,StrToTime(TimeToStr(Time[i+1],TIME_DATE)+" "+������ʼ))-1)
-iClose(NULL,30,iBarShift(NULL,30,StrToTime(TimeToStr(Time[i],TIME_DATE)+" "+��������)));
if(iBarShift(NULL,30,StrToTime(TimeToStr(Time[i+1],TIME_DATE)+" "+������ʼ))-1==0
||iBarShift(NULL,30,StrToTime(TimeToStr(Time[i],TIME_DATE)+" "+��������))==0
)������[i]=88888;
if(TimeDayOfWeek(StrToTime(TimeToStr(Time[i+1],TIME_DATE)+" "+������ʼ))==6
||TimeDayOfWeek(StrToTime(TimeToStr(Time[i],TIME_DATE)+" "+��������))==0
)������[i]=88888;
}
if(StrToTime(TimeToStr(Time[i],TIME_DATE)+" "+������ʼ)<StrToTime(TimeToStr(Time[i],TIME_DATE)+" "+��������))
{   
������[i]=iOpen(NULL,30,iBarShift(NULL,30,StrToTime(TimeToStr(Time[i],TIME_DATE)+" "+������ʼ))-1)
-iClose(NULL,30,iBarShift(NULL,30,StrToTime(TimeToStr(Time[i],TIME_DATE)+" "+��������)));
if(iBarShift(NULL,30,StrToTime(TimeToStr(Time[i],TIME_DATE)+" "+������ʼ))-1==0
||iBarShift(NULL,30,StrToTime(TimeToStr(Time[i],TIME_DATE)+" "+��������))==0
)������[i]=88888;
if(TimeDayOfWeek(StrToTime(TimeToStr(Time[i],TIME_DATE)+" "+������ʼ))==6
||TimeDayOfWeek(StrToTime(TimeToStr(Time[i],TIME_DATE)+" "+��������))==0
)������[i]=88888;

}
ŷ����[i]=iOpen(NULL,30,iBarShift(NULL,30,StrToTime(TimeToStr(Time[i],TIME_DATE)+" "+ŷ����ʼ))-1)
-iClose(NULL,30,iBarShift(NULL,30,StrToTime(TimeToStr(Time[i],TIME_DATE)+" "+ŷ������)));
if(iBarShift(NULL,30,StrToTime(TimeToStr(Time[i],TIME_DATE)+" "+ŷ����ʼ))-1==0
||iBarShift(NULL,30,StrToTime(TimeToStr(Time[i],TIME_DATE)+" "+ŷ������))==0
)ŷ����[i]=88888;
if(TimeDayOfWeek(StrToTime(TimeToStr(Time[i],TIME_DATE)+" "+ŷ����ʼ))==6
||TimeDayOfWeek(StrToTime(TimeToStr(Time[i],TIME_DATE)+" "+ŷ������))==0
)ŷ����[i]=88888;

������[i]=iOpen(NULL,30,iBarShift(NULL,30,StrToTime(TimeToStr(Time[i],TIME_DATE)+" "+������ʼ))-1)
-iClose(NULL,30,iBarShift(NULL,30,StrToTime(TimeToStr(Time[i],TIME_DATE)+" "+��������)));   
   }   
 if(iBarShift(NULL,30,StrToTime(TimeToStr(Time[i],TIME_DATE)+" "+������ʼ))-1==0
||iBarShift(NULL,30,StrToTime(TimeToStr(Time[i],TIME_DATE)+" "+��������))==0
)������[i]=88888;
 if(TimeDayOfWeek(StrToTime(TimeToStr(Time[i],TIME_DATE)+" "+������ʼ))==6
||TimeDayOfWeek(StrToTime(TimeToStr(Time[i],TIME_DATE)+" "+��������))==0
)������[i]=88888; 
int s1,s2,s3,s4,s5,s6,s7,s8;
 
   for(i=1; i<=��������; i++)
   {
if(������[i]<0&&ŷ����[i]<0&&������[i]<0&&(������[i]!=88888&&ŷ����[i]!=88888&&������[i]!=88888))s1++;
if(������[i]<0&&ŷ����[i]<0&&������[i]>0&&(������[i]!=88888&&ŷ����[i]!=88888&&������[i]!=88888))s2++;
if(������[i]<0&&ŷ����[i]>0&&������[i]<0&&(������[i]!=88888&&ŷ����[i]!=88888&&������[i]!=88888))s3++;
if(������[i]<0&&ŷ����[i]>0&&������[i]>0&&(������[i]!=88888&&ŷ����[i]!=88888&&������[i]!=88888))s4++;
if(������[i]>0&&ŷ����[i]<0&&������[i]<0&&(������[i]!=88888&&ŷ����[i]!=88888&&������[i]!=88888))s5++;
if(������[i]>0&&ŷ����[i]<0&&������[i]>0&&(������[i]!=88888&&ŷ����[i]!=88888&&������[i]!=88888))s6++;
if(������[i]>0&&ŷ����[i]>0&&������[i]<0&&(������[i]!=88888&&ŷ����[i]!=88888&&������[i]!=88888))s7++;
if(������[i]>0&&ŷ����[i]>0&&������[i]>0&&(������[i]!=88888&&ŷ����[i]!=88888&&������[i]!=88888))s8++;
   } 
iDisplayInfo("s1", "����ŷ�����ǣ�"+ DoubleToStr(s1,0) , 1, 20, 20, 12, "Arial", Chartreuse); 
iDisplayInfo("s2", "����ŷ��������"+ DoubleToStr(s2,0) , 1, 20, 40, 12, "Arial", Chartreuse); 
iDisplayInfo("s3", "����ŷ�����ǣ�"+ DoubleToStr(s3,0) , 1, 20, 60, 12, "Arial", Chartreuse); 
iDisplayInfo("s4", "����ŷ��������"+ DoubleToStr(s4,0) , 1, 20, 80, 12, "Arial", Chartreuse); 
iDisplayInfo("s5", "�ǵ�ŷ�����ǣ�"+ DoubleToStr(s5,0) , 1, 20, 100, 12, "Arial", Chartreuse); 
iDisplayInfo("s6", "�ǵ�ŷ��������"+ DoubleToStr(s6,0) , 1, 20, 120, 12, "Arial", Chartreuse); 
iDisplayInfo("s7", "�ǵ�ŷ�����ǣ�"+ DoubleToStr(s7,0) , 1, 20, 140, 12, "Arial", Chartreuse); 
iDisplayInfo("s8", "�ǵ�ŷ��������"+ DoubleToStr(s8,0) , 1, 20, 160, 12, "Arial", Chartreuse); 
       
//----
   return(0);
  }
//+------------------------------------------------------------------+
void iDisplayInfo(string LableName,string LableDoc,int Corner,int LableX,int LableY,int DocSize,string DocStyle,color DocColor) 

   { 

      if (Corner == -1) return(0); 

      ObjectCreate(LableName, OBJ_LABEL, 0, 0, 0); //������ǩ���� 

      ObjectSetText(LableName, LableDoc, DocSize, DocStyle,DocColor); //����������� 

      ObjectSet(LableName, OBJPROP_CORNER, Corner); //ȷ������ԭ�㪨0-���ϽǪ�1-���ϽǪ�2-���½Ǫ�3-���½Ǫ�-1-����ʾ 

      ObjectSet(LableName, OBJPROP_XDISTANCE, LableX); //��������ꪨ��λ���� 

      ObjectSet(LableName, OBJPROP_YDISTANCE, LableY); //���������ꪨ��λ���� 

   } 