################################################################################
#                                START-DEV
#      Sets up a terminal with tabs needed to do efficient development
#
# How to use?
# Add your apps to choices and if else-blocks maching them and spawning the tabs
# you need and run the necessary commands to start your dev environments.
################################################################################


activate

set choices to {"app1"}
choose from list choices with title "Start" with prompt "What do you want to develop?" default items (get item 1 in choices)
set choice to result

-- http://stackoverflow.com/questions/8621290/how-to-tell-an-applescript-to-stop-executing
if choice is false then
	error number -128
end if

if choice as string is equal to "app1" then
	
	-- https://apple.stackexchange.com/questions/58037/how-to-use-applescript-to-launch-three-scripts-each-in-new-terminal-tab
	tell application "Terminal"
		activate
		do script
		do script "nvm use 4.4.6" in tab 1 of front window
		do script "cd code/app1/server" in tab 1 of front window
		do script "npm run start" in tab 1 of front window
		
		my makeTab()
		do script "nvm use 4.4.6" in tab 2 of front window
		do script "cd code/app1/client" in tab 2 of front window
		do script "npm run dev-data" in tab 2 of front window
		
		my makeTab()
		do script "nvm use 4.4.6" in tab 3 of front window
		do script "cd code/app1/client" in tab 3 of front window
		do script "npm run start" in tab 3 of front window
		
	end tell
end if

on makeTab()
	tell application "System Events" to keystroke "t" using {command down}
	delay 0.2
end makeTab
