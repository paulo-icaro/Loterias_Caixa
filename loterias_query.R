# ======================================= #
# === QUERY FUNCTION - LOTERIAS CAIXA === #
# ======================================= #


# --- Script by Paulo Icaro --- #


# ============= #
# === Query === #
# ============= #
loterias_query = function(lista_concursos, source_github = TRUE){

  # ---------------------------------- #
  # --- Source Auxiliary Functions --- #
  # ---------------------------------- #
  if(source_github == TRUE){
    #tryCatch(expr = suppressWarnings(source('https://raw.githubusercontent.com/paulo-icaro/Loterias_Caixa/refs/heads/main/loterias_api.R')),
     #        error = function(e){message('Não foi possível acessar a função loterias_api')})
    
    Sys.sleep(1)
    
    tryCatch(expr = suppressWarnings(source('https://raw.githubusercontent.com/paulo-icaro/Loterias_Caixa/refs/heads/main/loterias_url.R')),
      error = function(e){message('Não foi possível acessar a função loterias_url')})
    
    Sys.sleep(1)
    
    } else {
      message('Caso não tenha feito ainda, importe as funções loterias_api e loterias_url de um diretório local e execute este script novamente.\n')
    }
  
  
  
  # ----------------------- #
  # --- Data Extraction --- #
  # ----------------------- #
  for(l in seq_along(lista_concursos)){
    message(paste0('Extração\nLoteria: ', toupper(names(lista_concursos[l])), '\n'))
    
    for(c in seq_along(lista_concursos[[l]])){
      message(paste0('\nConcurso: ', lista_concursos[[l]][c], '\n'  ))
    
    
    tryCatch(expr = {
      
      # --- Extraction --- #
      loterias_raw = loterias_api(url = loterias_url(loteria = names(lista_concursos[l]), concurso = lista_concursos[[l]][c]))
      
      # --- Storing Results --- #
      resultados = as.double(loterias_raw$listaDezenas)
      
      if(c == 1){
        matriz_resultados = matrix(data = resultados, nrow = length(resultados), ncol = 1)
      } else {
        matriz_resultados = cbind(matriz_resultados, resultados)
      }
      
      # --- Naming Headers --- #
      if(c == length(lista_concursos[[l]])){colnames(matriz_resultados) = lista_concursos[[l]]}
      
      # --- Error Handling --- #
      error = function(e){stop('A conexão com a API pode estar indisponível no momento. Verifique sua conexão.\n', call. = FALSE)}

      })
    }
    
    
    # -------------------------- #
    # --- Return Data Output --- #
    # -------------------------- #
    return(matriz_resultados)
    
  }
}