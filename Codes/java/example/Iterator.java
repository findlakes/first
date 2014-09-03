import java.io.*;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

class Tld {

	public static void main(String[] args) throws IOException {

		String x = "abc.www.baidu.com.cn";

		List<String> lst = new ArrayList<String>();
		lst.add(".com.cn");
		lst.add(".net.cn");
		lst.add(".org.cn");
		lst.add(".gov.cn");
		lst.add(".edu.cn");
		lst.add(".com");
		lst.add(".co");
		lst.add(".net");
		lst.add(".org");
		lst.add(".cn");
		lst.add(".me");
		lst.add(".biz");
		lst.add(".name");
		lst.add(".info");
		lst.add(".me");
		lst.add(".so");
		lst.add(".tel");
		lst.add(".mobi");
		lst.add(".asia");
		lst.add(".cc");
		lst.add(".io");
		lst.add(".im");
		lst.add(".pw");
		lst.add(".tv");

		Iterator<String> iterator = lst.iterator();
		while (iterator.hasNext())
		{
			String tld = (String)iterator.next();
			boolean istrue = x.endsWith(tld);
			if(istrue){
				String substr = x.substring(0, x.length()-tld.length());
				String ret = x.substring(substr.lastIndexOf(".")+1);
				System.out.println(substr + "  "+ ret);
				break;
			}
		}

	}

}
