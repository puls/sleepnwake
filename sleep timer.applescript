set minutesToSleep to 15
set startFadingTimeLeft to 5
tell application "iTunes"
	play
	set the sound volume to 100
	set delaySeconds to (minutesToSleep - startFadingTimeLeft) * minutes
	delay delaySeconds
	set startTime to the current date
	repeat while the sound volume is greater than 0
		set percentageDone to ((current date) - startTime) / (startFadingTimeLeft * minutes)
		set the sound volume to 100 * (1 - percentageDone)
		delay 1
	end repeat
	pause
	set the sound volume to 100
end tell