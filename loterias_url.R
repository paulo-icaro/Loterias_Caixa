# ===================================== #
# === URL FUNCTION - LOTERIAS CAIXA === #
# ===================================== #

# --- Script by Paulo Icaro --- #


# Para mais detalhes, ver: https://github.com/guidi/loteria_api



# ------------------------------ #
# --- URL Generator Function --- #
# ------------------------------ #
loterias_url = function(loteria = 'lotofacil', concurso = 'ultimo'){
   if(is.null(loteria)){
     message('Loteria não informada. Coletando dados da loteria padrão: Lotofácil.')
     loteria = 'lotofacil'
   }
  base_url = 'https://api.guidi.dev.br/loteria'
  loteria_url = paste0(base_url, '/', loteria, '/', concurso)
  return(loteria_url)
}