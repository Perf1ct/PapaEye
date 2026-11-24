# PapaEye training sources

`scripts/train_public_models.py` downloads these public datasets to a temporary
directory, extracts numeric features, trains the three small local MLP models,
and removes the downloaded source files when it exits. Raw examples are not
copied into this project.

- **Text:** [HC3](https://huggingface.co/datasets/Hello-SimpleAI/HC3), `reddit_eli5`
  subset, English Reddit answers compared with early ChatGPT answers. Dataset
  card license: CC BY-SA 4.0. See the [dataset card](https://huggingface.co/datasets/Hello-SimpleAI/HC3)
  and its source-copyright note. This model is not validated for Russian.
- **Code:** [Python AI Code Detection](https://huggingface.co/datasets/serafeimdossas/ai-code-detection),
  dataset card marked MIT; based on Rosetta Code and IBM Project CodeNet. The
  model is limited to this paired Python-task benchmark. Source dataset terms
  may impose additional obligations; see the [dataset card](https://huggingface.co/datasets/serafeimdossas/ai-code-detection).
- **Images:** [CIFAKE](https://huggingface.co/datasets/yanbax/CIFAKE_autotrain_compatible),
  MIT; 32x32 CIFAR-10 images and Stable Diffusion 1.4 generations. This is only
  a low-resolution benchmark, not representative of modern high-resolution
  image generation. See the [dataset card](https://huggingface.co/datasets/yanbax/CIFAKE_autotrain_compatible)
  and [paper](https://arxiv.org/abs/2303.14126).

Validation uses held-out groups for text questions and code tasks, so paired
answers for one question or task are not split between train and test. Image
validation is a random holdout from CIFAKE's training split and should not be
interpreted as performance on current image generators.

The bundled model file stores weights, sample counts, validation metrics, and
source notes only—not source text, code, or image files. Model scores are not
proof of authorship and can fail outside the listed benchmark domains.
