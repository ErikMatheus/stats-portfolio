library(ggplot2)
library(viridis)
library(dplyr)

# Temperley's key profiles
temperley_major_key <- c(5.0, 2.0, 3.5, 2.0, 4.5, 4.0, 2.0, 4.5, 2.0, 3.5, 1.5, 4.0)
temperley_minor_key <- c(5.0, 2.0, 3.5, 4.5, 2.0, 4.0, 2.0, 4.5, 3.5, 2.0, 1.5, 4.0)

# Create Temperley key templates
temperley_key_templates <- tribble(
  ~name, ~template,
  "Gb:maj", circshift(temperley_major_key, 6),
  "Bb:min", circshift(temperley_minor_key, 10),
  "Db:maj", circshift(temperley_major_key, 1),
  "F:min", circshift(temperley_minor_key, 5),
  "Ab:maj", circshift(temperley_major_key, 8),
  "C:min", circshift(temperley_minor_key, 0),
  "Eb:maj", circshift(temperley_major_key, 3),
  "G:min", circshift(temperley_minor_key, 7),
  "Bb:maj", circshift(temperley_major_key, 10),
  "D:min", circshift(temperley_minor_key, 2),
  "F:maj", circshift(temperley_major_key, 5),
  "A:min", circshift(temperley_minor_key, 9),
  "C:maj", circshift(temperley_major_key, 0),
  "E:min", circshift(temperley_minor_key, 4),
  "G:maj", circshift(temperley_major_key, 7),
  "B:min", circshift(temperley_minor_key, 11),
  "D:maj", circshift(temperley_major_key, 2),
  "F#:min", circshift(temperley_minor_key, 6),
  "A:maj", circshift(temperley_major_key, 9),
  "C#:min", circshift(temperley_minor_key, 1),
  "E:maj", circshift(temperley_major_key, 4),
  "G#:min", circshift(temperley_minor_key, 8),
  "B:maj", circshift(temperley_major_key, 11),
  "D#:min", circshift(temperley_minor_key, 3)
)

# Create a function for generating keygrams with Temperley's profiles
create_temperley_keygram <- function(json_file, title, subtitle) {
  json_file |> 
    compmus_chroma(norm = "manhattan") |> 
    compmus_match_pitch_templates(
      temperley_key_templates,
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

# Only for direct testing when running this file by itself
if (interactive()) {
  keygram_plot <- create_temperley_keygram(
    "features/erik-l-2.json",
    "Keygram using Temperley's Key Profiles",
    "erik-l-2 (Für Elise)"
  )
  print(keygram_plot)
}