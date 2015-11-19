require File.expand_path('lib/helper_csv.rb')

class UploadPoliceCrimes < ActiveRecord::Migration
  def change
	upload_police_crimes
  end
end
