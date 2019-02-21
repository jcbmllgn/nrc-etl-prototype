require 'rails_helper'
require 'csv'
require 'json'

RSpec.describe AgressoDataProcessor, type: :job do

	it 'transforms csv provided to me by Samir to json' do

		# agresso_real_sample_feb_19	| 	sample_1_input
		csv_file = File.read(File.join(Rails.root, 'lib/assets/sample_1_input.csv')).gsub('"','').gsub(';','|').gsub(' ', ' ')

		csv = CSV.new(csv_file, :col_sep => "|")

		json, exception = AgressoDataProcessor.transform_csv_string_to_json(csv)

		expect(json.length).to eq(100)

	end

end


