module Ankusa

  class Emots
    LIST = ":) :( ! ?".split
    NOT_WORDS_AND_EMOTS = /[^\w\s:\)\(!\?]/
    NOT_WORDS = /[^\w\s]/

    def self.reject_not_emotted_signs(text)
      text.gsub(/(:[^\)\(])/){ " " + $1[1] }.
      gsub(/([^:][\(\)])/){ $1[0] + " " }.
      gsub(/([\(\)!\?])/){ $1 + " " }.
      gsub(/([:!\?])/){ " " + $1 }
    end

  end

end
