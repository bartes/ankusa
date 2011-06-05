require 'fast_stemmer'
require 'ankusa/stopwords'
require 'ankusa/emots'

module Ankusa

  class TextHash < Hash
    attr_reader :word_count

    def initialize(text=nil)
      super 0
      @word_count = 0
      add_text(text) if not text.nil?
    end

    def add_text(text)
      if text.kind_of? Array
        text.each { |t| add_text t }
      else
        # replace dashes with spaces, then get rid of non-word/non-space characters,
        # then split by space to get words
        words = TextHash.atomize text
        words.each { |word| add_word(word) if TextHash.valid_word?(word) }
      end
      self
    end

    def add_word(word)
      @word_count += 1
      key = word.stem.intern
      store key, fetch(key, 0)+1
    end

    def self.atomize(text)
      t = text.to_ascii.tr('-', ' ')
      Ankusa::Emots.reject_not_emotted_signs(text.to_ascii.tr('-', ' ')).
        gsub(Ankusa::Emots::NOT_WORDS_AND_EMOTS, " ").split.compact.map { |w| w.downcase }
    end

    def self.valid_word_format?(word)
      return false if word.length < 3
      return false if word.numeric?
      true
    end

    def self.parsed_stopwords
      return @parsed_stopwords unless @parsed_stopwords.nil?
      @parsed_stopwords = (Ankusa::STOPWORDS.gsub(Ankusa::Emots::NOT_WORDS," ").split + Ankusa::STOPWORDS.gsub(Ankusa::Emots::NOT_WORDS,"").split).uniq
      @parsed_stopwords = @parsed_stopwords.select{|w| valid_word_format?(w)}
      @parsed_stopwords
    end

    # word should be only alphanum chars at this point
    def self.valid_word?(word)
      return true  if Ankusa::Emots::LIST.include?(word)
      return false if parsed_stopwords.include?(word)
      return false unless valid_word_format?(word)
      true
    end

  end

end
