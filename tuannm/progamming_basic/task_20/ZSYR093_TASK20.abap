*&---------------------------------------------------------------------*
*& Report ZSYR093_TASK20
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZSYR093_TASK20.

TYPES:
  lty_airline TYPE TABLE OF zy093tsc,
  lty_flight  TYPE TABLE OF zy093tf,
  lty_booking TYPE TABLE OF zy093tb.

DATA: lt_airline TYPE lty_airline,
      lt_flight  TYPE lty_flight,
      lt_booking TYPE lty_booking.

*&---------------------------------------------------------------------*
*& Insert data into lt_airline.
*&---------------------------------------------------------------------*
APPEND VALUE #(
  carrid = 'LH' carrname = 'Lufthansa' currcode = 'EUR' url = 'http://www.lufthansa.com'
) TO lt_airline.
APPEND VALUE #(
  carrid = 'SQ' carrname = 'Singapore Airlines' currcode = 'SGD' url = 'http://www.singaporeair.com'
) TO lt_airline.

*&---------------------------------------------------------------------*
*& Insert data into lt_flight.
*&---------------------------------------------------------------------*
APPEND VALUE #(
  carrid = 'LH' connid = 400 fldate = '19950228' price = 899 currency = 'DEM'
  planetype = 'A319' seatsmax = 350 seatsocc = 3 paymentsum = 2639 seatsmax_b = 0
  seatsocc_b = 0 seatsmax_f = 0 seatsocc_f = 0
) TO lt_flight.
APPEND VALUE #(
  carrid = 'LH' connid = 454 fldate = '19951117' price = 1499 currency = 'DEM'
  planetype = 'A319' seatsmax = 350 seatsocc = 2 paymentsum = 2949 seatsmax_b = 0
  seatsocc_b = 0 seatsmax_f = 0 seatsocc_f = 0
) TO lt_flight.
APPEND VALUE #(
  carrid = 'LH' connid = 455 fldate = '19950606' price = 1090 currency = 'USD'
  planetype = 'A319' seatsmax = 220 seatsocc = 1 paymentsum = 1499 seatsmax_b = 0
  seatsocc_b = 0 seatsmax_f = 0 seatsocc_f = 0
) TO lt_flight.
APPEND VALUE #(
  carrid = 'LH' connid = 3577 fldate = '19950428' price = 6000 currency = 'LIT'
  planetype = 'A319' seatsmax = 220 seatsocc = 1 paymentsum = 600 seatsmax_b = 0
  seatsocc_b = 0 seatsmax_f = 0 seatsocc_f = 0
) TO lt_flight.
APPEND VALUE #(
  carrid = 'SQ' connid = 26 fldate = '19950228' price = 849 currency = 'DEM'
  planetype = 'DC-10-10' seatsmax = 380 seatsocc = 2 paymentsum = 1684 seatsmax_b = 0
  seatsocc_b = 0 seatsmax_f = 0 seatsocc_f = 0
) TO lt_flight.

*&---------------------------------------------------------------------*
*& Insert data into lt_booking.
*&---------------------------------------------------------------------*
APPEND VALUE #(
  carrid = 'SQ' connid = 26 fldate = '19950228' bookid = 1 customid = 2487 custtype = 'P'
  luggweight = '226.000' wunit = 'KG' invoice = '2000.74' class = 'C' forcuram = '4408.08'
  forcurkey = 'AUD' loccuram = '4640.08' loccurkey = 'SGD' order_date = '20121205'
  counter = 188 agencynum = 'Lothar Koslowski' passname = 'Lothar Koslowski'
) TO lt_booking.
APPEND VALUE #(
  carrid = 'SQ' connid = 26 fldate = '19950228' bookid = 2 customid = 351 custtype = 'P'
  luggweight = 0 wunit = 'KG' invoice = '2804.00' class = 'C' forcuram = '4640.08'
  forcurkey = 'SGD' loccuram = '4640.08' loccurkey = 'SGD' order_date = '20130409'
  counter = 188 agencynum = 'Illya Vrsic' passname = 'Illya Vrsic'
) TO lt_booking.
APPEND VALUE #(
  carrid = 'SQ' connid = 26 fldate = '19950228' bookid = 3 customid = 4281 custtype = 'P'
  luggweight = '188.000' wunit = 'KG' invoice = '4644.08' class = 'C' forcuram = '4644.08'
  forcurkey = 'SGD' loccuram = '4408.08' loccurkey = 'EUR' order_date = '20121224'
  counter = 72 agencynum = 'Walter Heller' passname = 'Walter Heller'
) TO lt_booking.
APPEND VALUE #(
  carrid = 'SQ' connid = 26 fldate = '19950228' bookid = 4 customid = 2523 custtype = 'P'
  luggweight = '152.000' wunit = 'KG' invoice = '2663.80' class = 'C' forcuram = '4408.08'
  forcurkey = 'EUR' loccuram = '3944.06' loccurkey = 'SGD' order_date = '20130311'
  counter = 188 agencynum = 'Ulla Lautenbach' passname = 'Ulla Lautenbach'
) TO lt_booking.
APPEND VALUE #(
  carrid = 'SQ' connid = 26 fldate = '19950228' bookid = 5 customid = 442 custtype = 'P'
  luggweight = '104.000' wunit = 'KG' invoice = '1790.13' class = 'C' forcuram = '3944.06'
  forcurkey = 'SGD' loccuram = '1684.00' loccurkey = 'DEM' order_date = '20131216'
  counter = 188 agencynum = 'Johann Rahn' passname = 'Johann Rahn'
) TO lt_booking.
APPEND VALUE #(
  carrid = 'LH' connid = 400 fldate = '19950228' bookid = 1 customid = 946 custtype = 'P'
  luggweight = 0 wunit = 'KG' invoice = '784.99' class = 'C' forcuram = '1265.40'
  forcurkey = 'GBP' loccuram = '1983.79' loccurkey = 'SGD' order_date = '20130325'
  counter = 188 agencynum = 'Christine Picard' passname = 'Christine Picard'
) TO lt_booking.
APPEND VALUE #(
  carrid = 'LH' connid = 400 fldate = '19950228' bookid = 2 customid = 2400 custtype = 'P'
  luggweight = '202.000' wunit = 'KG' invoice = '1983.79' class = 'C' forcuram = '1198.80'
  forcurkey = 'EUR' loccuram = '1265.40' loccurkey = 'GBP' order_date = '20130325'
  counter = 188 agencynum = 'Jean Sudhoff' passname = 'Jean Sudhoff'
) TO lt_booking.
APPEND VALUE #(
  carrid = 'LH' connid = 400 fldate = '19950228' bookid = 3 customid = 3621 custtype = 'P'
  luggweight = 0 wunit = 'KG' invoice = '1132.20' class = 'C' forcuram = '1132.20'
  forcurkey = 'EUR' loccuram = '1132.20' loccurkey = 'EUR' order_date = '20130423'
  counter = 188 agencynum = 'Thilo Domenech' passname = 'Thilo Domenech'
) TO lt_booking.
APPEND VALUE #(
  carrid = 'LH' connid = 400 fldate = '19950228' bookid = 4 customid = 1193 custtype = 'P'
  luggweight = '28.000' wunit = 'KG' invoice = '702.36' class = 'C' forcuram = '1132.20'
  forcurkey = 'EUR' loccuram = '1132.20' loccurkey = 'EUR' order_date = '20130207'
  counter = 188 agencynum = 'Thomas Sommer' passname = 'Thomas Sommer'
) TO lt_booking.
APPEND VALUE #(
  carrid = 'LH' connid = 400 fldate = '19950228' bookid = 5 customid = 4521 custtype = 'P'
  luggweight = '186.000' wunit = 'KG' invoice = '1332.00' class = 'C' forcuram = '1332.00'
  forcurkey = 'EUR' loccuram = '1332.00' loccurkey = 'EUR' order_date = '20121209'
  counter = 188 agencynum = 'Claire Heller' passname = 'Claire Heller'
) TO lt_booking.
APPEND VALUE #(
  carrid = 'LH' connid = 455 fldate = '19950606' bookid = 1 customid = 946 custtype = 'P'
  luggweight = 0 wunit = 'KG' invoice = '784.99' class = 'C' forcuram = '784.99'
  forcurkey = 'GBP' loccuram = '784.99' loccurkey = 'GBP' order_date = '20130305'
  counter = 188 agencynum = 'Christine Picard' passname = 'Christine Picard'
) TO lt_booking.
APPEND VALUE #(
  carrid = 'LH' connid = 455 fldate = '19950606' bookid = 2 customid = 2400 custtype = 'P'
  luggweight = '202.000' wunit = 'KG' invoice = '1983.79' class = 'C' forcuram = '1198.80'
  forcurkey = 'EUR' loccuram = '1983.79' loccurkey = 'SGD' order_date = '20130325'
  counter = 188 agencynum = 'Jean Sudhoff' passname = 'Jean Sudhoff'
) TO lt_booking.
APPEND VALUE #(
  carrid = 'LH' connid = 454 fldate = '19951117' bookid = 1 customid = 3621 custtype = 'P'
  luggweight = 0 wunit = 'KG' invoice = '1132.20' class = 'C' forcuram = '1132.20'
  forcurkey = 'EUR' loccuram = '1132.20' loccurkey = 'EUR' order_date = '20130423'
  counter = 188 agencynum = 'Thilo Domenech' passname = 'Thilo Domenech'
) TO lt_booking.
APPEND VALUE #(
  carrid = 'LH' connid = 454 fldate = '19951117' bookid = 2 customid = 1193 custtype = 'P'
  luggweight = '28.000' wunit = 'KG' invoice = '702.36' class = 'C' forcuram = '1132.20'
  forcurkey = 'EUR' loccuram = '1132.20' loccurkey = 'EUR' order_date = '20130207'
  counter = 188 agencynum = 'Thomas Sommer' passname = 'Thomas Sommer'
) TO lt_booking.
APPEND VALUE #(
  carrid = 'LH' connid = 3577 fldate = '19950428' bookid = 1 customid = 4521 custtype = 'P'
  luggweight = '186.000' wunit = 'KG' invoice = '1332.00' class = 'C' forcuram = '1332.00'
  forcurkey = 'EUR' loccuram = '1332.00' loccurkey = 'EUR' order_date = '20121209'
  counter = 188 agencynum = 'Claire Heller' passname = 'Claire Heller'
) TO lt_booking.

*&---------------------------------------------------------------------*
*& Modify data into main tables from internal tables.
*&---------------------------------------------------------------------*
PERFORM modify_db USING lt_airline lt_flight lt_booking.

INCLUDE zsyr093_task20_modify_dbf01.