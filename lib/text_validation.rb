module TextValidation
  extend ActiveSupport::Concern

  def check_wrong_words(text)
    wrong_words =  ["bad", "poor", "stupid", "fiilty", "dirty"]
    text_chuncks = text.split(" ") if text.present?
    wrong_words.each do |wrong_word|
        if text_chuncks.include? (wrong_word)
          return true
        else
          return false
        end
    end
  end

  module ClassMethods
    def vowel_counts(text)
      vowels_count = 0
      vowels_count = text.count("aAeEoOuUiI") if text.present?
      return vowels_count
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
