class CreateCrimeGroups < ActiveRecord::Migration
  def change
    create_table :crime_groups do |t|
      t.string :name

      t.timestamps null: false
    end

	groups = [
	"Non-sexual crimes of violence",
	"Sexual offences",
	"Crimes of dishonesty",
	"Fire-raising, vandalism etc.",
	"Other crimes",
	"Miscellaneous offences",
	"Motor vehicle offences"
	]
	groups.each do |group_name|
		group = CrimeGroup.new
		group.name = group_name
		group.save
	end
  end
end
