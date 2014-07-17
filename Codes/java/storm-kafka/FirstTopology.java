package storm.starter;

import backtype.storm.Config;
import backtype.storm.LocalCluster;
import backtype.storm.StormSubmitter;
import backtype.storm.topology.TopologyBuilder;
import backtype.storm.topology.BasicOutputCollector;
import backtype.storm.topology.OutputFieldsDeclarer;
import backtype.storm.topology.base.BaseBasicBolt;
import backtype.storm.topology.OutputFieldsDeclarer;
import backtype.storm.topology.base.BaseRichSpout;
import backtype.storm.tuple.Tuple;
import backtype.storm.tuple.Fields;
import backtype.storm.tuple.Values;
import backtype.storm.task.TopologyContext;
import backtype.storm.spout.SpoutOutputCollector;
import backtype.storm.utils.Utils;
import java.util.Map;

public class FirstTopology {

public static class RandomSentenceSpout extends BaseRichSpout {
  SpoutOutputCollector _collector;

  @Override
  public void open(Map conf, TopologyContext context, SpoutOutputCollector collector) {
    _collector = collector;
  }

  @Override
  public void nextTuple() {
    Utils.sleep(100);
    String alog = "10.10.10.1 - - [15/Jul/2014:15:01:07 +0800] \"GET / HTTP/1.1\" 200 4 \"-\" \"curl/7.1 (x86-redhat)\"";
    _collector.emit(new Values(alog));
  }

  @Override
  public void declareOutputFields(OutputFieldsDeclarer declarer) {
    declarer.declare(new Fields("word"));
  }

}

public static class PrinterBolt extends BaseBasicBolt {

  @Override
  public void execute(Tuple tuple, BasicOutputCollector collector) {
    System.out.println("++++++ start ++++++"+tuple+"------ end ------");
  }
  @Override
  public void declareOutputFields(OutputFieldsDeclarer ofd) {
  }

}

public static void main(String[] args) throws Exception { 
    TopologyBuilder builder = new TopologyBuilder();
    builder.setSpout("spout", new RandomSentenceSpout(), 5);
    builder.setBolt("print", new PrinterBolt(),2).shuffleGrouping("spout");

    Config conf = new Config();
    conf.setDebug(true);
    conf.setMaxTaskParallelism(3);
    
    LocalCluster cluster = new LocalCluster();
    cluster.submitTopology("word-count-hl", conf, builder.createTopology());

    Thread.sleep(5000);
    cluster.shutdown();
}

}
