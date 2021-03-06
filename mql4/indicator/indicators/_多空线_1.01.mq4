//+------------------------------------------------------------------+
//|                                                     _多空线_.mq4 |
//|                                              Copyright 2014, Jiu |
//|                                                    jiuhz@163.com |
//|                                                                  |
//|   Generated by EX4-TO-MQ4 decompiler V4.0.224.1 []               |
//|   Website: http://purebeam.biz                                   |
//|   E-mail : purebeam@gmail.com                                    |
//+------------------------------------------------------------------+
#property copyright   "Copyright 2014, Jiu"
#property link        "jiuhz@163.com"
#property description "jiuhz@163.com"
#property version     "1.01"
//#property strict
#property indicator_chart_window //把指标显示在主图

#property indicator_buffers 4 // 显示4根指标线

#property indicator_color1 clrBlack // 第1根指标线的颜色为clrBlack
#property indicator_color2 clrBlack // 第2根指标线的颜色为clrBlack

#property indicator_color3 clrRed // 第3根指标线的颜色为clrRed
#property indicator_color4 clrBlue // 第2根指标线的颜色为clrBlue


#property indicator_style3 STYLE_SOLID
#property indicator_style4 STYLE_SOLID

#property indicator_type3  DRAW_HISTOGRAM  // 第3根指标线的类型为柱子
#property indicator_type4  DRAW_HISTOGRAM // 第4根指标线的类型为柱子

#property indicator_width3 4
#property indicator_width4 4


extern int MaMetod = 1;
extern int MaPeriod = 55;  // 6
extern int MaMetod2 = 1;
extern int MaPeriod2 = 12;

// 8个缓冲
double g_ibuf_92[];
double g_ibuf_96[];
double g_ibuf_100[];
double g_ibuf_104[];
double g_ibuf_108[];
double g_ibuf_112[];
double g_ibuf_116[];
double g_ibuf_120[];

int gi_124 = 0;

//+------------------------------------------------------------------+
//| Custom indicator SUB function                                    |
//+------------------------------------------------------------------+
/*
void ads() {
   SetLab("ads01", 20, 25, 3, "宝琦银，七个点回本，全国最低", 11, "宋体", Lime);
   SetLab("ads02", 20, 6, 3, "无点差，AA：578604041", 11, "Arial", Aqua);
}

void SetLab(string a_name_0, int a_x_8, int a_y_12, int a_corner_16, string a_text_20, int a_fontsize_28, string a_fontname_32, color a_color_40 = -1) {
   ObjectCreate(a_name_0, OBJ_LABEL, 0, 0, 0);
   ObjectSet(a_name_0, OBJPROP_XDISTANCE, a_x_8);
   ObjectSet(a_name_0, OBJPROP_YDISTANCE, a_y_12);
   ObjectSet(a_name_0, OBJPROP_CORNER, a_corner_16);
   ObjectSetText(a_name_0, a_text_20, a_fontsize_28, a_fontname_32, a_color_40);
}
*/
//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int OnInit(void) {
//int init() {
   // ads();
   IndicatorBuffers(8);
   //SetIndexStyle(2, DRAW_HISTOGRAM, STYLE_SOLID, 4, clrRed);
   //SetIndexStyle(2, DRAW_HISTOGRAM);
   //SetIndexBuffer(2, g_ibuf_100);
   //SetIndexStyle(3, DRAW_HISTOGRAM, STYLE_SOLID, 4, clrBlue);
   //SetIndexStyle(3, DRAW_HISTOGRAM);
   //SetIndexBuffer(3, g_ibuf_104);
   SetIndexDrawBegin(0, 5);
   // buffer就位
   SetIndexBuffer(0, g_ibuf_92);
   SetIndexBuffer(1, g_ibuf_96);
   SetIndexBuffer(2, g_ibuf_100);
   SetIndexBuffer(3, g_ibuf_104);
   SetIndexBuffer(4, g_ibuf_108);
   SetIndexBuffer(5, g_ibuf_112);
   SetIndexBuffer(6, g_ibuf_116);
   SetIndexBuffer(7, g_ibuf_120);
   //return (0);
   return(INIT_SUCCEEDED);
}
//+------------------------------------------------------------------+
//| Custom indicator deinit function                                 |
//+------------------------------------------------------------------+
//void OnDeinit(const int reason);
//int deinit() {
   // ads();
//   return (0);
//}
//+------------------------------------------------------------------+
//| OnCalculate                                                      |
//+------------------------------------------------------------------+
int OnCalculate(const int rates_total,
                const int prev_calculated,
                const datetime &time[],
                const double &open[],
                const double &high[],
                const double &low[],
                const double &close[],
                const long &tick_volume[],
                const long &volume[],
                const int &spread[]) {
//int start() {
   
   double l_ima_0;
   double l_ima_8;
   double l_ima_16;
   double l_ima_24;
   
   double ld_32;
   double ld_40;
   double ld_48;
   double ld_56;
   if (Bars <= 10) return (0);
   gi_124 = IndicatorCounted();
   if (gi_124 < 0) return (-1);
   if (gi_124 > 0) gi_124--;
   int li_64 = Bars - gi_124 - 1;
   int li_68 = li_64;
   // 之前画过的就忽略掉
   while (li_64 >= 0) {
      l_ima_0 = iMA(NULL, 0, MaPeriod, 0, MaMetod, PRICE_CLOSE, li_64);
      l_ima_8 = iMA(NULL, 0, MaPeriod, 0, MaMetod, PRICE_LOW, li_64);
      l_ima_16 = iMA(NULL, 0, MaPeriod, 0, MaMetod, PRICE_OPEN, li_64);
      l_ima_24 = iMA(NULL, 0, MaPeriod, 0, MaMetod, PRICE_HIGH, li_64);
      ld_32 = (g_ibuf_108[li_64 + 1] + (g_ibuf_112[li_64 + 1])) / 2.0;
      ld_56 = (l_ima_0 + l_ima_24 + l_ima_16 + l_ima_8) / 4.0;
      ld_40 = MathMax(l_ima_24, MathMax(ld_32, ld_56));
      ld_48 = MathMin(l_ima_16, MathMin(ld_32, ld_56));
      
      // 116 120
      if (ld_32 < ld_56) {
         g_ibuf_116[li_64] = ld_48;
         g_ibuf_120[li_64] = ld_40;
      } else {
         g_ibuf_116[li_64] = ld_40;
         g_ibuf_120[li_64] = ld_48;
      }
      // 108 112
      g_ibuf_108[li_64] = ld_32;
      g_ibuf_112[li_64] = ld_56;
      li_64--;
   }
   // 92 96 100 104
  // int li_72;
  // for (li_72 = 0; li_72 < li_68; li_72++) g_ibuf_92[li_72] = iMAOnArray(g_ibuf_108, Bars, MaPeriod2, 0, MaMetod2, li_72);
   //for (li_72 = 0; li_72 < li_68; li_72++) g_ibuf_96[li_72] = iMAOnArray(g_ibuf_112, Bars, MaPeriod2, 0, MaMetod2, li_72);
   //for (li_72 = 0; li_72 < li_68; li_72++) g_ibuf_100[li_72] = iMAOnArray(g_ibuf_108, Bars, MaPeriod2, 0, MaMetod2, li_72);
   //for (li_72 = 0; li_72 < li_68; li_72++) g_ibuf_104[li_72] = iMAOnArray(g_ibuf_112, Bars, MaPeriod2, 0, MaMetod2, li_72);
   //return (0);
   return(rates_total);
}
//+------------------------------------------------------------------+
