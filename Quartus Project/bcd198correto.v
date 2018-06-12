module decoder198 (UNI, data, DEZ, CEN, signalIN, signalOUT);
	input[7:0] data;
	input signalIN;
	
	output reg signalOUT;
	output reg [6:0] UNI, DEZ, CEN;

	always begin
		signalOUT <= ~signalIN;
		
		if(data<100) begin
			CEN=7'b0000001;
			if(data>=0 && data<10) begin
				DEZ = 7'b0000001;
				case(data)
					0:UNI=7'b0000001;
					1:UNI=7'b1001111;
					2:UNI=7'b0010010;
					3:UNI=7'b0000110;
					4:UNI=7'b1001100;
					5:UNI=7'b0100100;
					6:UNI=7'b0100000;
					7:UNI=7'b0001111;
					8:UNI=7'b0000000;
					9:UNI=7'b0000100;
				endcase
			end
			if(data>=10 && data<20) begin
				DEZ = 7'b1001111;
				case(data)
					10:UNI=7'b0000001;
					11:UNI=7'b1001111;
					12:UNI=7'b0010010;
					13:UNI=7'b0000110;
					14:UNI=7'b1001100;
					15:UNI=7'b0100100;
					16:UNI=7'b0100000;
					17:UNI=7'b0001111;
					18:UNI=7'b0000000;
					19:UNI=7'b0000100;
				endcase
			end
			if(data>=20 && data<30) begin
				DEZ = 7'b0010010;
				case(data)
					20:UNI=7'b0000001;
					21:UNI=7'b1001111;
					22:UNI=7'b0010010;
					23:UNI=7'b0000110;
					24:UNI=7'b1001100;
					25:UNI=7'b0100100;
					26:UNI=7'b0100000;
					27:UNI=7'b0001111;
					28:UNI=7'b0000000;
					29:UNI=7'b0000100;
				endcase
			end
			if(data>=30 && data<40) begin
				DEZ = 7'b0000110;
				case(data)
					30:UNI=7'b0000001;
					31:UNI=7'b1001111;
					32:UNI=7'b0010010;
					33:UNI=7'b0000110;
					34:UNI=7'b1001100;
					35:UNI=7'b0100100;
					36:UNI=7'b0100000;
					37:UNI=7'b0001111;
					38:UNI=7'b0000000;
					39:UNI=7'b0000100;
				endcase
			end
			if(data>=40 && data<50) begin
				DEZ = 7'b1001100;
				case(data)
					40:UNI=7'b0000001;
					41:UNI=7'b1001111;
					42:UNI=7'b0010010;
					43:UNI=7'b0000110;
					44:UNI=7'b1001100;
					45:UNI=7'b0100100;
					46:UNI=7'b0100000;
					47:UNI=7'b0001111;
					48:UNI=7'b0000000;
					49:UNI=7'b0000100;
				endcase
			end
			if(data>=50 && data<60) begin
				DEZ = 7'b0100100;
				case(data)
					50:UNI=7'b0000001;
					51:UNI=7'b1001111;
					52:UNI=7'b0010010;
					53:UNI=7'b0000110;
					54:UNI=7'b1001100;
					55:UNI=7'b0100100;
					56:UNI=7'b0100000;
					57:UNI=7'b0001111;
					58:UNI=7'b0000000;
					59:UNI=7'b0000100;
				endcase
			end
			if(data>=60 && data<70) begin
				DEZ = 7'b0100000;
				case(data)
					60:UNI=7'b0000001;
					61:UNI=7'b1001111;
					62:UNI=7'b0010010;
					63:UNI=7'b0000110;
					64:UNI=7'b1001100;
					65:UNI=7'b0100100;
					66:UNI=7'b0100000;
					67:UNI=7'b0001111;
					68:UNI=7'b0000000;
					69:UNI=7'b0000100;
				endcase
			end
			if(data>=70 && data<80) begin
				DEZ = 7'b0001111;
				case(data)
					70:UNI=7'b0000001;
					71:UNI=7'b1001111;
					72:UNI=7'b0010010;
					73:UNI=7'b0000110;
					74:UNI=7'b1001100;
					75:UNI=7'b0100100;
					76:UNI=7'b0100000;
					77:UNI=7'b0001111;
					78:UNI=7'b0000000;
					79:UNI=7'b0000100;
				endcase
			end
			if(data>=80 && data<90) begin
				DEZ = 7'b0000000;
				case(data)
					80:UNI=7'b0000001;
					81:UNI=7'b1001111;
					82:UNI=7'b0010010;
					83:UNI=7'b0000110;
					84:UNI=7'b1001100;
					85:UNI=7'b0100100;
					86:UNI=7'b0100000;
					87:UNI=7'b0001111;
					88:UNI=7'b0000000;
					89:UNI=7'b0000100;
				endcase
			end
			if(data>=90 && data<=99) begin
				DEZ = 7'b0000100;
				case(data)
					90:UNI=7'b0000001;
					91:UNI=7'b1001111;
					92:UNI=7'b0010010;
					93:UNI=7'b0000110;
					94:UNI=7'b1001100;
					95:UNI=7'b0100100;
					96:UNI=7'b0100000;
					97:UNI=7'b0001111;
					98:UNI=7'b0000000;
					99:UNI=7'b0000100;
				endcase
			end
		end
		else if(data<200) begin
			CEN=7'b1001111;
			if(data>=100 && data<110) begin
				DEZ = 7'b0000001;
				case(data)
					100:UNI=7'b0000001;
					101:UNI=7'b1001111;
					102:UNI=7'b0010010;
					103:UNI=7'b0000110;
					104:UNI=7'b1001100;
					105:UNI=7'b0100100;
					106:UNI=7'b0100000;
					107:UNI=7'b0001111;
					108:UNI=7'b0000000;
					109:UNI=7'b0000100;
				endcase
			end
			if(data>=110 && data<120) begin
				DEZ = 7'b1001111;
				case(data)
					110:UNI=7'b0000001;
					111:UNI=7'b1001111;
					112:UNI=7'b0010010;
					113:UNI=7'b0000110;
					114:UNI=7'b1001100;
					115:UNI=7'b0100100;
					116:UNI=7'b0100000;
					117:UNI=7'b0001111;
					118:UNI=7'b0000000;
					119:UNI=7'b0000100;
				endcase
			end
			if(data>=120 && data<130) begin
				DEZ = 7'b0010010;
				case(data)
					120:UNI=7'b0000001;
					121:UNI=7'b1001111;
					122:UNI=7'b0010010;
					123:UNI=7'b0000110;
					124:UNI=7'b1001100;
					125:UNI=7'b0100100;
					126:UNI=7'b0100000;
					127:UNI=7'b0001111;
					128:UNI=7'b0000000;
					129:UNI=7'b0000100;
				endcase
			end
			if(data>=130 && data<140) begin
				DEZ = 7'b0000110;
				case(data)
					130:UNI=7'b0000001;
					131:UNI=7'b1001111;
					132:UNI=7'b0010010;
					133:UNI=7'b0000110;
					134:UNI=7'b1001100;
					135:UNI=7'b0100100;
					136:UNI=7'b0100000;
					137:UNI=7'b0001111;
					138:UNI=7'b0000000;
					139:UNI=7'b0000100;
				endcase
			end
			if(data>=140 && data<150) begin
				DEZ = 7'b1001100;
				case(data)
					140:UNI=7'b0000001;
					141:UNI=7'b1001111;
					142:UNI=7'b0010010;
					143:UNI=7'b0000110;
					144:UNI=7'b1001100;
					145:UNI=7'b0100100;
					146:UNI=7'b0100000;
					147:UNI=7'b0001111;
					148:UNI=7'b0000000;
					149:UNI=7'b0000100;
				endcase
			end
			if(data>=150 && data<160) begin
				DEZ = 7'b0100100;
				case(data)
					150:UNI=7'b0000001;
					151:UNI=7'b1001111;
					152:UNI=7'b0010010;
					153:UNI=7'b0000110;
					154:UNI=7'b1001100;
					155:UNI=7'b0100100;
					156:UNI=7'b0100000;
					157:UNI=7'b0001111;
					158:UNI=7'b0000000;
					159:UNI=7'b0000100;
				endcase
			end
			if(data>=160 && data<170) begin
				DEZ = 7'b0100000;
				case(data)
					160:UNI=7'b0000001;
					161:UNI=7'b1001111;
					162:UNI=7'b0010010;
					163:UNI=7'b0000110;
					164:UNI=7'b1001100;
					165:UNI=7'b0100100;
					166:UNI=7'b0100000;
					167:UNI=7'b0001111;
					168:UNI=7'b0000000;
					169:UNI=7'b0000100;
				endcase
			end
			if(data>=170 && data<180) begin
				DEZ = 7'b0001111;
				case(data)
					170:UNI=7'b0000001;
					171:UNI=7'b1001111;
					172:UNI=7'b0010010;
					173:UNI=7'b0000110;
					174:UNI=7'b1001100;
					175:UNI=7'b0100100;
					176:UNI=7'b0100000;
					177:UNI=7'b0001111;
					178:UNI=7'b0000000;
					179:UNI=7'b0000100;
				endcase
			end
			if(data>=180 && data<190) begin
				DEZ = 7'b0000000;
				case(data)
					180:UNI=7'b0000001;
					181:UNI=7'b1001111;
					182:UNI=7'b0010010;
					183:UNI=7'b0000110;
					184:UNI=7'b1001100;
					185:UNI=7'b0100100;
					186:UNI=7'b0100000;
					187:UNI=7'b0001111;
					188:UNI=7'b0000000;
					189:UNI=7'b0000100;
				endcase
			end
			if(data>=190 && data<=198) begin
				DEZ = 7'b0000100;
				case(data)
					190:UNI=7'b0000001;
					191:UNI=7'b1001111;
					192:UNI=7'b0010010;
					193:UNI=7'b0000110;
					194:UNI=7'b1001100;
					195:UNI=7'b0100100;
					196:UNI=7'b0100000;
					197:UNI=7'b0001111;
					198:UNI=7'b0000000;
					199:UNI=7'b0000100;
				endcase
			end
		end
		else begin
			CEN=7'b1111111;
			DEZ=7'b1111111;
			UNI=7'b1111111;
		end
	end
endmodule 