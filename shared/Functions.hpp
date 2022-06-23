class shared
{
    class public
    {
        file = "shared\functions";
	class log {};
        class getCurrentParamValue {};
        class getDefaultParameterSets {};
        class getDefaultParams {};

        class getConfigEntryAsNumber {};
        class getConfigEntryAsString {};
    };

    class internal
    {
        file = "shared\functions";
        class getNumberFromString {};
        class padString {};

        class getProfileParam {};
        class setProfileParam {};

        class loadParameterSet {};
        class saveParameterSet {};
        class getParameterSets {};

        class loadSelectedParameterSet {};
        class saveSelectedParameterSet {};
        class setSavedParameterSets {};
        class getSavedParameterSets {};
    };
};
