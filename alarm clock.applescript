-- two variables to set
set podcastToUse to "NPR: 7AM ET News Summary Podcast"
-- this is from the album field
set timeToWakeUp to date "7:00 am" of (current date)
-- this will be fixed to be tomorrow if necessary

if timeToWakeUp is less than the (current date) then
	set timeToWakeUp to timeToWakeUp + 1 * days
end if
delay timeToWakeUp - (current date)
tell application "iTunes"
	set podcastPlaylist to the playlist "Podcasts"
	set partyShuffle to the playlist "iTunes DJ"
	updatePodcast (first track of podcastPlaylist whose album is podcastToUse)
	set finishedUpdating to false
	repeat while finishedUpdating is false
		try
			set newTrack to the first track of podcastPlaylist whose album is podcastToUse and date added is greater than ((current date) - 12 * hours)
			set finishedUpdating to true
			set trackOnPlaylist to duplicate (a reference to newTrack) to partyShuffle
			
			set theDate to current date
			set theTime to time string of theDate
			set firstColon to offset of ":" in theTime
			set timeString to text 1 through (firstColon + 2) of theTime & text (firstColon + 6) through end of theTime
			say "Good morning. Today is  " & date string of theDate & "; the time is " & timeString
			
			tell partyShuffle to play trackOnPlaylist
		on error the errorMessage
			set finishedUpdating to false
			delay 10
		end try
	end repeat
end tell