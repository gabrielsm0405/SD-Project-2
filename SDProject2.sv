module decodificador(
		 IRDA_RXD,
		 CLOCK_50,
		 LEDR[0],
		 LEDR[1],
		 LEDR[2],
		 LEDR[3],
		 LEDR[4],
		 LEDR[5],
		 LEDR[6],
		 LEDR[7]);
		 
		 //Entradas
		 input IRDA_RXD; // infrared
		 input CLOCK_50; // clock de 50Mz
		 
		 //Saídas
		 output LEDR[0];
		 output LEDR[1];
		 output LEDR[2];
		 output LEDR[3];
		 output LEDR[4];
		 output LEDR[5];
		 output LEDR[6];
		 output LEDR[7];
		 
		 reg[7:0] mainReg, invReg;
		 
		 time tempo, leadCodeTime=64'd79000, bitTime=64'd5000;
		 
		 integer cont;
		 
		 parameter[3:0] A=4'b0000, B=4'b0001, C=4'b0010, 
							 D=4'b0011, E=4'b0100, F=4'b0101, 
							 G=4'b0110, H=4'b0111, I=4'b1000, 
							 J=4'b1001, K=4'b1010;
		 
		 reg[3:0] estado, prox_estado;
		 
		 always@(posedge CLOCK_50)
			estado<=prox_estado;
			case (estado)
				A:																//Máquina 1
					if(IRDA_RXD) begin									//Estado 1
						prox_estado=A;
					end
					else begin
						prox_estado=B;
						tempo=64'd0;
					end
				B:
					if(IRDA_RXD) begin									//Estado 2
						if(tempo>leadCodeTime) begin
							prox_estado=C;
							tempo=64'd0;
						end
						else begin
							prox_estado=A;
						end
					end
					else begin
						prox_estado=B;
					end
				C:
					if(IRDA_RXD) begin									//Estado 3
						prox_estado=C;
					end
					else begin
						if(tempo>leadCodeTime) begin
							prox_estado=D;
							cont=32d'0;
						end
						else begin
							prox_estado=A;
						end
					end
				D:															//Máquina 2
					if(IRDA_RXD) begin								//Estado 1
						prox_estado=E;
						cont<=cont+32'd1;
					end
					else begin
						prox_estado=D;
					end
				E:
					if(IRDA_RXD) begin								//Estado 2
						prox_estado=E;
					end
					else begin
						if(cont<32'd16) begin
							prox_estado=D;
						end
						else begin
							prox_estado=F;
							cont=32'd0;
						end
					end
				F:															//Máquina 3
					if(IRDA_RXD) begin								//Estado 1
						prox_estado=G;
						cont<=cont+32'd1;
						tempo=64'd0;
					end
					else begin
						prox_estado=F;
					end
				G:
					if(IRDA_RXD) begin								//Estado 2
						prox_estado=G;
					end 
					else begin
						if(cont<32'd8) begin
							prox_estado=F;
							if(tempo>bitTime) begin //Registra 1
								mainReg <= mainReg << 1;
							end
							else begin	//Registra 0
								mainReg <= mainReg << 0;
							end
						end
						else begin
							prox_estado=H;
							cont=32'd0;
						end
					end
				H:															//Máquina 4
					if(IRDA_RXD) begin								//Estado 1
						prox_estado=I;
						cont<=cont+32'd1;
						tempo=64'd0;
					end
					else begin
						prox_estado=H;
					end
				I:
					if(IRDA_RXD) begin								//Estado 2
						prox_estado=I;
					end 
					else begin
						if(cont<32'd8) begin
							prox_estado=H;
							if(tempo>bitTime) begin //Registra 1
								invReg <= invReg << 1;
							end
							else begin	//Registra 0
								invReg <= invReg << 0;
							end
						end
						else begin
							prox_estado=J;
						end
					end
				J:															//Comparação
					if(mainReg==~invReg) begin
						LEDR[0]<=mainReg[0];
						LEDR[1]<=mainReg[1];
						LEDR[2]<=mainReg[2];
						LEDR[3]<=mainReg[3];
						LEDR[4]<=mainReg[4];
						LEDR[5]<=mainReg[5];
						LEDR[6]<=mainReg[6];
						LEDR[7]<=mainReg[7];
					end
					else begin
						if(IRDA_RXD) begin
							prox_estado=A;
						end
					end
				end case
				
				tempo <= tempo+64'd1;
endmodule
		 
		 