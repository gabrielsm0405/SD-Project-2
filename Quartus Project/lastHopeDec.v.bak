module lastHopeDec(CLOCK_50, IRDA_RXD, okBit, OUT);
	input CLOCK_50, IRDA_RXD;
	output reg okBit;
	output reg[7:0] OUT;

	parameter INFINITY=2'b00;
	parameter LEADCODE=2'b01;
	parameter LEITURA=2'b10;
	
	parameter inf=262143;
	parameter leadCodeTimeLow=230000;
	parameter leadCodeTimeHigh=210000;
	parameter bitTime=41500;

	reg[17:0] infinityCont, leadCodeCont, leituraCont;
	reg[5:0] bitCont;
	reg[1:0] estado;
	reg[31:0] temp;

	always @(posedge CLOCK_50)	begin
		if (estado==INFINITY && !IRDA_RXD) begin
			infinityCont<=infinityCont+1'b1;
		end
		else begin  
			infinityCont <= 0;		      		 	
		end
	end	     		 	
		  
	always @(posedge CLOCK_50) begin
		if (estado == LEADCODE && IRDA_RXD) begin
			leadCodeCont <= leadCodeCont + 1'b1;
		end
		else begin  
			leadCodeCont <= 0;
		end
	end   		 	

	always @(posedge CLOCK_50) begin
		if(estado == LEITURA && IRDA_RXD) begin
			leituraCont <= leituraCont + 1'b1;
		end
		else begin 
			leituraCont <= 1'b0;
		end
	end

	always @(posedge CLOCK_50) begin
		if (estado == LEITURA) begin
			if (leituraCont == 20000) begin
				bitCont <= bitCont + 1'b1;
			end  
		end
		else begin
			bitCont <= 6'b0;
		end
	end

	always @(posedge CLOCK_50) begin
		case(estado)
			INFINITY: begin 
				if (infinityCont>leadCodeTimeLow) begin
					estado<=LEADCODE;
				end
			end
			LEADCODE: begin
				if (leadCodeCont>leadCodeTimeHigh) begin
					estado<=LEITURA;
				end
			end
			LEITURA: begin
				if (leituraCont >= inf || bitCont >= 33) begin
					estado <= INFINITY;
				end
			end
		endcase
	end

	always @(posedge CLOCK_50) begin
		if (estado == LEITURA) begin
			if (leituraCont>=bitTime) begin
				temp[bitCont-1'b1] <= 1'b1;
			end
		end
		else begin
			temp <= 0;
		end
	end
		
	always @(posedge CLOCK_50) begin
		if (bitCont == 32) begin
			if (temp[31:24]==~temp[23:16]) begin		
				OUT<=temp[23:16];
				okBit<=1;
			end	
			else begin
			  okBit<=0;
			end
		end
		else begin
			okBit<=0;
		end
	end
endmodule
