### Make tags for a blog post

https://cri.dev/posts/2023-10-08-improve-tags-blogging-openai-chatgpt-nodejs-ai/

Given a blog post, suggest appropriate tags for it.
The blog is about software programming.
Extract the 5 most important tags from the blog post.
The tags need to satisfy the following:
- short
- simple
- super generic
- one word (avoid putting words together)
- lowercase, no camelcase
- no duplicate concepts in the tags, e.g. githubcodespaces and github should become github and codespaces
- no numbers as tags
- when a tag gets too long, split it in two or generalize it
- avoid very specific tags
- do not use generic tags like "blog", "post", "programming", "software" etc. (if they're useful to categorize the post it's ok)
- the output should not contain any other extra text