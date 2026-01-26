# Fabric notebook source

# METADATA ********************

# META {
# META   "kernel_info": {
# META     "name": "synapse_pyspark"
# META   },
# META   "dependencies": {}
# META }

# MARKDOWN ********************

# **1. Correlações Atualizadas (Incluindo NEW)**
# 
# Problema (P), Solução (S) e Resultado (R):
# 
# - P-S (Saúde e Saneamento): Correlação entre Safely managed sanitation e Government expenditure on Health. (Verificar se o gasto em saúde é preventivo ou apenas remediador).
# 
# - P-R (Infraestrutura e Vida): Correlação entre Sanitation services e Life expectancy. (Esta tende a ser uma das correlações mais fortes do projeto).
# 
# - P-P (Custo e Fome): Correlação entre Consumer Price Indices (CPI) e Food insecurity. (Analisar como a inflação impacta diretamente a fome no curto prazo).
# 
# - S-R (Educação e Capital Humano): Correlação entre Expenditure on education e Literacy rates. (Mede a eficácia pedagógica do gasto público).
# 
# - S-R (Bem-estar Geral): Correlação entre Social protection spending e Life expectancy.
# 
# - P-R (Educação e Moradia): Correlação entre Population in slums e Literacy rates. (O ambiente urbano precário trava o desenvolvimento cognitivo/educacional?).
# 
# **2. Questões para a Análise**
# 
# **Bloco A:** O Ciclo da Pobreza (O Problema)
# - A inflação é o maior motor da fome? Como as variações no CPI (Preços) afetaram a Insegurança Alimentar em comparação com o Poverty Ratio?
# 
# - Onde mora o perigo? Existe uma relação direta entre o tipo de alojamento (Living Quarters) e a falta de Saneamento Básico, ou o saneamento é precário mesmo em áreas urbanas formais?
# 
# - Barreiras ao Conhecimento: Países com alta densidade de Slums (Favelas) apresentam taxas de Literacia significativamente menores, independentemente do GNI?
# 
# **Bloco B:** A Eficiência da Intervenção (A Solução)
# Onde o dinheiro faz mais diferença? O investimento em Saúde tem um impacto maior na Expectativa de Vida do que o investimento em Proteção Social?
# 
# - Qualidade vs. Quantidade: O aumento do gasto em Educação está efetivamente se traduzindo em maiores taxas de Literacia e Attendance, ou há perda de eficiência no caminho?
# 
# - P&D para quem? O gasto em Research and Development está correlacionado apenas com o aumento do GNI, ou ele também ajuda a melhorar indicadores de Energia Sustentável?
# 
# **Bloco C:** A Entrega Final (O Resultado)
# - Crescimento vs. Desenvolvimento: Países que aumentaram o GNI per capita conseguiram necessariamente melhorar o acesso a Energia Sustentável e Saneamento?
# 
# - O veredito da longevidade: Qual fator do "Problema" (Fome, Saneamento ou Pobreza) é o preditor mais forte para uma baixa Expectativa de Vida?
# 
# - A Luz no fim do túnel: A transição para Energia Sustentável é um luxo de países ricos (GNI alto) ou há países pobres que estão liderando essa frente como "Solução"?


# MARKDOWN ********************

# ### Fontes de dados
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
# - Population by literacy, age, sex and urban/rural residence (NEW)
# 	- https://data.un.org/Data.aspx?d=POP&f=tableCode:31
# 	- 1995 - 2023
# 	- p_un_literacy.csv
# - People using safely managed sanitation services (% of population) (NEW)
# 	- https://data360.worldbank.org/en/indicator/WB_WDI_SH_STA_SMSS_ZS
# 	- 2000 - 2024
# 	- p_wb_sanitation.csv
# -  Consumer Price Indices (NEW)
# 	- https://data360.worldbank.org/en/dataset/FAO_CP
# 	- 2000 - 2025
# 	- p_wb_price_indices.csv
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
# - Government expenditure on Health (NEW)
# 	- https://data360.worldbank.org/en/indicator/WB_WDI_SH_XPD_GHED_PC_CD
# 	- 2000-2023
# 	- s_wb_health.csv
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
# - Life expectancy at birth, total (years) (NEW)
# 	- https://data360.worldbank.org/en/indicator/WB_WDI_SP_DYN_LE00_IN
# 	- 1960 - 2023
# 	- r_wb_lifeExpectancy.csv
# 


# CELL ********************


# METADATA ********************

# META {
# META   "language": "python",
# META   "language_group": "synapse_pyspark"
# META }
