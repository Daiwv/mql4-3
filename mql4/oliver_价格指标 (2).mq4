//+------------------------------------------------------------------+
//|                                            deadswan_�۸�ָ��.mq4 |
//|                                      �Ա����� liuxiaoqian2525400 |
//|                                             http://www.waihui.ru |
//+------------------------------------------------------------------+
#property copyright "�Ա����� liuxiaoqian2525400"
#property link      "http://www.waihui.ru"

#property indicator_chart_window
extern string ����ʱ��="2013.03.10 20:30:20";
double jiage;
int sj;
//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int init()
  {
//---- indicators
if(TimeLocal()<StrToTime(����ʱ��))sj=1;
if(TimeLocal()>=StrToTime(����ʱ��))sj=0;

//----
   return(0);
  }
//+------------------------------------------------------------------+
//| Custom indicator deinitialization function                       |
//+------------------------------------------------------------------+
int deinit()
  {
//----
   
//----
   return(0);
  }
//+------------------------------------------------------------------+
//| Custom indicator iteration function                              |
//+------------------------------------------------------------------+
int start()
  {
   int    counted_bars=IndicatorCounted();
//----
if(sj==0)jiage=Open[0];
if(sj==1&&TimeLocal()<StrToTime(����ʱ��)){ jiage=Open[0];}

if(sj==1&&TimeLocal()>=StrToTime(����ʱ��)){ jiage=Close[0]; sj=2;}
if(jiage!=0&&Close[0]>=jiage) 
iDisplayInfo("jgc", DoubleToStr((MathAbs((Close[0]-jiage))/Point)/100,3), 0, 30, 30, 60, "΢���ź�", Red); 
if(jiage!=0&&Close[0]<jiage) 
iDisplayInfo("jgc", DoubleToStr((MathAbs((Close[0]-jiage))/Point)/100,3), 0, 30, 30, 60, "΢���ź�", Green); 
Print("jiage");
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