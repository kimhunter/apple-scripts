property thePhoneGroup : "Phone"
property theNotPhoneGroup : "Not Phone"

on createGroup(str)
	tell application "Address Book"
		try
			get group str
		on error
			make new group with properties {name:str}
			save
		end try
	end tell
end createGroup


tell application "Address Book"
	
	my createGroup(thePhoneGroup)
	my createGroup(theNotPhoneGroup)
	
	set allContacts to every person
	
	repeat with p in allContacts
		if (count of phone of p) is 0 then
			-- Dont have a number
			-- if they are in the group then remove them
			if (name of groups of p contains thePhoneGroup) then remove p from group thePhoneGroup
		else
			-- They have a number, add to the group
			if (name of groups of p does not contain thePhoneGroup) then
				add p to group thePhoneGroup
			end if
			if (name of groups of p contains thePhoneGroup and name of groups of p contains theNotPhoneGroup) then remove p from group thePhoneGroup
		end if
	end repeat
	save
	beep
end tell