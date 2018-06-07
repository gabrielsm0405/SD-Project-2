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
		 LEDE1);
		 
		 //Entradas
		 input IRDA_RXD; // infrared
		 input CLOCK_50; // clock de 50Mz
		 
		 //Saidas
		 output LEDR0;
		 output LEDR1;
		 output LEDR2;
		 output LEDR3;
		 output LEDR4;
		 output LEDR5;
		 output LEDR6;
		 output LEDR7;
		 output LEDE1;
		 
		 initial LEDE1=0;
	
		 parameter bitTime=41500;
		 parameter infinity=550000;
		 parameter leadCodeTime=450000;
	
		 reg[31:0] temp;
		 reg[7:0] mainReg;
		 reg[64:0] tempo, cont;
		 
		 parameter[3:0] A=4'b0000, B=4'b0001, C=4'b0010;
		 
		 reg[3:0] estado=A;
		 
		 always@(posedge CLOCK_50) begin
			LEDR0=mainReg[0];
			LEDR1=mainReg[1];
			LEDR2=mainReg[2];
			LEDR3=mainReg[3];
			LEDR4=mainReg[4];
			LEDR5=mainReg[5];
			LEDR6=mainReg[6];
			LEDR7=mainReg[7];
			
			case (estado)
				A:begin
					LEDE1=1;
					cont=64'b0;
					temp=32'b0;									//MÃ¡quina 1
					if(IRDA_RXD) begin									//Estado 1
						estado=A;
					end
					else begin
						estado=B;
						tempo=64'b0;
					end
				end
				
				B:begin
				LEDE1=0;
					tempo=tempo+1'b1;
					
					if(IRDA_RXD) begin
						cont=cont+1'b1;
						
						if(cont==1) begin
							if(tempo>leadCodeTime) begin
								estado=C;
								tempo=64'b0;
							end
							else begin
								estado=A;
							end
						end
						else begin
							if(cont>33) begin
								estado=A;
								
								if(temp[23:16]==~temp[31:24]) begin
									mainReg[0]=temp[16];
									mainReg[1]=temp[17];
									mainReg[2]=temp[18];
									mainReg[3]=temp[19];
									mainReg[4]=temp[20];
									mainReg[5]=temp[21];
									mainReg[6]=temp[22];
									mainReg[7]=temp[23];
								end
							end
							else begin
								estado=C;
								tempo=64'b0;
							end
						end
					end
					else begin
						estado=B;
					end
				end
				
				C:begin
				LEDE1=0;
					tempo=tempo+1'b1;
					
					if(tempo>=infinity) begin
						estado=A;
					end
					else begin
						if(IRDA_RXD) begin
							estado=C;
						end
						else begin
							estado=B;
							
							if(cont>=2 && cont<=33 && tempo>bitTime) begin
								temp[cont-2] = 1;
							end
							
							tempo=64'b0;
						end
					end
				end
			endcase
		end
endmodule
