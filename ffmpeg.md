## Convert video to GIF

https://superuser.com/questions/556029/how-do-i-convert-a-video-to-gif-using-ffmpeg-with-reasonable-quality

```
ffmpeg -y -ss 30 -t 3 -i input.flv -vf fps=10,scale=320:-1:flags=lanczos,palettegen palette.png

ffmpeg -ss 30 -t 3 -i input.flv -i palette.png -filter_complex "fps=10,scale=320:-1:flags=lanczos[x];[x][1:v]paletteuse" output.gif
ffmpeg -i input.flv -i palette.png -filter_complex "fps=10,scale=320:-1:flags=lanczos[x];[x][1:v]paletteuse" output.gif
```


Examples:

```
ffmpeg -y -ss 30 -t 3 -i demo-description-override.mov -vf fps=10,scale=320:-1:flags=lanczos,palettegen palette.png
ffmpeg -i demo-description-override.mov -i palette.png -filter_complex "fps=10,scale=640:-1:flags=lanczos[x];[x][1:v]paletteuse" output.gif
```

# Youtube-dl

### Recode video
```
youtube-dl --recode-video mp4 <url>
```

Conversion for Blu-Ray movies to H.265:
`ffmpeg -i <input_file> -c:v libx265 -b:v 1100k -maxrate 1800k -bufsize 2200k -c:a aac -b:a 320k -c:s copy <output_file>

For 720p use -b:v of like 1000k

# Conversions

`
function convert1080p {
  ffmpeg -i $1 -s hd1080 -c:v libx264 -crf 23 -c:a aac -strict -2 $1_1080p.mp4
}
`

# Take subsegment of video clip

```
ffmpeg -ss 00:00:30.0 -i input.wmv -c copy -t 00:00:10.0 output.wmv
ffmpeg -ss 30 -i input.wmv -c copy -t 10 output.wmv
```

# Reverse video

```
ffmpeg -i input.mp4 -ss 00:00:17.0 -t 00:00:10.0 -vf reverse output.mp4
```

# Extract Audio
```
ffmpeg -i input_video.mp4 -vn -ab 320k -ar 44100 -ac 2 output_audio.mp3

ffmpeg -i TOP\ 20\ SOUND\ EFFECTS\ YOUTUBERS\ USE\ IN\ 2022\ \(ROYALTY\ FREE\)\ \[V0Dbq0OfxnU\].mkv -c:a copy "TOP 20 SOUND EFFECTS YOUTUBERS USE IN 2022 (ROYALTY FREE) [V0Dbq0OfxnU].opus"
```
