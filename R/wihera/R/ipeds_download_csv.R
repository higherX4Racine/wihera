ipeds_download_csv <- function(.year, .survey_code, .table_code, .path){
    .zip <- ipeds_data_zip(.year, .survey_code, .table_code)
    curl::curl_download(file.path(IPEDS_DATA_URL, .zip),
                        file.path(.path, .zip))
}
