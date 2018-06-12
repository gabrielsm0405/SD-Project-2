module ULA2(CLOCK_50, data, value, validate, out_A, out_B, signalR);	
	//Clock padrÃ£o de 50Mhz
	input CLOCK_50, validate;
	
	//Valor de entrada que irÃ¡ definir as aÃ§Ãµes da mÃ¡quina
	input [7:0] data;
	
	//PossÃ­veis estados para a mÃ¡quina, alÃ©m de macros
	parameter [7:0] On_Off = 8'd18, Waiting = 8'd0, Def_A = 8'd15, Def_B = 8'd19, 
	Clear_All = 8'd16, Change_Signal = 8'd12, Sum = 8'd26, Minus = 8'd30;
	
	//Valores de A e B
	reg [7:0] value_A_Dez, value_A_Uni, value_B_Dez, value_B_Uni;
	
	//saida do sinal do resultado
	output reg signalR;
	
	//saida do A e do B, e valor de saída para o BCD
	output reg [7:0] out_A, out_B, value;
	
	//VariÃ¡vel de controle para definir o estado padrÃ£o da mÃ¡quina 
	reg [3:0] state, editB, editA, clear;
	
	//VariÃ¡veis de controle de 1bit que servem como flags ao longo do programa
	reg signalA, signalB, isOn;
	
	//Inicia as variÃ¡veis de controle como 0 e o valor padrÃ£o do estado para desligado 
	initial begin
		state = clear;
		
		value_A_Dez=8'b0;
		value_A_Uni=8'b0;
		signalA = 0;
		out_A = 200;
		
		value_B_Dez=8'b0;
		value_B_Uni=8'b0;
		signalB = 0;
		out_B = 200;
		
		value=200;
		signalR = 0;
		
		isOn=0;
		
		editA = 4'b0000;
		editB = 4'b0001;
		clear = 4'b0010;
	end
		
	always @ (negedge validate) begin // begin do clock
		//Caso o bit de controle alcance a placa, inicia a operaÃ§Ã£o de seleÃ§Ã£o de estado
		case(data) //begin do case(data)
			On_Off: begin //Liga/Desliga
						isOn<=~isOn;
				end										
			Def_A: begin //Zera A e seta valor
						state <= editA;
				end					   
			Def_B: begin //Zera B e seta valor
						state <= editB;
				end					   
			Clear_All: begin //Zera tudo
						state<=clear;
				end

		endcase //end do case(data)
	end //end do clock
	
	always @(negedge validate) begin
		if(isOn) begin
			case(state) //begin do case(state)
				editA: begin //begin-edit-A
						if(data==Def_A) begin
							value_A_Dez=8'b0;
							value_A_Uni=8'b0;
						end
						else if(data>=0 && data<=9) begin //Indica que data é um valor numério
							value_A_Dez=10*value_A_Uni;
							value_A_Uni=data;
						end
						else if(data==Change_Signal) begin
							if(signalA==0) begin
								signalA=1;
							end
							else begin 
								signalA=0;
							end
						end

						out_A<=value_A_Dez+value_A_Uni;
					   end//end-edit-A
				editB: begin
						if(data==Def_B) begin
							value_B_Dez=8'b0;
							value_B_Uni=8'b0;
						end
						else if(data>=0 && data<=9) begin //Indica que data é um valor numério
							value_B_Dez=10*value_B_Uni;
							value_B_Uni=data;
						end
						else if(data==Change_Signal) begin
							if(signalB==0) begin
								signalB=1;
							end
							else begin 
								signalB=0;
							end
						end

						out_B<=value_B_Dez+value_B_Uni;
					end
				clear: begin
						value_A_Dez=8'b0;
						value_A_Uni=8'b0;
						value_B_Dez=8'b0;
						value_B_Uni=8'b0;
						signalA=0;
						signalB=0;

						out_A=value_A_Dez+value_A_Uni;
						out_B=value_B_Dez+value_B_Uni;
					end	
			endcase
		end
		else begin
			out_A<=200;
			out_B<=200;
			
			state<=clear
		end
	end
	
	always begin
		if(isOn) begin
			value=out_A*(1-2*signalA)+out_B*(1-2*signalB);
		
			if(value==0) begin
				signalR<=0;
			end
			else if(out_A>=out_B) begin
				signalR<=signalA;
			end
			else begin
				signalR<=signalB;
			end	

			if(signalR) begin
				value=~value+1;
			end	
		end
		else begin
			value=200;
		end
	end
endmodule 
