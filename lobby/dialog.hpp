#define COLOR_HALF_BLACK { 0, 0, 0, 0.5 }
#define COLOR_HALF_BLUE { 0, 0, 1, 0.5 }
#define COLOR_HALF_WHITE { 1, 1, 1, 0.5 }
#define COLOR_TRANSPARENT { 0, 0, 0, 0 }
#define COLOR_WHITE { 1, 1, 1, 1 }
#define COLOR_GREEN { 0, 1, 0, 1 }
#define COLOR_RED { 1, 0, 0, 1 }
#define COLOR_DARK_GREEN { 0, 0.5, 0, 1 }
#define COLOR_HALF_PINK { 1, 0, 1, 0.5 }
#define COLOR_DISABLED_TEXT { 0.75, 0.75, 0.75, 1 }
#define COLOR_DISABLED_BACKGROUND { 0.5, 0.5, 0.5, 1 }

class bulwarkParams_Dialog
{
    idd = 9999;
    movingEnabled = false;

	onLoad = "_this call lobby_fnc_populateDialogParameterSets";
	controls[] = {
		BulwarkParamsParameterSetList,
		BulwarkParamsParameterList,
		BulwarkParamsCloseButton,
		BulwarkParamsSaveAsButton,
		BulwarkParamsSaveButton
	};

	controlsBackground[] = {
		BulwarkParamsBackground,
		BulwarkParamsTitle
	};
	
	//
	// HEADER
	//
	class BulwarkParamsBackground : RscText 
    {
		colorBackground[] = COLOR_HALF_BLACK;
		x = 0;  y = 0;
		w = 1; h = 1;
	};
	
	class BulwarkParamsTitle : RscText
	{
		colorBackground[] = COLOR_HALF_BLUE;
		colorText[] = COLOR_WHITE;

		x = 0; y = 0;
		w = 0.5; h = 0.05;
		text="Mission Parameters";
	};

	class BulwarkParamsParameterSetList : RscCombo
	{
		idc = 100;
		x = 0.5; y = 0;
		w = 0.5; h = 0.05;
		onLBSelChanged = "_this call lobby_fnc_selectParameterSet";
	};

	//
	// PARAMETER LIST
	//
	class BulwarkParamsParameterList : RscControlsTable
	{
		idc = 200;
		x = 0.025; y = 0.075;
		w = 0.95; h = 0.85;
		colorBackground[] = COLOR_HALF_PINK;

	    lineSpacing = 0;
	    rowHeight = 0.05;
	    headerHeight = 0.05;

		class HeaderTemplate
		{
			class HeaderBackground
			{
				controlBaseClassPath[] = {"RscText"};
				columnX = 0;
				columnW = 0.9;
				controlH = 0.1;
				controlOffsetY = 0;
				colorBackground[] = COLOR_HALF_PINK;
			};

			class HeaderNameText
			{
				controlBaseClassPath[] = {"RscText"};
				columnX = 0;
				columnW = 0.45;
				controlH = 0.1;
				controlOffsetY = 0;
				text = "Parameter Name";
			};

			class HeaderValueText
			{
				controlBaseClassPath[] = {"RscText"};
				columnX = 0.5;
				columnW = 0.45;
				controlH = 0.1;
				controlOffsetY = 0;
				text = "Value";
			};
		};

		class RowTemplate
		{
			class RowBackground
			{
				controlBaseClassPath[] = {"RscText"};
				columnX = 0;
				columnW = 0.9;
				controlH = 0.1;
				controlOffsetY = 0;
			};

			class RowNameText
			{
				controlBaseClassPath[] = {"RscText"};
				columnX = 0;
				columnW = 0.45;
				controlH = 0.1;
				controlOffsetY = 0;
				text = "Parameter Name";
			};

			class RowValueText
			{
				controlBaseClassPath[] = {"RscText"};
				columnX = 0.5;
				columnW = 0.45;
				controlH = 0.1;
				controlOffsetY = 0;
				text = "Value";
			};

			class RowChangeButton
			{
				controlBaseClassPath[] = {"RscButton"};
				columnX = 0.8;
				columnW = 0.1;
				controlH = 0.1;
				controlOffsetY = 0;
			};
		};
	};

	//
	// FOOTER
	//
	class BulwarkParamsCloseButton : RscButton
	{
		colorBackground[] = COLOR_GREEN;
		colorText[] = COLOR_WHITE;

		idc=1;
		x = 0.8; y = 0.95;
		w = 0.2; h = 0.05;
		text="OK";
	};

	class BulwarkParamsSaveAsButton : RscButton
	{
		colorBackground[] = COLOR_TRANSPARENT;
		colorText[] = COLOR_WHITE;

		idc=4;
		x = 0.6; y = 0.95;
		w = 0.2; h = 0.05;
		text="Save As...";
		action = "call lobby_fnc_saveParameterSetAs";
	};

	class BulwarkParamsSaveButton : RscButton
	{
		colorBackground[] = COLOR_TRANSPARENT;
		colorText[] = COLOR_WHITE;
		colorBackgroundDisabled[] = COLOR_DISABLED_BACKGROUND;
		colorDisabled[] = COLOR_DISABLED_TEXT;

		idc=3;
		x = 0.4; y = 0.95;
		w = 0.2; h = 0.05;
		text="Save";
		action = "call lobby_fnc_saveParameterSet";
	};
};

class bulwarkSaveParamsAs_Dialog
{
	idd = 9997;
	movingEnabled = false;

	controls[] = {
		BulwarkParamCloseButton,
		BulwarkParamSaveButton,
		NameEntry
	};

	controlsBackground[] = {
		BulwarkParamBackground,
		BulwarkParamTitle,
		BulwarkParamDescription
	};

	class BulwarkParamBackground : RscText
	{
		idc = -1;
		x = 0.2; y = 0.2;
		w = 0.6; h = 0.6;
		colorBackground[] = COLOR_HALF_BLACK;
	};

	class BulwarkParamTitle : RscText
	{
		idc = 1;
		x = 0.2; y = 0.2;
		w = 0.6; h = 0.05;
		colorBackground[] = COLOR_DARK_GREEN;
		text = "Change <param>";
	};

	class BulwarkParamDescription : RscStructuredText
	{
		x = 0.2; y = 0.275;
		w = 0.6; h = 0.325;
		colorBackground[] = COLOR_HALF_BLACK;
		text = "Enter a name to save this profile under";
	};

	class NameEntry : RscEdit
	{
		idc = 100;
		x = 0.3; y = 0.625;
		w = 0.4; h = 0.05;
		colorBackground[] = COLOR_HALF_BLACK;
		colorText[] = COLOR_WHITE;
		text = "";
	};

	//
	// FOOTER
	//
	class BulwarkParamCloseButton : RscButton
	{
		colorBackground[] = COLOR_RED;
		colorText[] = COLOR_WHITE;

		idc=2;
		x = 0.2; y = 0.75;
		w = 0.2; h = 0.05;
		text="Cancel";
	};

	class BulwarkParamSaveButton : RscButton
	{
		colorBackground[] = COLOR_GREEN;
		colorText[] = COLOR_WHITE;

		idc=3;
		x = 0.6; y = 0.75;
		w = 0.2; h = 0.05;
		text="Save";
		action="call lobby_fnc_btnDoSaveAs";
	};
};

class bulwarkParam_Dialog
{
	idd = 9998;
	movingEnabled = false;

	controls[] = {
		BulwarkParamCloseButton
	};

	controlsBackground[] = {
		BulwarkParamBackground,
		BulwarkParamTitle,
		BulwarkParamDescription
	};

	//
	// HEADER
	//
	class BulwarkParamBackground : RscText
	{
		idc = -1;
		x = 0.2; y = 0.2;
		w = 0.6; h = 0.6;
		colorBackground[] = COLOR_HALF_BLACK;
	};

	class BulwarkParamTitle : RscText
	{
		idc = 1;
		x = 0.2; y = 0.2;
		w = 0.6; h = 0.05;
		colorBackground[] = COLOR_DARK_GREEN;
		text = "Change <param>";
	};

	class BulwarkParamDescription : RscStructuredText
	{
		idc = 2;
		x = 0.2; y = 0.275;
		w = 0.6; h = 0.325;
		colorBackground[] = COLOR_HALF_BLACK;
		text = "Some description that is really long and should wrap";
	};

	//
	// FOOTER
	//
	class BulwarkParamCloseButton : RscButton
	{
		colorBackground[] = COLOR_GREEN;
		colorText[] = COLOR_WHITE;

		idc=3;
		x = 0.6; y = 0.75;
		w = 0.2; h = 0.05;
		text="OK";
	};
};

class bulwarkParamEdit_Dialog : BulwarkParam_Dialog
{
	controls[] = {
		BulwarkParamCloseButton,
		NumberEntry
	};

	class NumberEntry : RscEdit
	{
		idc = 100;
		x = 0.3; y = 0.625;
		w = 0.4; h = 0.05;
		colorBackground[] = COLOR_HALF_BLACK;
		colorText[] = COLOR_WHITE;
		text = "";
	};
};

class bulwarkParamSelect_Dialog : BulwarkParam_Dialog
{
	controls[] = {
		BulwarkParamCloseButton,
		SelectBox
	};

	class SelectBox : RscCombo
	{
		idc = 100;
		x = 0.3; y = 0.625;
		w = 0.4; h = 0.05;
		colorBackground[] = COLOR_HALF_BLACK;
		colorText[] = COLOR_WHITE;
	};
};

class bulwarkParamMultiSelect_Dialog : BulwarkParam_Dialog
{
	controls[] = {
		BulwarkParamCloseButton,
		MultiSelectBox
	};

	//
	// HEADER
	//
	class BulwarkParamBackground : RscText
	{
		idc = -1;
		x = 0.2; y = 0.1;
		w = 0.6; h = 0.8;
		colorBackground[] = COLOR_HALF_BLACK;
	};

	class BulwarkParamTitle : RscText
	{
		idc = 1;
		x = 0.2; y = 0.1;
		w = 0.6; h = 0.05;
		colorBackground[] = COLOR_DARK_GREEN;
		text = "Change <param>";
	};

	class BulwarkParamDescription : RscStructuredText
	{
		idc = 2;
		x = 0.2; y = 0.175;
		w = 0.6; h = 0.325;
		colorBackground[] = COLOR_HALF_BLACK;
		text = "Some description that is really long and should wrap";
	};

    //
	// FOOTER
	//
	class BulwarkParamCloseButton : RscButton
	{
		colorBackground[] = COLOR_GREEN;
		colorText[] = COLOR_WHITE;

		idc=3;
		x = 0.6; y = 0.85;
		w = 0.2; h = 0.05;
		text="OK";
	};

	//
	// PARAMETER LIST
	//
	class MultiSelectBox : RscControlsTable
	{
		idc = 100;
		x = 0.3; y = 0.525;
		w = 0.4; h = 0.25;
		colorBackground[] = COLOR_HALF_PINK;
    	lineSpacing = 0;
	    rowHeight = 0.05;
	    headerHeight = 0.0;
		class HeaderTemplate
		{
		};
		class RowTemplate
		{
			class RowBackground
			{
				controlBaseClassPath[] = {"RscText"};
				columnX = 0;
				columnW = 0.4;
				controlW = 0.4;
				controlH = 0.1;
				controlOffsetY = 0;
			};
			class RowCheck
			{
				controlBaseClassPath[] = {"RscCheckbox"};
				columnX = 0;
				columnW = 0.05;
				controlW = 0.05;
				controlH = 0.1;
				controlOffsetY = 0;
				checked = 0;
			};
			class RowValueText
			{
				controlBaseClassPath[] = {"RscText"};
				columnX = 0.05;
				columnW = 0.35;
				controlW = 0.35;
				controlH = 0.1;
				controlOffsetY = 0;
				text = "Value";
			};
		};
	};
};
