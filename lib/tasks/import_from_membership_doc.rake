require 'open-uri'
require 'csv'

MEMBERSHIP_LIST =
{
  "2014" => "https://docs.google.com/spreadsheet/pub?key=0AsG_QYTCtlqrdFdpUnBGeWNIZmQ5YzB5YnBDSzQySXc&output=csv",
  "2013" => "https://docs.google.com/spreadsheet/pub?key=0AsG_QYTCtlqrdGRCQmduX2tNeFozR0NFZ1liZ09HVkE&output=csv",
  "2012" => "https://docs.google.com/spreadsheet/pub?key=0AsG_QYTCtlqrdGZMekc0cTRHMUpienBJWHN1ZW1zLXc&output=csv"
}

def csv_to_array(uri)
  csv = CSV.new(open(uri), :headers => :first_row)
  csv.to_a.map {|row| row.to_hash }
end

desc "imports from member spreadsheet on google docs"
task import_memberships: [:environment] do
  MEMBERSHIP_LIST.each do |year, link|
    member_list = csv_to_array(link)
    member_list.each do |row|
      ### Preprocessing
      if row["#{year} Dues Paid"].present?
        @date_paid = DateTime.strptime(row["#{year} Dues Paid"], "%m/%d/%Y")
      end
      # override emails for members under 13
      if row["Birthday"].present?
        @birth_date = DateTime.strptime(row["Birthday"], "%m/%d/%Y")
      end
      if (Date.today - @birth_date) <= 365*13
        row["email address"] = "nobody" + \
        SecureRandom.random_number(9999).to_s.rjust(4, "0") + \
        "@example.com"
      end
      if row["email address"].present?
        ### Setup
        @gender = 0
        if row["gender"] == 'f'
          @gender = 1
        end
        @admin_flag = false
        if row["Position"] != "member"
          @admin_flag = true
        end
        initial_password = "password" + \
        SecureRandom.random_number(9999).to_s.rjust(4, "0")
        ### Member Import###
        m = Member.find_or_create_by!(first_name: row["First Name"], last_name: row["Last Name"]) do |member|
          member.email = row["email address"]
          member.birthdate = @birth_date
          member.gender = @gender
          member.usat_number = row["USAT #"]
          member.home_phone = row["Home Phone"]
          member.cell_phone = row["Cell Phone"]
          member.password = initial_password
          member.password_confirmation = initial_password
          member.is_admin = @admin_flag
        end
        full_address = row["Address"] + ", " + \
                       row["City/State"] + ", " + \
                       row["State"] + " " + \
                       row["Zip"]
        address = Address.create(full_address: full_address, member: m)

        ### Memberships
        if row["Category"] == "Individual"
          membership = Membership.new(category: row["Category"],
                                      year: year,
                                      date_paid: @date_paid,
                                      price_paid: 40.00)
          membership.member_memberships.build(primary: true, member: m)
          membership.save
        elsif row["Category"] == "Family"
          membership = Membership.find_or_initialize_by(category: row["Category"],
                                                    year: year,
                                                    date_paid: @date_paid,
                                                    price_paid: 65.00)
          if membership.member_memberships.where(primary: true).empty?
            membership.member_memberships.build(primary: true, member: m)
          else
            membership.member_memberships.build(primary: false, member: m)
          end
          membership.save
        end
      end
    end
  end
end
