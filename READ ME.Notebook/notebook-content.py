# Fabric notebook source

# METADATA ********************

# META {
# META   "kernel_info": {
# META     "name": "synapse_pyspark"
# META   },
# META   "dependencies": {
# META     "lakehouse": {
# META       "default_lakehouse_name": "",
# META       "default_lakehouse_workspace_id": ""
# META     }
# META   }
# META }

# MARKDOWN ********************

# 


# MARKDOWN ********************

# ## Data Engineering Mastering Project
# 
# ### Global Demographic & Economic Growth Dashboard

# MARKDOWN ********************

# ### 1. Contexto
# 
# O projeto "Data Engineering Mastering" foca-se na convergência entre demografia global e indicadores económicos. O objetivo central é transformar dados brutos provenientes de organizações internacionais em inteligência de negócio acionável, permitindo uma análise profunda das tendências que moldarão o cenário mundial em 2026.
# 
# ##### - Objetivos Estratégicos
# O sucesso do projeto é medido através de quatro pilares fundamentais:
# 
# - **Exploração de Dados:** Investigar e compreender a fundo os datasets disponíveis.
# 
# - **Inteligência de Negócio:** Identificar perguntas críticas que gerem valor estratégico.
#  
# - **Visualização de Dados:** Construir relatórios no Power BI que ofereçam insights claros.
#  
# - **Colaboração:** Maximizar a eficiência do trabalho em equipa durante o ciclo de desenvolvimento.

# MARKDOWN ********************

# ### 2. Fontes de dados
# 
# Para garantir a robustez das análises, o projeto utiliza fontes de dados heterogéneas de prestígio global:
# 
# - **UN Census Data:** Dados demográficos detalhados da base de censos das Nações Unidas.
# <img src="https://data.un.org/_Images/Logo.png" width="300"/>
# 
#     - Population by type of living quarters, age and sex
#     - Population by literacy, age, sex and urban/rural residence
#     - School attendance
#     
# 
# - **World Bank Global Development:** Indicadores económicos e de desenvolvimento do Portal de Dados do Banco Mundial.
# <img src="https://pbs.twimg.com/profile_images/1831702419744460800/ghgvfq33_400x400.jpg" width="300"/>
# 
#     - Population living in slums
#     - Population with food insecurity (%)
#     - Poverty headcount ratio
#     - People using safely managed sanitation services (% of population) (NEW)
#     -  Consumer Price Indices (NEW)
#     - Government expenditure on education
#     - Social protection spending
#     - Research and development expenditure
#     - Government expenditure on Health (NEW)
#     - GNI per capita, PPP
#     - Sustainable Energy
#     - Life expectancy at birth, total (years) (NEW)


# MARKDOWN ********************

# ### 3. Correlações
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
# ### 4. Questões para a Análise
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

# ### Abordagem ou Estrutura

# MARKDOWN ********************

# <table>
# <tr>
# <th>Categoria</th>
# <th>Indicador</th>
# <th>Link</th>
# <th>Período</th>
# <th>Arquivo</th>
# </tr>
# 
# <tr style="background-color:#f2f2f2;">
# <td>Problema</td>
# <td>Population living in slums (%)</td>
# <td>https://data360.worldbank.org/en/indicator/WB_WDI_EN_POP_SLUM_UR_ZS</td>
# <td>2000–2022</td>
# <td>p_wb_slums.csv</td>
# </tr>
# 
# <tr style="background-color:#f2f2f2;">
# <td>Problema</td>
# <td>Population with food insecurity (%)</td>
# <td>https://data360.worldbank.org/en/indicator/WB_WDI_SN_ITK_MSFI_ZS</td>
# <td>2015–2022</td>
# <td>p_wb_food.csv</td>
# </tr>
# 
# <tr style="background-color:#f2f2f2;">
# <td>Problema</td>
# <td>Poverty headcount ratio</td>
# <td>https://data360.worldbank.org/en/indicator/WB_WDI_SI_POV_MPWB</td>
# <td>2008–2024</td>
# <td>p_wb_ratio.csv</td>
# </tr>
# 
# <tr style="background-color:#f2f2f2;">
# <td>Problema</td>
# <td>Population by type of living quarters, age and sex</td>
# <td>https://data.un.org/Data.aspx?d=POP&f=tableCode:46</td>
# <td>1995–2023</td>
# <td>p_un_quarters.csv</td>
# </tr>
# 
# <tr style="background-color:#f2f2f2;">
# <td>Problema</td>
# <td>Population by literacy, age, sex and urban/rural residence (NEW)</td>
# <td>https://data.un.org/Data.aspx?d=POP&f=tableCode:31</td>
# <td>1995–2023</td>
# <td>p_un_literacy.csv</td>
# </tr>
# 
# <tr style="background-color:#f2f2f2;">
# <td>Problema</td>
# <td>People using safely managed sanitation services (% of population) (NEW)</td>
# <td>https://data360.worldbank.org/en/indicator/WB_WDI_SH_STA_SMSS_ZS</td>
# <td>2000–2024</td>
# <td>p_wb_sanitation.csv</td>
# </tr>
# 
# <tr style="background-color:#f2f2f2;">
# <td>Problema</td>
# <td>Consumer Price Indices (NEW)</td>
# <td>https://data360.worldbank.org/en/dataset/FAO_CP</td>
# <td>2000–2025 (best: 2001–2021)</td>
# <td>p_wb_price_indices.csv</td>
# </tr>
# 
# <tr style="background-color:#dbe9ff;">
# <td>Solução</td>
# <td>Government expenditure on education</td>
# <td>https://data360.worldbank.org/en/indicator/WB_EDSTATS_UIS_X_PPP_FSGOV</td>
# <td>1990–2024</td>
# <td>s_wb_education.csv</td>
# </tr>
# 
# <tr style="background-color:#dbe9ff;">
# <td>Solução</td>
# <td>Social protection spending</td>
# <td>https://data360.worldbank.org/en/indicator/WEF_TTDI_SOCPROTECTOGDP</td>
# <td>2019–2024</td>
# <td>s_wb_social.csv</td>
# </tr>
# 
# <tr style="background-color:#dbe9ff;">
# <td>Solução</td>
# <td>Research and development expenditure</td>
# <td>https://data360.worldbank.org/en/indicator/WB_WDI_GB_XPD_RSDV_GD_ZS</td>
# <td>1996–2023</td>
# <td>s_wb_research.csv</td>
# </tr>
# 
# <tr style="background-color:#dbe9ff;">
# <td>Solução</td>
# <td>Government expenditure on Health (NEW)</td>
# <td>https://data360.worldbank.org/en/indicator/WB_WDI_SH_XPD_GHED_PC_CD</td>
# <td>2000–2023</td>
# <td>s_wb_health.csv</td>
# </tr>
# 
# <tr style="background-color:#dff5e1;">
# <td>Resultado</td>
# <td>GNI per capita, PPP</td>
# <td>https://data360.worldbank.org/en/indicator/WB_WDI_NY_GNP_PCAP_PP_CD</td>
# <td>1990–2024</td>
# <td>r_wb_gni.csv</td>
# </tr>
# 
# <tr style="background-color:#dff5e1;">
# <td>Resultado</td>
# <td>School attendance</td>
# <td>https://data.un.org/Data.aspx?d=POP&f=tableCode:29</td>
# <td>1995–2023</td>
# <td>r_un_attendance.csv</td>
# </tr>
# 
# <tr style="background-color:#dff5e1;">
# <td>Resultado</td>
# <td>Sustainable Energy</td>
# <td>https://data360.worldbank.org/en/indicator/WB_RISE_RE_ALL</td>
# <td>2010–2023</td>
# <td>r_wb_energy.csv</td>
# </tr>
# 
# <tr style="background-color:#dff5e1;">
# <td>Resultado</td>
# <td>Life expectancy at birth, total (years) (NEW)</td>
# <td>https://data360.worldbank.org/en/indicator/WB_WDI_SP_DYN_LE00_IN</td>
# <td>1960–2023</td>
# <td>r_wb_lifeExpectancy.csv</td>
# </tr>
# 
# </table>


# MARKDOWN ********************

# ### 4. Medalhões
# A implementação segue a Arquitetura Medallion, garantindo a qualidade e a linhagem dos dados ao longo de três camadas:
# 
# 
# 
# ```text
# ┌───────────────────────────────────────────────┐
#  │ 🟤 BRONZE (RAW)                             │
# │───────────────────────────────────────────────│
# │ • Ingestão de dados no estado original        │
# │ • Download de arquivos (CSV)                  │
# │ • Web Scraping                                │
# │ • Sem transformações                          │
# └───────────────────────────────────────────────┘
#                     │
#                     ▼
# ┌───────────────────────────────────────────────┐
#  │ ⚪ SILVER (VALIDATED / CLEAN)               │
# │───────────────────────────────────────────────│
# │ • Validação dos dados                         │
# │ • Limpeza (dados nulos, duplicados, erros)    │
# │ • Normalização                                │
# │ • Padronização de schemas                     │
# └───────────────────────────────────────────────┘
#                     │
#                     ▼
# ┌───────────────────────────────────────────────┐
#  │ 🟡 GOLD (ENRICHED / CURATED)                │
# │───────────────────────────────────────────────│
# │ • Modelagem dimensional                       │
# │ • Dados enriquecidos                          │
# │ • Prontos para consumo analítico              │
# │ • BI, Dashboards e Analytics                  │
# └───────────────────────────────────────────────┘


# MARKDOWN ********************


# MARKDOWN ********************

# ### 4.1. Transformação de Dados (ETL): Bronze para Silver
# 
# O processo de transformação visa elevar a qualidade dos dados, garantindo que a camada Silver contenha dados limpos, tipados e prontos para análise:
# 
# #### - Limpeza e Padronização (Data Cleansing)
# - **Tratamento de Nulos:** Substituição de valores nulos por zero para evitar erros em operações matemáticas e aplicação de filtros para remover registros incompletos.
# 
# - **Tipagem Estrita:** Conversão de tipos de dados (strings para numéricos/percentuais) para garantir a integridade dos cálculos.
# 
# - **Filtragem de Escopo:** Aplicação de critérios específicos para isolar subconjuntos de dados relevantes e remoção de entradas inválidas que não constam nas listas de referência.
# 
# - **Normalização de Valores:** Re-escala de valores (ex: divisão por 100) para converter números brutos em formatos decimais e percentuais padronizados.
# 
# #### - Reestruturação de Esquema (Schema Design)
# - **Pivot & Unpivot:** Manipulação da estrutura das tabelas para converter formatos Wide em Long (e vice-versa), garantindo que os anos e atributos sejam tratados como dimensões e métricas.
# 
# - **Agregação Temporal:** Cálculo de médias anuais a partir de dados mensais (janela de 2000 a 2025), consolidando 12 colunas mensais em uma única métrica anual.
# 
# - **Cálculos Customizados:** Criação de colunas calculadas, como totais por soma de múltiplos campos e razões percentuais entre colunas.
# 
# #### - Enriquecimento e Integração
# - **Lookup & Join:** Integração com fontes externas (arquivos CSV de referência) para associar códigos de área a nomes de países e etiquetas descritivas.
# 
# - **Expansão de Metadados:** Inclusão de códigos de referência e nomes padronizados para aumentar o contexto analítico do dado.
# 
# - **Consolidação de Idades:** Resumo e agrupamento de diferentes faixas etárias para simplificar a análise demográfica.
# 
# #### - Otimização e Refino (Data Pruning)
# - **Seleção de Colunas:** Remoção de metadados técnicos, etiquetas redundantes (FREQ, STATUS, UNIT) e colunas auxiliares de join.
# 
# - **Redução de Footprint:** Eliminação massiva de colunas originais (ex: centenas de colunas mensais) após a geração das médias anuais para reduzir o peso do modelo.
# 
# - **Renomeação Semântica:** Padronização final dos nomes das colunas (ex: YEAR, VALUE, COUNTRY_NAME) para garantir consistência e facilidade de uso no Power BI/Databricks.


# MARKDOWN ********************

# ### 4.2. Transformação de Dados (ETL): Silver para Gold

# MARKDOWN ********************

# #### - Preparação e Limpeza
# 
# - **Fusão de tabelas:** Agruparam-se várias fontes numa só lista.
# 
# - **Redução de colunas:** Mantiveram-se apenas os identificadores essenciais.
# 
# - **Remoção de duplicados:** Eliminaram-se entradas repetidas.
# 
# - **Divisão de IDs:** Separaram-se os códigos de identificação em categorias (como país e ano).
# 
# #### - Cruzamento e Organização
# 
# - **Associação de métricas:** Recuperaram-se os dados de cada fonte com base na lista principal.
# 
# - **Simplificação de estrutura:** Transformaram-se dados complexos em colunas simples.
# 
# - **Ajuste de formatos:** Corrigiram-se os tipos de dados (texto e números) para análise.
# 
# #### - Refinação Final
# 
# - **Extração de texto:** Limparam-se colunas de texto, removendo informação desnecessária antes da vírgula.
# 
# - **Atualização de nomes:** Renomearam-se as colunas para títulos mais claros.
# 
# - **Ordenação:** Organizou-se a lista final por ordem crescente.

# MARKDOWN ********************

# ### 5. Desafios

# MARKDOWN ********************

# - Web scrapping nos dados da UN:  originalmente o site só libera um numero limitado de dados
# - Dificuldade na distribuição de tarefas devido a limitações do Fabric e a linearidade do projeto
# - Inconsistencia de alguns dados da UN, principalmente a sobreposição de dados referentes as idades
# - Dificuldade de conexão de internet

# MARKDOWN ********************

