//+------------------------------------------------------------------+
//|                                      Trades History from CSV.mq4 |
//+------------------------------------------------------------------+

#property indicator_chart_window

#include <hanover --- function header (np).mqh>

extern string     FileName               = "DetailedStatement.CSV";
extern string     ShowOrderTypes         = "COP";             // C=Closed orders; O=Open orders; P=Pending orders
//    Legend for  FieldXlateTable          "Ticket#, OpenDateTime, OrderType, Lots, Symbol, OpenPrice, SL, TP, CloseDateTime, ClosePrice, Commission, Swap, Profit/Loss, Comment, Magic#"
//extern string     FieldXlateTable      = "0,1,2,3,4,5,6,7,8,9,10,12,13,14,15";
extern string     FieldXlateTable        = "20,0,1,2,3,4,5,6,7,8,9,10,11,12,20";
extern string     DateTimeFormat         = "YYYY.MM.DD HH:II";
extern string     FieldDelimiter         = ",";
extern string     EntrySettings          = "White,2,0";
extern string     SLSettings             = "Red,2,0";
extern string     TPSettings             = "Green,2,0";
extern string     ExitLossSettings       = "Red,2,0";
extern string     ExitProfitSettings     = "Green,2,0";
extern int        HorizLineLength        = 3;
extern string     EquityCalcBasis        = "E";               // B=Balance; E=Equity; F=Free margin
extern string     Visibility             = "M1,M5,M15,M30,H1,H4,D1,W1,MN";

string   ccy, sym, IndiName, arr[50];
int      dig, tf, tmf, FXT[21], objnum;
double   spr, pnt, tickval, bidp, askp, minlot, lswap, sswap, AcctEquity;
string   optypes[7] = {"BUY","SELL","BUY LIMIT","SELL LIMIT","BUY STOP","SELL STOP","?-UNKNOWN-?"};
color    EntryColor, TPColor, SLColor, ExitProfitColor, ExitLossColor;
int      EntryWidth, TPWidth, SLWidth, ExitProfitWidth, ExitLossWidth;
int      EntryStyle, TPStyle, SLStyle, ExitProfitStyle, ExitLossStyle;

string   xOrderStatus, xOrderSymbol, xOrderComment;
int      xOrderTicket, xOrderType, xOrderMagicNum;
datetime xOrderOpenTime, xOrderCloseTime;
double   xOrderLots, xOrderOpenPrice, xOrderStopLoss, xOrderTakeProfit, xOrderClosePrice, xOrderCommission, xOrderSwap, xOrderProfit;

//+------------------------------------------------------------------+
int init()  {
//+------------------------------------------------------------------+
  IndiName = "#ON #";
  IndicatorShortName(IndiName);

  sym     = Symbol();
  ccy     = Symbol();
  tmf     = Period();
  bidp    = MarketInfo(ccy,MODE_BID);
  askp    = MarketInfo(ccy,MODE_ASK);
  pnt     = MarketInfo(ccy,MODE_POINT);
  dig     = MarketInfo(ccy,MODE_DIGITS);
  spr     = MarketInfo(ccy,MODE_SPREAD);
  tickval = MarketInfo(ccy,MODE_TICKVALUE);
  minlot  = MarketInfo(ccy,MODE_MINLOT);
  lswap   = MarketInfo(ccy,MODE_SWAPLONG);
  sswap   = MarketInfo(ccy,MODE_SWAPSHORT);
  if (dig == 3 || dig == 5) {
    pnt     *= 10;
    spr     /= 10;
    tickval *= 10;
  }  

  StrToStringArray(EntrySettings,arr);       EntryColor = StrToColor(arr[0]);        EntryWidth = StrToInteger(arr[1]);        EntryStyle = StrToInteger(arr[2]);
  StrToStringArray(SLSettings,arr);          SLColor = StrToColor(arr[0]);           SLWidth = StrToInteger(arr[1]);           SLStyle = StrToInteger(arr[2]);
  StrToStringArray(TPSettings,arr);          TPColor = StrToColor(arr[0]);           TPWidth = StrToInteger(arr[1]);           TPStyle = StrToInteger(arr[2]);
  StrToStringArray(ExitProfitSettings,arr);  ExitProfitColor = StrToColor(arr[0]);   ExitProfitWidth = StrToInteger(arr[1]);   ExitProfitStyle = StrToInteger(arr[2]);
  StrToStringArray(ExitLossSettings,arr);    ExitLossColor = StrToColor(arr[0]);     ExitLossWidth = StrToInteger(arr[1]);     ExitLossStyle = StrToInteger(arr[2]);

  StrToIntegerArray(FieldXlateTable,FXT);
  ShowOrderTypes = StringUpper(ShowOrderTypes);
  
  AcctEquity = AccountBalance();
  if (StringUpper(EquityCalcBasis) == "E")    AcctEquity = AccountEquity();
  if (StringUpper(EquityCalcBasis) == "F")    AcctEquity = AccountFreeMargin();

  del_obj();
  plot_obj();
  return(0);
}

//+------------------------------------------------------------------+
int deinit()  {
//+------------------------------------------------------------------+
  del_obj();
  return(0);
}

//+------------------------------------------------------------------+
void del_obj()  {
//+------------------------------------------------------------------+
  int k=0;
  while (k<ObjectsTotal())   {
    string objname = ObjectName(k);
    if (StringSubstr(objname,0,StringLen(IndiName)) == IndiName)  
      ObjectDelete(objname);
    else
      k++;
  }    
  return(0);
}

//+------------------------------------------------------------------+
int start()  {
//+------------------------------------------------------------------+
  del_obj();
  plot_obj();
  return(0);
}

//+------------------------------------------------------------------+
void plot_obj()   {
//+------------------------------------------------------------------+
// 检查是否在时间周期显示
  if (StringFind(StringUpper(Visibility)+",",TFToStr(Period())+",") < 0)   return;

  int h=FileOpen(FileName,FILE_CSV|FILE_READ,'~');//
  if (h<1)  return(0);
  objnum = 0;
  while (!FileIsEnding(h))   {
    //读一行内容
    string s = FileReadString(h);
    if (FileIsEnding(h))   break;
    StrToStringArray(s,arr,FieldDelimiter);
    // 编号
    xOrderTicket        = StrToNumber(arr[FXT[0]]);
//    if (!IsAlpha(arr[FXT[0]],"1"))                             continue;
//    if (StrToNumber(arr[FXT[0]]) < 1)                          continue;
    if (StringFind(ShowOrderTypes,GetOrderStatus()) < 0)       continue;
//    log(DebugStringArray(arr));
    // 开仓时间
    xOrderOpenTime      = StrToDate(arr[FXT[1]],DateTimeFormat);
    // 开仓类型
    xOrderType          = arr[FXT[2]];
    // 跳过返佣
    if(StringFind(xOrderType,'balance',0)>-1) continue;
    // 开仓手数
    xOrderLots          = StrToNumber(arr[FXT[3]]);
    // 开仓品种
    xOrderSymbol        = arr[FXT[4]];
    // 开仓价
    xOrderOpenPrice     = StrToNumber(arr[FXT[5]]);
    // 止损价
    xOrderStopLoss      = StrToNumber(arr[FXT[6]]);
    // 止盈价
    xOrderTakeProfit    = StrToNumber(arr[FXT[7]]);
    // 平仓时间
    xOrderCloseTime     = StrToDate(arr[FXT[8]],DateTimeFormat);
    // 平仓价格
    xOrderClosePrice    = StrToNumber(arr[FXT[9]]);
    // 佣金
    xOrderCommission    = StrToNumber(arr[FXT[10]]);
    // tax
    xOrderCommission    = StrToNumber(arr[FXT[11]]);
    // 过夜费
    xOrderSwap          = StrToNumber(arr[FXT[12]]);
    // 利润
    xOrderProfit        = StrToNumber(arr[FXT[13]]);
    
    
    xOrderComment       = "备注";//arr[FXT[14]];
    xOrderMagicNum      = 888;//StrToNumber(arr[FXT[15]]);
    plot_order();
  }
  FileClose(h);
  return(0);
}

//+------------------------------------------------------------------+
void plot_order()   {
//+------------------------------------------------------------------+
//  log(xOrderTicket,GetOrderStatus(),xOrderType,xOrderSymbol);
  if (StringUpper(xOrderSymbol) != StringUpper(Symbol()))    return;      // must bne same symbol as chart

  int bar0 = iBarShift(Symbol(),Period(),xOrderOpenTime);
  int bar1 = iBarShift(Symbol(),Period(),xOrderCloseTime);

  double RiskPips  = MathAbs(xOrderOpenPrice - xOrderStopLoss  ) / pnt;
  double RetnPips  = MathAbs(xOrderOpenPrice - xOrderTakeProfit) / pnt;
  double ExitPips = 0;
  if (MathMod(xOrderType,2) == 0)
    ExitPips  = (xOrderClosePrice - xOrderOpenPrice) / pnt;
  else
    ExitPips  = (xOrderOpenPrice - xOrderClosePrice) / pnt;
  if (xOrderStopLoss   == 0)   RiskPips = 0;
  if (xOrderTakeProfit == 0)   RetnPips = 0;
  if (xOrderClosePrice == 0)   ExitPips = 0;
  double RiskAmt   = xOrderLots * tickval * RiskPips; 
  double RetnAmt   = xOrderLots * tickval * RetnPips;
  double ExitAmt   = xOrderProfit;
  double RiskPcnt  = 100*DivZero(RiskAmt,AcctEquity);  
  double RetnPcnt  = 100*DivZero(RetnAmt,AcctEquity);  
  double ExitPcnt  = 100*DivZero(ExitAmt,AcctEquity);
  double RR        = DivZero(RetnAmt,RiskAmt);
  
  string DispTP    = "";
  string DispSL    = "";
  string DispEntry = "";
  string DispExit  = "";
  if (xOrderTakeProfit > 0)  {
    DispTP = NumberToStr(xOrderTakeProfit,"'@ 'TB4."+dig) + NumberToStr(RetnPips,"' = 'TB3.1' pips'")
           + NumberToStr(RetnAmt,"' = 'TB$,7.2") + NumberToStr(RetnPcnt,"' = 'TR%2.2");
    if (xOrderStopLoss > 0)  {
      DispTP = DispTP + NumberToStr(RR,"'= 'TBR3.2':1 RR'");
  } }                 
  if (xOrderStopLoss > 0)  {
    DispSL = NumberToStr(xOrderStopLoss,"'@ 'TB4."+dig) + NumberToStr(RiskPips,"' = 'TB3.1' pips'")
           + NumberToStr(RiskAmt,"' = 'TB$,7.2") + NumberToStr(RiskPcnt,"' = 'TR%2.2");
  }
  DispEntry = NumberToStr(xOrderOpenPrice,"'@ 'T4."+dig) + NumberToStr(xOrderLots,"'  :  'T,4.2' lots'") 
            + NumberToStr(tickval*xOrderLots,"' = 'TR$,7.2' per pip'");
  DispExit  = NumberToStr(xOrderClosePrice,"'@ 'TB4."+dig) + NumberToStr(ExitPips,"' = 'TB-3.1' pips'")
            + NumberToStr(ExitAmt,"' = 'TB$,-7.2") + NumberToStr(ExitPcnt,"' = 'TR%-2.2");
  if (xOrderCloseTime > xOrderOpenTime)
    DispExit = DispExit + DateToStr(xOrderCloseTime-xOrderOpenTime,"@H4!hI!m");
  string ord_type = " (" + StringLower(optypes[xOrderType]) + ")";

  // Plot entry line.....
  objnum++;
  string  objname = IndiName + NumberToStr(objnum,"T6") + "-ENTRY" + ord_type + " '" + xOrderComment + "' [" + NumberToStr(xOrderMagicNum,"T12") + "]";
  PlotTL (objname, false, 0, xOrderOpenTime, xOrderOpenPrice, xOrderOpenTime+HorizLineLength*Period()*60, xOrderOpenPrice, EntryColor, EntryWidth, EntryStyle, false, false, 0, DispEntry);  // Plot trendline

  // Plot SL line.....
  objname = IndiName + NumberToStr(objnum,"T6") + "-SL";
  PlotTL (objname, false, 0, xOrderOpenTime, xOrderStopLoss, xOrderOpenTime+HorizLineLength*Period()*60, xOrderStopLoss, SLColor, SLWidth, SLStyle, false, false, 0, DispSL);  // Plot trendline

  // Plot TP line.....
  objname = IndiName + NumberToStr(objnum,"T6") + "-TP";
  PlotTL (objname, false, 0, xOrderOpenTime, xOrderTakeProfit, xOrderOpenTime+HorizLineLength*Period()*60, xOrderTakeProfit, TPColor, TPWidth, TPStyle, false, false, 0, DispTP);  // Plot trendline

  // Plot exit line.....
  if (StringFind("OC",GetOrderStatus()) >= 0)  {
    objname = IndiName + NumberToStr(objnum,"T6") + "-EXIT";
    datetime ctime = xOrderCloseTime;
    if (ctime == 0)   ctime = TimeCurrent();
    double oprice = xOrderOpenPrice;
    if (OrderStatus(xOrderTicket) == "O")  {
      oprice = xOrderClosePrice;
      ctime  = xOrderOpenTime+HorizLineLength*Period()*60;
    }  
    if (OrderProfit() >= 0)
      PlotTL (objname, false, 0, xOrderOpenTime, oprice, ctime, xOrderClosePrice, ExitProfitColor, ExitProfitWidth, ExitProfitStyle, false, false, 0, DispExit);  // Plot trendline
    else
      PlotTL (objname, false, 0, xOrderOpenTime, oprice, ctime, xOrderClosePrice, ExitLossColor, ExitLossWidth, ExitLossStyle, false, false, 0, DispExit);        // Plot trendline
  }    
  return;
}

//+------------------------------------------------------------------+
string GetOrderStatus()   {
//+------------------------------------------------------------------+
// Given a ticket number, returns the status of an order:
//  P=pending, O=open, C=closed, D=deleted, N=non-existent ticket, U=unknown
// string   optypes[6] = {"BUY","SELL","BUY LIMIT","SELL LIMIT","BUY STOP","SELL STOP"};
  xOrderType = 6;
  if (StringLower(arr[FXT[2]]) == "buy")           xOrderType = 0;
  if (StringLower(arr[FXT[2]]) == "sell")          xOrderType = 1;
  if (StringLower(arr[FXT[2]]) == "buy limit")     xOrderType = 2;
  if (StringLower(arr[FXT[2]]) == "sell limit")    xOrderType = 3;
  if (StringLower(arr[FXT[2]]) == "buy stop")      xOrderType = 4;
  if (StringLower(arr[FXT[2]]) == "sell stop")     xOrderType = 5;

  if (xOrderType > 5)    return("U");

  if (xOrderCloseTime == 0) {
    if (xOrderType == OP_BUY || xOrderType == OP_SELL) 
      return("O");     // open
    else  
      return("P");     // pending
  } else {
    if (xOrderType == OP_BUY || xOrderType == OP_SELL) 
      return("C");     // closed (for profit or loss)
    else  
      return("D");     // cancelled (deleted)
  }     
  return("U");         // unknown
}

//+------------------------------------------------------------------+
#include <hanover --- extensible functions (np).mqh>

