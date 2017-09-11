require 'rubygems'
require 'benchmark'

Dir["*.rb"].each {|file| require_relative file }

Benchmark.bm do |x|
  x.report('load dict + spellcheck') do
    x.report { SpellChecker.new('dictionary.txt').spellcheck_lines('sonnets.txt') }
  end
end

if ARGV.any?
  Benchmark.bm do |x|
    x.report("load dict + suggest words:") do
      SpellChecker.new('dictionary.txt').suggest_words(ARGV[0].chomp)
    end
  end
end
