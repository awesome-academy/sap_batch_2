*&---------------------------------------------------------------------*
*& Report ZSYR8413
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zsyr8413.

DATA: lt_scarr   TYPE TABLE OF zy84t_scarr,
      ls_scarr   TYPE zy84t_scarr,
      lt_sflight TYPE TABLE OF zy84t_sflight,
      ls_sflight TYPE zy84t_sflight,
      lt_sbook   TYPE TABLE OF zy84t_sbook,
      ls_sbook   TYPE zy84t_sbook.

" SCARR Table
ls_scarr-carrid = 'LH'.
ls_scarr-carrname = 'Lufthansa'.
ls_scarr-currcode = 'EUR'.
ls_scarr-url = 'http://www.lufthansa.com'.
APPEND ls_scarr TO lt_scarr.

ls_scarr-carrid = 'SO'.
ls_scarr-carrname = 'Singapore Airlines'.
ls_scarr-currcode = 'SGD'.
ls_scarr-url = 'http://www.singaporeair.com'.
APPEND ls_scarr TO lt_scarr.

" Insert table
*INSERT ZY84T_SCARR FROM TABLE lt_scarr.

WRITE: / 'CARRID', 15 'CARRNAME', 40 'CURRCODE', 60 'URL'.
LOOP AT lt_scarr INTO ls_scarr.
  WRITE: / ls_scarr-carrid, 15 ls_scarr-carrname, 40 ls_scarr-currcode, 60 ls_scarr-url.
ENDLOOP.
ULINE.

" SFLIGHT Table
ls_sflight-carrid = 'LH'.
ls_sflight-connid = '450'.
ls_sflight-fldate = '19950222'.
ls_sflight-price = '899'.
ls_sflight-currency = 'DEM'.
ls_sflight-planetype = 'A319'.
ls_sflight-seatsmax = '350'.
ls_sflight-seatsocc = '3'.
ls_sflight-paymentsum = '2635.00'.
APPEND ls_sflight TO lt_sflight.

ls_sflight-carrid = 'LH'.
ls_sflight-connid = '450'.
ls_sflight-fldate = '19951117'.
ls_sflight-price = '1499'.
ls_sflight-currency = 'DEM'.
ls_sflight-planetype = 'A319'.
ls_sflight-seatsmax = '350'.
ls_sflight-seatsocc = '2'.
ls_sflight-paymentsum = '2849.00'.
APPEND ls_sflight TO lt_sflight.

ls_sflight-carrid = 'LH'.
ls_sflight-connid = '450'.
ls_sflight-fldate = '19950606'.
ls_sflight-price = '1090'.
ls_sflight-currency = 'USD'.
ls_sflight-planetype = 'A319'.
ls_sflight-seatsmax = '220'.
ls_sflight-seatsocc = '1'.
ls_sflight-paymentsum = '1459.00'.
APPEND ls_sflight TO lt_sflight.

ls_sflight-carrid = 'LH'.
ls_sflight-connid = '3577'.
ls_sflight-fldate = '19950402'.
ls_sflight-price = '6000'.
ls_sflight-currency = 'LIT'.
ls_sflight-planetype = 'A319'.
ls_sflight-seatsmax = '220'.
ls_sflight-seatsocc = '1'.
ls_sflight-paymentsum = '600'.
APPEND ls_sflight TO lt_sflight.

ls_sflight-carrid = 'SO'.
ls_sflight-connid = '26'.
ls_sflight-fldate = '19950222'.
ls_sflight-price = '849'.
ls_sflight-currency = 'DEM'.
ls_sflight-planetype = 'DC-10-10'.
ls_sflight-seatsmax = '380'.
ls_sflight-seatsocc = '2'.
ls_sflight-paymentsum = '1684.00'.
APPEND ls_sflight TO lt_sflight.

" Insert dữ liệu vào bảng
*INSERT zy##t_sflight FROM TABLE lt_sflight ACCEPTING DUPLICATE KEYS.

WRITE: / 'CARRID',8 'CONNID', 15 'FLDATE', 30 'PRICE', 46 'CURRENCY', 55 'PLANETYPE', 65 'SEATSMAX', 80 'SEATSOCC', 90 'PAYMENTSUM'.
LOOP AT lt_sflight INTO ls_sflight.
  WRITE: / ls_sflight-carrid, 8 ls_sflight-connid, 15 ls_sflight-fldate,
           25 ls_sflight-price, 46 ls_sflight-currency, 55 ls_sflight-planetype,
           65 ls_sflight-seatsmax, 80 ls_sflight-seatsocc, 90 ls_sflight-paymentsum.
ENDLOOP.
ULINE.

" SBOOK Table
ls_sbook-carrid = 'SQ'.
ls_sbook-connid = '26'.
ls_sbook-fldate = '19950228'.
ls_sbook-bookid = '1'.
ls_sbook-customid = '2447P'.
ls_sbook-custtype = 'OKG'.
ls_sbook-luggweight = '226.000'.
ls_sbook-wunit = 'KG'.
ls_sbook-invoice = 'C'.
ls_sbook-forcuram = '2000.74'.
ls_sbook-forcurkey = 'AUD'.
ls_sbook-loccuram = '4408.08'.
ls_sbook-loccurkey = 'SGD'.
ls_sbook-order_date = '20121205'.
ls_sbook-counter = '188'.
ls_sbook-agencynum = 'Loftair Kostowski'.
APPEND ls_sbook TO lt_sbook.

ls_sbook-carrid = 'SQ'.
ls_sbook-connid = '26'.
ls_sbook-fldate = '19950228'.
ls_sbook-bookid = '2'.
ls_sbook-customid = '351IP'.
ls_sbook-custtype = 'OKG'.
ls_sbook-luggweight = ''.
ls_sbook-wunit = ''.
ls_sbook-invoice = 'C'.
ls_sbook-forcuram = '2804.00'.
ls_sbook-forcurkey = 'EUR'.
ls_sbook-loccuram = '4840.08'.
ls_sbook-loccurkey = 'SGD'.
ls_sbook-order_date = '20130409'.
ls_sbook-counter = '188'.
ls_sbook-agencynum = 'Ilng Wisk'.
APPEND ls_sbook TO lt_sbook.

ls_sbook-carrid = 'SQ'.
ls_sbook-connid = '26'.
ls_sbook-fldate = '19950228'.
ls_sbook-bookid = '3'.
ls_sbook-customid = '4281P'.
ls_sbook-custtype = 'OKG'.
ls_sbook-luggweight = '188.000'.
ls_sbook-wunit = 'KG'.
ls_sbook-invoice = 'C'.
ls_sbook-forcuram = '4840.08'.
ls_sbook-forcurkey = 'SGD'.
ls_sbook-loccuram = '4840.08'.
ls_sbook-loccurkey = 'SGD'.
ls_sbook-order_date = '20121224'.
ls_sbook-counter = '72'.
ls_sbook-agencynum = 'Walter Heller'.
APPEND ls_sbook TO lt_sbook.

ls_sbook-carrid = 'SQ'.
ls_sbook-connid = '26'.
ls_sbook-fldate = '19950228'.
ls_sbook-bookid = '4'.
ls_sbook-customid = '2523P'.
ls_sbook-custtype = 'OKG'.
ls_sbook-luggweight = '192.000'.
ls_sbook-wunit = 'KG'.
ls_sbook-invoice = 'C'.
ls_sbook-forcuram = '2636.80'.
ls_sbook-forcurkey = 'EUR'.
ls_sbook-loccuram = '4408.08'.
ls_sbook-loccurkey = 'SGD'.
ls_sbook-order_date = '20130311'.
ls_sbook-counter = '188'.
ls_sbook-agencynum = 'Lisa Laudensach'.
APPEND ls_sbook TO lt_sbook.

ls_sbook-carrid = 'SQ'.
ls_sbook-connid = '26'.
ls_sbook-fldate = '19950228'.
ls_sbook-bookid = '6'.
ls_sbook-customid = '442IP'.
ls_sbook-custtype = 'OKG'.
ls_sbook-luggweight = '104.000'.
ls_sbook-wunit = 'KG'.
ls_sbook-invoice = 'X'.
ls_sbook-forcuram = '1793.73'.
ls_sbook-forcurkey = 'AUD'.
ls_sbook-loccuram = '3844.06'.
ls_sbook-loccurkey = 'SGD'.
ls_sbook-order_date = '20121215'.
ls_sbook-counter = '188'.
ls_sbook-agencynum = 'Johann Rahn'.
APPEND ls_sbook TO lt_sbook.

ls_sbook-carrid = 'LH'.
ls_sbook-connid = '400'.
ls_sbook-fldate = '19950222'.
ls_sbook-bookid = '1'.
ls_sbook-customid = '845IP'.
ls_sbook-custtype = ''.
ls_sbook-luggweight = '0'.
ls_sbook-wunit = 'KG'.
ls_sbook-invoice = 'C'.
ls_sbook-forcuram = '1744.99'.
ls_sbook-forcurkey = 'GBP'.
ls_sbook-loccuram = '17955.40'.
ls_sbook-loccurkey = 'EUR'.
ls_sbook-order_date = '20130305'.
ls_sbook-counter = '188'.
ls_sbook-agencynum = 'Christina Picard'.
APPEND ls_sbook TO lt_sbook.

ls_sbook-carrid = 'LH'.
ls_sbook-connid = '400'.
ls_sbook-fldate = '19950222'.
ls_sbook-bookid = '2'.
ls_sbook-customid = '2400IP'.
ls_sbook-custtype = ''.
ls_sbook-luggweight = '202.000'.
ls_sbook-wunit = 'KG'.
ls_sbook-invoice = 'C'.
ls_sbook-forcuram = '1183.79'.
ls_sbook-forcurkey = 'SGD'.
ls_sbook-loccuram = '1198.80'.
ls_sbook-loccurkey = 'EUR'.
ls_sbook-order_date = '20130325'.
ls_sbook-counter = '188'.
ls_sbook-agencynum = 'Jean Sudhoff'.
APPEND ls_sbook TO lt_sbook.

ls_sbook-carrid = 'LH'.
ls_sbook-connid = '400'.
ls_sbook-fldate = '19950222'.
ls_sbook-bookid = '3'.
ls_sbook-customid = '3521IP'.
ls_sbook-custtype = 'X'.
ls_sbook-luggweight = '0'.
ls_sbook-wunit = 'KG'.
ls_sbook-invoice = 'C'.
ls_sbook-forcuram = '1132.20'.
ls_sbook-forcurkey = 'BUR'.
ls_sbook-loccuram = '1132.20'.
ls_sbook-loccurkey = 'EUR'.
ls_sbook-order_date = '20130423'.
ls_sbook-counter = '188'.
ls_sbook-agencynum = 'Thito Domenech'.
APPEND ls_sbook TO lt_sbook.

ls_sbook-carrid = 'LH'.
ls_sbook-connid = '400'.
ls_sbook-fldate = '19950222'.
ls_sbook-bookid = '4'.
ls_sbook-customid = '1193IP'.
ls_sbook-custtype = ''.
ls_sbook-luggweight = '28'.
ls_sbook-wunit = 'KG'.
ls_sbook-invoice = 'C'.
ls_sbook-forcuram = '702.45'.
ls_sbook-forcurkey = 'GBP'.
ls_sbook-loccuram = '11132.00'.
ls_sbook-loccurkey = 'EUR'.
ls_sbook-order_date = '20130207'.
ls_sbook-counter = '189'.
ls_sbook-agencynum = 'Thomas Sommer'.
APPEND ls_sbook TO lt_sbook.

ls_sbook-carrid = 'LH'.
ls_sbook-connid = '400'.
ls_sbook-fldate = '19950222'.
ls_sbook-bookid = '5'.
ls_sbook-customid = '4521IP'.
ls_sbook-custtype = 'X'.
ls_sbook-luggweight = '186.000'.
ls_sbook-wunit = 'KG'.
ls_sbook-invoice = 'C'.
ls_sbook-forcuram = '1332.00'.
ls_sbook-forcurkey = 'EUR'.
ls_sbook-loccuram = '1332.00'.
ls_sbook-loccurkey = 'EUR'.
ls_sbook-order_date = '20121209'.
ls_sbook-counter = '188'.
ls_sbook-agencynum = 'Cater Helier'.
APPEND ls_sbook TO lt_sbook.

ls_sbook-carrid = 'LH'.
ls_sbook-connid = '455'.
ls_sbook-fldate = '19950222'.
ls_sbook-bookid = '6'.
ls_sbook-customid = '945IP'.
ls_sbook-custtype = ''.
ls_sbook-luggweight = '0'.
ls_sbook-wunit = 'KG'.
ls_sbook-invoice = 'C'.
ls_sbook-forcuram = '784.49'.
ls_sbook-forcurkey = 'GBP'.
ls_sbook-loccuram = '1265.40'.
ls_sbook-loccurkey = 'EUR'.
ls_sbook-order_date = '20130305'.
ls_sbook-counter = '188'.
ls_sbook-agencynum = 'Justine Picard'.
APPEND ls_sbook TO lt_sbook.

ls_sbook-carrid = 'LH'.
ls_sbook-connid = '455'.
ls_sbook-fldate = '19950222'.
ls_sbook-bookid = '2'.
ls_sbook-customid = '2400IP'.
ls_sbook-custtype = ''.
ls_sbook-luggweight = '202.000'.
ls_sbook-wunit = 'KG'.
ls_sbook-invoice = 'C'.
ls_sbook-forcuram = '1983.79'.
ls_sbook-forcurkey = 'SGD'.
ls_sbook-loccuram = '1198.80'.
ls_sbook-loccurkey = 'EUR'.
ls_sbook-order_date = '20130325'.
ls_sbook-counter = '188'.
ls_sbook-agencynum = 'Jean Sudhoff'.
APPEND ls_sbook TO lt_sbook.

ls_sbook-carrid = 'LH'.
ls_sbook-connid = '454'.
ls_sbook-fldate = '19950606'.
ls_sbook-bookid = '1'.
ls_sbook-customid = '3521IP'.
ls_sbook-custtype = 'X'.
ls_sbook-luggweight = '0'.
ls_sbook-wunit = 'KG'.
ls_sbook-invoice = 'C'.
ls_sbook-forcuram = '1132.20'.
ls_sbook-forcurkey = 'EUR'.
ls_sbook-loccuram = '1132.20'.
ls_sbook-loccurkey = 'EUR'.
ls_sbook-order_date = '20130423'.
ls_sbook-counter = '188'.
ls_sbook-agencynum = 'Thito Domenech'.
APPEND ls_sbook TO lt_sbook.

ls_sbook-carrid = 'LH'.
ls_sbook-connid = '454'.
ls_sbook-fldate = '19950606'.
ls_sbook-bookid = '2'.
ls_sbook-customid = '1193IP'.
ls_sbook-custtype = ''.
ls_sbook-luggweight = '28'.
ls_sbook-wunit = 'KG'.
ls_sbook-invoice = 'C'.
ls_sbook-forcuram = '702.35'.
ls_sbook-forcurkey = 'GBP'.
ls_sbook-loccuram = '11132.00'.
ls_sbook-loccurkey = 'EUR'.
ls_sbook-order_date = '20130207'.
ls_sbook-counter = '188'.
ls_sbook-agencynum = 'Thomas Sommer'.
APPEND ls_sbook TO lt_sbook.

ls_sbook-carrid = 'LH'.
ls_sbook-connid = '3577'.
ls_sbook-fldate = '19950402'.
ls_sbook-bookid = '1'.
ls_sbook-customid = '4521IP'.
ls_sbook-custtype = 'X'.
ls_sbook-luggweight = '186.000'.
ls_sbook-wunit = 'KG'.
ls_sbook-invoice = 'C'.
ls_sbook-forcuram = '1133.20'.
ls_sbook-forcurkey = 'EUR'.
ls_sbook-loccuram = '1332.00'.
ls_sbook-loccurkey = 'EUR'.
ls_sbook-order_date = '20121209'.
ls_sbook-counter = '188'.
ls_sbook-agencynum = 'Claire Helier'.
APPEND ls_sbook TO lt_sbook.

" Insert dữ liệu vào bảng
*INSERT ZY84T_SBOOK FROM TABLE lt_sbook ACCEPTING DUPLICATE KEYS.

WRITE: / 'CARRID',8 'CONNID', 15 'FLDATE', 30 'BOOKID',
40 'CUSTOMID', 50 'CUSTTYPE', 60 'LUGGWEIGHT', 70 'WUNIT', 80 'INVOICE',
90 'FORCURAM', 110 'FORCURKEY', 120 'LOCCURAM',
130 'LOCCURKEY', 140 'ORDER_DATE', 150 'COUNTER', 160 'AGENCYNUM'.
LOOP AT lt_sbook INTO ls_sbook.
  WRITE: / ls_sbook-carrid, 8 ls_sbook-connid, 15 ls_sbook-fldate,
           30 ls_sbook-bookid, 40 ls_sbook-customid, 50 ls_sbook-custtype,
           60 ls_sbook-luggweight, 70 ls_sbook-wunit, 80 ls_sbook-invoice,
           90 ls_sbook-forcuram, 110 ls_sbook-forcurkey, 120 ls_sbook-loccuram,
           130 ls_sbook-loccurkey, 140 ls_sbook-order_date, 150 ls_sbook-counter, 160 ls_sbook-agencynum.
ENDLOOP.
ULINE.
