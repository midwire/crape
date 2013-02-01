require File.dirname(__FILE__) + '/../../spec_helper'

describe Craigslist::Scraper do
  CATEGORY = 'cars_and_trucks'
  QUERY = 'blue ford'
  let(:scraper) {Craigslist::Scraper.new(:category => CATEGORY)}

  it "constructor ensures CRAPEDIR and LOG_FILE exist" do
    Craigslist::Scraper.new(:category => CATEGORY)
    File.exists?(Craigslist::Scraper::CRAPEDIR).should === true
    File.exists?(Craigslist::Scraper::LOG_FILE).should === true
  end

  it "provides a log file accessor 'log'" do
    scraper.log.should be_a(Logger)
  end

  it "sets last_runtime" do
    scraper.set_last_runtime(QUERY, Time.parse("2000-01-01 12:00:00 -0600"))
    File.exists?(Craigslist::Scraper::DATA_FILE).should === true
    data = YAML.load(open(Craigslist::Scraper::DATA_FILE))
    Time.parse(data[CATEGORY][QUERY]['last_runtime']).should be_a(Time)
  end

  it "gets last_runtime" do
    data = YAML.load(open(Craigslist::Scraper::DATA_FILE))
    scraper.get_last_runtime(QUERY).should == Time.parse(data[CATEGORY][QUERY]['last_runtime'])
  end

end
