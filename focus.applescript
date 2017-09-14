################################################################################
#                                  FOCUS
#       Block addictive sites that steal your time during the workday!
#
# How to use?
# Add the addictive sites in the 'dangerous' variable below and run at the
# beginning of your work day to block them!
################################################################################

activate

set yesno to {"yes", "no"}
choose from list yesno with title "Focus" with prompt "Want to focus?" default items (get item 1 in yesno)
set chosen to result

-- http://stackoverflow.com/questions/8621290/how-to-tell-an-applescript-to-stop-executing
if chosen is false then
	error number -128
end if

set hostsFile to "/etc/hosts"
set theContent to read hostsFile as «class utf8»

set theOffset to (offset of "######## focus" in theContent) - 1

set coreContent to ""
if theOffset is -1 then
	set coreContent to theContent
else
	set coreContent to text 1 thru (theOffset) of theContent
end if

set dangerous to "######## focus
127.0.0.1 www.facebook.com
127.0.0.1 facebook.com
127.0.0.1 www.youtube.com
127.0.0.1 youtube.com
127.0.0.1 inbox.google.com"

set newContent to ""

if chosen as string is equal to "yes" then
	set newContent to coreContent & dangerous
else
	set newContent to coreContent
end if

do shell script "echo '" & newContent & "' > " & hostsFile with administrator privileges

do shell script "dscacheutil -flushcache"
