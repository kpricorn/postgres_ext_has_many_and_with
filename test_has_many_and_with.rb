require 'bundler'
Bundler.setup(:default)

require 'pry'
require 'active_record'
require 'postgres_ext'
require 'minitest/autorun'
require 'logger'

# This connection will do for database-independent bug reports.
ActiveRecord::Base.establish_connection('postgres://localhost/has_many_and_with')
ActiveRecord::Base.logger = Logger.new(STDOUT)

ActiveRecord::Schema.define do
  create_table :posts, force: true  do |t|
  end

  create_table :comments, force: true  do |t|
    t.integer :post_id
  end
end

class Post < ActiveRecord::Base
  has_many :comments
  has_many :comments_foo, -> { foo }, class_name: 'Comment'
  has_many :comments_with_foo, -> { with_foo }, class_name: 'Comment'
end

class Comment < ActiveRecord::Base
  belongs_to :post

  def self.foo
    select("*, 1 AS foo")
  end

  def self.with_foo
    with(comments: select("*, 1 AS foo")).select('*')
  end
end

class BugTest < Minitest::Test
  def test_has_many_and_with
    post = Post.create!
    post.comments << Comment.create!

    assert_equal Comment.foo.first.foo, 1
    assert_equal post.comments.foo.first.foo, 1
    assert_equal post.comments_foo.first.foo, 1

    assert_equal Comment.with_foo.first.foo, 1
    assert_equal post.comments.with_foo.first.foo, 1
    assert_equal post.comments_with_foo.first.foo, 1 # with_foo scope is ignored
  end
end
