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
		 LEDR7);
		 
		 //Entradas
		 input IRDA_RXD; // infrared
		 input CLOCK_50; // clock de 50Mz
		 
		 //Saídas
		 output LEDR0;
		 output LEDR1;
		 output LEDR2;
		 output LEDR3;
		 output LEDR4;
		 output LEDR5;
		 output LEDR6;
		 output LEDR7;
	
		 parameter bitTime=41500;
		 parameter infinity=200000;
	
		 reg[7:0] mainReg, invReg;
		 reg[17:0] tempo, cont;
		 
		 parameter[3:0] A=4'b0000, B=4'b0001, C=4'b0010, 
				D=4'b0011, E=4'b0100, F=4'b0101, 
				G=4'b0110, H=4'b0111, I=4'b1000, 
				J=4'b1001;
		 
		 reg[3:0] estado, prox_estado;
		 
		 always@(posedge CLOCK_50) begin
			estado=prox_estado;
	
			case (estado)
				A:begin														//Máquina 1
					if(IRDA_RXD) begin									//Estado 1
						prox_estado=A;
					end
					else begin
						prox_estado=B;
					end
				end
				B:begin
					if(IRDA_RXD) begin									//Estado 2
						prox_estado=C;
						tempo=18'b0;
					end
					else begin
						prox_estado=B;
					end
				end
				C:begin
					if(IRDA_RXD) begin									//Estado 3
						prox_estado=C;
						tempo=tempo+1'b1;
						if(tempo>infinity) begin
							prox_estado=A;
						end
					end
					else begin
						prox_estado=D;
						cont=18'b0;
					end
				end
				D:begin															//Máquina 2
					if(IRDA_RXD) begin								//Estado 1
						prox_estado=E;
						cont=cont+1'b1;
						tempo=18'b0;
					end
					else begin
						prox_estado=D;
					end
				end
				E:begin
					if(IRDA_RXD) begin								//Estado 2
						prox_estado=E;
						tempo=tempo+1'b1;
						if(tempo>infinity) begin
							prox_estado=A;
						end
					end
					else begin
						if(cont<18'd16) begin
							prox_estado=D;
						end
						else begin
							prox_estado=F;
							cont=18'b0;
						end
					end
				end
				F:begin															//Máquina 3
					if(IRDA_RXD) begin								//Estado 1
						prox_estado=G;
						cont=cont+1'b1;
						tempo=18'b0;
					end
					else begin
						prox_estado=F;
					end
				end
				G:begin
					if(IRDA_RXD) begin								//Estado 2
						prox_estado=G;
						tempo=tempo+1'b1;
						if(tempo>infinity) begin
							prox_estado=A;
						end
					end 
					else begin
						if(cont<=18'd8) begin
							prox_estado=F;
							if(tempo>bitTime) begin //Registra 1
								mainReg = mainReg << 1;
								mainReg[0]=1'b1;
							end
							else begin	//Registra 0
								mainReg <= mainReg << 1;
								mainReg[0]=1'b0;
							end
						end
						
						if(cont==18'd8) begin
							prox_estado=H;
							cont=18'b0;
						end
					end
				end
				H:begin															//Máquina 4
					if(IRDA_RXD) begin								//Estado 1
						prox_estado=I;
						cont=cont+1'b1;
						tempo=18'b0;
					end
					else begin
						prox_estado=H;
					end
				end
				I:begin
					if(IRDA_RXD) begin						//Estado 2
						prox_estado=I;
						tempo=tempo+1'b1;
						if(tempo>infinity) begin
							prox_estado=A;
						end
					end 
					else begin
						if(cont<=18'd8) begin
							prox_estado=H;
							if(tempo>bitTime) begin //Registra 1
								invReg = invReg << 1;
								invReg[0]=1'b1;
							end
							else begin	//Registra 0
								invReg = invReg << 1;
								invReg=1'b0;
							end
						end
						
						if(cont==18'd8) begin
							prox_estado=J;
						end
					end
				end
				J:begin															//Comparação
					LEDR0=mainReg[0];
					LEDR1=mainReg[1];
					LEDR2=mainReg[2];
					LEDR3=mainReg[3];
					LEDR4=mainReg[4];
					LEDR5=mainReg[5];
					LEDR6=mainReg[6];
					LEDR7=mainReg[7];
				
					if(IRDA_RXD) begin
						prox_estado=A;
					end
					else begin
						prox_estado=J;
					end
				end
			endcase
		end
endmodule
