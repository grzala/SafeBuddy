require File.expand_path('lib/helper_csv.rb')


class UploadCrimes < ActiveRecord::Migration
  def change
	upload_crimes
  end
end
