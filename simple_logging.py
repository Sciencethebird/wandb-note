import wandb
import time
from simple_modules.print_lol import print_lol

# 2. Save any model configuration
config = dict (
  learning_rate = 0.01,
  momentum = 0.2,
  architecture = "CNN",
  dataset_id = "peds-0192",
  infra = "AWS",
)

# 1. Start a new W&B experiment run
wandb.init(
  project="wandb-examples",
  notes="tweak baseline",
  tags=["baseline", "paper1"],
  config=config,
)

wandb.config.learning_rate = 0.01

# [train your model]

# 3. Log metrics to visualize model performance
for i in range(100):
    time.sleep(10)
    wandb.log({"loss" : 10-i, "acc" : float(i)/10.0})