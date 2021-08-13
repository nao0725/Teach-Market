class Notification < ApplicationRecord

  #作成日時の降順で絞り込み
  default_scope -> {order(create_at: :desc)}
  belongs_to :article, optional: true
  belongs_to :comment, optional: true

  belongs_to :visitor, class_name: "User", foreign_key: "visitor_id", optional: true
  belongs_to :visited, class_name: "User", foreign_key: "visited_idgit ", optional: true

end
