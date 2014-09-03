package com.example.hive.udf;
import org.apache.hadoop.hive.ql.exec.UDF;

public final class Rank1 extends UDF {
	private int counter;
	private String last_dp_id;
	private String last_tid;
	//多参数
	public int evaluate(String dp_id, String tid) {
		if (dp_id.equalsIgnoreCase(this.last_dp_id) && tid.equalsIgnoreCase(this.last_tid)) {
			this.counter++;
		}else{
			this.counter = 0;
			this.last_dp_id = dp_id;
			this.last_tid = tid;
		}
		return this.counter;
	}
	//一个参数
	public int evaluate(final String tid) {
		if (!tid.equals(this.last_tid)) {
			this.counter = 0;
			this.last_tid = tid;
		}
		return this.counter++;
	}
}

