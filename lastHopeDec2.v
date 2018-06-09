module lastHopeDec(IRDA_RXD, CLOCK_50, OUT);
	 input IRDA_RXD; // Infrared
	 input CLOCK_50; // Clock de 50Mz
	 
	 output reg[7:0] OUT;
	 
	 parameter min1=41500, max1=100000;
	 parameter min0=20000, max0=41500;
	 parameter infinity=262140;
	
	 reg[31:0] temp;
	 reg[17:0] tempo;
	 reg[0:5] cont;

	 initial cont=6'b0;
	 initial tempo=18'b0;
	 initial temp=32'b0;


	 always @(posedge CLOCK_50 or posedge IRDA_RXD) begin
		if (IRDA_RXD) begin
			@(posedge IRDA_RXD) tempo<=18'b0;
			
			if (tempo<infinity) begin
				tempo<=tempo+1'b1;
			end
		end
	 end

	 always @(negedge IRDA_RXD) begin
	 	if (tempo>min1 && tempo<max1) begin
	 		temp[cont]=1;
	 		cont=cont+1'b1;
	 	end 
	 	else if (tempo>min0 && tempo<max0) begin
	 		temp[cont]=0;
	 		cont=cont+1'b1;
	 	end	
	 	else if(tempo>infinity) begin
	 		cont=6'b0;
	 	end

	 	if(cont>31) begin
	 		cont=6'b0;	
	 		if(temp[23:16]==~temp[31:24]) begin
	 			OUT=temp[23:16];
	 		end
	 	end
	 end
endmodule 
