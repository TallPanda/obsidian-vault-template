---
name: yt2doc
description: Use when the user wants to transcribe a YouTube video or playlist to markdown. Triggers on "pull [url]", "transcribe [url]", "yt2doc [url]", or any request to extract content from a YouTube video for use in notes or guides.
version: 1.0.0
---

# yt2doc — YouTube to Markdown

Transcribes YouTube videos locally using Whisper and formats as markdown with chapter headings.

## Basic Usage

```bash
yt2doc --video "URL" -o /tmp/yt2doc-output.md
```

Then read `/tmp/yt2doc-output.md` with the Read tool.

**Always use `-o file.md`** — transcripts are large; never print to terminal.

## Key Options

| Option | Use when |
|---|---|
| `--video "URL"` | Single video (default) |
| `--playlist "URL"` | Full playlist |
| `--segment-unchaptered` | Video has no YouTube chapters — adds AI chapters via Ollama |
| `--timestamp-paragraphs` | Want timestamps on each paragraph |
| `--whisper-model tiny\|base\|small\|medium\|large-v3` | Speed vs accuracy (default: medium) |

## With AI Chaptering (for videos without chapters)

```bash
yt2doc --video "URL" \
  --segment-unchaptered \
  --llm-model llama3.1:8b \
  --llm-server http://<YOUR_OLLAMA_SERVER_URL>/v1 \
  -o /tmp/yt2doc-output.md
```

Set `--llm-server` to your local Ollama instance URL.

## Notes

- Videos with existing YouTube chapters use them automatically
- `--segment-unchaptered` requires a running Ollama instance
