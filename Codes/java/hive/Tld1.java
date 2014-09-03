package com.example.hive.udf;
import org.apache.hadoop.hive.ql.exec.UDF;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.net.URL;

public final class Tld1 extends UDF {
	public static List<String> lst = new ArrayList<String>();
	static {  
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
    };  

	public String evaluate(final String url, final String txt) {
		try{
			URL ret = new URL(url);
			return this.getTld(ret.getHost());
		}catch(Exception e){
			return url;
		}
	}

	public String evaluate(final String tid) {
		return this.getTld(tid);
	}

	public String getTld(final String tid) {
		try{
			String x = tid;
			Iterator<String> iterator = Tld1.lst.iterator();
			while (iterator.hasNext())
			{
				String tld = (String)iterator.next();
				if(x.endsWith(tld)){
					String substr = x.substring(0, x.length()-tld.length());
					String ret = x.substring(substr.lastIndexOf(".")+1);
					return ret;
				}
			}
			return tid;
		}catch(Exception e){
			return tid;
		}
	}
}
