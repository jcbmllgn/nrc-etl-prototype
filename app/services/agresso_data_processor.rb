require 'net/ssh'
require 'net/sftp'

module AgressoDataProcessor

	def self.run(csv_input)
		# https://codereview.stackexchange.com/questions/151041/sftp-ruby-script-for-downloading-files-from-server
		# 1) fetch CSV
		host = 'csftp.u4a.se'
		port = 22
		user = "insert user name"
		pass = "insert pass"

		sfpt = Net::SFTP.start(host, user, password: pass, port: 22) do |sftp|
		  # TODO: fetch CSV from
		  # fetched_csv = sfpt.download(todo)
		end

		# sftp.close


		# 2) translate CSV to JSON
		# self.transform_csv_string_to_json(fetched_csv)


		# 3) Post JSON to Salesforce
	end

	def self.transform_csv_string_to_json(csv_input)
		csv_as_json = []
		exception_list = []

		csv_input.each_with_index do |line, index|

			# Country/region code is set as the first two characters of this field:
			country_code = line[0][0..1]

			next unless ["JO", "NO", "AF"].include? country_code

			csv_as_json << {
				"Title__c": line[1],
				"Expenditure_Eligibility_Start_Date__c": line[2],
				"Expenditure_Eligibility_End_Date__c": line[3],
				"NRC_Main_Project_Code__c": line[0],
				"NRC_Frame_Project_Code__c": nil, # Samir??
				"Agresso_Donor_ID__c": line[6],
				"Donor_Currency__c": line[7],
				"Country_Code__c": country_code,
				"Agresso_Project_Cycle__c": line[9],
				"Overhead__c": line[10],
				"Total_Budget_Donor_Currency__c": line[12],
				"Total_Budget_NOK__c": line[13],
				"NOK_to_USD_Exchange__c": line[14],
				"Donor_Currency_to_NOK_Exchange__c": line[15],
				"Name": line[0],
				"New_Donor__c": false # question for Samir/Motaz, where do I get this bool from?
			}
		end

		return csv_as_json, exception_list
	end

end
