# Search and replace

```
:[range]s/search/replace/g

:8,10 s/thisstring/thatstring/g
```

To do whole file: `%s/thisstring/thatstring/g`


# Copy/Paste

1. Position the cursor where you want to begin cutting.
2. Press v to select characters (or uppercase V to select whole lines).
3. Move the cursor to the end of what you want to cut.
4. Press d to cut (or y to copy).
5. Move to where you would like to paste.
6. Press P to paste before the cursor, or p to paste after.