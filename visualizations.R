# Visualization functions for music analysis

# Create a chordogram visualization
create_chordogram <- function(json_file, title, subtitle = "Using standard chord templates") {
  json_file |> 
    compmus_chroma(norm = "euclidean") |> 
    compmus_match_pitch_templates(
      chord_templates,
      norm = "euclidean",
      distance = "cosine"
    ) |>
    ggplot(aes(x = time, y = name, fill = d)) + 
    geom_raster() +
    scale_fill_viridis_c(guide = "none") +
    labs(x = "Time (s)", y = "Chord", fill = NULL,
         title = title,
         subtitle = subtitle) +
    theme_classic()
}

# Create a keygram visualization
create_keygram <- function(json_file, title, subtitle = "Using Krumhansl-Kessler key profiles") {
  json_file |> 
    compmus_chroma(norm = "manhattan") |> 
    compmus_match_pitch_templates(
      key_templates,
      norm = "manhattan",
      distance = "aitchison"
    ) |>
    ggplot(aes(x = time, y = name, fill = d)) + 
    geom_raster() +
    scale_fill_viridis_c(guide = "none") +
    labs(x = "Time (s)", y = "Key", fill = NULL,
         title = title,
         subtitle = subtitle) +
    theme_classic()
}
