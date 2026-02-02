[DefaultOutputDestinationSettings = [DestinationDefinition = [Kind = "Reference", QueryName = "DefaultDestination", IsNewTarget = true], UpdateMethod = [Kind = "Replace"], DestinationTypeSettings = [Kind = "Table"]], StagingDefinition = [Kind = "FastCopy"]]
section Section1;
[BindToDefaultDestination = true]
shared #"Renewable Energy Score" = let
  Source = Lakehouse.Contents(null),
  Navigation = Source{[workspaceId = "dff63297-ff0e-4927-8e91-bc223e951376"]}[Data],
  #"Navigation 1" = Navigation{[lakehouseId = "caea25e2-1b4f-4b81-913a-7fd6b66cce9e"]}[Data],
  #"Navigation 2" = #"Navigation 1"{[Id = "r_wb_energy", ItemKind = "Table"]}[Data],
  #"Removed columns" = Table.RemoveColumns(#"Navigation 2", {"FREQ", "FREQ_LABEL", "INDICATOR", "OBS_CONF_LABEL", "OBS_CONF", "OBS_STATUS_LABEL", "OBS_STATUS", "UNIT_MULT_LABEL", "UNIT_MULT", "DATABASE_ID_LABEL", "DATABASE_ID", "UNIT_MEASURE_LABEL", "UNIT_MEASURE", "INDICATOR_LABEL"}),
  #"Unpivoted other columns" = Table.UnpivotOtherColumns(#"Removed columns", {"REF_AREA", "REF_AREA_LABEL"}, "Attribute", "Value"),
  #"Renamed columns" = Table.RenameColumns(#"Unpivoted other columns", {{"Attribute", "Year"}}),
  #"Changed column type" = Table.TransformColumnTypes(#"Renamed columns", {{"Year", Int64.Type}}),
  #"Renamed columns 1" = Table.RenameColumns(#"Changed column type", {{"Year", "YEAR"}, {"Value", "VALUE"}}),
  #"Renamed columns 2" = Table.RenameColumns(#"Renamed columns 1", {{"REF_AREA", "Ref_Area"}, {"YEAR", "Year"}, {"VALUE", "Value"}}),
  #"Rounded off" = Table.TransformColumns(#"Renamed columns 2", {{"Value", each Number.Round(_, 2), type number}}),
  #"Merged queries" = Table.NestedJoin(#"Rounded off", {"Ref_Area"}, Countries, {"Country_Code"}, "Countries", JoinKind.LeftOuter),
  #"Expanded Countries" = Table.ExpandTableColumn(#"Merged queries", "Countries", {"Country_Name"}, {"Country_Name"}),
  #"Filtered rows" = Table.SelectRows(#"Expanded Countries", each ([Country_Name] <> null)),
  #"Removed columns 2" = Table.RemoveColumns(#"Filtered rows", {"Country_Name", "REF_AREA_LABEL"})
in
  #"Removed columns 2";
[BindToDefaultDestination = true]
shared #"GNI per capita" = let
  Source = Lakehouse.Contents(null),
  Navigation = Source{[workspaceId = "dff63297-ff0e-4927-8e91-bc223e951376"]}[Data],
  #"Navigation 1" = Navigation{[lakehouseId = "caea25e2-1b4f-4b81-913a-7fd6b66cce9e"]}[Data],
  #"Navigation 2" = #"Navigation 1"{[Id = "r_wb_gni", ItemKind = "Table"]}[Data],
  #"Removed columns" = Table.RemoveColumns(#"Navigation 2", {"OBS_CONF_LABEL", "OBS_CONF", "OBS_STATUS_LABEL", "OBS_STATUS", "DATA_SOURCE_LABEL", "DATA_SOURCE", "UNIT_MULT_LABEL", "UNIT_MULT", "DATABASE_ID_LABEL", "DATABASE_ID", "DECIMALS_LABEL", "DECIMALS", "AGG_METHOD_LABEL", "AGG_METHOD", "UNIT_MEASURE_LABEL", "UNIT_MEASURE", "INDICATOR_LABEL", "INDICATOR", "FREQ", "FREQ_LABEL"}),
  #"Unpivoted other columns" = Table.UnpivotOtherColumns(#"Removed columns", {"REF_AREA", "REF_AREA_LABEL"}, "Attribute", "Value"),
  #"Changed column type" = Table.TransformColumnTypes(#"Unpivoted other columns", {{"Attribute", Int64.Type}}),
  #"Renamed columns" = Table.RenameColumns(#"Changed column type", {{"Attribute", "YEAR"}, {"Value", "VALUE"}}),
  #"Removed columns 1" = Table.RemoveColumns(#"Renamed columns", {"REF_AREA_LABEL"}),
  #"Renamed columns 1" = Table.RenameColumns(#"Removed columns 1", {{"REF_AREA", "Ref_Area"}, {"YEAR", "Year"}, {"VALUE", "Value"}}),
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
  Navigation = Source{[workspaceId = "dff63297-ff0e-4927-8e91-bc223e951376"]}[Data],
  #"Navigation 1" = Navigation{[lakehouseId = "caea25e2-1b4f-4b81-913a-7fd6b66cce9e"]}[Data],
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
  Navigation = Source{[workspaceId = "dff63297-ff0e-4927-8e91-bc223e951376"]}[Data],
  #"Navigation 1" = Navigation{[lakehouseId = "caea25e2-1b4f-4b81-913a-7fd6b66cce9e"]}[Data],
  #"Navigation 2" = #"Navigation 1"{[Id = "s_wb_education", ItemKind = "Table"]}[Data],
  #"Removed columns" = Table.RemoveColumns(#"Navigation 2", {"OBS_CONF_LABEL", "OBS_CONF", "OBS_STATUS_LABEL", "OBS_STATUS", "UNIT_MULT_LABEL", "UNIT_MULT", "DATABASE_ID_LABEL", "DATABASE_ID", "UNIT_MEASURE_LABEL", "UNIT_MEASURE", "INDICATOR_LABEL", "INDICATOR", "FREQ_LABEL", "FREQ"}),
  #"Unpivoted other columns" = Table.UnpivotOtherColumns(#"Removed columns", {"REF_AREA", "REF_AREA_LABEL"}, "Attribute", "Value"),
  #"Changed column type" = Table.TransformColumnTypes(#"Unpivoted other columns", {{"Attribute", Int64.Type}}),
  #"Renamed columns" = Table.RenameColumns(#"Changed column type", {{"Attribute", "YEAR"}, {"Value", "VALUE"}}),
  #"Removed columns 1" = Table.RemoveColumns(#"Renamed columns", {"REF_AREA_LABEL"}),
  #"Renamed columns 1" = Table.RenameColumns(#"Removed columns 1", {{"REF_AREA", "Ref_Area"}, {"YEAR", "Year"}, {"VALUE", "Value"}}),
  #"Changed column type 1" = Table.TransformColumnTypes(#"Renamed columns 1", {{"Value", Currency.Type}})
in
  #"Changed column type 1";
[BindToDefaultDestination = true]
shared #"Public Health Spending" = let
  Source = Lakehouse.Contents(null),
  Navigation = Source{[workspaceId = "dff63297-ff0e-4927-8e91-bc223e951376"]}[Data],
  #"Navigation 1" = Navigation{[lakehouseId = "caea25e2-1b4f-4b81-913a-7fd6b66cce9e"]}[Data],
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
  Navigation = Source{[workspaceId = "dff63297-ff0e-4927-8e91-bc223e951376"]}[Data],
  #"Navigation 1" = Navigation{[lakehouseId = "caea25e2-1b4f-4b81-913a-7fd6b66cce9e"]}[Data],
  #"Navigation 2" = #"Navigation 1"{[Id = "s_wb_research", ItemKind = "Table"]}[Data],
  #"Removed columns" = Table.RemoveColumns(#"Navigation 2", {"STRUCTURE", "STRUCTURE_ID", "ACTION", "FREQ", "INDICATOR", "SEX", "AGE", "URBANISATION", "UNIT_MEASURE", "COMP_BREAKDOWN_1", "COMP_BREAKDOWN_2", "COMP_BREAKDOWN_3", "AGG_METHOD", "UNIT_TYPE", "DECIMALS", "DATABASE_ID", "TIME_FORMAT", "COMMENT_TS", "UNIT_MULT", "DATA_SOURCE", "OBS_CONF", "OBS_STATUS", "FREQ_LABEL", "INDICATOR_LABEL", "SEX_LABEL", "AGE_LABEL", "URBANISATION_LABEL", "UNIT_MEASURE_LABEL", "COMP_BREAKDOWN_1_LABEL", "COMP_BREAKDOWN_2_LABEL", "COMP_BREAKDOWN_3_LABEL", "AGG_METHOD_LABEL", "UNIT_TYPE_LABEL", "DECIMALS_LABEL", "DATABASE_ID_LABEL", "TIME_FORMAT_LABEL", "UNIT_MULT_LABEL", "OBS_STATUS_LABEL", "OBS_CONF_LABEL"}),
  #"Unpivoted other columns" = Table.UnpivotOtherColumns(#"Removed columns", {"REF_AREA", "REF_AREA_LABEL"}, "Attribute", "Value"),
  #"Renamed columns" = Table.RenameColumns(#"Unpivoted other columns", {{"Attribute", "YEAR"}}),
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
  Navigation = Source{[workspaceId = "dff63297-ff0e-4927-8e91-bc223e951376"]}[Data],
  #"Navigation 1" = Navigation{[lakehouseId = "caea25e2-1b4f-4b81-913a-7fd6b66cce9e"]}[Data],
  #"Navigation 2" = #"Navigation 1"{[Id = "s_wb_social", ItemKind = "Table"]}[Data],
  #"Filtered rows" = Table.SelectRows(#"Navigation 2", each [TYPE_LABEL] = "Type: Value"),
  #"Removed columns" = Table.RemoveColumns(#"Filtered rows", {"FREQ", "FREQ_LABEL", "INDICATOR", "INDICATOR_LABEL", "UNIT_MEASURE", "UNIT_MEASURE_LABEL", "TYPE", "TYPE_LABEL", "DATABASE_ID", "DATABASE_ID_LABEL", "UNIT_MULT", "UNIT_MULT_LABEL", "OBS_STATUS", "OBS_STATUS_LABEL", "OBS_CONF", "OBS_CONF_LABEL", "REF_AREA_LABEL"}),
  #"Unpivoted other columns" = Table.UnpivotOtherColumns(#"Removed columns", {"REF_AREA"}, "Attribute", "Value"),
  #"Renamed columns" = Table.RenameColumns(#"Unpivoted other columns", {{"REF_AREA", "Ref_Area"}, {"Attribute", "Year"}}),
  #"Divided column" = Table.TransformColumns(#"Renamed columns", {{"Value", each _ / 100, type number}}),
  #"Changed column type" = Table.TransformColumnTypes(#"Divided column", {{"Value", Percentage.Type}}),
  #"Merged queries" = Table.NestedJoin(#"Changed column type", {"Ref_Area"}, Countries, {"Country_Code"}, "Countries", JoinKind.LeftOuter),
  #"Expanded Countries" = Table.ExpandTableColumn(#"Merged queries", "Countries", {"Country_Name"}, {"Country_Name"}),
  #"Filtered rows 1" = Table.SelectRows(#"Expanded Countries", each ([Country_Name] <> null)),
  #"Removed columns 1" = Table.RemoveColumns(#"Filtered rows 1", {"Country_Name"})
in
  #"Removed columns 1";
[DataDestinations = {[Definition = [Kind = "Reference", QueryName = "Countries_DataDestination", IsNewTarget = true], Settings = [Kind = "Automatic", TypeSettings = [Kind = "Table"]]]}]
shared Countries = let
  Source = Lakehouse.Contents(null),
  Navigation = Source{[workspaceId = "dff63297-ff0e-4927-8e91-bc223e951376"]}[Data],
  #"Navigation 1" = Navigation{[lakehouseId = "caea25e2-1b4f-4b81-913a-7fd6b66cce9e"]}[Data],
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
shared Countries_DataDestination = let
  Pattern = Lakehouse.Contents([HierarchicalNavigation = null, CreateNavigationProperties = false, EnableFolding = false]),
  Navigation_1 = Pattern{[workspaceId = "dff63297-ff0e-4927-8e91-bc223e951376"]}[Data],
  Navigation_2 = Navigation_1{[lakehouseId = "40bd4a39-6798-4210-8e2f-e09024560926"]}[Data],
  TableNavigation = Navigation_2{[Id = "Countries", ItemKind = "Table"]}?[Data]?
in
  TableNavigation;
shared DefaultDestination = let
  Source = Lakehouse.Contents([HierarchicalNavigation = null, CreateNavigationProperties = false, EnableFolding = false]),
  #"Navigation 1" = Source{[workspaceId = "dff63297-ff0e-4927-8e91-bc223e951376"]}[Data],
  #"Navigation 2" = #"Navigation 1"{[lakehouseId = "40bd4a39-6798-4210-8e2f-e09024560926"]}[Data]
in
  #"Navigation 2";
