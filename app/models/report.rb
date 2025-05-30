# frozen_string_literal: true

class Report < ApplicationRecord
  belongs_to :user
  has_many :comments, as: :commentable, dependent: :destroy

  has_many :mentioning_relationships, class_name: 'Mention', foreign_key: 'mentioned_id', dependent: :destroy, inverse_of: :mentioning
  has_many :mentioned_relationships, class_name: 'Mention', foreign_key: 'mentioning_id', dependent: :destroy, inverse_of: :mentioned
  has_many :mentioning_reports, through: :mentioning_relationships, source: :mentioning
  has_many :mentioned_reports, through: :mentioned_relationships, source: :mentioned

  validates :title, presence: true
  validates :content, presence: true

  def editable?(target_user)
    user == target_user
  end

  def created_on
    created_at.to_date
  end

  def create_mentions
    mentioning_relationships.destroy_all
    report_url_pattern = %r{http://localhost:3000/reports/(\d+)}
    mentions = content.scan(report_url_pattern).flatten
    mentions.each do |mentioning_id|
      Mention.create!(mentioning_id: mentioning_id, mentioned_id: id)
    end
  end
end
