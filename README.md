# PapaEye

PapaEye is a local desktop prototype with experimental starter models for text,
Python code, and images. It does not claim that AI authorship can be proved:
results depend on the training benchmark and can be wrong. The bundled text
model is English-only, the code model is Python-only, and the image model uses
32x32 benchmark images; see [DATASETS.md](./DATASETS.md).

## Use on Android and iPhone

The responsive, installable PWA lives in `pwa\`. It runs the same bundled
weights in the browser without uploading the text, code, or image. Open
`pwa\index.html` on a local development server for a desktop preview.

To install it on a phone, host the `pwa\` files on an HTTPS origin. On iPhone,
open that URL in Safari and choose Share → Add to Home Screen. On Android,
open it in Chrome and choose Install app / Add to Home screen. After the first
online visit completes, the service worker caches the app and model for offline
use. A public HTTPS host or an HTTPS server on your own network is needed; this
workspace does not publish the app automatically. See [phone deployment steps](./pwa/DEPLOY.md).

For the selected GitHub Pages route, `python scripts\package_github_pages.py`
creates `dist\PapaEye-GitHub-Pages.zip`. It contains only the mobile site and a
GitHub Actions deployment workflow; the Windows source and datasets are not
included. Follow the included README to publish it from your GitHub account.

Retraining public models with `scripts\train_public_models.py` updates both
`originlens\pretrained_models.json` and `pwa\models.json`; rebuild the Windows
EXE after retraining.

## Run from source

Requires Python 3.10+ and Pillow:

```powershell
python -m pip install -r requirements.txt
python main.py
```

## Build the Windows app

Run `build.bat`. The standalone application is written to `dist\release\PapaEye.exe`;
it includes Python and the required runtime files.

## Train the bundled starter models

The starter models use public benchmark data. Their language and dataset limits
are described in [DATASETS.md](./DATASETS.md); in particular, the text model
was not validated on Russian, and the image model uses only 32x32 benchmark
images.

To reproduce training, install `training-requirements.txt`, then run:

```powershell
python scripts\train_public_models.py
build.bat
```

The script downloads source datasets to a temporary directory, keeps only
feature vectors in memory, writes the trained model weights and provenance to
`originlens\pretrained_models.json`, and removes the downloaded files.

## Train a model

On the Training tab, import a UTF-8 CSV with these columns:

```csv
modality,label,content
text,human,"A human-written example"
code,ai,"print('an AI-labeled example')"
image,human,photos/example.jpg
```

Use `text`, `code`, or `image`; labels can be `human` / `ai` or `0` / `1`.
Image paths may be absolute or relative to the CSV. Provide at least eight
examples per label and modality. The app extracts numeric features locally and
stores those features, not the original text. Image paths are read during import
and are not stored.

Training and inference run offline. The reported score is not a calibrated
probability, and validation performance on a small or unrepresentative dataset
does not imply performance on other content.
