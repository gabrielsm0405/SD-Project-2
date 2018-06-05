

/*OBS: COLOCAR MAIS OPÇÕES DAS MÁQUINAS DE ESTADO; CHECAR SE O PROGRAMA É FUNCIONAL COM MONITORES
	programador: Romildo Juliano
*/
module changeNumber(value, CLOCK_50, reset, number);

	//Valores de entrada como o clock, o reset (clear), 
	input value, CLOCK_50, reset;
	
	//Valor que vai ser alterado 
	output number;
	
	reg control = 0;
	
	//Inicia o valor em 0, para que possa ser somado posteriormente ao longo da máquina
	value = 0; 

	always @ (posedge CLOCK_50 or negedge reset) begin //1 
		if (reset) begin //4
		/*
			 RESETAR O PROGRAMA
		*/	
		 end //4
	//Caso o valor seja alterado pela primeira vez...
		case (value) begin //<- Funcional?
			h'0x01: number <= 7d'10;
			h'0x02: number <= 7d'20;
			h'0x03: number <= 7d'30;
			h'0x04: number <= 7d'40;
			h'0x05: number <= 7d'50;
			h'0x06: number <= 7d'60;
			h'0x07: number <= 7d'70;
			h'0x08: number <= 7d'80;
			h'0x09: number <= 7d'90; 	
		 endcase
		
		
		if(number>0) begin //3
			if(value) begin //2
				
				
			end //2
	    	end //3
		
	end //1
	
endmodule
