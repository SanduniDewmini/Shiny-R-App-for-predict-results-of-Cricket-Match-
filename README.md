**Shiny R App: Cricket Match Winning Probability Calculator**

This is a **basic Shiny app** designed to calculate the **winning probability of a selected cricket team** based on its **recent performances** against the same opposition team and other teams. The app uses **fundamental probability concepts**, including:

* **Classical probability**
* **Combinations**
* **Permutations**

The app allows users to input team statistics and match context, and it outputs the probability of winning for the selected team.

**Purpose:**

* Demonstrate how basic probability theories can be applied to cricket match predictions.
* Provide a simple interactive tool for cricket enthusiasts and students to explore probability concepts in a practical context.

## 🧩 Features

- Calculate winning probability for a particular cricket team.
- Inputs based on **latest team performances** against opposition teams.
- Uses **basic probability theories** to derive outcomes.
- Interactive and easy-to-use **Shiny interface**.

 ---

## ⚙️ How It Works

1. Select a team and its opposition.
2. Enter performance statistics (e.g., wins, losses, matches played).
3. The app calculates the **probability of winning** using:
   - Classical probability
   - Combinations
   - Permutations
4. Outputs the probability in an **interactive format**.

---

## 💻 Running the App Locally

### Option 1: Clone the repo and run
```r
# Clone the repo
git clone https://github.com/YourUsername/CricketMatchPredictor.git

# Set working directory
setwd("CricketMatchPredictor")
```
# Run the Shiny app
shiny::runApp()
