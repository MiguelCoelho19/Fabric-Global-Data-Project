[DefaultOutputDestinationSettings = [DestinationDefinition = [Kind = "Reference", QueryName = "DefaultDestination", IsNewTarget = true], UpdateMethod = [Kind = "Replace"], DestinationTypeSettings = [Kind = "Table"]], StagingDefinition = [Kind = "FastCopy"]]
section Section1;
[BindToDefaultDestination = true]
shared #"Renewable Energy Score" = let
  Source = Lakehouse.Contents(null),
  Navigation = Source{[workspaceId = "336a3dcc-c24a-497c-8a80-a8fefb6face9"]}[Data],
  #"Navigation 1" = Navigation{[lakehouseId = "91c1f691-8f6a-4cd4-96e7-adb18f7e60a1"]}[Data],
  #"Navigation 2" = #"Navigation 1"{[Id = "r_wb_energy", ItemKind = "Table"]}[Data],
  #"Removed columns" = Table.RemoveColumns(#"Navigation 2", {"FREQ", "FREQ_LABEL", "ACTION", "STRUCTURE_ID", "STRUCTURE", "REF_AREA_LABEL", "INDICATOR", "INDICATOR_LABEL", "SEX", "SEX_LABEL", "AGE", "AGE_LABEL", "URBANISATION", "URBANISATION_LABEL", "UNIT_MEASURE", "UNIT_MEASURE_LABEL", "COMP_BREAKDOWN_1", "COMP_BREAKDOWN_1_LABEL", "COMP_BREAKDOWN_2", "COMP_BREAKDOWN_2_LABEL", "COMP_BREAKDOWN_3", "COMP_BREAKDOWN_3_LABEL", "DATABASE_ID", "DATABASE_ID_LABEL", "UNIT_MULT", "UNIT_MULT_LABEL", "UNIT_TYPE", "UNIT_TYPE_LABEL", "TIME_FORMAT", "TIME_FORMAT_LABEL", "OBS_STATUS", "OBS_STATUS_LABEL", "OBS_CONF_LABEL", "OBS_CONF"}),
  #"Renamed columns 3" = Table.RenameColumns(#"Removed columns", {{"TIME_PERIOD", "Year"}}),
  #"Changed column type" = Table.TransformColumnTypes(#"Renamed columns 3", {{"Year", Int64.Type}}),
  #"Renamed columns" = Table.RenameColumns(#"Changed column type", {{"Year", "YEAR"}, {"OBS_VALUE", "VALUE"}}),
  #"Renamed columns 2" = Table.RenameColumns(#"Renamed columns", {{"REF_AREA", "Ref_Area"}, {"YEAR", "Year"}, {"VALUE", "Value"}}),
  #"Rounded off" = Table.TransformColumns(#"Renamed columns 2", {{"Value", each Number.Round(_, 2), type number}}),
  #"Merged queries" = Table.NestedJoin(#"Rounded off", {"Ref_Area"}, Countries, {"Country_Code"}, "Countries", JoinKind.LeftOuter),
  #"Expanded Countries" = Table.ExpandTableColumn(#"Merged queries", "Countries", {"Country_Name"}, {"Country_Name"}),
  #"Filtered rows" = Table.SelectRows(#"Expanded Countries", each ([Country_Name] <> null)),
  #"Removed columns 1" = Table.RemoveColumns(#"Filtered rows", {"Country_Name"})
in
  #"Removed columns 1";
[BindToDefaultDestination = true]
shared #"GNI per capita" = let
  Source = Lakehouse.Contents(null),
  Navigation = Source{[workspaceId = "336a3dcc-c24a-497c-8a80-a8fefb6face9"]}[Data],
  #"Navigation 1" = Navigation{[lakehouseId = "91c1f691-8f6a-4cd4-96e7-adb18f7e60a1"]}[Data],
  #"Navigation 2" = #"Navigation 1"{[Id = "r_wb_gni", ItemKind = "Table"]}[Data],
  #"Removed columns" = Table.RemoveColumns(#"Navigation 2", {"STRUCTURE", "STRUCTURE_ID", "ACTION", "FREQ", "FREQ_LABEL", "REF_AREA_LABEL", "INDICATOR", "INDICATOR_LABEL", "SEX", "SEX_LABEL", "AGE", "AGE_LABEL", "URBANISATION", "URBANISATION_LABEL", "UNIT_MEASURE", "UNIT_MEASURE_LABEL", "COMP_BREAKDOWN_1", "COMP_BREAKDOWN_1_LABEL", "COMP_BREAKDOWN_2", "COMP_BREAKDOWN_2_LABEL", "COMP_BREAKDOWN_3", "COMP_BREAKDOWN_3_LABEL", "AGG_METHOD", "AGG_METHOD_LABEL", "DECIMALS", "DECIMALS_LABEL", "DATABASE_ID", "DATABASE_ID_LABEL", "COMMENT_TS", "UNIT_MULT", "UNIT_MULT_LABEL", "DATA_SOURCE", "DATA_SOURCE_LABEL", "UNIT_TYPE", "UNIT_TYPE_LABEL", "TIME_FORMAT", "TIME_FORMAT_LABEL", "COMMENT_OBS", "OBS_STATUS", "OBS_STATUS_LABEL", "OBS_CONF", "OBS_CONF_LABEL"}),
  #"Renamed columns 2" = Table.RenameColumns(#"Removed columns", {{"TIME_PERIOD", "Attribute"}, {"OBS_VALUE", "Value"}}),
  #"Changed column type" = Table.TransformColumnTypes(#"Renamed columns 2", {{"Attribute", Int64.Type}}),
  #"Renamed columns" = Table.RenameColumns(#"Changed column type", {{"Attribute", "YEAR"}, {"Value", "VALUE"}}),
  #"Renamed columns 1" = Table.RenameColumns(#"Renamed columns", {{"REF_AREA", "Ref_Area"}, {"YEAR", "Year"}, {"VALUE", "Value"}}),
  #"Changed column type 1" = Table.TransformColumnTypes(#"Renamed columns 1", {{"Value", Currency.Type}}),
  #"Merged queries" = Table.NestedJoin(#"Changed column type 1", {"Ref_Area"}, Countries, {"Country_Code"}, "Countries", JoinKind.LeftOuter),
  #"Expanded Countries" = Table.ExpandTableColumn(#"Merged queries", "Countries", {"Country_Name"}, {"Country_Name"}),
  #"Filtered rows" = Table.SelectRows(#"Expanded Countries", each ([Country_Name] <> null)),
  #"Removed columns 2" = Table.RemoveColumns(#"Filtered rows", {"Country_Name"})
in
  #"Removed columns 2";
[BindToDefaultDestination = true]
shared #"Life Expectancy After Birth" = let
  Source = Lakehouse.Contents(null),
  Navigation = Source{[workspaceId = "336a3dcc-c24a-497c-8a80-a8fefb6face9"]}[Data],
  #"Navigation 1" = Navigation{[lakehouseId = "91c1f691-8f6a-4cd4-96e7-adb18f7e60a1"]}[Data],
  #"Navigation 2" = #"Navigation 1"{[Id = "r_wb_lifeexpectancy", ItemKind = "Table"]}[Data],
  #"Removed columns" = Table.RemoveColumns(#"Navigation 2", {"OBS_CONF_LABEL", "OBS_STATUS_LABEL", "UNIT_MULT_LABEL", "TIME_FORMAT_LABEL", "DATABASE_ID_LABEL", "DECIMALS_LABEL", "UNIT_TYPE_LABEL", "AGG_METHOD_LABEL", "COMP_BREAKDOWN_3_LABEL", "COMP_BREAKDOWN_2_LABEL", "COMP_BREAKDOWN_1_LABEL", "UNIT_MEASURE_LABEL", "URBANISATION_LABEL", "AGE_LABEL", "SEX_LABEL", "INDICATOR_LABEL", "FREQ_LABEL", "OBS_STATUS", "OBS_CONF", "DATA_SOURCE", "UNIT_MULT", "COMMENT_TS", "TIME_FORMAT", "DATABASE_ID", "DECIMALS", "UNIT_TYPE", "AGG_METHOD", "COMP_BREAKDOWN_3", "COMP_BREAKDOWN_2", "COMP_BREAKDOWN_1", "UNIT_MEASURE", "URBANISATION", "AGE", "SEX", "INDICATOR", "FREQ", "ACTION", "STRUCTURE_ID", "STRUCTURE"}),
  #"Unpivoted other columns" = Table.UnpivotOtherColumns(#"Removed columns", {"REF_AREA_LABEL", "REF_AREA"}, "Attribute", "Value"),
  #"Changed column type" = Table.TransformColumnTypes(#"Unpivoted other columns", {{"Attribute", Int64.Type}}),
  #"Renamed columns" = Table.RenameColumns(#"Changed column type", {{"Attribute", "YEAR"}, {"Value", "VALUE"}}),
  #"Removed columns 1" = Table.RemoveColumns(#"Renamed columns", {"REF_AREA_LABEL"}),
  #"Renamed columns 1" = Table.RenameColumns(#"Removed columns 1", {{"REF_AREA", "Ref_Area"}, {"YEAR", "Year"}, {"VALUE", "Value"}}),
  #"Rounded off" = Table.TransformColumns(#"Renamed columns 1", {{"Value", each Number.Round(_, 2), type number}}),
  #"Merged queries" = Table.NestedJoin(#"Rounded off", {"Ref_Area"}, Countries, {"Country_Code"}, "Countries", JoinKind.LeftOuter),
  #"Expanded Countries" = Table.ExpandTableColumn(#"Merged queries", "Countries", {"Country_Code", "Country_Name"}, {"Country_Code", "Country_Name"}),
  #"Filtered rows" = Table.SelectRows(#"Expanded Countries", each ([Country_Name] <> null)),
  #"Removed columns 2" = Table.RemoveColumns(#"Filtered rows", {"Country_Code", "Country_Name"})
in
  #"Removed columns 2";
[BindToDefaultDestination = true]
shared #"Public Education Spending" = let
  Source = Lakehouse.Contents(null),
  Navigation = Source{[workspaceId = "336a3dcc-c24a-497c-8a80-a8fefb6face9"]}[Data],
  #"Navigation 1" = Navigation{[lakehouseId = "91c1f691-8f6a-4cd4-96e7-adb18f7e60a1"]}[Data],
  #"Navigation 2" = #"Navigation 1"{[Id = "s_wb_education", ItemKind = "Table"]}[Data],
  #"Removed columns" = Table.RemoveColumns(#"Navigation 2", {"STRUCTURE", "STRUCTURE_ID", "ACTION", "FREQ", "FREQ_LABEL", "REF_AREA_LABEL", "INDICATOR", "INDICATOR_LABEL", "SEX", "SEX_LABEL", "AGE", "AGE_LABEL", "URBANISATION", "URBANISATION_LABEL", "UNIT_MEASURE", "UNIT_MEASURE_LABEL", "COMP_BREAKDOWN_1", "COMP_BREAKDOWN_1_LABEL", "COMP_BREAKDOWN_2", "COMP_BREAKDOWN_2_LABEL", "COMP_BREAKDOWN_3", "COMP_BREAKDOWN_3_LABEL", "DATABASE_ID", "DATABASE_ID_LABEL", "UNIT_MULT", "UNIT_MULT_LABEL", "UNIT_TYPE", "UNIT_TYPE_LABEL", "TIME_FORMAT", "TIME_FORMAT_LABEL", "OBS_STATUS", "OBS_STATUS_LABEL", "OBS_CONF", "OBS_CONF_LABEL"}),
  #"Renamed columns 2" = Table.RenameColumns(#"Removed columns", {{"TIME_PERIOD", "Attribute"}, {"OBS_VALUE", "Value"}}),
  #"Changed column type" = Table.TransformColumnTypes(#"Renamed columns 2", {{"Attribute", Int64.Type}}),
  #"Renamed columns" = Table.RenameColumns(#"Changed column type", {{"Attribute", "YEAR"}, {"Value", "VALUE"}}),
  #"Renamed columns 1" = Table.RenameColumns(#"Renamed columns", {{"REF_AREA", "Ref_Area"}, {"YEAR", "Year"}, {"VALUE", "Value"}}),
  #"Changed column type 1" = Table.TransformColumnTypes(#"Renamed columns 1", {{"Value", Currency.Type}}),
  #"Filtered rows" = Table.SelectRows(#"Changed column type 1", each ([Value] <> null))
in
  #"Filtered rows";
[BindToDefaultDestination = true]
shared #"Public Health Spending" = let
  Source = Lakehouse.Contents(null),
  Navigation = Source{[workspaceId = "336a3dcc-c24a-497c-8a80-a8fefb6face9"]}[Data],
  #"Navigation 1" = Navigation{[lakehouseId = "91c1f691-8f6a-4cd4-96e7-adb18f7e60a1"]}[Data],
  #"Navigation 2" = #"Navigation 1"{[Id = "s_wb_health", ItemKind = "Table"]}[Data],
  #"Removed columns" = Table.RemoveColumns(#"Navigation 2", {"OBS_CONF_LABEL", "OBS_STATUS_LABEL", "UNIT_MULT_LABEL", "TIME_FORMAT_LABEL", "DATABASE_ID_LABEL", "DECIMALS_LABEL", "UNIT_TYPE_LABEL", "AGG_METHOD_LABEL", "COMP_BREAKDOWN_3_LABEL", "COMP_BREAKDOWN_2_LABEL", "COMP_BREAKDOWN_1_LABEL", "UNIT_MEASURE_LABEL", "URBANISATION_LABEL", "AGE_LABEL", "SEX_LABEL", "INDICATOR_LABEL", "FREQ_LABEL", "OBS_STATUS", "OBS_CONF", "DATA_SOURCE", "UNIT_MULT", "COMMENT_TS", "TIME_FORMAT", "DATABASE_ID", "DECIMALS", "UNIT_TYPE", "AGG_METHOD", "COMP_BREAKDOWN_3", "COMP_BREAKDOWN_2", "COMP_BREAKDOWN_1", "UNIT_MEASURE", "URBANISATION", "AGE", "SEX", "INDICATOR", "FREQ", "ACTION", "STRUCTURE_ID", "STRUCTURE"}),
  #"Unpivoted other columns" = Table.UnpivotOtherColumns(#"Removed columns", {"REF_AREA", "REF_AREA_LABEL"}, "Attribute", "Value"),
  #"Renamed columns" = Table.RenameColumns(#"Unpivoted other columns", {{"Attribute", "YEAR"}, {"Value", "VALUE"}}),
  #"Changed column type" = Table.TransformColumnTypes(#"Renamed columns", {{"YEAR", Int64.Type}}),
  #"Removed columns 1" = Table.RemoveColumns(#"Changed column type", {"REF_AREA_LABEL"}),
  #"Renamed columns 1" = Table.RenameColumns(#"Removed columns 1", {{"REF_AREA", "Ref_Area"}, {"YEAR", "Year"}, {"VALUE", "Value"}}),
  #"Changed column type 1" = Table.TransformColumnTypes(#"Renamed columns 1", {{"Value", Currency.Type}}),
  #"Merged queries" = Table.NestedJoin(#"Changed column type 1", {"Ref_Area"}, Countries, {"Country_Code"}, "Countries", JoinKind.LeftOuter),
  #"Expanded Countries" = Table.ExpandTableColumn(#"Merged queries", "Countries", {"Country_Name"}, {"Country_Name"}),
  #"Filtered rows" = Table.SelectRows(#"Expanded Countries", each ([Country_Name] <> null)),
  #"Removed columns 2" = Table.RemoveColumns(#"Filtered rows", {"Country_Name"})
in
  #"Removed columns 2";
[BindToDefaultDestination = true]
shared #"Research and Development Spending" = let
  Source = Lakehouse.Contents(null),
  Navigation = Source{[workspaceId = "336a3dcc-c24a-497c-8a80-a8fefb6face9"]}[Data],
  #"Navigation 1" = Navigation{[lakehouseId = "91c1f691-8f6a-4cd4-96e7-adb18f7e60a1"]}[Data],
  #"Navigation 2" = #"Navigation 1"{[Id = "s_wb_research", ItemKind = "Table"]}[Data],
  #"Removed columns" = Table.RemoveColumns(#"Navigation 2", {"STRUCTURE", "STRUCTURE_ID", "ACTION", "FREQ", "INDICATOR", "SEX", "AGE", "URBANISATION", "UNIT_MEASURE", "COMP_BREAKDOWN_1", "COMP_BREAKDOWN_2", "COMP_BREAKDOWN_3", "AGG_METHOD", "UNIT_TYPE", "DECIMALS", "DATABASE_ID", "TIME_FORMAT", "COMMENT_TS", "UNIT_MULT", "DATA_SOURCE", "OBS_CONF", "OBS_STATUS", "FREQ_LABEL", "INDICATOR_LABEL", "SEX_LABEL", "AGE_LABEL", "URBANISATION_LABEL", "UNIT_MEASURE_LABEL", "COMP_BREAKDOWN_1_LABEL", "COMP_BREAKDOWN_2_LABEL", "COMP_BREAKDOWN_3_LABEL", "AGG_METHOD_LABEL", "UNIT_TYPE_LABEL", "DECIMALS_LABEL", "DATABASE_ID_LABEL", "TIME_FORMAT_LABEL", "UNIT_MULT_LABEL", "OBS_STATUS_LABEL", "OBS_CONF_LABEL"}),
  #"Renamed columns 3" = Table.RenameColumns(#"Removed columns", {{"TIME_PERIOD", "Attribute"}, {"OBS_VALUE", "Value"}}),
  #"Renamed columns" = Table.RenameColumns(#"Renamed columns 3", {{"Attribute", "YEAR"}}),
  #"Changed column type" = Table.TransformColumnTypes(#"Renamed columns", {{"YEAR", Int64.Type}}),
  #"Renamed columns 1" = Table.RenameColumns(#"Changed column type", {{"Value", "VALUE"}}),
  #"Removed columns 1" = Table.RemoveColumns(#"Renamed columns 1", {"REF_AREA_LABEL"}),
  #"Renamed columns 2" = Table.RenameColumns(#"Removed columns 1", {{"REF_AREA", "Ref_Area"}, {"YEAR", "Year"}, {"VALUE", "Value"}}),
  #"Divided column" = Table.TransformColumns(#"Renamed columns 2", {{"Value", each _ / 100, type number}}),
  #"Changed column type 1" = Table.TransformColumnTypes(#"Divided column", {{"Value", Percentage.Type}}),
  #"Merged queries" = Table.NestedJoin(#"Changed column type 1", {"Ref_Area"}, Countries, {"Country_Code"}, "Countries", JoinKind.LeftOuter),
  #"Expanded Countries" = Table.ExpandTableColumn(#"Merged queries", "Countries", {"Country_Name"}, {"Country_Name"}),
  #"Filtered rows" = Table.SelectRows(#"Expanded Countries", each ([Country_Name] <> null)),
  #"Removed columns 2" = Table.RemoveColumns(#"Filtered rows", {"Country_Name"})
in
  #"Removed columns 2";
[BindToDefaultDestination = true]
shared #"GDP Social Protection Spending" = let
  Source = Lakehouse.Contents(null),
  Navigation = Source{[workspaceId = "336a3dcc-c24a-497c-8a80-a8fefb6face9"]}[Data],
  #"Navigation 1" = Navigation{[lakehouseId = "91c1f691-8f6a-4cd4-96e7-adb18f7e60a1"]}[Data],
  #"Navigation 2" = #"Navigation 1"{[Id = "s_wb_social", ItemKind = "Table"]}[Data],
  #"Filtered rows 2" = Table.SelectRows(#"Navigation 2", each ([COMP_BREAKDOWN_1_LABEL] = "Type: Value")),
  #"Removed columns" = Table.RemoveColumns(#"Filtered rows 2", {"STRUCTURE", "STRUCTURE_ID", "ACTION", "FREQ", "FREQ_LABEL", "INDICATOR", "INDICATOR_LABEL", "SEX", "SEX_LABEL", "AGE", "AGE_LABEL", "URBANISATION", "URBANISATION_LABEL", "UNIT_MEASURE", "UNIT_MEASURE_LABEL", "COMP_BREAKDOWN_1", "COMP_BREAKDOWN_1_LABEL", "COMP_BREAKDOWN_2", "COMP_BREAKDOWN_2_LABEL", "COMP_BREAKDOWN_3", "COMP_BREAKDOWN_3_LABEL", "DATABASE_ID", "DATABASE_ID_LABEL", "UNIT_MULT", "UNIT_MULT_LABEL", "UNIT_TYPE", "UNIT_TYPE_LABEL", "TIME_FORMAT", "TIME_FORMAT_LABEL", "COMMENT_OBS", "OBS_STATUS", "OBS_STATUS_LABEL", "OBS_CONF", "OBS_CONF_LABEL", "REF_AREA_LABEL"}),
  #"Renamed columns" = Table.RenameColumns(#"Removed columns", {{"REF_AREA", "Ref_Area"}}),
  #"Filtered rows" = Table.SelectRows(#"Renamed columns", each ([OBS_VALUE] <> null)),
  #"Merged queries" = Table.NestedJoin(#"Filtered rows", {"Ref_Area"}, Countries, {"Country_Code"}, "Countries", JoinKind.LeftOuter),
  #"Expanded Countries" = Table.ExpandTableColumn(#"Merged queries", "Countries", {"Country_Name"}, {"Country_Name"}),
  #"Filtered rows 1" = Table.SelectRows(#"Expanded Countries", each ([Country_Name] <> null)),
  #"Removed columns 1" = Table.RemoveColumns(#"Filtered rows 1", {"Country_Name"}),
  #"Renamed columns 1" = Table.RenameColumns(#"Removed columns 1", {{"OBS_VALUE", "Value"}, {"TIME_PERIOD", "Year"}}),
  #"Divided column" = Table.TransformColumns(#"Renamed columns 1", {{"Value", each _ / 100, type number}}),
  #"Changed column type" = Table.TransformColumnTypes(#"Divided column", {{"Value", Percentage.Type}})
in
  #"Changed column type";
[DataDestinations = {[Definition = [Kind = "Reference", QueryName = "Countries_DataDestination", IsNewTarget = true], Settings = [Kind = "Manual", AllowCreation = true, ColumnSettings = [Mappings = {[SourceColumnName = "Country_Code", DestinationColumnName = "Country_Code"], [SourceColumnName = "Country_Name", DestinationColumnName = "Country_Name"]}], DynamicSchema = true, UpdateMethod = [Kind = "Replace"], TypeSettings = [Kind = "Table"]]]}]
shared Countries = let
  Source = Lakehouse.Contents(null),
  Navigation = Source{[workspaceId = "336a3dcc-c24a-497c-8a80-a8fefb6face9"]}[Data],
  #"Navigation 1" = Navigation{[lakehouseId = "91c1f691-8f6a-4cd4-96e7-adb18f7e60a1"]}[Data],
  #"Navigation 2" = #"Navigation 1"{[Id = "Files", ItemKind = "Folder"]}[Data],
  #"Navigation 3" = #"Navigation 2"{[Name = "countries.csv"]}[Content],
  #"Imported CSV" = Csv.Document(#"Navigation 3", [Delimiter = ",", Columns = 4, Encoding = 65001, QuoteStyle = QuoteStyle.None]),
  #"Removed columns" = Table.RemoveColumns(#"Imported CSV", {"Column4"}),
  #"Promoted headers" = Table.PromoteHeaders(#"Removed columns", [PromoteAllScalars = true]),
  #"Renamed columns" = Table.RenameColumns(#"Promoted headers", {{"country_code", "COUNTRY_CODE"}}),
  #"Changed column type" = Table.TransformColumnTypes(#"Renamed columns", {{"COUNTRY_CODE", type text}, {"ref_area", Int64.Type}, {"country_name", type text}}),
  #"Renamed columns 1" = Table.RenameColumns(#"Changed column type", {{"ref_area", "REF"}, {"country_name", "COUNTRY_NAME"}}),
  #"Changed column type 1" = Table.TransformColumnTypes(#"Renamed columns 1", {{"REF", type text}}),
  #"Removed columns 1" = Table.RemoveColumns(#"Changed column type 1", {"REF"}),
  #"Renamed columns 2" = Table.RenameColumns(#"Removed columns 1", {{"COUNTRY_CODE", "Country_Code"}, {"COUNTRY_NAME", "Country_Name"}})
in
  #"Renamed columns 2";
shared DefaultDestination = Lakehouse.Contents([EnableFolding = false]){[workspaceId = "336a3dcc-c24a-497c-8a80-a8fefb6face9"]}[Data]{[lakehouseId = "49958665-f44c-42aa-aeb9-9a260ada0e2f"]}[Data];
shared Countries_DataDestination = let
  Pattern = Lakehouse.Contents([HierarchicalNavigation = null, CreateNavigationProperties = false, EnableFolding = false]),
  Navigation_1 = Pattern{[workspaceId = "336a3dcc-c24a-497c-8a80-a8fefb6face9"]}[Data],
  Navigation_2 = Navigation_1{[lakehouseId = "49958665-f44c-42aa-aeb9-9a260ada0e2f"]}[Data],
  TableNavigation = Navigation_2{[Id = "Countries", ItemKind = "Table"]}?[Data]?
in
  TableNavigation;
