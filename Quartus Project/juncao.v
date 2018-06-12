module juncao(CLOCK_50, IRDA_RXD, HEXUNIA, HEXDEZA, HEXUNIB, HEXDEZB, HEXCENR, HEXDEZR, HEXUNIR, SOUTR);
	input CLOCK_50, IRDA_RXD;
	
	output wire[6:0] HEXUNIA, HEXDEZA, HEXUNIB, HEXDEZB, HEXCENR, HEXDEZR, HEXUNIR;
	output wire SOUTR;
	
	wire okBit, SINR;
	wire[7:0] dataDec, dataRes, A, B;
	
	lastHopeDec dec(CLOCK_50, IRDA_RXD, okBit, dataDec);
	
	ULA2 ulaULA(CLOCK_50, dataDec, dataRes, okBit, A, B, SINR);
	
	decoder99 bcdA(HEXUNIA, A, HEXDEZA);
	decoder99 bcdB(HEXUNIB, B, HEXDEZB);
	decoder198 (HEXUNIR, dataRes, HEXDEZR, HEXCENR, SINR, SOUTR);
endmodule 