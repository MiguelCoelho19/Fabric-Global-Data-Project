[DefaultOutputDestinationSettings = [DestinationDefinition = [Kind = "Reference", QueryName = "DefaultDestination", IsNewTarget = true], UpdateMethod = [Kind = "Replace"], DestinationTypeSettings = [Kind = "Table"]], StagingDefinition = [Kind = "FastCopy"]]
section Section1;
[DataDestinations = {[Definition = [Kind = "Reference", QueryName = "Population by Illiteracy_DataDestination", IsNewTarget = true], Settings = [Kind = "Manual", AllowCreation = true, ColumnSettings = [Mappings = {[SourceColumnName = "Year", DestinationColumnName = "Year"], [SourceColumnName = "Value", DestinationColumnName = "Value"], [SourceColumnName = "country_code", DestinationColumnName = "country_code"]}], DynamicSchema = true, UpdateMethod = [Kind = "Replace"], TypeSettings = [Kind = "Table"]]]}]
shared #"Population by Illiteracy" = let
  Source = Lakehouse.Contents(null),
  Navigation = Source{[workspaceId = "336a3dcc-c24a-497c-8a80-a8fefb6face9"]}[Data],
  #"Navigation 1" = Navigation{[lakehouseId = "91c1f691-8f6a-4cd4-96e7-adb18f7e60a1"]}[Data],
  #"Navigation 2" = #"Navigation 1"{[Id = "p_un_literacy", ItemKind = "Table"]}[Data],
  #"Removed columns" = Table.RemoveColumns(#"Navigation 2", {"table_code", "reliability_code", "reliability", "column_19", "record_type", "record_type_code"}),
  #"Filtered rows" = Table.SelectRows(#"Removed columns", each ([sex] = "Both Sexes") and ([area] = "Total") and ([age] = "10 - 14" or [age] = "100 +" or [age] = "15 - 19" or [age] = "20 - 24" or [age] = "25 - 29" or [age] = "30 - 34" or [age] = "35 - 39" or [age] = "40 - 44" or [age] = "45 - 49" or [age] = "50 - 54" or [age] = "55 - 59" or [age] = "60 - 64" or [age] = "65 - 69" or [age] = "70 - 74" or [age] = "75 - 79" or [age] = "80 - 84" or [age] = "85 - 89" or [age] = "90 - 94" or [age] = "95 - 99")),
  #"Removed columns 1" = Table.RemoveColumns(#"Filtered rows", {"area_code", "area", "sex_code", "sex", "code_of_age"}),
  #"Changed column type" = Table.TransformColumnTypes(#"Removed columns 1", {{"value", Int64.Type}}),
  #"Pivoted column" = Table.Pivot(Table.TransformColumnTypes(#"Changed column type", {{"age", type text}}), List.Distinct(Table.TransformColumnTypes(#"Changed column type", {{"age", type text}})[age]), "age", "value", List.Min),
  #"Replaced value" = Table.ReplaceValue(#"Pivoted column", null, 0, Replacer.ReplaceValue, {"95 - 99", "35 - 39", "25 - 29", "70 - 74", "10 - 14", "50 - 54", "40 - 44", "45 - 49", "60 - 64", "85 - 89", "65 - 69", "100 +", "15 - 19", "30 - 34", "80 - 84", "20 - 24", "75 - 79", "55 - 59", "90 - 94"}),
  #"Added custom" = Table.AddColumn(#"Replaced value", "Value", each [#"95 - 99"]+[#"35 - 39"]+[#"25 - 29"]+[#"70 - 74"]+[#"10 - 14"]+[#"50 - 54"]+[#"40 - 44"]+[#"45 - 49"]+[#"60 - 64"]+[#"85 - 89"]+[#"65 - 69"]+[#"100 +"]+[#"15 - 19"]+[#"30 - 34"]+[#"80 - 84"]+[#"20 - 24"]+[#"75 - 79"]+[#"55 - 59"]+[#"90 - 94"]),
  #"Changed column type 1" = Table.TransformColumnTypes(#"Added custom", {{"Value", Int64.Type}}),
  #"Removed columns 2" = Table.RemoveColumns(#"Changed column type 1", {"90 - 94", "55 - 59", "75 - 79", "20 - 24", "80 - 84", "30 - 34", "15 - 19", "100 +", "65 - 69", "85 - 89", "60 - 64", "45 - 49", "40 - 44", "50 - 54", "10 - 14", "70 - 74", "25 - 29", "35 - 39", "95 - 99", "code_of_literacy"}),
  #"Pivoted column 1" = Table.Pivot(Table.TransformColumnTypes(#"Removed columns 2", {{"literacy", type text}}), List.Distinct(Table.TransformColumnTypes(#"Removed columns 2", {{"literacy", type text}})[literacy]), "literacy", "Value"),
  #"Filtered rows 1" = Table.SelectRows(#"Pivoted column 1", each [Total] <> null and [Literate] <> null),
  #"Replaced value 1" = Table.ReplaceValue(#"Filtered rows 1", null, 0, Replacer.ReplaceValue, {"Illiterate"}),
  #"Added custom 1" = Table.TransformColumnTypes(Table.AddColumn(#"Replaced value 1", "Value", each [Illiterate] / [Total]), {{"Value", Percentage.Type}}),
  #"Removed columns 3" = Table.RemoveColumns(#"Added custom 1", {"Literate", "Illiterate", "Unknown", "Total", "reference_date", "source_year"}),
  #"Merged queries" = Table.NestedJoin(#"Removed columns 3", {"country_or_area_code"}, #"countries csv", {"ref_area"}, "countries csv", JoinKind.LeftOuter),
  #"Expanded countries csv" = Table.ExpandTableColumn(#"Merged queries", "countries csv", {"country_code", "country_name"}, {"country_code", "country_name"}),
  #"Filtered rows 2" = Table.SelectRows(#"Expanded countries csv", each ([country_name] <> null)),
  #"Removed columns 4" = Table.RemoveColumns(#"Filtered rows 2", {"country_or_area", "country_name", "country_or_area_code"}),
  #"Renamed columns" = Table.RenameColumns(#"Removed columns 4", {{"year", "Year"}})
in
  #"Renamed columns";
[DataDestinations = {[Definition = [Kind = "Reference", QueryName = "Population by Type of Living Quarters_DataDestination", IsNewTarget = true], Settings = [Kind = "Manual", AllowCreation = true, ColumnSettings = [Mappings = {[SourceColumnName = "Year", DestinationColumnName = "Year"], [SourceColumnName = "Housing units", DestinationColumnName = "Housing units"], [SourceColumnName = "Collective living quarters", DestinationColumnName = "Collective living quarters"], [SourceColumnName = "Roofless", DestinationColumnName = "Roofless"], [SourceColumnName = "Unknown", DestinationColumnName = "Unknown"], [SourceColumnName = "country_code", DestinationColumnName = "country_code"]}], DynamicSchema = true, UpdateMethod = [Kind = "Replace"], TypeSettings = [Kind = "Table"]]]}]
shared #"Population by Type of Living Quarters" = let
  Source = Lakehouse.Contents(null),
  Navigation = Source{[workspaceId = "336a3dcc-c24a-497c-8a80-a8fefb6face9"]}[Data],
  #"Navigation 1" = Navigation{[lakehouseId = "91c1f691-8f6a-4cd4-96e7-adb18f7e60a1"]}[Data],
  #"Navigation 2" = #"Navigation 1"{[Id = "p_un_quarters", ItemKind = "Table"]}[Data],
  #"Removed columns" = Table.RemoveColumns(#"Navigation 2", {"table_code", "record_type_code", "record_type", "reliability", "reliability_code", "column_19"}),
  #"Filtered rows" = Table.SelectRows(#"Removed columns", each ([area] = "Total") and ([sex] = "Both Sexes")),
  #"Removed columns 1" = Table.RemoveColumns(#"Filtered rows", {"reference_date", "area_code", "area", "sex_code", "sex", "code_of_age", "code_of_type_of_living_quarters", "source_year"}),
  #"Filtered rows 1" = Table.SelectRows(#"Removed columns 1", each ([age] = "Total")),
  #"Removed columns 2" = Table.RemoveColumns(#"Filtered rows 1", {"age"}),
  #"Pivoted column" = Table.Pivot(Table.TransformColumnTypes(#"Removed columns 2", {{"type_of_living_quarters", type text}}), List.Distinct(Table.TransformColumnTypes(#"Removed columns 2", {{"type_of_living_quarters", type text}})[type_of_living_quarters]), "type_of_living_quarters", "value"),
  #"Filtered rows 2" = Table.SelectRows(#"Pivoted column", each ([Total] <> null)),
  #"Replaced value" = Table.ReplaceValue(#"Filtered rows 2", null, "0", Replacer.ReplaceValue, {"Collective living quarters", "Roofless", "Unknown"}),
  #"Renamed columns" = Table.RenameColumns(#"Replaced value", {{"Housing units", "Housing units2"}, {"Collective living quarters", "Collective living quarters2"}, {"Roofless", "Roofless2"}, {"Unknown", "Unknown2"}}),
  #"Changed column type" = Table.TransformColumnTypes(#"Renamed columns", {{"Housing units2", Int64.Type}, {"Total", Int64.Type}, {"Collective living quarters2", Int64.Type}, {"Roofless2", Int64.Type}, {"Unknown2", Int64.Type}}),
  #"Added custom" = Table.TransformColumnTypes(Table.AddColumn(#"Changed column type", "Housing units", each [Housing units2] / [Total]), {{"Housing units", Percentage.Type}}),
  #"Added custom 1" = Table.TransformColumnTypes(Table.AddColumn(#"Added custom", "Collective living quarters", each [Collective living quarters2] / [Total]), {{"Collective living quarters", Percentage.Type}}),
  #"Added custom 2" = Table.TransformColumnTypes(Table.AddColumn(#"Added custom 1", "Roofless", each [Roofless2] / [Total]), {{"Roofless", Percentage.Type}}),
  #"Added custom 3" = Table.TransformColumnTypes(Table.AddColumn(#"Added custom 2", "Unknown", each [Unknown2] / [Total]), {{"Unknown", Percentage.Type}}),
  #"Removed columns 3" = Table.RemoveColumns(#"Added custom 3", {"Collective living quarters2", "Roofless2", "Unknown2", "Total", "Housing units2"}),
  #"Merged queries" = Table.NestedJoin(#"Removed columns 3", {"country_or_area_code"}, #"countries csv", {"ref_area"}, "countries csv", JoinKind.LeftOuter),
  #"Expanded countries csv" = Table.ExpandTableColumn(#"Merged queries", "countries csv", {"country_code", "country_name"}, {"country_code", "country_name"}),
  #"Filtered rows 3" = Table.SelectRows(#"Expanded countries csv", each ([country_name] <> null)),
  #"Removed columns 4" = Table.RemoveColumns(#"Filtered rows 3", {"country_or_area", "country_name", "country_or_area_code"}),
  #"Renamed columns 1" = Table.RenameColumns(#"Removed columns 4", {{"year", "Year"}})
in
  #"Renamed columns 1";
[BindToDefaultDestination = true]
shared #"Food price inflation" = let
  Source = Lakehouse.Contents(null),
  Navigation = Source{[workspaceId = "336a3dcc-c24a-497c-8a80-a8fefb6face9"]}[Data],
  #"Navigation 1" = Navigation{[lakehouseId = "91c1f691-8f6a-4cd4-96e7-adb18f7e60a1"]}[Data],
  #"Navigation 2" = #"Navigation 1"{[Id = "p_wb_price_indices", ItemKind = "Table"]}[Data],
  #"Removed columns" = Table.RemoveColumns(#"Navigation 2", {"FREQ", "FREQ_LABEL", "DATABASE_ID", "DATABASE_ID_LABEL", "UNIT_MULT", "UNIT_MULT_LABEL", "OBS_STATUS", "OBS_STATUS_LABEL", "OBS_CONF", "OBS_CONF_LABEL"}),
  #"Filtered rows" = Table.SelectRows(#"Removed columns", each ([INDICATOR_LABEL] = "Food price inflation")),
  #"Removed columns 1" = Table.RemoveColumns(#"Filtered rows", {"INDICATOR", "INDICATOR_LABEL", "UNIT_MEASURE", "UNIT_MEASURE_LABEL", "AGG_METHOD_LABEL", "AGG_METHOD"}),
  #"Inserted average" = Table.AddColumn(#"Removed columns 1", "2000", each List.Average({[2000_01], [2000_02], [2000_03], [2000_04], [2000_05], [2000_06], [2000_07], [2000_08], [2000_09], [2000_10], [2000_11], [2000_12]}), type nullable number),
  #"Inserted average 1" = Table.AddColumn(#"Inserted average", "2001", each List.Average({[2001_01], [2001_02], [2001_03], [2001_04], [2001_05], [2001_06], [2001_07], [2001_08], [2001_09], [2001_10], [2001_11], [2001_12]}), type nullable number),
  #"Inserted average 2" = Table.AddColumn(#"Inserted average 1", "2002", each List.Average({[2002_01], [2002_02], [2002_03], [2002_04], [2002_05], [2002_06], [2002_07], [2002_08], [2002_09], [2002_10], [2002_11], [2002_12]}), type nullable number),
  #"Inserted average 3" = Table.AddColumn(#"Inserted average 2", "2003", each List.Average({[2003_01], [2003_02], [2003_03], [2003_04], [2003_05], [2003_06], [2003_07], [2003_08], [2003_09], [2003_10], [2003_11], [2003_12]}), type nullable number),
  #"Inserted average 4" = Table.AddColumn(#"Inserted average 3", "2004", each List.Average({[2004_01], [2004_02], [2004_03], [2004_04], [2004_05], [2004_06], [2004_07], [2004_08], [2004_09], [2004_10], [2004_11], [2004_12]}), type nullable number),
  #"Inserted average 5" = Table.AddColumn(#"Inserted average 4", "2005", each List.Average({[2005_01], [2005_02], [2005_03], [2005_04], [2005_05], [2005_06], [2005_07], [2005_08], [2005_09], [2005_10], [2005_11], [2005_12]}), type nullable number),
  #"Inserted average 6" = Table.AddColumn(#"Inserted average 5", "2006", each List.Average({[2006_01], [2006_02], [2006_03], [2006_04], [2006_05], [2006_06], [2006_07], [2006_08], [2006_09], [2006_10], [2006_11], [2006_12]}), type nullable number),
  #"Inserted average 7" = Table.AddColumn(#"Inserted average 6", "2007", each List.Average({[2007_01], [2007_02], [2007_03], [2007_04], [2007_05], [2007_06], [2007_07], [2007_08], [2007_09], [2007_10], [2007_11], [2007_12]}), type nullable number),
  #"Inserted average 8" = Table.AddColumn(#"Inserted average 7", "2008", each List.Average({[2008_01], [2008_02], [2008_03], [2008_04], [2008_05], [2008_06], [2008_07], [2008_08], [2008_09], [2008_10], [2008_11], [2008_12]}), type nullable number),
  #"Inserted average 9" = Table.AddColumn(#"Inserted average 8", "2009", each List.Average({[2009_01], [2009_02], [2009_03], [2009_04], [2009_05], [2009_06], [2009_07], [2009_08], [2009_09], [2009_10], [2009_11], [2009_12]}), type nullable number),
  #"Inserted average 10" = Table.AddColumn(#"Inserted average 9", "2010", each List.Average({[2010_01], [2010_02], [2010_03], [2010_04], [2010_05], [2010_06], [2010_07], [2010_08], [2010_09], [2010_10], [2010_11], [2010_12]}), type nullable number),
  #"Inserted average 11" = Table.AddColumn(#"Inserted average 10", "2011", each List.Average({[2011_01], [2011_02], [2011_03], [2011_04], [2011_05], [2011_06], [2011_07], [2011_08], [2011_09], [2011_10], [2011_11], [2011_12]}), type nullable number),
  #"Inserted average 12" = Table.AddColumn(#"Inserted average 11", "2012", each List.Average({[2012_01], [2012_02], [2012_03], [2012_04], [2012_05], [2012_06], [2012_07], [2012_08], [2012_09], [2012_10], [2012_11], [2012_12]}), type nullable number),
  #"Inserted average 13" = Table.AddColumn(#"Inserted average 12", "2013", each List.Average({[2013_01], [2013_02], [2013_03], [2013_04], [2013_05], [2013_06], [2013_07], [2013_08], [2013_09], [2013_10], [2013_11], [2013_12]}), type nullable number),
  #"Inserted average 14" = Table.AddColumn(#"Inserted average 13", "2014", each List.Average({[2014_01], [2014_02], [2014_03], [2014_04], [2014_05], [2014_06], [2014_07], [2014_08], [2014_09], [2014_10], [2014_11], [2014_12]}), type nullable number),
  #"Inserted average 15" = Table.AddColumn(#"Inserted average 14", "2015", each List.Average({[2015_01], [2015_02], [2015_03], [2015_04], [2015_05], [2015_06], [2015_07], [2015_08], [2015_09], [2015_10], [2015_11], [2015_12]}), type nullable number),
  #"Inserted average 16" = Table.AddColumn(#"Inserted average 15", "2016", each List.Average({[2016_01], [2016_02], [2016_03], [2016_04], [2016_05], [2016_06], [2016_07], [2016_08], [2016_09], [2016_10], [2016_11], [2016_12]}), type nullable number),
  #"Inserted average 17" = Table.AddColumn(#"Inserted average 16", "2017", each List.Average({[2017_01], [2017_02], [2017_03], [2017_04], [2017_05], [2017_06], [2017_07], [2017_08], [2017_09], [2017_10], [2017_11], [2017_12]}), type nullable number),
  #"Inserted average 18" = Table.AddColumn(#"Inserted average 17", "2018", each List.Average({[2018_01], [2018_02], [2018_03], [2018_04], [2018_05], [2018_06], [2018_07], [2018_08], [2018_09], [2018_10], [2018_11], [2018_12]}), type nullable number),
  #"Inserted average 19" = Table.AddColumn(#"Inserted average 18", "2019", each List.Average({[2019_01], [2019_02], [2019_03], [2019_04], [2019_05], [2019_06], [2019_07], [2019_08], [2019_09], [2019_10], [2019_11], [2019_12]}), type nullable number),
  #"Inserted average 20" = Table.AddColumn(#"Inserted average 19", "2020", each List.Average({[2020_01], [2020_02], [2020_03], [2020_04], [2020_05], [2020_06], [2020_07], [2020_08], [2020_09], [2020_10], [2020_11], [2020_12]}), type nullable number),
  #"Inserted average 21" = Table.AddColumn(#"Inserted average 20", "2021", each List.Average({[2021_01], [2021_02], [2021_03], [2021_04], [2021_05], [2021_06], [2021_07], [2021_08], [2021_09], [2021_10], [2021_11], [2021_12]}), type nullable number),
  #"Inserted average 22" = Table.AddColumn(#"Inserted average 21", "2022", each List.Average({[2022_01], [2022_02], [2022_03], [2022_04], [2022_05], [2022_06], [2022_07], [2022_08], [2022_09], [2022_10], [2022_11], [2022_12]}), type nullable number),
  #"Inserted average 23" = Table.AddColumn(#"Inserted average 22", "2023", each List.Average({[2023_01], [2023_02], [2023_03], [2023_04], [2023_05], [2023_06], [2023_07], [2023_08], [2023_09], [2023_10], [2023_11], [2023_12]}), type nullable number),
  #"Inserted average 24" = Table.AddColumn(#"Inserted average 23", "2024", each List.Average({[2024_01], [2024_02], [2024_03], [2024_04], [2024_05], [2024_06], [2024_07], [2024_08], [2024_09], [2024_10], [2024_11], [2024_12]}), type nullable number),
  #"Inserted average 25" = Table.AddColumn(#"Inserted average 24", "2025", each List.Average({[2025_01], [2025_02], [2025_03], [2025_04], [2025_05], [2025_06], [2025_07], [2025_08], [2025_09]}), type nullable number),
  #"Removed columns 2" = Table.RemoveColumns(#"Inserted average 25", {"2000_01", "2000_02", "2000_03", "2000_04", "2000_05", "2000_06", "2000_07", "2000_08", "2000_09", "2000_10", "2000_11", "2000_12", "2001_01", "2001_02", "2001_03", "2001_04", "2001_05", "2001_06", "2001_07", "2001_08", "2001_09", "2001_10", "2001_11", "2001_12", "2002_01", "2002_02", "2002_03", "2002_04", "2002_05", "2002_06", "2002_07", "2002_08", "2002_09", "2002_10", "2002_11", "2002_12", "2003_01", "2003_02", "2003_03", "2003_04", "2003_05", "2003_06", "2003_07", "2003_08", "2003_09", "2003_10", "2003_11", "2003_12", "2004_01", "2004_02", "2004_03", "2004_04", "2004_05", "2004_06", "2004_07", "2004_08", "2004_09", "2004_10", "2004_11", "2004_12", "2005_01", "2005_02", "2005_03", "2005_04", "2005_05", "2005_06", "2005_07", "2005_08", "2005_09", "2005_10", "2005_11", "2005_12", "2006_01", "2006_02", "2006_03", "2006_04", "2006_05", "2006_06", "2006_07", "2006_08", "2006_09", "2006_10", "2006_11", "2006_12", "2007_01", "2007_02", "2007_03", "2007_04", "2007_05", "2007_06", "2007_07", "2007_08", "2007_09", "2007_10", "2007_11", "2007_12", "2008_01", "2008_02", "2008_03", "2008_04", "2008_05", "2008_06", "2008_07", "2008_08", "2008_09", "2008_10", "2008_11", "2008_12", "2009_01", "2009_02", "2009_03", "2009_04", "2009_05", "2009_06", "2009_07", "2009_08", "2009_09", "2009_10", "2009_11", "2009_12", "2010_01", "2010_02", "2010_03", "2010_04", "2010_05", "2010_06", "2010_07", "2010_08", "2010_09", "2010_10", "2010_11", "2010_12", "2011_01", "2011_02", "2011_03", "2011_04", "2011_05", "2011_06", "2011_07", "2011_08", "2011_09", "2011_10", "2011_11", "2011_12", "2012_01", "2012_02", "2012_03", "2012_04", "2012_05", "2012_06", "2012_07", "2012_08", "2012_09", "2012_10", "2012_11", "2012_12", "2013_01", "2013_02", "2013_03", "2013_04", "2013_05", "2013_06", "2013_07", "2013_08", "2013_09", "2013_10", "2013_11", "2013_12", "2014_01", "2014_02", "2014_03", "2014_04", "2014_05", "2014_06", "2014_07", "2014_08", "2014_09", "2014_10", "2014_11", "2014_12", "2015_01", "2015_02", "2015_03", "2015_04", "2015_05", "2015_06", "2015_07", "2015_08", "2015_09", "2015_10", "2015_11", "2015_12", "2016_01", "2016_02", "2016_03", "2016_04", "2016_05", "2016_06", "2016_07", "2016_08", "2016_09", "2016_10", "2016_11", "2016_12", "2017_01", "2017_02", "2017_03", "2017_04", "2017_05", "2017_06", "2017_07", "2017_08", "2017_09", "2017_10", "2017_11", "2017_12", "2018_01", "2018_02", "2018_03", "2018_04", "2018_05", "2018_06", "2018_07", "2018_08", "2018_09", "2018_10", "2018_11", "2018_12", "2019_01", "2019_02", "2019_03", "2019_04", "2019_05", "2019_06", "2019_07", "2019_08", "2019_09", "2019_10", "2019_11", "2019_12", "2020_01", "2020_02", "2020_03", "2020_04", "2020_05", "2020_06", "2020_07", "2020_08", "2020_09", "2020_10", "2020_11", "2020_12", "2021_01", "2021_02", "2021_03", "2021_04", "2021_05", "2021_06", "2021_07", "2021_08", "2021_09", "2021_10", "2021_11", "2021_12", "2022_01", "2022_02", "2022_03", "2022_04", "2022_05", "2022_06", "2022_07", "2022_08", "2022_09", "2022_10", "2022_11", "2022_12", "2023_01", "2023_02", "2023_03", "2023_04", "2023_05", "2023_06", "2023_07", "2023_08", "2023_09", "2023_10", "2023_11", "2023_12", "2024_01", "2024_02", "2024_03", "2024_04", "2024_05", "2024_06", "2024_07", "2024_08", "2024_09", "2024_10", "2024_11", "2024_12", "2025_01", "2025_02", "2025_03", "2025_04", "2025_05", "2025_06", "2025_07", "2025_08", "2025_09"}),
  #"Unpivoted other columns" = Table.UnpivotOtherColumns(#"Removed columns 2", {"REF_AREA", "REF_AREA_LABEL"}, "Year", "Value"),
  #"Divided column" = Table.TransformColumns(#"Unpivoted other columns", {{"Value", each _ / 100, type number}}),
  #"Changed column type" = Table.TransformColumnTypes(#"Divided column", {{"Value", Percentage.Type}}),
  #"Merged queries" = Table.NestedJoin(#"Changed column type", {"REF_AREA"}, #"countries csv", {"country_code"}, "countries csv", JoinKind.LeftOuter),
  #"Expanded countries csv" = Table.ExpandTableColumn(#"Merged queries", "countries csv", {"country_name"}, {"country_name"}),
  #"Filtered rows 1" = Table.SelectRows(#"Expanded countries csv", each ([country_name] <> null)),
  #"Removed columns 3" = Table.RemoveColumns(#"Filtered rows 1", {"REF_AREA_LABEL", "country_name"}),
  #"Renamed columns" = Table.RenameColumns(#"Removed columns 3", {{"REF_AREA", "country_code"}})
in
  #"Renamed columns";
[DataDestinations = {[Definition = [Kind = "Reference", QueryName = "Population by School Attendance_DataDestination", IsNewTarget = true], Settings = [Kind = "Manual", AllowCreation = true, ColumnSettings = [Mappings = {[SourceColumnName = "Year", DestinationColumnName = "Year"], [SourceColumnName = "Not attending school", DestinationColumnName = "Not attending school"], [SourceColumnName = "country_code", DestinationColumnName = "country_code"]}], DynamicSchema = true, UpdateMethod = [Kind = "Replace"], TypeSettings = [Kind = "Table"]]]}]
shared #"Population by School Attendance" = let
  Source = Lakehouse.Contents(null),
  Navigation = Source{[workspaceId = "336a3dcc-c24a-497c-8a80-a8fefb6face9"]}[Data],
  #"Navigation 1" = Navigation{[lakehouseId = "91c1f691-8f6a-4cd4-96e7-adb18f7e60a1"]}[Data],
  #"Navigation 2" = #"Navigation 1"{[Id = "r_un_attendance", ItemKind = "Table"]}[Data],
  #"Removed columns" = Table.RemoveColumns(#"Navigation 2", {"table_code", "record_type_code", "record_type", "reliability_code", "reliability", "column_19", "reference_date", "area_code", "sex_code", "code_of_age", "code_of_school_attendance", "source_year"}),
  #"Filtered rows" = Table.SelectRows(#"Removed columns", each ([area] = "Total") and ([sex] = "Both Sexes")),
  #"Removed columns 1" = Table.RemoveColumns(#"Filtered rows", {"area", "sex"}),
  #"Filtered rows 1" = Table.SelectRows(#"Removed columns 1", each ([age] = "10" or [age] = "11" or [age] = "12" or [age] = "13" or [age] = "14" or [age] = "15" or [age] = "16" or [age] = "17" or [age] = "18" or [age] = "19" or [age] = "20" or [age] = "21" or [age] = "22" or [age] = "23" or [age] = "24" or [age] = "5" or [age] = "6" or [age] = "7" or [age] = "8" or [age] = "9")),
  #"Pivoted column 1" = Table.Pivot(Table.TransformColumnTypes(#"Filtered rows 1", {{"age", type text}}), List.Distinct(Table.TransformColumnTypes(#"Filtered rows 1", {{"age", type text}})[age]), "age", "value"),
  #"Replaced value" = Table.ReplaceValue(#"Pivoted column 1", null, "0", Replacer.ReplaceValue, {"20", "6", "11", "12", "22", "8", "18", "24", "5", "9", "10", "13", "14", "21", "16", "7", "15", "19", "23", "17"}),
  #"Changed column type" = Table.TransformColumnTypes(#"Replaced value", {{"17", Int64.Type}, {"23", Int64.Type}, {"19", Int64.Type}, {"15", Int64.Type}, {"7", Int64.Type}, {"16", Int64.Type}, {"21", Int64.Type}, {"14", Int64.Type}, {"13", Int64.Type}, {"10", Int64.Type}, {"9", Int64.Type}, {"5", Int64.Type}, {"24", Int64.Type}, {"18", Int64.Type}, {"8", Int64.Type}, {"22", Int64.Type}, {"12", Int64.Type}, {"11", Int64.Type}, {"6", Int64.Type}, {"20", Int64.Type}}),
  #"Added custom" = Table.TransformColumnTypes(Table.AddColumn(#"Changed column type", "Value", each [20]+[6]+[11]+[12]+[22]+[8]+[18]+[24]+[5]+[9]+[10]+[13]+[14]+[21]+[16]+[7]+[15]+[19]+[23]+[17]), {{"Value", Int64.Type}}),
  #"Removed columns 2" = Table.RemoveColumns(#"Added custom", {"17", "23", "19", "15", "7", "16", "21", "14", "13", "10", "9", "5", "24", "18", "8", "22", "12", "11", "6", "20"}),
  #"Pivoted column" = Table.Pivot(Table.TransformColumnTypes(#"Removed columns 2", {{"school_attendance", type text}}), List.Distinct(Table.TransformColumnTypes(#"Removed columns 2", {{"school_attendance", type text}})[school_attendance]), "school_attendance", "Value"),
  #"Replaced value 1" = Table.ReplaceValue(#"Pivoted column", null, 0, Replacer.ReplaceValue, {"Not attending school"}),
  #"Added custom 1" = Table.TransformColumnTypes(Table.AddColumn(#"Replaced value 1", "Value", each ([Not attending school])/[Total]), {{"Value", Percentage.Type}}),
  #"Removed columns 3" = Table.RemoveColumns(#"Added custom 1", {"Attending school", "Not attending school", "Not stated", "Total"}),
  #"Renamed columns" = Table.RenameColumns(#"Removed columns 3", {{"Value", "Not attending school"}}),
  #"Merged queries" = Table.NestedJoin(#"Renamed columns", {"country_or_area_code"}, #"countries csv", {"ref_area"}, "countries csv", JoinKind.LeftOuter),
  #"Expanded countries csv" = Table.ExpandTableColumn(#"Merged queries", "countries csv", {"country_code", "country_name"}, {"country_code", "country_name"}),
  #"Filtered rows 2" = Table.SelectRows(#"Expanded countries csv", each ([country_name] <> null)),
  #"Removed columns 4" = Table.RemoveColumns(#"Filtered rows 2", {"country_or_area", "country_name", "country_or_area_code"}),
  #"Renamed columns 1" = Table.RenameColumns(#"Removed columns 4", {{"year", "Year"}})
in
  #"Renamed columns 1";
[BindToDefaultDestination = true]
shared #"Population with food insecurity" = let
  Source = Lakehouse.Contents(null),
  Navigation = Source{[workspaceId = "336a3dcc-c24a-497c-8a80-a8fefb6face9"]}[Data],
  #"Navigation 1" = Navigation{[lakehouseId = "91c1f691-8f6a-4cd4-96e7-adb18f7e60a1"]}[Data],
  #"Navigation 2" = #"Navigation 1"{[Id = "p_wb_food", ItemKind = "Table"]}[Data],
  #"Removed columns" = Table.RemoveColumns(#"Navigation 2", {"STRUCTURE", "STRUCTURE_ID", "ACTION", "FREQ", "INDICATOR", "SEX", "AGE", "URBANISATION", "UNIT_MEASURE", "COMP_BREAKDOWN_1", "COMP_BREAKDOWN_2", "COMP_BREAKDOWN_3", "AGG_METHOD", "UNIT_TYPE", "DECIMALS", "DATABASE_ID", "TIME_FORMAT", "COMMENT_TS", "UNIT_MULT", "DATA_SOURCE", "OBS_CONF", "OBS_STATUS", "FREQ_LABEL", "INDICATOR_LABEL", "SEX_LABEL", "AGE_LABEL", "URBANISATION_LABEL", "UNIT_MEASURE_LABEL", "COMP_BREAKDOWN_3_LABEL", "COMP_BREAKDOWN_1_LABEL", "COMP_BREAKDOWN_2_LABEL", "AGG_METHOD_LABEL", "UNIT_TYPE_LABEL", "DECIMALS_LABEL", "DATABASE_ID_LABEL", "TIME_FORMAT_LABEL", "UNIT_MULT_LABEL", "OBS_STATUS_LABEL", "OBS_CONF_LABEL"}),
  #"Unpivoted columns" = Table.UnpivotOtherColumns(#"Removed columns", {"REF_AREA", "REF_AREA_LABEL"}, "Year", "Value"),
  #"Divided column" = Table.TransformColumns(#"Unpivoted columns", {{"Value", each _ / 100, type number}}),
  #"Changed column type" = Table.TransformColumnTypes(#"Divided column", {{"Value", Percentage.Type}}),
  #"Merged queries" = Table.NestedJoin(#"Changed column type", {"REF_AREA"}, #"countries csv", {"country_code"}, "countries csv", JoinKind.LeftOuter),
  #"Expanded countries csv" = Table.ExpandTableColumn(#"Merged queries", "countries csv", {"country_name"}, {"country_name"}),
  #"Filtered rows" = Table.SelectRows(#"Expanded countries csv", each ([country_name] <> null)),
  #"Removed columns 1" = Table.RemoveColumns(#"Filtered rows", {"REF_AREA_LABEL", "country_name"}),
  #"Renamed columns" = Table.RenameColumns(#"Removed columns 1", {{"REF_AREA", "country_code"}})
in
  #"Renamed columns";
[BindToDefaultDestination = true]
shared #"Population in poverty" = let
  Source = Lakehouse.Contents(null),
  Navigation = Source{[workspaceId = "336a3dcc-c24a-497c-8a80-a8fefb6face9"]}[Data],
  #"Navigation 1" = Navigation{[lakehouseId = "91c1f691-8f6a-4cd4-96e7-adb18f7e60a1"]}[Data],
  #"Navigation 2" = #"Navigation 1"{[Id = "p_wb_ratio", ItemKind = "Table"]}[Data],
  #"Removed columns" = Table.RemoveColumns(#"Navigation 2", {"STRUCTURE", "STRUCTURE_ID", "ACTION", "FREQ", "INDICATOR", "SEX", "AGE", "URBANISATION", "UNIT_MEASURE", "COMP_BREAKDOWN_1", "COMP_BREAKDOWN_2", "COMP_BREAKDOWN_3", "AGG_METHOD", "UNIT_TYPE", "DECIMALS", "DATABASE_ID", "TIME_FORMAT", "COMMENT_TS", "UNIT_MULT", "DATA_SOURCE", "OBS_CONF", "OBS_STATUS", "FREQ_LABEL", "INDICATOR_LABEL", "SEX_LABEL", "AGE_LABEL", "URBANISATION_LABEL", "UNIT_MEASURE_LABEL", "COMP_BREAKDOWN_1_LABEL", "COMP_BREAKDOWN_2_LABEL", "COMP_BREAKDOWN_3_LABEL", "AGG_METHOD_LABEL", "UNIT_TYPE_LABEL", "DECIMALS_LABEL", "DATABASE_ID_LABEL", "TIME_FORMAT_LABEL", "UNIT_MULT_LABEL", "OBS_STATUS_LABEL", "OBS_CONF_LABEL"}),
  #"Unpivoted columns" = Table.UnpivotOtherColumns(#"Removed columns", {"REF_AREA", "REF_AREA_LABEL"}, "Year", "Value"),
  #"Divided column" = Table.TransformColumns(#"Unpivoted columns", {{"Value", each _ / 100, type number}}),
  #"Changed column type" = Table.TransformColumnTypes(#"Divided column", {{"Value", Percentage.Type}}),
  #"Merged queries" = Table.NestedJoin(#"Changed column type", {"REF_AREA"}, #"countries csv", {"country_code"}, "countries csv", JoinKind.LeftOuter),
  #"Expanded countries csv" = Table.ExpandTableColumn(#"Merged queries", "countries csv", {"country_name"}, {"country_name"}),
  #"Filtered rows" = Table.SelectRows(#"Expanded countries csv", each ([country_name] <> null)),
  #"Removed columns 1" = Table.RemoveColumns(#"Filtered rows", {"REF_AREA_LABEL", "country_name"}),
  #"Renamed columns" = Table.RenameColumns(#"Removed columns 1", {{"REF_AREA", "country_code"}})
in
  #"Renamed columns";
[BindToDefaultDestination = true]
shared #"Population using safely managed sanitation services" = let
  Source = Lakehouse.Contents(null),
  Navigation = Source{[workspaceId = "336a3dcc-c24a-497c-8a80-a8fefb6face9"]}[Data],
  #"Navigation 1" = Navigation{[lakehouseId = "91c1f691-8f6a-4cd4-96e7-adb18f7e60a1"]}[Data],
  #"Navigation 2" = #"Navigation 1"{[Id = "p_wb_sanitation", ItemKind = "Table"]}[Data],
  #"Removed columns" = Table.RemoveColumns(#"Navigation 2", {"STRUCTURE", "STRUCTURE_ID", "ACTION", "FREQ", "INDICATOR", "SEX", "AGE", "URBANISATION", "UNIT_MEASURE", "COMP_BREAKDOWN_1", "COMP_BREAKDOWN_2", "COMP_BREAKDOWN_3", "AGG_METHOD", "UNIT_TYPE", "DECIMALS", "DATABASE_ID", "TIME_FORMAT", "COMMENT_TS", "UNIT_MULT", "DATA_SOURCE", "OBS_CONF", "OBS_STATUS", "FREQ_LABEL", "INDICATOR_LABEL", "SEX_LABEL", "AGE_LABEL", "URBANISATION_LABEL", "UNIT_MEASURE_LABEL", "COMP_BREAKDOWN_1_LABEL", "COMP_BREAKDOWN_2_LABEL", "COMP_BREAKDOWN_3_LABEL", "AGG_METHOD_LABEL", "UNIT_TYPE_LABEL", "DECIMALS_LABEL", "DATABASE_ID_LABEL", "TIME_FORMAT_LABEL", "UNIT_MULT_LABEL", "OBS_STATUS_LABEL", "OBS_CONF_LABEL"}),
  #"Unpivoted columns" = Table.UnpivotOtherColumns(#"Removed columns", {"REF_AREA", "REF_AREA_LABEL"}, "Year", "Value"),
  #"Divided column" = Table.TransformColumns(#"Unpivoted columns", {{"Value", each _ / 100, type number}}),
  #"Changed column type" = Table.TransformColumnTypes(#"Divided column", {{"Value", Percentage.Type}}),
  #"Merged queries" = Table.NestedJoin(#"Changed column type", {"REF_AREA"}, #"countries csv", {"country_code"}, "countries csv", JoinKind.LeftOuter),
  #"Expanded countries csv" = Table.ExpandTableColumn(#"Merged queries", "countries csv", {"country_name"}, {"country_name"}),
  #"Filtered rows" = Table.SelectRows(#"Expanded countries csv", each ([country_name] <> null)),
  #"Renamed columns" = Table.RenameColumns(#"Filtered rows", {{"REF_AREA", "ref_area"}}),
  #"Removed columns 1" = Table.RemoveColumns(#"Renamed columns", {"REF_AREA_LABEL", "country_name"}),
  #"Renamed columns 1" = Table.RenameColumns(#"Removed columns 1", {{"ref_area", "country_code"}})
in
  #"Renamed columns 1";
[BindToDefaultDestination = true]
shared #"Population living in slums" = let
  Source = Lakehouse.Contents(null),
  Navigation = Source{[workspaceId = "336a3dcc-c24a-497c-8a80-a8fefb6face9"]}[Data],
  #"Navigation 1" = Navigation{[lakehouseId = "91c1f691-8f6a-4cd4-96e7-adb18f7e60a1"]}[Data],
  #"Navigation 2" = #"Navigation 1"{[Id = "p_wb_slums", ItemKind = "Table"]}[Data],
  #"Removed columns" = Table.RemoveColumns(#"Navigation 2", {"STRUCTURE", "STRUCTURE_ID", "ACTION", "FREQ", "INDICATOR", "SEX", "AGE", "URBANISATION", "UNIT_MEASURE", "COMP_BREAKDOWN_1", "COMP_BREAKDOWN_2", "COMP_BREAKDOWN_3", "AGG_METHOD", "UNIT_TYPE", "DECIMALS", "DATABASE_ID", "TIME_FORMAT", "COMMENT_TS", "UNIT_MULT", "DATA_SOURCE", "OBS_CONF", "OBS_STATUS", "FREQ_LABEL", "INDICATOR_LABEL", "SEX_LABEL", "AGE_LABEL", "URBANISATION_LABEL", "UNIT_MEASURE_LABEL", "COMP_BREAKDOWN_1_LABEL", "COMP_BREAKDOWN_2_LABEL", "COMP_BREAKDOWN_3_LABEL", "AGG_METHOD_LABEL", "UNIT_TYPE_LABEL", "DECIMALS_LABEL", "DATABASE_ID_LABEL", "TIME_FORMAT_LABEL", "UNIT_MULT_LABEL", "OBS_STATUS_LABEL", "OBS_CONF_LABEL"}),
  #"Unpivoted other columns" = Table.UnpivotOtherColumns(#"Removed columns", {"REF_AREA", "REF_AREA_LABEL"}, "Year", "Value"),
  #"Divided column" = Table.TransformColumns(#"Unpivoted other columns", {{"Value", each _ / 100, type number}}),
  #"Changed column type" = Table.TransformColumnTypes(#"Divided column", {{"Value", Percentage.Type}}),
  #"Merged queries" = Table.NestedJoin(#"Changed column type", {"REF_AREA"}, #"countries csv", {"country_code"}, "countries csv", JoinKind.LeftOuter),
  #"Expanded countries csv" = Table.ExpandTableColumn(#"Merged queries", "countries csv", {"country_name"}, {"country_name"}),
  #"Filtered rows" = Table.SelectRows(#"Expanded countries csv", each ([country_name] <> null)),
  #"Renamed columns" = Table.RenameColumns(#"Filtered rows", {{"REF_AREA", "ref_area"}}),
  #"Removed columns 1" = Table.RemoveColumns(#"Renamed columns", {"REF_AREA_LABEL", "country_name"}),
  #"Renamed columns 1" = Table.RenameColumns(#"Removed columns 1", {{"ref_area", "country_code"}})
in
  #"Renamed columns 1";
shared #"countries csv" = let
  Source = Lakehouse.Contents(null),
  Navigation = Source{[workspaceId = "336a3dcc-c24a-497c-8a80-a8fefb6face9"]}[Data],
  #"Navigation 1" = Navigation{[lakehouseId = "91c1f691-8f6a-4cd4-96e7-adb18f7e60a1"]}[Data],
  #"Navigation 2" = #"Navigation 1"{[Id = "Files", ItemKind = "Folder"]}[Data],
  #"Navigation 3" = #"Navigation 2"{[Name = "countries.csv"]}[Content],
  #"Imported CSV" = Csv.Document(#"Navigation 3", [Delimiter = ",", Columns = 3, Encoding = 65001, QuoteStyle = QuoteStyle.None]),
  #"Promoted headers" = Table.PromoteHeaders(#"Imported CSV", [PromoteAllScalars = true]),
  #"Changed column type" = Table.TransformColumnTypes(#"Promoted headers", {{"country_code", type text}, {"ref_area", Int64.Type}, {"country_name", type text}}),
  #"Changed column type 1" = Table.TransformColumnTypes(#"Changed column type", {{"ref_area", type text}})
in
  #"Changed column type 1";
shared DefaultDestination = Lakehouse.Contents([EnableFolding = false]){[workspaceId = "336a3dcc-c24a-497c-8a80-a8fefb6face9"]}[Data]{[lakehouseId = "49958665-f44c-42aa-aeb9-9a260ada0e2f"]}[Data];
shared #"Population by Illiteracy_DataDestination" = let
  Pattern = Lakehouse.Contents([HierarchicalNavigation = null, CreateNavigationProperties = false, EnableFolding = false]),
  Navigation_1 = Pattern{[workspaceId = "336a3dcc-c24a-497c-8a80-a8fefb6face9"]}[Data],
  Navigation_2 = Navigation_1{[lakehouseId = "49958665-f44c-42aa-aeb9-9a260ada0e2f"]}[Data],
  TableNavigation = Navigation_2{[Id = "Population by Illiteracy", ItemKind = "Table"]}?[Data]?
in
  TableNavigation;
shared #"Population by School Attendance_DataDestination" = let
  Pattern = Lakehouse.Contents([HierarchicalNavigation = null, CreateNavigationProperties = false, EnableFolding = false]),
  Navigation_1 = Pattern{[workspaceId = "336a3dcc-c24a-497c-8a80-a8fefb6face9"]}[Data],
  Navigation_2 = Navigation_1{[lakehouseId = "49958665-f44c-42aa-aeb9-9a260ada0e2f"]}[Data],
  TableNavigation = Navigation_2{[Id = "Population by School Attendance", ItemKind = "Table"]}?[Data]?
in
  TableNavigation;
shared #"Population by Type of Living Quarters_DataDestination" = let
  Pattern = Lakehouse.Contents([HierarchicalNavigation = null, CreateNavigationProperties = false, EnableFolding = false]),
  Navigation_1 = Pattern{[workspaceId = "336a3dcc-c24a-497c-8a80-a8fefb6face9"]}[Data],
  Navigation_2 = Navigation_1{[lakehouseId = "49958665-f44c-42aa-aeb9-9a260ada0e2f"]}[Data],
  TableNavigation = Navigation_2{[Id = "Population by Type of Living Quarters", ItemKind = "Table"]}?[Data]?
in
  TableNavigation;
