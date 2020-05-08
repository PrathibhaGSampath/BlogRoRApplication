module TextValidation
  extend ActiveSupport::Concern

  def contains_wrong_words?(text)
    wrong_words =  ["bad", "poor", "stupid", "filty", "dirty"]
    result = nil
    wrong_words.each do |wrong_word|
        if text.include? (wrong_word)
          return true
        else
          next
          result = false
        end
    end
    return result
  end

  module ClassMethods
    def vowel_counts(text)
      vowels_count = 0
      vowels_count = text.count("aAeEoOuUiI") if text.present?
      return vowels_count
    end

    def get_word_count(text)
      text_chuncks = []
      text_chuncks = text.split(" ") if text.present?
      return text_chuncks.count
    end
  end

  # included do
  # we need to extend
  #   # extend ClassMethods
  # end

  # def self.included(included_class)
  #   included_class.extend ClassMethod
  # end

  # def self.included(included_class)
  #   included_class.class_eval do
  #     extend ClassMethod
  #   end
  # end
end
