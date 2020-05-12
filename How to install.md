# How to install this mission directly from source control

1. Choose a unique install directory name for your mission, in the format `<yourmissionname>.<mapname>`, where:
    *  `<yourmissionname>` is a name of your choosing, such as `MyBulwarks`
    *  `<mapname>` is one of the actual maps, such as `altis`, `tanoa`, `enoch`, `linovia`, `stratis`, or `malden`.
       *  You can find these world names in the mission editor.  Open the editor, click `Tools`, then `Config Viewer`, then double-click `+configFile` on the left side and scroll down to `+CfgWorlds` and double-click on that.
2. Choose the location where you will install the mission.  It can be one of the following:
   * The Steam ARMA directory.  This will look like `F:\Steam\steamapps\common\Arma 3\MPMissions`, where `F:\Steam` should be replaced with your Steam directory. The final directory will look like `F:\Steam\steamapps\common\Arma 3\MPMissions\<yourmissionname>.<mapname>`
   * Your user documents ARMA directory. You can find this in Explorer with `%USERPROFILE%\Documents\Arma 3\mpmissions`.  It will look something like `C:\Users\yourusername\Documents\Arma 3\mpmissions`.  The final directory will look like `%USERPROFILE%\Documents\Arma 3\mpmissions\<yourmissionname>.<mapname>`
     * If you use this location, you can also use the in-game editor to edit the mission.
3. `git clone` this repository to the above directory.
    * Don't clone the repository to a directory *inside* the above directory. For example, this file should appear directly underneath the directory you chose above.
4. To distinguish your mission from other versions of this mod, you can also rename the mission.  Locate the `mission.sqm` file (it's in the same directory as this one), and find the line `briefingName="Dynamic Bulwarks"`.  Change `Dynamic Bulwarks` to whatever you like.
5. Launch the game and host the mission - it'll show up under the list of missions available for whatever map you've chosen.