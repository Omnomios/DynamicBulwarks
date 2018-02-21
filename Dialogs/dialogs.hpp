class startBox_Dialog
{
  idd = 9999
  movingEnabled = false;

  class controls
  {
    ////////////////////////////////////////////////////////
// GUI EDITOR OUTPUT START (by Hilltop, v1.063, #Hofuqe)
////////////////////////////////////////////////////////

class startBox_rscPicture: RscPicture
{
	idc = 1200;
	text = "#(argb,8,8,3)color(0.1,0.5,0.1,0.8)";
	x = 0.345321 * safezoneW + safezoneX;
	y = 0.268954 * safezoneH + safezoneY;
	w = 0.309357 * safezoneW;
	h = 0.462092 * safezoneH;
};
class startBox_rscButton: RscButton
{
	idc = 1600;
	text = "Purchase"; //--- ToDo: Localize;
	x = 0.376257 * safezoneW + safezoneX;
	y = 0.665033 * safezoneH + safezoneY;
	w = 0.247486 * safezoneW;
	h = 0.0440088 * safezoneH;
  action = "_nil=[]ExecVM ""loot\buildSup.sqf""";
};
class startBox_list: RscListbox
{
	idc = 1500;
	x = 0.376257 * safezoneW + safezoneX;
	y = 0.290958 * safezoneH + safezoneY;
	w = 0.247486 * safezoneW;
	h = 0.308061 * safezoneH;
};
////////////////////////////////////////////////////////
// GUI EDITOR OUTPUT END
////////////////////////////////////////////////////////

  };
};
