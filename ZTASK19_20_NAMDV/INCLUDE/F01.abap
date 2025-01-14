*&---------------------------------------------------------------------*
*& Include          ZSYR1570_NAMDV_F01
*&---------------------------------------------------------------------*
FORM BUILD_CARR_DATA.
  APPEND VALUE #( CARRID   = 'LH'
                  CARRNAME = 'Lufthansa'
                  CURRCODE = 'EUR'
                  URL      = 'http://www.lufthansa.com' ) TO GT_SCARR.

  APPEND VALUE #( CARRID   = 'SQ'
                  CARRNAME = 'Singapore Airlines'
                  CURRCODE = 'SGD'
                  URL      = 'http://www.singaporeair.com' ) TO GT_SCARR.

  PERFORM MODIFY_SCARR_DATA USING GT_SCARR.
ENDFORM.

FORM BUILD_FLIGHT_DATA.
  APPEND VALUE #( CARRID      = 'LH'
                  CONNID      = '400'
                  FLDATE      = '19950228'
                  PRICE       = 899
                  CURRENCY    = 'DEM'
                  PLANETYPE   = 'A319'
                  SEATSMAX    = 350
                  SEATSOCC    = 3
                  PAYMENTSUM  = 2639
                  SEATSMAX_B  = 0
                  SEATSOCC_B  = 0
                  SEATSMAX_F  = 0
                  SEATSOCC_F  = 0 ) TO GT_FLIGHT.

  APPEND VALUE #( CARRID      = 'LH'
                  CONNID      = '454'
                  FLDATE      = '19951117'
                  PRICE       = 1499
                  CURRENCY    = 'DEM'
                  PLANETYPE   = 'A319'
                  SEATSMAX    = 350
                  SEATSOCC    = 2
                  PAYMENTSUM  = 2949
                  SEATSMAX_B  = 0
                  SEATSOCC_B  = 0
                  SEATSMAX_F  = 0
                  SEATSOCC_F  = 0 ) TO GT_FLIGHT.

  APPEND VALUE #( CARRID      = 'LH'
                  CONNID      = '455'
                  FLDATE      = '19950606'
                  PRICE       = 1090
                  CURRENCY    = 'USD'
                  PLANETYPE   = 'A319'
                  SEATSMAX    = 220
                  SEATSOCC    = 1
                  PAYMENTSUM  = 1499
                  SEATSMAX_B  = 0
                  SEATSOCC_B  = 0
                  SEATSMAX_F  = 0
                  SEATSOCC_F  = 0 ) TO GT_FLIGHT.

  APPEND VALUE #( CARRID      = 'LH'
                  CONNID      = '3577'
                  FLDATE      = '19950428'
                  PRICE       = 6000
                  CURRENCY    = 'LIT'
                  PLANETYPE   = 'A319'
                  SEATSMAX    = 220
                  SEATSOCC    = 2
                  PAYMENTSUM  = 600
                  SEATSMAX_B  = 0
                  SEATSOCC_B  = 0
                  SEATSMAX_F  = 0
                  SEATSOCC_F  = 0 ) TO GT_FLIGHT.

  APPEND VALUE #( CARRID      = 'SQ'
                  CONNID      = '26'
                  FLDATE      = '19950228'
                  PRICE       = 849
                  CURRENCY    = 'DEM'
                  PLANETYPE   = 'DC-10-10'
                  SEATSMAX    = 380
                  SEATSOCC    = 2
                  PAYMENTSUM  = 1684
                  SEATSMAX_B  = 0
                  SEATSOCC_B  = 0
                  SEATSMAX_F  = 0
                  SEATSOCC_F  = 0 ) TO GT_FLIGHT.

  PERFORM MODIFY_FLIGHT_DATA USING GT_FLIGHT.
ENDFORM.

FORM BUILD_BOOK_FLIGHT_DATA.
  APPEND VALUE #( CARRID = 'SQ'
                  CONNID = '26'
                  FLDATE = '19950228'
                  BOOKID = '1'
                  CUSTOMID = '2487'
                  CUSTTYPE = 'P'
                  LUGGWEIGHT = '226.000'
                  WUNIT = 'KG'
                  INVOICE = ''
                  CLASS = 'C'
                  FORCURAM = '2000.74'
                  FORCURKEY = 'AUD'
                  LOCCURAM = '4408.08'
                  LOCCURKEY = 'SGD'
                  ORDER_DATE = '20121216'
                  COUNTER = ''
                  AGENCYNUM = '188'
                  PASSNAME = 'OLIVER KOSLOWSKI' ) TO GT_BOOK_FLIGHT.

  APPEND VALUE #( CARRID = 'SQ'
                  CONNID = '26'
                  FLDATE = '19950228'
                  BOOKID = '2'
                  CUSTOMID = '351'
                  CUSTTYPE = 'P'
                  LUGGWEIGHT = '0.00'
                  WUNIT = 'KG'
                  INVOICE = ''
                  CLASS = 'C'
                  FORCURAM = '2804.00'
                  FORCURKEY = 'EUR'
                  LOCCURAM = '4640.08'
                  LOCCURKEY = 'SGD'
                  ORDER_DATE = '20130409'
                  COUNTER = ''
                  AGENCYNUM = '188'
                  PASSNAME = 'INKA VRSIC' ) TO GT_BOOK_FLIGHT.

  APPEND VALUE #( CARRID = 'SQ'
                  CONNID = '26'
                  FLDATE = '19950228'
                  BOOKID = '3'
                  CUSTOMID = '4281'
                  CUSTTYPE = 'P'
                  LUGGWEIGHT = '188.000'
                  WUNIT = 'KG'
                  INVOICE = ''
                  CLASS = 'C'
                  FORCURAM = '4240.08'
                  FORCURKEY = 'SGD'
                  LOCCURAM = '4400.08'
                  LOCCURKEY = 'SGD'
                  ORDER_DATE = '20131224'
                  COUNTER = '72'
                  AGENCYNUM = '188'
                  PASSNAME = 'WALTER HELLER' ) TO GT_BOOK_FLIGHT.

  APPEND VALUE #( CARRID = 'SQ'
                  CONNID = '26'
                  FLDATE = '19950228'
                  BOOKID = '4'
                  CUSTOMID = '2523'
                  CUSTTYPE = 'P'
                  LUGGWEIGHT = '152.000'
                  WUNIT = 'KG'
                  INVOICE = ''
                  CLASS = 'C'
                  FORCURAM = '2063.80'
                  FORCURKEY = 'EUR'
                  LOCCURAM = '4408.08'
                  LOCCURKEY = 'SGD'
                  ORDER_DATE = '20130311'
                  COUNTER = ''
                  AGENCYNUM = '188'
                  PASSNAME = 'ULLA LAUTENBACH' ) TO GT_BOOK_FLIGHT.

  APPEND VALUE #( CARRID = 'SQ'
                  CONNID = '26'
                  FLDATE = '19950228'
                  BOOKID = '5'
                  CUSTOMID = '442'
                  CUSTTYPE = 'P'
                  LUGGWEIGHT = '104.000'
                  WUNIT = 'KG'
                  INVOICE = 'X'
                  CLASS = 'C'
                  FORCURAM = '1790.13'
                  FORCURKEY = 'AUD'
                  LOCCURAM = '3944.90'
                  LOCCURKEY = 'SGD'
                  ORDER_DATE = '20121216'
                  COUNTER = ''
                  AGENCYNUM = '188'
                  PASSNAME = 'GÜNTER HAHN' ) TO GT_BOOK_FLIGHT.

  APPEND VALUE #( CARRID = 'LH'
                  CONNID = '400'
                  FLDATE = '19950228'
                  BOOKID = '1'
                  CUSTOMID = '946'
                  CUSTTYPE = 'P'
                  LUGGWEIGHT = '0.00'
                  WUNIT = 'KG'
                  INVOICE = ''
                  CLASS = 'C'
                  FORCURAM = '764.99'
                  FORCURKEY = 'GBP'
                  LOCCURAM = '1265.40'
                  LOCCURKEY = 'EUR'
                  ORDER_DATE = '20130305'
                  COUNTER = ''
                  AGENCYNUM = '188'
                  PASSNAME = 'CHRISTINE PICARD' ) TO GT_BOOK_FLIGHT.

  APPEND VALUE #( CARRID = 'LH'
                  CONNID = '400'
                  FLDATE = '19950228'
                  BOOKID = '2'
                  CUSTOMID = '2400'
                  CUSTTYPE = 'P'
                  LUGGWEIGHT = '202.000'
                  WUNIT = 'KG'
                  INVOICE = ''
                  CLASS = 'C'
                  FORCURAM = '1983.79'
                  FORCURKEY = 'SGD'
                  LOCCURAM = '1198.90'
                  LOCCURKEY = 'EUR'
                  ORDER_DATE = '20130325'
                  COUNTER = ''
                  AGENCYNUM = '188'
                  PASSNAME = 'JEAN SUDHOFF' ) TO GT_BOOK_FLIGHT.

  APPEND VALUE #( CARRID = 'LH'
                  CONNID = '400'
                  FLDATE = '19950228'
                  BOOKID = '3'
                  CUSTOMID = '3621'
                  CUSTTYPE = 'P'
                  LUGGWEIGHT = '0.00'
                  WUNIT = 'KG'
                  INVOICE = 'X'
                  CLASS = 'C'
                  FORCURAM = '1132.20'
                  FORCURKEY = 'EUR'
                  LOCCURAM = '1132.20'
                  LOCCURKEY = 'EUR'
                  ORDER_DATE = '20130423'
                  COUNTER = ''
                  AGENCYNUM = '188'
                  PASSNAME = 'THILO DORNMENECH' ) TO GT_BOOK_FLIGHT.

  APPEND VALUE #( CARRID = 'LH'
                  CONNID = '400'
                  FLDATE = '19950228'
                  BOOKID = '4'
                  CUSTOMID = '1193'
                  CUSTTYPE = 'P'
                  LUGGWEIGHT = '28.00'
                  WUNIT = 'KG'
                  INVOICE = ''
                  CLASS = 'C'
                  FORCURAM = '702.36'
                  FORCURKEY = 'GBP'
                  LOCCURAM = '1132.20'
                  LOCCURKEY = 'EUR'
                  ORDER_DATE = '20130207'
                  COUNTER = ''
                  AGENCYNUM = '188'
                  PASSNAME = 'THOMAS SOMMER' ) TO GT_BOOK_FLIGHT.

  APPEND VALUE #( CARRID = 'LH'
                  CONNID = '400'
                  FLDATE = '19950228'
                  BOOKID = '5'
                  CUSTOMID = '4521'
                  CUSTTYPE = 'P'
                  LUGGWEIGHT = '186.000'
                  WUNIT = 'KG'
                  INVOICE = 'X'
                  CLASS = 'C'
                  FORCURAM = '1332.00'
                  FORCURKEY = 'EUR'
                  LOCCURAM = '1332.00'
                  LOCCURKEY = 'EUR'
                  ORDER_DATE = '20121209'
                  COUNTER = ''
                  AGENCYNUM = '188'
                  PASSNAME = 'CLAIRE HELLER' ) TO GT_BOOK_FLIGHT.

  APPEND VALUE #( CARRID = 'LH'
                  CONNID = '455'
                  FLDATE = '19950228'
                  BOOKID = '1'
                  CUSTOMID = '946'
                  CUSTTYPE = 'P'
                  LUGGWEIGHT = '0.00'
                  WUNIT = 'KG'
                  INVOICE = ''
                  CLASS = 'C'
                  FORCURAM = '764.99'
                  FORCURKEY = 'GBP'
                  LOCCURAM = '1265.40'
                  LOCCURKEY = 'EUR'
                  ORDER_DATE = '20130305'
                  COUNTER = ''
                  AGENCYNUM = '188'
                  PASSNAME = 'CHRISTINE PICARD' ) TO GT_BOOK_FLIGHT.

  APPEND VALUE #( CARRID = 'LH'
                  CONNID = '455'
                  FLDATE = '19950228'
                  BOOKID = '2'
                  CUSTOMID = '2400'
                  CUSTTYPE = 'P'
                  LUGGWEIGHT = '202.000'
                  WUNIT = 'KG'
                  INVOICE = ''
                  CLASS = 'C'
                  FORCURAM = '1983.79'
                  FORCURKEY = 'SGD'
                  LOCCURAM = '1198.90'
                  LOCCURKEY = 'EUR'
                  ORDER_DATE = '20130325'
                  COUNTER = ''
                  AGENCYNUM = '188'
                  PASSNAME = 'JEAN SUDHOFF' ) TO GT_BOOK_FLIGHT.

  APPEND VALUE #( CARRID = 'LH'
                  CONNID = '454'
                  FLDATE = '19950606'
                  BOOKID = '1'
                  CUSTOMID = '3621'
                  CUSTTYPE = 'P'
                  LUGGWEIGHT = '0.00'
                  WUNIT = 'KG'
                  INVOICE = 'X'
                  CLASS = 'C'
                  FORCURAM = '1132.20'
                  FORCURKEY = 'EUR'
                  LOCCURAM = '1132.20'
                  LOCCURKEY = 'EUR'
                  ORDER_DATE = '20130423'
                  COUNTER = ''
                  AGENCYNUM = '188'
                  PASSNAME = 'THILO DORNMENECH' ) TO GT_BOOK_FLIGHT.

  APPEND VALUE #( CARRID = 'LH'
                  CONNID = '454'
                  FLDATE = '19950606'
                  BOOKID = '2'
                  CUSTOMID = '1193'
                  CUSTTYPE = 'P'
                  LUGGWEIGHT = '28.00'
                  WUNIT = 'KG'
                  INVOICE = ''
                  CLASS = 'C'
                  FORCURAM = '702.36'
                  FORCURKEY = 'GBP'
                  LOCCURAM = '1132.20'
                  LOCCURKEY = 'EUR'
                  ORDER_DATE = '20130207'
                  COUNTER = ''
                  AGENCYNUM = '188'
                  PASSNAME = 'THOMAS SOMMER' ) TO GT_BOOK_FLIGHT.

  APPEND VALUE #( CARRID = 'LH'
                  CONNID = '3577'
                  FLDATE = '19952804'
                  BOOKID = '1'
                  CUSTOMID = '4521'
                  CUSTTYPE = 'P'
                  LUGGWEIGHT = '186.00'
                  WUNIT = 'KG'
                  INVOICE = 'X'
                  CLASS = 'C'
                  FORCURAM = '1332'
                  FORCURKEY = 'EUR'
                  LOCCURAM = '1332.0'
                  LOCCURKEY = 'EUR'
                  ORDER_DATE = '20121209'
                  COUNTER = ''
                  AGENCYNUM = '188'
                  PASSNAME = 'CLAIRE HELLER' ) TO GT_BOOK_FLIGHT.

  PERFORM MODIFY_BOOK_FLIGHT_DATA USING GT_BOOK_FLIGHT.
ENDFORM.

* FORM MODIFY DATA INTO SCARR TABLE
FORM MODIFY_SCARR_DATA USING UT_SCARR TYPE TABLE.
  MODIFY ZY050T FROM TABLE UT_SCARR.
  IF SY-SUBRC = 0.
    WRITE: / TEXT-001.
  ELSE.
    WRITE: / TEXT-002.
  ENDIF.
ENDFORM.

* FORM MODIFY DATA INTO FLIGHT TABLE
FORM MODIFY_FLIGHT_DATA USING UT_FLIGHT TYPE TABLE.
  MODIFY ZY052T FROM TABLE UT_FLIGHT.
  IF SY-SUBRC = 0.
    WRITE: / TEXT-003.
  ELSE.
    WRITE: / TEXT-004.
  ENDIF.
ENDFORM.

* FORM MODIFY DATA INTO BOOK FLIGHT TABLE
FORM MODIFY_BOOK_FLIGHT_DATA USING UT_BF TYPE TABLE.
  MODIFY ZY054T FROM TABLE UT_BF.
  IF SY-SUBRC = 0.
    WRITE: / TEXT-005.
  ELSE.
    WRITE: / TEXT-006.
  ENDIF.
ENDFORM.