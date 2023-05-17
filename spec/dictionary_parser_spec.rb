# frozen_string_literal: true

require 'rspec-benchmark'
require_relative '../dictionary_parser'

RSpec.configure do |config|
  config.include RSpec::Benchmark::Matchers
end

describe 'Quality' do
  before(:all) do
    parse('dictionaires/test.txt')
  end

  it 'makes correct sequenses output' do
    expect(File.read('output/sequences.txt')).to eq File.read('spec/sequences.txt')
  end

  it 'makes correct words output' do
    expect(File.read('output/words.txt')).to eq File.read('spec/words.txt')
  end
end

describe 'Memory usage' do
  it 'lower than 5 MB on 25K records' do
    m_before = `ps -o rss= -p #{Process.pid}`.to_f / 1024
    parse('dictionaires/full_dictionary.txt')
    m_after = `ps -o rss= -p #{Process.pid}`.to_f / 1024
    expect(m_after - m_before).to be <= 5
  end
end

describe 'Performance' do
  it 'process 1k words for under 20 ms' do
    expect { parse('dictionaires/1k_words.txt') }.to perform_under(20).ms.warmup(2).times.sample(10).times
  end

  it 'process 25k words for under 400 ms' do
    expect { parse('dictionaires/full_dictionary.txt') }.to perform_under(400).ms.warmup(2).times.sample(10).times
  end
end
