class Comment < ActiveRecord::Base
  belongs_to :prototype               #tweetsテーブルとのアソシエーション
  belongs_to :user                #usersテーブルとのアソシエーション
end
