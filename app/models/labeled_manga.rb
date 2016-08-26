class LabeledManga < ApplicationRecord
	belongs_to :manga
	belongs_to :label
end
