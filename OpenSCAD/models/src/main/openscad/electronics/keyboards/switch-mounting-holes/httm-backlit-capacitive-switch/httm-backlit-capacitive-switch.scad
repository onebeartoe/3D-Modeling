
/**
 * Mike Hall showed and gave me afew of one day at work.
 *
 * The height of the board with cap touch plat is listed as 3mm.

 *		http://www.cnx-software.com/2017/07/27/httm-backlit-capacitive-touch-switch-button-sells-for-about-one-dollar/
 *
 *      From the link:
				 HTTM button specifications:

				 Voltage input range: + 2.7v to + 6v
				 Signal output – Voltage: + 3.3v; Current up to 500 mA
				 Header – 3-pin with GND, VCC, and OUT
				 Backlight color – red, blue (cyan), or yellow
				 Dimensions – 20.4 x 16.6 mm
				 Operating temperature range: -30 ℃ to + 70 ℃

	 https://www.aliexpress.com/item/10-pcs-red-color-HTTM-Series-2-7V-6V-Capacitive-Touch-Switch-Module-Strong-anti-interference/32814839036.html

		 From aliexpress:

			 Working voltage: + 2.7 ~ 6V
			 Working temperature: 30 ~ +70 °
			  OUT pin Output voltage: + 3.3V ± 0.1V
			 OUTPin maximum output current:500mA
 */

module httmBacklitCapacitiveTouchSwitchMountingHole()
{
	xLength = 20.4;
	yLength = 16.6;
	zLength = 3.0;

	cube([xLength, yLength, zLength]);
}
