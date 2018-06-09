/*				ULA REFORMULADA
				DEVELOPED BY: ROMILDO JULIANO		*/
				
module ULA(CLOCK_50, data, value, validate, out_A, out_B);
	//Clock padrão de 50Mhz
	input CLOCK_50, validate;
	//Valor de entrada que irá definir as ações da máquina
	input [7:0] data;
	//Valor de saída para o BCD
	output [8:0] value;
	//Possíveis estados para a máquina, além de macros
	parameter [4:0] On_Off = 5'd18, Waiting = 5'd0, Def_A = 5'd15, Def_B = 5'd19, Clear_All = 5'd16, OFF = 0;
	//Valores de A e B 
	reg [7:0] value_A, value_B;
	//saida do A e do B
	output reg [7:0] out_A, out_B;
	//Variável de controle para definir o estado padrão da máquina 
	reg [3:0] state, editB, editA;
	//Variáveis de controle de 1bit que servem como flags ao longo do programa
	reg ON, BCD, dezena_A, unidade_A, unidade_B, dezena_B;
	
	//Inicia as variáveis de controle como 0 e o valor padrão do estado para desligado 
	initial begin
		state = On_Off;
		value_A = 0;
		value_B = 0;
		editA = 4'b0;
		editB = 4'b1;
		ON = 0;
		dezena_A = 0;
		unidade_A = 0;
		dezena_B = 0;
		unidade_B = 0;
		out_A <= value_A;
		out_B <= value_B;
	end

	always @ (posedge validate) begin // begin do clock
		//Caso o bit de controle alcance a placa, inicia a operação de seleção de estado
		case(data) //begin do case(data)
			On_Off: begin
						ON = ~ON;
						//Ligar/Apagar o BCD de alguma maneira
						state = Clear_All; 
					end										
			Def_A: begin
						value_A <= 0;
						unidade_A <= 0;
						dezena_A <= 0;
						state <= editA;
				   end					   
			Def_B: begin
						value_B = 0;
						unidade_B <= 0;
						dezena_B <= 0;
						state <= editB;
				   end					   
			Clear_All: begin
						   value_A <= 0;
						   value_B <= 0;
						   dezena_A <= 0;
						   dezena_B <= 0;
						   unidade_A <= 0;
						   unidade_B <= 0;
					   end
		endcase //end do case(data)
	end //end do clock
	
	always @(posedge CLOCK_50) begin
		case(state) //begin do case(state)
			editA: begin //begin-edit-A
					   if(~unidade_A || ~dezena_A) begin //begin-if
							if(data <= 9) begin
								if(~unidade_A) begin
									value_A <= data;
									unidade_A <= 1;
								end
								else begin
									value_A <= 10 * value_A + data;
									dezena_A <= 1;
								end
							end 
						end //end-if
				   end//end-edit-A
			editB: begin
					if(~unidade_B || ~dezena_B) begin //begin-if
							if(data <= 9) begin
								if(~unidade_B) begin
									value_B <= data;
									unidade_B <= 1;
								end
								else begin
									value_B <= 10 * value_B + data;
									dezena_B <= 1;
								end
							end 
						end //end-if
				   end
		endcase
	end
endmodule 
