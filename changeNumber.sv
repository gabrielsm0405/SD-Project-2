

/*OBS: COLOCAR MAIS OPÇÕES DAS MÁQUINAS DE ESTADO; CHECAR SE O PROGRAMA É FUNCIONAL COM MONITORES
	programador: Romildo Juliano
*/
module changeNumber(value, CLOCK_50, reset, number, clear);

	//Valores de entrada como o clock, o reset ( máquina de estados?), e o clear 
	input value, CLOCK_50, reset, clear;
	
	//Valor que vai ser alterado 
	output number;
	
	reg control = 1b'0;
	
	//Inicia o valor em 0, para que possa ser somado posteriormente ao longo da máquina
	value = 0; 

	always @ (posedge CLOCK_50) begin //1 
		always @(negedge reset) begin //reset
		 /*
			BLOCO PARA RESETAR O PROGRAMA	
		*/
		end //reset


		//Validando a função de limpar o número ( ou números, dependendo da propriedade do sistema)
		if(clear) begin //clear
			number <= 7d'00;
		end //clear
		
	//Caso o valor seja alterado pela primeira vez...
		case (value) begin //2 <- Funcional?
			h'0x00: number <= 7d'00;
			h'0x01: number <= 7d'10;
			h'0x02: number <= 7d'20;
			h'0x03: number <= 7d'30;
			h'0x04: number <= 7d'40;
			h'0x05: number <= 7d'50;
			h'0x06: number <= 7d'60;
			h'0x07: number <= 7d'70;
			h'0x08: number <= 7d'80;
			h'0x09: number <= 7d'90; 	
		 endcase //2
			
		//Muda o valor de control sequencialmente para poder setar as unidades
		control = control + 1b'1;
		
		//
		always @(posedge control) begin //unidade-1
		
		//Validando a função de limpar o número ( ou números, dependendo da propriedade do sistema)
		if(clear) begin //clear-1
			number <= 7d'00;
		end //clear-1
		
			case (value) begin //unidade-2
				h'0x01: number <= number + 7d'00;
				h'0x01: number <= number + 7d'01;
				h'0x02: number <= number + 7d'02;
				h'0x03: number <= number + 7d'03;
				h'0x04: number <= number + 7d'04;
				h'0x05: number <= number + 7d'05;
				h'0x06: number <= number + 7d'06;
				h'0x07: number <= number + 7d'07;
				h'0x08: number <= number + 7d'08;
				h'0x09: number <= number + 7d'09; 
			endcase //unidade-2
		end //unidade-1
	end //1
	
endmodule
