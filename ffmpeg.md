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