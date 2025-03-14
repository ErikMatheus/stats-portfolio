# Feature extraction functions for musical analysis

# Extract features from a JSON file
extract_features <- function(json_file) {
  data <- fromJSON(json_file)
  
  # Extract the features we want
  tibble(
    filename = data$metadata$tags$file_name,
    bpm = data$rhythm$bpm,
    danceability = data$rhythm$danceability,
    key = paste(data$tonal$key_key, data$tonal$key_scale),
    loudness = data$lowlevel$average_loudness,
    onset_rate = data$rhythm$onset_rate,
    beats_count = data$rhythm$beats_count
  )
}
