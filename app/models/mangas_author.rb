class MangasAuthor < ApplicationRecord
	belongs_to :manga
	belongs_to :author
end
