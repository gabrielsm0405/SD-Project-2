module decodificador(
		 IRDA_RXD,
		 CLOCK_50,
		 LEDR0,
		 LEDR1,
		 LEDR2,
		 LEDR3,
		 LEDR4,
		 LEDR5,
		 LEDR6,
		 LEDR7,
		 LEDE,
		 LEDE1);
		 
		 //Entradas
		 input IRDA_RXD; // infrared
		 input CLOCK_50; // clock de 50Mz
		 
		 //SaÃ­das
		 output LEDR0;
		 output LEDR1;
		 output LEDR2;
		 output LEDR3;
		 output LEDR4;
		 output LEDR5;
		 output LEDR6;
		 output LEDR7;
		 output LEDE;
		 output LEDE1;
		 
		 initial LEDE1=0;
	
		 parameter bitTime=41500;
		 parameter infinity=262143;
		 parameter leadCodeTime=230000;
	
		 reg[31:0] mainReg, invReg;
		 reg[64:0] tempo, cont;
		 
		 parameter[3:0] A=4'b0000, B=4'b0001, C=4'b0010, 
				D=4'b0011, E=4'b0100, F=4'b0101, 
				G=4'b0110, H=4'b0111, I=4'b1000, 
				J=4'b1001;
		 
		 reg[3:0] estado, prox_estado=A;
		 
		 always@(posedge CLOCK_50) begin
			estado=prox_estado;
			
			if(mainReg[23:16]==~mainReg[31:24]) begin
				LEDR0=mainReg[16];
				LEDR1=mainReg[17];
				LEDR2=mainReg[18];
				LEDR3=mainReg[19];
				LEDR4=mainReg[20];
				LEDR5=mainReg[21];
				LEDR6=mainReg[22];
				LEDR7=mainReg[23];
			end
			
			case (estado)
				A:begin	
					cont=64'b0;										//MÃ¡quina 1
					if(IRDA_RXD) begin									//Estado 1
						prox_estado=A;
					end
					else begin
						prox_estado=B;
						tempo=64'b0;
					end
				end
				
				B:begin
					tempo=tempo+1'b1;
					
					if(IRDA_RXD) begin
						cont=cont+1'b1;
						
						if(cont==1) begin
							if(tempo>leadCodeTime) begin
								prox_estado=C;
								tempo=64'b0;
							end
							else begin
								prox_estado=A;
							end
						end
						else begin
							if(cont>=33) begin
								prox_estado=A;
							end
							else begin
								prox_estado=C;
								tempo=64'b0;
							end
						end
					end
					else begin
						prox_estado=B;
					end
				end
				
				C:begin
					tempo=tempo+1'b1;
					
					if(tempo>infinity) begin
						prox_estado=A;
					end
					else begin
						if(IRDA_RXD) begin
							prox_estado=C;
						end
						else begin
							prox_estado=B;
							
							if(cont>1) begin
								if(tempo>bitTime) begin
									mainReg[cont-1] = 1;
								end
								else begin
									mainReg[cont-1] = 0;
								end
							end
							tempo=64'b0;
						end
					end
				end
			endcase
		end
endmodule
