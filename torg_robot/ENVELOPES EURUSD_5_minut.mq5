//+------------------------------------------------------------------+
//|                                    ENVELOPES EURUSD 5 daqiqalik  |
//|                                  qushma korxona  MetaQuotes Ltd. |                // Robot nomi , korxona nomi , Korxona silkasi
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "qushma korxona 2022, MetaQuotes Ltd "                            // turi (string) //  Ishlab chiqaruvchining nomi 
#property link      "https://www.mql5.com"                                            // turi (string) //  Ishlab chiqaruvchining veb-saytiga havola
#property version   "1.00"                                                            // turi (string) //  Dastur versiyasi, 31 belgidan oshmasligi kerak
//#property strict.                                                                   // Kompilyatorga maxsus qattiq xatolarni tekshirish rejimidan foydalanishni aytish (mql4 da ishlatib bo'ladi faqat)
//+------------------------------------------------------------------+
//| Include                                                          |                // O'z ichiga oladigan malumotlar
//+------------------------------------------------------------------+
#include <Expert\Expert.mqh>                                                          // tashqi hujatlarni ulaudi (Strelkali qavslar ichida hujatni ismi)
//--- mavjud signallar
#include <Expert\Signal\SignalEnvelopes.mqh>  // signal envelopes indikatori          // tashqi hujatlarni ulaudi (Strelkali qavslar ichida hujatni ismi)
//--- mavjud orqa
#include <Expert\Trailing\TrailingNone.mqh>   // mutaxasis\keyingi\keyingiyuq.        // tashqi hujatlarni ulaudi (Strelkali qavslar ichida hujatni ismi)
//--- mavjud pul boshqaruvi                   // mavjud pulni chiqarish
#include <Expert\Money\MoneyFixedLot.mqh>     //mutaxasis\ pul\ pul belgilangan lot.  // tashqi hujatlarni ulaudi (Strelkali qavslar ichida hujatni ismi)
//+------------------------------------------------------------------+
//| Inputs  //kirish                                                 |
//+------------------------------------------------------------------+
//---   Mutaxasis uchun kirishlar
input string             Expert_Title              ="ENVELOPES EURUSD 5  minut";      // Mutaxassis nomi
ulong                    Expert_MagicNumber        =28758;                            // Mutaxassisning sehrli raqami
bool                     Expert_EveryTick          =false;                            // Har bir belgi mutaxassisi
//--- Asosiy signal uchun kirishlar
input int                Signal_ThresholdOpen      =1;                                // Signal chegarasi ochiq               // Signal threshold value to open [0...100]           Ochish uchun signalning chegara qiymati
input int                Signal_ThresholdClose     =0;                                // Signal chegarasi yopish              // Signal threshold value to close [0...100]          Yopish uchun signalning chegara qiymati
input double             Signal_PriceLevel         =0.0;                              // Signal narxi darajasi                // Price level to execute a deal                      Bitimni amalga oshirish uchun narx darajasi
input double             Signal_StopLevel          =0.0;                              // Signalning to'xtash darajasi         // Stop Loss level (in points)                        Stop loss darajasi (nuqtalarda)
input double             Signal_TakeLevel          =0.0;                              // Signal qabul qilish darajasi         // Take Profit level (in points)                      Daromad darajasi    (nuqtalarda)
input int                Signal_Expiration         =1;                                // Signalning amal qilish muddati       // Expiration of pending orders (in bars),            Kutilayotgan buyurtmalarning amal qilish muddati (bar o'lchovida)
input int                Signal_Envelopes_PeriodMA =1;                                // Signal konvertlari davri MA          // Envelopes(1,0,MODE_LWMA,...) Period of averaging   O'rtacha hisoblash davri
input int                Signal_Envelopes_Shift    =0;                                // Signal konvertlarini siljitish       // Envelopes(1,0,MODE_LWMA,...) Time shift            Vaqt siljishi
input ENUM_MA_METHOD     Signal_Envelopes_Method   =MODE_LWMA;                        // Signal konvertlari usuli             // Envelopes(1,0,MODE_LWMA,...) Method of averaging   O'rtacha hisoblash usuli
input ENUM_APPLIED_PRICE Signal_Envelopes_Applied  =PRICE_OPEN;                       // Signal konvertlari qo'llaniladi      // Envelopes(1,0,MODE_LWMA,...) Prices series         Narxlar seriyasi
input double             Signal_Envelopes_Deviation=0.15;                             // Signal konvertlarining og'ishi       // Envelopes(1,0,MODE_LWMA,...) Deviation             O'chirish
input double             Signal_Envelopes_Weight   =1.0;                              // Signal konvertlarining vazni         // Envelopes(1,0,MODE_LWMA,...) Weight [0...1.0]      Vazni
//--- pul uchun kirishlar
input double             Money_FixLot_Percent      =10.0;                             // Pulni tuzatish Lot foizi             // Percent                                            Foiz
input double             Money_FixLot_Lots         =0.1;                              // Pulni tuzatish lotlar                // Fixed volume.                                      Lot ochish



//+------------------------------------------------------------------+
//| Global expert object   // global ekspert obyekti                 |
//+------------------------------------------------------------------+
CExpert ExtExpert;
//+-------------------------------------------------------------------------------+
//| Initialization function of the expert   ekspertning ishga tushirish funksiyasi|
//+-------------------------------------------------------------------------------+
int OnInit()
  {
//--- Initializing expert
   if(!ExtExpert.Init(Symbol(),Period(),Expert_EveryTick,Expert_MagicNumber))  
     {
      //--- failed // muvoffaqiyatsiz
      printf(__DATETIME__+": error initializing expert"); 
      ExtExpert.Deinit();
      return(INIT_FAILED);
     }
//--- Signal yaratish
   CExpertSignal *signal=new CExpertSignal;
   if(signal==NULL)
     {
      //--- muvaffaqiyatsiz
      printf(__DATETIME__+": error creating signal");
      ExtExpert.Deinit();
      return(INIT_FAILED);
     }
//---
   ExtExpert.InitSignal(signal);
   signal.ThresholdOpen(Signal_ThresholdOpen);
   signal.ThresholdClose(Signal_ThresholdClose);
   signal.PriceLevel(Signal_PriceLevel);
   signal.StopLevel(Signal_StopLevel);
   signal.TakeLevel(Signal_TakeLevel);
   signal.Expiration(Signal_Expiration);
//--- Filtrni C Signal konvertlarini yaratish
   CSignalEnvelopes *filter0=new CSignalEnvelopes;
   if(filter0==NULL)
     {
      //--- muvaffaqiyatsiz
      printf(__DATETIME__+": error creating filter0");
      ExtExpert.Deinit();
      return(INIT_FAILED);
     }
   signal.AddFilter(filter0);
//--- Filtr parametrlarini o'rnatish
   filter0.PeriodMA(Signal_Envelopes_PeriodMA);
   filter0.Shift(Signal_Envelopes_Shift);
   filter0.Method(Signal_Envelopes_Method);
   filter0.Applied(Signal_Envelopes_Applied);
   filter0.Deviation(Signal_Envelopes_Deviation);
   filter0.Weight(Signal_Envelopes_Weight);
//--- zamikat qiladigan ob'ektni yaratish
   CTrailingNone *trailing=new CTrailingNone;
   if(trailing==NULL)
     {
      //--- muvaffaqiyatsiz
      printf(__DATETIME__+": error creating trailing");
      ExtExpert.Deinit();
      return(INIT_FAILED);
     }
//--- Mutaxassisga so'rov qo'shish (avtomatik ravishda o'chiriladi))
   if(!ExtExpert.InitTrailing(trailing))
     {
      //--- muvaffaqiyatsiz
      printf(__DATETIME__+": error initializing trailing");
      ExtExpert.Deinit();
      return(INIT_FAILED);
     }
//--- Keyingi parametrlarni o'rnatish
//--- Pul ob'ektini yaratish
   CMoneyFixedLot *money=new CMoneyFixedLot;
   if(money==NULL)
     {
      //--- muvaffaqiyatsiz
      printf(__DATETIME__+": error creating money");
      ExtExpert.Deinit();
      return(INIT_FAILED);
     }
//--- Ekspertga pul qo'shish (avtomatik ravishda o'chiriladi))
   if(!ExtExpert.InitMoney(money))
     {
      //--- muvaffaqiyatsiz
      printf(__DATETIME__+": error initializing money");
      ExtExpert.Deinit();
      return(INIT_FAILED);
     }
//--- Pul parametrlarini o'rnating
   money.Percent(Money_FixLot_Percent);
   money.Lots(Money_FixLot_Lots);
//--- Savdo ob'ektlarining barcha parametrlarini tekshiring
   if(!ExtExpert.ValidationSettings())
     {
      //--- muvaffaqiyatsiz
      ExtExpert.Deinit();
      return(INIT_FAILED);
     }
//--- Barcha kerakli ko'rsatkichlarni sozlash
   if(!ExtExpert.InitIndicators())
     {
      //--- muvaffaqiyatsiz
      printf(__DATETIME__+": error initializing indicators");
      ExtExpert.Deinit();
      return(INIT_FAILED);
     }
//--- ok
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Deinitialization function of the expert                          |  Ekspertning initsializatsiya funksiyasi
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
   ExtExpert.Deinit();
  }
//+------------------------------------------------------------------+
//| "Tick" event handler function                                    |  "Tick" hodisasini qayta ishlash funktsiyasi
//+------------------------------------------------------------------+
void OnTick()
  {
   ExtExpert.OnTick();
  }
//+------------------------------------------------------------------+
//| "Trade" event handler function                                   |  "Savdo" hodisasini qayta ishlash funksiyasi
//+------------------------------------------------------------------+
void OnTrade()
  {
   ExtExpert.OnTrade();
  }
//+------------------------------------------------------------------+
//| "Timer" event handler function                                   |  "Taymer" hodisani qayta ishlash funktsiyasi
//+------------------------------------------------------------------+
void OnTimer()
  {
   ExtExpert.OnTimer();
  }
//+------------------------------------------------------------------+


OnInit(is)