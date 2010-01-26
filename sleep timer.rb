#!/usr/bin/ruby

require 'rubygems'
require 'active_support'
require 'osx/cocoa'
include OSX
require_framework 'ScriptingBridge'

timeToSleep = 2.minutes
startFadingTimeLeft = 1.minutes

iTunes = SBApplication.applicationWithBundleIdentifier 'com.apple.iTunes'
iTunes.currentTrack.playOnce false
iTunes.soundVolume = 100
sleep (timeToSleep - startFadingTimeLeft).to_i

startTime = Time.now
while iTunes.soundVolume > 0
  percentageDone = (Time.now - startTime) / startFadingTimeLeft
  iTunes.soundVolume = 100 * (1 - percentageDone)
  sleep 1
end
iTunes.pause
iTunes.soundVolume = 100
