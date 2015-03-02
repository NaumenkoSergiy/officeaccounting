class AddPasswordDigestToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :password_digest, :string
    Rake::Task['activebooks:encrypt_user_password'].invoke
  end

  def self.down
    remove_column :users, :password_digest, :string
  end
end
