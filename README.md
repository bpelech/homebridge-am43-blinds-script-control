# homebridge-am43-blinds-script-control
Controlling am43 blinds motor via script for Homebridge



**Prerequisities:**
1. Homebridge (HB)
2. Insecure mode in the HB
3. Plugin 1: https://github.com/renssies/homebridge-am43-blinds
4. Plugin 1 up and running - you have to be able to control the blinds via this plugin in order to continue.
5. Plugin 2: https://github.com/cr3ative/homebridge-shell-switch


**Installation/usage:**
1. Put all three .sh scripts into the folder: /var/lib/homebridge/control (if you put them elsewhere, you'll need to update the directory everywhere accordingly)
2. Run `chmod 755 script_name.sh` for all of them
3. Update change_blinds.sh with your own Homebridge settings (aid, IP, PORT, KEY)
4. To find out aid, click the wheel in the accessory page in the HB UI and second from the bottom you'll see aid number for the blinds:

![image](https://user-images.githubusercontent.com/31206422/114417061-910d0b80-9bb1-11eb-9dad-95bc4f2ee043.png)

5. Setup the shell-switch plugin (update/set this to your Config.js):
```
{
            "accessory": "ShellSwitch",
            "name": "Blinds Up Switch",
            "onCmd": "/var/lib/homebridge/control/blinds_up.sh",
            "offCmd": "/var/lib/homebridge/control/blinds_down.sh"
 }
```

6. Save config and restart HB
7. You should have a button in the the Home app that will call blinds_up.sh when you turn it on and blinds_down.sh when you turin it off:

![IMG_F7010545E6DA-1](https://user-images.githubusercontent.com/31206422/114418583-f0b7e680-9bb2-11eb-98ff-b9ac6cccbd49.jpeg)
