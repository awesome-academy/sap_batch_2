*&---------------------------------------------------------------------*
*& Include          ZSYRO1110_T15_GNV_F01
*&---------------------------------------------------------------------*

FORM modify_table_zyscarr1t.
APPEND VALUE #( carrid   = 'LH'
                carrname = 'Lufthansa'
                currcode = 'EUR'
                url      = 'http://www.lufthansa.com' ) TO gt_yscarr1t.

APPEND VALUE #( carrid   = 'SQ'
                carrname = 'Singapore Airlines'
                currcode = 'SGD'
                url      = 'http://www.singaporeair.com' ) TO gt_yscarr1t.

PERFORM insert_yscarr1t USING gt_yscarr1t.
ENDFORM.


FORM modify_table_zysflight1t.
" Populate the internal table with the provided data
APPEND VALUE #( carrid      = 'LH'
                connid      = '400'
                fldate      = '19950228'
                price       = 899
                currency    = 'DEM'
                planetype   = 'A319'
                seatsmax    = 350
                seatsocc    = 3
                paymentsum  = 2639
                seatsmax_b  = 0
                seatsocc_b  = 0
                seatsmax_f  = 0
                seatsocc_f  = 0 ) TO gt_ysflight1t.

APPEND VALUE #( carrid      = 'LH'
                connid      = '454'
                fldate      = '19951117'
                price       = 1499
                currency    = 'DEM'
                planetype   = 'A319'
                seatsmax    = 350
                seatsocc    = 2
                paymentsum  = 2949
                seatsmax_b  = 0
                seatsocc_b  = 0
                seatsmax_f  = 0
                seatsocc_f  = 0 ) TO gt_ysflight1t.

APPEND VALUE #( carrid      = 'LH'
                connid      = '455'
                fldate      = '19950606'
                price       = 1090
                currency    = 'USD'
                planetype   = 'A319'
                seatsmax    = 220
                seatsocc    = 1
                paymentsum  = 1499
                seatsmax_b  = 0
                seatsocc_b  = 0
                seatsmax_f  = 0
                seatsocc_f  = 0 ) TO gt_ysflight1t.

APPEND VALUE #( carrid      = 'LH'
                connid      = '3577'
                fldate      = '19950428'
                price       = 6000
                currency    = 'LIT'
                planetype   = 'A319'
                seatsmax    = 220
                seatsocc    = 2
                paymentsum  = 600
                seatsmax_b  = 0
                seatsocc_b  = 0
                seatsmax_f  = 0
                seatsocc_f  = 0 ) TO gt_ysflight1t.

APPEND VALUE #( carrid      = 'SQ'
                connid      = '26'
                fldate      = '19950228'
                price       = 849
                currency    = 'DEM'
                planetype   = 'DC-10-10'
                seatsmax    = 380
                seatsocc    = 2
                paymentsum  = 1684
                seatsmax_b  = 0
                seatsocc_b  = 0
                seatsmax_f  = 0
                seatsocc_f  = 0 ) TO gt_ysflight1t.

  PERFORM insert_ysflight1t USING gt_ysflight1t.
ENDFORM.


FORM modify_table_zysbook1t.

  DATA: ls_booking  TYPE zysbook1t.

* Fill internal table with booking data
ls_booking-carrid     = 'SQ'.
ls_booking-connid     = '26'.
ls_booking-fldate     = '19950228'.
ls_booking-bookid     = '1'.
ls_booking-customid   = '2487'.
ls_booking-custtype   = 'P'.
ls_booking-luggweight = '226.000'.
ls_booking-wunit      = 'KG'.
ls_booking-invoice    = ''.
ls_booking-class      = 'C'.
ls_booking-forcuram   = '2000.74'.
ls_booking-forcurkey  = 'AUD'.
ls_booking-loccuram   = '4408.08'.
ls_booking-loccurkey  = 'SGD'.
ls_booking-order_date = '20121216'.
ls_booking-counter    = ''.
ls_booking-agencynum  = '188'.
ls_booking-passname   = 'Oliver Koslowski'.
APPEND ls_booking TO gt_ysbook1t.

CLEAR ls_booking.
ls_booking-carrid     = 'SQ'.
ls_booking-connid     = '26'.
ls_booking-fldate     = '19950228'.
ls_booking-bookid     = '2'.
ls_booking-customid   = '351'.
ls_booking-custtype   = 'P'.
ls_booking-luggweight = '0.00'.
ls_booking-wunit      = 'KG'.
ls_booking-invoice    = ''.
ls_booking-class      = 'C'.
ls_booking-forcuram   = '2804.00'.
ls_booking-forcurkey  = 'EUR'.
ls_booking-loccuram   = '4640.08'.
ls_booking-loccurkey  = 'SGD'.
ls_booking-order_date = '20130409'.
ls_booking-counter    = ''.
ls_booking-agencynum  = '188'.
ls_booking-passname   = 'Inka Vrsic'.
APPEND ls_booking TO gt_ysbook1t.

CLEAR ls_booking.
ls_booking-carrid     = 'SQ'.
ls_booking-connid     = '26'.
ls_booking-fldate     = '19950228'.
ls_booking-bookid     = '3'.
ls_booking-customid   = '4281'.
ls_booking-custtype   = 'P'.
ls_booking-luggweight = '188.000'.
ls_booking-wunit      = 'KG'.
ls_booking-invoice    = ''.
ls_booking-class      = 'C'.
ls_booking-forcuram   = '4240.08'.
ls_booking-forcurkey  = 'SGD'.
ls_booking-loccuram   = '4400.08'.
ls_booking-loccurkey  = 'SGD'.
ls_booking-order_date = '20131224'.
ls_booking-counter    = '72'.
ls_booking-agencynum  = '188'.
ls_booking-passname   = 'Walter Heller'.
APPEND ls_booking TO gt_ysbook1t.

CLEAR ls_booking.
ls_booking-carrid     = 'SQ'.
ls_booking-connid     = '26'.
ls_booking-fldate     = '19950228'.
ls_booking-bookid     = '4'.
ls_booking-customid   = '2523'.
ls_booking-custtype   = 'P'.
ls_booking-luggweight = '152.000'.
ls_booking-wunit      = 'KG'.
ls_booking-invoice    = ''.
ls_booking-class      = 'C'.
ls_booking-forcuram   = '2063.80'.
ls_booking-forcurkey  = 'EUR'.
ls_booking-loccuram   = '4408.08'.
ls_booking-loccurkey  = 'SGD'.
ls_booking-order_date = '20130311'.
ls_booking-counter    = ''.
ls_booking-agencynum  = '188'.
ls_booking-passname   = 'Ulla Lautenbach'.
APPEND ls_booking TO gt_ysbook1t.

CLEAR ls_booking.
ls_booking-carrid     = 'SQ'.
ls_booking-connid     = '26'.
ls_booking-fldate     = '19950228'.
ls_booking-bookid     = '5'.
ls_booking-customid   = '442'.
ls_booking-custtype   = 'P'.
ls_booking-luggweight = '104.000'.
ls_booking-wunit      = 'KG'.
ls_booking-invoice    = 'X'.
ls_booking-class      = 'C'.
ls_booking-forcuram   = '1790.13'.
ls_booking-forcurkey  = 'AUD'.
ls_booking-loccuram   = '3944.90'.
ls_booking-loccurkey  = 'SGD'.
ls_booking-order_date = '20121216'.
ls_booking-counter    = ''.
ls_booking-agencynum  = '188'.
ls_booking-passname   = 'Günter Hahn'.
APPEND ls_booking TO gt_ysbook1t.

CLEAR ls_booking.
ls_booking-carrid     = 'LH'.
ls_booking-connid     = '400'.
ls_booking-fldate     = '19950228'.
ls_booking-bookid     = '1'.
ls_booking-customid   = '946'.
ls_booking-custtype   = 'P'.
ls_booking-luggweight = '0.00'.
ls_booking-wunit      = 'KG'.
ls_booking-invoice    = ''.
ls_booking-class      = 'C'.
ls_booking-forcuram   = '764.99'.
ls_booking-forcurkey  = 'GBP'.
ls_booking-loccuram   = '1265.40'.
ls_booking-loccurkey  = 'EUR'.
ls_booking-order_date = '20130305'.
ls_booking-counter    = ''.
ls_booking-agencynum  = '188'.
ls_booking-passname   = 'Christine Picard'.
APPEND ls_booking TO gt_ysbook1t.

CLEAR ls_booking.
ls_booking-carrid     = 'LH'.
ls_booking-connid     = '400'.
ls_booking-fldate     = '19950228'.
ls_booking-bookid     = '2'.
ls_booking-customid   = '2400'.
ls_booking-custtype   = 'P'.
ls_booking-luggweight = '202.000'.
ls_booking-wunit      = 'KG'.
ls_booking-invoice    = ''.
ls_booking-class      = 'C'.
ls_booking-forcuram   = '1983.79'.
ls_booking-forcurkey  = 'SGD'.
ls_booking-loccuram   = '1198.90'.
ls_booking-loccurkey  = 'EUR'.
ls_booking-order_date = '20130325'.
ls_booking-counter    = ''.
ls_booking-agencynum  = '188'.
ls_booking-passname   = 'Jean Sudhoff'.
APPEND ls_booking TO gt_ysbook1t.

CLEAR ls_booking.
ls_booking-carrid     = 'LH'.
ls_booking-connid     = '400'.
ls_booking-fldate     = '19950228'.
ls_booking-bookid     = '3'.
ls_booking-customid   = '3621'.
ls_booking-custtype   = 'P'.
ls_booking-luggweight = '0.00'.
ls_booking-wunit      = 'KG'.
ls_booking-invoice    = 'X'.
ls_booking-class      = 'C'.
ls_booking-forcuram   = '1132.20'.
ls_booking-forcurkey  = 'EUR'.
ls_booking-loccuram   = '1132.20'.
ls_booking-loccurkey  = 'EUR'.
ls_booking-order_date = '20130423'.
ls_booking-counter    = ''.
ls_booking-agencynum  = '188'.
ls_booking-passname   = 'Thilo Dornmenech'.
APPEND ls_booking TO gt_ysbook1t.

CLEAR ls_booking.
ls_booking-carrid     = 'LH'.
ls_booking-connid     = '400'.
ls_booking-fldate     = '19950228'.
ls_booking-bookid     = '4'.
ls_booking-customid   = '1193'.
ls_booking-custtype   = 'P'.
ls_booking-luggweight = '28.00'.
ls_booking-wunit      = 'KG'.
ls_booking-invoice    = ''.
ls_booking-class      = 'C'.
ls_booking-forcuram   = '702.36'.
ls_booking-forcurkey  = 'GBP'.
ls_booking-loccuram   = '1132.20'.
ls_booking-loccurkey  = 'EUR'.
ls_booking-order_date = '20130207'.
ls_booking-counter    = ''.
ls_booking-agencynum  = '188'.
ls_booking-passname   = 'Thomas Sommer'.
APPEND ls_booking TO gt_ysbook1t.

CLEAR ls_booking.
ls_booking-carrid     = 'LH'.
ls_booking-connid     = '400'.
ls_booking-fldate     = '19950228'.
ls_booking-bookid     = '5'.
ls_booking-customid   = '4521'.
ls_booking-custtype   = 'P'.
ls_booking-luggweight = '186.000'.
ls_booking-wunit      = 'KG'.
ls_booking-invoice    = 'X'.
ls_booking-class      = 'C'.
ls_booking-forcuram   = '1332.00'.
ls_booking-forcurkey  = 'EUR'.
ls_booking-loccuram   = '1332.00'.
ls_booking-loccurkey  = 'EUR'.
ls_booking-order_date = '20121209'.
ls_booking-counter    = ''.
ls_booking-agencynum  = '188'.
ls_booking-passname   = 'Claire Heller'.
APPEND ls_booking TO gt_ysbook1t.

CLEAR ls_booking.
ls_booking-carrid     = 'LH'.
ls_booking-connid     = '455'.
ls_booking-fldate     = '19950228'.
ls_booking-bookid     = '1'.
ls_booking-customid   = '946'.
ls_booking-custtype   = 'P'.
ls_booking-luggweight = '0.00'.
ls_booking-wunit      = 'KG'.
ls_booking-invoice    = ''.
ls_booking-class      = 'C'.
ls_booking-forcuram   = '764.99'.
ls_booking-forcurkey  = 'GBP'.
ls_booking-loccuram   = '1265.40'.
ls_booking-loccurkey  = 'EUR'.
ls_booking-order_date = '20130305'.
ls_booking-counter    = ''.
ls_booking-agencynum  = '188'.
ls_booking-passname   = 'Christine Picard'.
APPEND ls_booking TO gt_ysbook1t.

CLEAR ls_booking.
ls_booking-carrid     = 'LH'.
ls_booking-connid     = '455'.
ls_booking-fldate     = '19950228'.
ls_booking-bookid     = '2'.
ls_booking-customid   = '2400'.
ls_booking-custtype   = 'P'.
ls_booking-luggweight = '202.000'.
ls_booking-wunit      = 'KG'.
ls_booking-invoice    = ''.
ls_booking-class      = 'C'.
ls_booking-forcuram   = '1983.79'.
ls_booking-forcurkey  = 'SGD'.
ls_booking-loccuram   = '1198.90'.
ls_booking-loccurkey  = 'EUR'.
ls_booking-order_date = '20130325'.
ls_booking-counter    = ''.
ls_booking-agencynum  = '188'.
ls_booking-passname   = 'Jean Sudhoff'.
APPEND ls_booking TO gt_ysbook1t.

CLEAR ls_booking.
ls_booking-carrid     = 'LH'.
ls_booking-connid     = '454'.
ls_booking-fldate     = '19950606'.
ls_booking-bookid     = '1'.
ls_booking-customid   = '3621'.
ls_booking-custtype   = 'P'.
ls_booking-luggweight = '0.00'.
ls_booking-wunit      = 'KG'.
ls_booking-invoice    = 'X'.
ls_booking-class      = 'C'.
ls_booking-forcuram   = '1132.20'.
ls_booking-forcurkey  = 'EUR'.
ls_booking-loccuram   = '1132.20'.
ls_booking-loccurkey  = 'EUR'.
ls_booking-order_date = '20130423'.
ls_booking-counter    = ''.
ls_booking-agencynum  = '188'.
ls_booking-passname   = 'Thilo Dornmenech'.
APPEND ls_booking TO gt_ysbook1t.

CLEAR ls_booking.
ls_booking-carrid     = 'LH'.
ls_booking-connid     = '454'.
ls_booking-fldate     = '19950606'.
ls_booking-bookid     = '2'.
ls_booking-customid   = '1193'.
ls_booking-custtype   = 'P'.
ls_booking-luggweight = '28.00'.
ls_booking-wunit      = 'KG'.
ls_booking-invoice    = ''.
ls_booking-class      = 'C'.
ls_booking-forcuram   = '702.36'.
ls_booking-forcurkey  = 'GBP'.
ls_booking-loccuram   = '1132.20'.
ls_booking-loccurkey  = 'EUR'.
ls_booking-order_date = '20130207'.
ls_booking-counter    = ''.
ls_booking-agencynum  = '188'.
ls_booking-passname   = 'Thomas Sommer'.
APPEND ls_booking TO gt_ysbook1t.

CLEAR ls_booking.
ls_booking-carrid     = 'LH'.
ls_booking-connid     = '3577'.
ls_booking-fldate     = '19952804'.
ls_booking-bookid     = '1'.
ls_booking-customid   = '4521'.
ls_booking-custtype   = 'P'.
ls_booking-luggweight = '186.00'.
ls_booking-wunit      = 'KG'.
ls_booking-invoice    = 'X'.
ls_booking-class      = 'C'.
ls_booking-forcuram   = '1332'.
ls_booking-forcurkey  = 'EUR'.
ls_booking-loccuram   = '1332.0'.
ls_booking-loccurkey  = 'EUR'.
ls_booking-order_date = '20121209'.
ls_booking-counter    = ''.
ls_booking-agencynum  = '188'.
ls_booking-passname   = 'Claire Heller'.
APPEND ls_booking TO gt_ysbook1t.

  PERFORM insert_ysbook1t USING gt_ysbook1t.
ENDFORM.


* Subroutine to insert data into ZYSCARR1T
FORM insert_yscarr1t USING pt_yscarr1t TYPE TABLE.
  MODIFY zyscarr1t FROM TABLE pt_yscarr1t.
  IF sy-subrc = 0.
    WRITE: / 'Data inserted into ZYSCARR1T successfully.'.
  ELSE.
    WRITE: / 'Error inserting data into ZYSCARR1T.'.
  ENDIF.
ENDFORM.

* Subroutine to insert data into ZYSFLIGHT1T
FORM insert_ysflight1t USING pt_ysflight1t TYPE TABLE.
  MODIFY zysflight1t FROM TABLE pt_ysflight1t.
  IF sy-subrc = 0.
    WRITE: / 'Data inserted into ZYSFLIGHT1T successfully.'.
  ELSE.
    WRITE: / 'Error inserting data into ZYSFLIGHT1T.'.
  ENDIF.
ENDFORM.

* Subroutine to insert data into ZYSBOOK1T
FORM insert_ysbook1t USING pt_ysbook1t TYPE TABLE.
  MODIFY zysbook1t FROM TABLE pt_ysbook1t.
  IF sy-subrc = 0.
    WRITE: / 'Data inserted into ZYSBOOK1T successfully.'.
  ELSE.
    WRITE: / 'Error inserting data into ZYSBOOK1T.'.
  ENDIF.
ENDFORM.
