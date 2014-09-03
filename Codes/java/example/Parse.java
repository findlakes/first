import java.io.*;

class Parse {

	static int lookahead;

	public Parse() throws IOException {
		lookahead = System.in.read();
	}

	void expr() throws IOException {
		term();
		while(true){
			if(lookahead == '+'){
				match('+'); term(); System.out.print("+");
			}
			else if(lookahead == '-'){
				match('-'); term(); System.out.print("-");
			}
			else return;
		}
	}

	void term() throws IOException {
		if( Character.isDigit((char)lookahead)){
			System.out.print((char)lookahead); match(lookahead);
		}
		else throw new Error("syntax error");
	}

	void match(int t) throws IOException {
		if(lookahead == t) lookahead = System.in.read();
		else throw new Error("syntax error");
	}

	public static void main(String[] args) throws IOException {
		Parse ps = new Parse();
		ps.expr();System.out.print("\n");
	}

}
