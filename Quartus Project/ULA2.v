module ULA2(CLOCK_50, data, value, validate, out_A, out_B, ON);
	//Clock padr√£o de 50Mhz
	input CLOCK_50, validate;
	//Valor de entrada que ir√° definir as a√ß√µes da m√°quina
	input [7:0] data;
	//Poss√≠veis estados para a m√°quina, al√©m de macros
	parameter [4:0] On_Off = 5'd18, Waiting = 5'd0, Def_A = 5'd15, Def_B = 5'd19, 
	Clear_All = 5'd16, Change_Signal = 5'd12, Sum = 5'd26, Minus = 5'd30;
	//Valores de A e B
	reg [7:0] value_A, value_B;
	//saida do A e do B, e valor de saÌda para o BCD
	output reg [7:0] out_A, out_B, value;
	//Vari√°vel de controle para definir o estado padr√£o da m√°quina 
	reg [3:0] state, editB, editA;
	//Vari√°veis de controle de 1bit que servem como flags ao longo do programa
	reg BCD, dezena_A, unidade_A, unidade_B, dezena_B, isNeg, isPos;
	//Vari·vel de controle que vai ser ligada ao BCD
	output reg ON;
	//Inicia as vari√°veis de controle como 0 e o valor padr√£o do estado para desligado 
	initial begin
		state = On_Off;
		value_A = 0;
		value_B = 0;
		editA = 4'b0;
		editB = 4'b1;
		ON = 0;
		isNeg = 0;
		isPos = 1; //Inicia os valores de B como positivos
		
		//Seta como 0 os par√¢metros de controle para setar as unidades e dezenas de A e B
		dezena_A = 0;
		unidade_A = 0;
		dezena_B = 0;
		unidade_B = 0;
		
		//Define as sa√≠das paralelamente como os valores A e B que ser√£o modificados ao longo do programa
		out_A <= value_A;
		out_B <= value_B;
		value <= value_A + value_B;
	end
	

	always @ (posedge validate) begin // begin do clock
		//Caso o bit de controle alcance a placa, inicia a opera√ß√£o de sele√ß√£o de estado
		case(data) //begin do case(data)
			On_Off: begin //Liga/Desliga
						ON = ~ON;
						//Ligar/Apagar o BCD de alguma maneira
						state <= Clear_All; 
					end										
			Def_A: begin //Zera A e seta valor
						value_A <= 0;
						unidade_A <= 0;
						dezena_A <= 0;
						state <= editA;
						//Caso pressione o bot„o de mudar sinal, inverte o valor de A (Funcional?)
						if(data == Change_Signal) value_A <= ~ value_A;
				   end					   
			Def_B: begin //Zera B e seta valor
						value_B = 0;
						unidade_B <= 0;
						dezena_B <= 0;
						state <= editB;
						//Caso pressione o bot„o de mudar sinal, inverte o valor de B (Funcional?)
						if(data == Change_Signal) value_B <= ~ value_B;
				   end					   
			Clear_All: begin //Zera tudo
						   value_A <= 0;
						   value_B <= 0;
						   dezena_A <= 0;
						   dezena_B <= 0;
						   unidade_A <= 0;
						   unidade_B <= 0;

						   //Seta sinal padr„o para B
						   isNeg <= 0; 
						   isPos <= 1;
					   end
			Sum: begin //Soma
					if(isPos) begin
						value_B <= ~value_B;
						//Inverte o valor de B (no caso de pos pra neg) e muda as vari·veis de controle para indicar que o n˙mero agora È negativo
						isPos <= 0;
						isNeg <= 1;
					end
				 end

			Minus: begin //SubtraÁ„o
				     if(isNeg) begin
				     	//Inverte o valor de B (no caso de neg pra pos) e muda as vari·veis de controle para indicar que o n˙mero agora È negativo
				     	value_B <= ~value_B;
				     end
				   end


		endcase //end do case(data)
	end //end do clock
	
	always @(posedge CLOCK_50) begin
		case(state) //begin do case(state)
			editA: begin //begin-edit-A
					   if(~unidade_A || ~dezena_A) begin //begin-if
							if(data <= 9) begin //Indica que data È um valor numÈrio
								if(~unidade_A) begin
									value_A <= data; 
									unidade_A = 1; 
								end
								else if (unidade_A && ~dezena_A) begin //Caso tenha inserido a unidade mas n„o a dezena
									value_A <= 10 * value_A + data;
									dezena_A = 1;
								end
							end 
						end //end-if
				   end//end-edit-A
			editB: begin
					if(~unidade_B && ~dezena_B) begin //begin-if
							if(data <= 9) begin //Indica que data È um valor n˙mero
								if(~unidade_B) begin
									value_B <= data;
									unidade_B <= 1;
								end
								else if(unidade_B && ~dezena_B) begin //Caso tenha inserido a unidade mas n„o a dezena
									value_B <= 10 * value_B + data;
									dezena_B <= 1;
								end
							end 
						end //end-if
				   end
		endcase
	end
endmodule 