#!/sbin/busybox sh

#
# Sample touch gesture actions by Tungstwenty - forum.xda-developers.com
# Modded by GM and dorimanx.

(
echo "
# Gesture 1 - swipe 1 finger near the top and one near the bottom from left to right
1:1:(0|150,0|150)
1:1:(330|480,0|150)
1:2:(0|150,650|800)
1:2:(330|480,650|800)

# Gesture 2 - swipe 3 fingers from near the top to near the bottom
2:1:(0|480,0|200)2:1:(0|480,600|800)
2:2:(0|480,0|200)2:2:(0|480,600|800)
2:3:(0|480,0|200)2:3:(0|480,600|800)

# Gesture 3 - draw a Z with one finger while another is pressed on the middle left
3:1:(0|150,0|150)
3:1:(330|480,0|150)
3:1:(0|150,650|800)
3:1:(330|480,650|800)

3:2:(0|150,300|500)

# Gesture 4 draw a heart starting at middle lower part of the screen
4:1:(200|280,699|799)
4:1:(0|150,300|500)
4:1:(200|280,300|500)
4:1:(330|480,300|500)
4:1:(200|280,699|799)

# Gesture 5 swipe 3 fingers from near the bottom to the top
5:1:(0|480,600|800)5:1:(0|480,0|200)
5:2:(0|480,600|800)5:2:(0|480,0|200)
5:3:(0|480,600|800)5:3:(0|480,0|200)

# Gesture 6 - one finger on bottom right while another goes from top-left to middle and back
6:1:(0|240,0|320)      6:1:(180|300,340|460)  6:1:(0|240,0|320) # top-left, middle, top-left
6:2:(530|800,960|1280)  # 2nd finger on the bottom right

# Gesture 7 - one finger on bottom left while another goes from top-right to middle and back
7:1:(530|800,0|320)    7:1:(180|300,340|460)  7:1:(530|800,0|320) # top-right, middle, top-right
7:2:(0|240,960|1280)    # 2nd finger on the bottom left

# Gesture 8 - 2 fingers start from the top-left and bottom-left corners and end in the middle right, like an arrow
8:1:(0|240,0|320)     8:1:(300|800,300|500)  # top-left to middle-right
8:2:(0|240,960|1280)   8:2:(300|800,300|500)  # bottom-left to middle-right

# Gesture 9 - 1 finger draws an X starting at the top left
9:1:(0|240,0|320)     # top left
9:1:(530|800,960|1280) # bottom right
9:1:(530|800,0|320)   # top right
9:1:(0|240,960|1280)   # bottom left

# Gesture 10 - 1 finger from bottom-left, bottom-right, bottom-left, bottom-right
10:1:(0|240,960|1280)   # bottom left
10:1:(530|800,960|1280) # bottom right
10:1:(0|240,960|1280)   # bottom left
10:1:(530|800,960|1280) # bottom right

" > /sys/devices/virtual/misc/touch_gestures/gesture_patterns
)&

# Detect ICS or JB - bluetooth calls are different
case "`getprop ro.build.version.release`" in
	4.1.* ) is_jb=1;;
	* )     is_jb=0;;
esac

(while [ 1 ];
do

	GESTURE=`cat /sys/devices/virtual/misc/touch_gestures/wait_for_gesture`
	
	if [ "$GESTURE" -eq "1" ]; then
	
	mdnie_status=`cat /sys/class/mdnie/mdnie/negative`
	if [ "$mdnie_status" -eq "0" ]; then
		echo 1 > /sys/class/mdnie/mdnie/negative
	else
		echo 0 > /sys/class/mdnie/mdnie/negative
	fi;

	elif [ "$GESTURE" -eq "2" ]; then

		# Power down the screen.
		input keyevent 26
				
	elif [ "$GESTURE" -eq "3" ]; then
	
		# Start the extweaks
		am start -a android.intent.action.MAIN -n com.darekxan.extweaks.app/.ExTweaksActivity

	elif [ "$GESTURE" -eq "4" ]; then

		echo "if blank GESTURE dont remove me."  > /dev/null 2>&1

		# Edit and uncomment the next line to automatically start a call to the target number
		# WARNING / BONUS: This will work even in the lockscreen with a PIN protection
		# When you ready to add some phone, remove the # before service call...

		#service call phone 2 s16 "your girl number"

	elif [ "$GESTURE" -eq "5" ]; then

		# Start Camera APP
		# for CM10
		launch_flags="--activity-exclude-from-recents --activity-reset-task-if-needed"
        
		result=`am start $launch_flags com.sec.android.app.camera/.Camera 2>&1 | grep Error`
		[ "$result" != "" ] && result=`am start $launch_flags com.android.camera/.Camera 2>&1 | grep Error`
		[ "$result" != "" ] && result=`am start $launch_flags com.android.gallery3d/com.android.camera.CameraLauncher 2>&1 | grep Error`
		[ "$result" != "" ] && result=`am start $launch_flags com.android.camera/.Camera 2>&1 | grep Error`

	elif [ "$GESTURE" == "6" ]; then

		# Toggle bluetooth on/off
		service call bluetooth 1 | grep "0 00000000" > /dev/null
		if [ "$?" -eq "0" ]; then
			service call bluetooth 3 > /dev/null
		else
			[ "$is_jb" -eq "1" ] && service call bluetooth 5 > /dev/null
			[ "$is_jb" -ne "1" ] && service call bluetooth 4 > /dev/null
		fi;
        
	elif [ "$GESTURE" == "7" ]; then

		# Toggle WiFi on/off
		service call wifi 14 | grep "0 00000001" > /dev/null
		if [ "$?" -eq "0" ]; then
			service call wifi 13 i32 1 > /dev/null
		else
			service call wifi 13 i32 0 > /dev/null
		fi;
        
	elif [ "$GESTURE" == "8" ]; then

		# Simulate key press - Play/Pause

		# 26 = Power
		# 3 = Home
		# 24/25 = Volume up/down
		# 85 = Media Play / pause
		# 86 = Media stop
		# 87/88 = Media next / previous
		# 164 = Volume mute / unmute

		input keyevent 85
    
	elif [ "$GESTURE" == "9" ]; then

		# Simulate key press - Volume mute / unmute

		# 26 = Power
		# 3 = Home
		# 24/25 = Volume up/down
		# 85 = Media Play / pause
		# 86 = Media stop
		# 87/88 = Media next / previous
		# 164 = Volume mute / unmute
		# 187 = Recent apps

		input keyevent 164

	elif [ "$GESTURE" == "10" ]; then

		# Simulate key press - Home
        
		# 26 = Power
		# 3 = Home
		# 24/25 = Volume up/down
		# 85 = Media Play / pause
		# 86 = Media stop
		# 87/88 = Media next / previous
		# 164 = Volume mute / unmute
		# 187 = Recent apps

		input keyevent 3
	fi;

	# Small vibration to provide feedback
	service call vibrator 2 i32 50 i32 0

	sleep 3

done &) > /dev/null 2>&1;

