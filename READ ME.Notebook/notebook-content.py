# Fabric notebook source

# METADATA ********************

# META {
# META   "kernel_info": {
# META     "name": "synapse_pyspark"
# META   },
# META   "dependencies": {}
# META }

# MARKDOWN ********************

# Idea: Problema -> Solução -> Resultado
# 
# Perguntas:
# - correlaçao entre education e attendance (28 anos)
# - correlaçao entre research e gni (27 anos)
# - correlaçao entre energy e gni (13 anos)
# - correlaçao entre slums e food (7 anos)
# - correlaçao entre quarters e ratio (5 anos)
# - correlaçao entre social e ratio (5 anos)
# - correlaçao entre attendance e gni (28 anos)
# - correlaçao entre slums e gni (22 anos)
# 
# -----------------------------------------------
# Problema
# - Population living in slums
# 	- https://data360.worldbank.org/en/indicator/WB_WDI_EN_POP_SLUM_UR_ZS
# 	- 2000 - 2022
# 	- p_wb_slums.csv
# - Prevalence of moderate or severe food insecurity in the population (%)
# 	- https://data360.worldbank.org/en/indicator/WB_WDI_SN_ITK_MSFI_ZS
# 	- 2015 - 2022
# 	- p_wb_food.csv
# - Poverty headcount ratio
# 	- https://data360.worldbank.org/en/indicator/WB_WDI_SI_POV_MPWB
# 	- 2008 - 2024
# 	- p_wb_ratio.csv
# - Population by type of living quarters, age and sex
# 	- https://data.un.org/Data.aspx?d=POP&f=tableCode:46
# 	- 1995 - 2023
# 	- p_un_quarters.csv
# 
# Solução
# - Government expenditure on education
# 	- https://data360.worldbank.org/en/indicator/WB_EDSTATS_UIS_X_PPP_FSGOV
# 	- 1990 - 2024
# 	- s_wb_education.csv
# - Social protection spending
# 	- https://data360.worldbank.org/en/indicator/WEF_TTDI_SOCPROTECTOGDP
# 	- 2019 - 2024
# 	- s_wb_social.csv
# - Research and development expenditure
# 	- https://data360.worldbank.org/en/indicator/WB_WDI_GB_XPD_RSDV_GD_ZS
# 	- 1996 - 2023
# 	- s_wb_research.csv
# 
# Resultado
# - GNI per capita, PPP
# 	- https://data360.worldbank.org/en/indicator/WB_WDI_NY_GNP_PCAP_PP_CD
# 	- 1990 - 2024
# 	- r_wb_gni.csv
# - School attendance
# 	- https://data.un.org/Data.aspx?d=POP&f=tableCode%3a29
# 	- 1995 - 2023
# 	- r_un_attendance.csv
# - Sustainable Energy
# 	- https://data360.worldbank.org/en/indicator/WB_RISE_RE_ALL
# 	- 2010 - 2023
# 	- r_wb_energy.csv

