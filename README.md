# NY-Giants-Win-Probability

**Overview**

Recreation of New York Giants win probability for Week 2 of the 2023 season vs Arizona Cardinals using a logistic equation. Given necessary factors, this win probability model can be used in any in-game scenario. Logit model includes derivation of new factor "Play-Action Impact" which increased the Giants chances of winning. 

Logit model correctly predicted 85% of total game win probability as compared to ESPN's win probability model.

**Background**

I selected week 2 of the 2023 season because the Giants were down 0-20 at halftime with a miniscule 5% win probability. Then the Giants coaches significantly changed their win probability by employing a play-action offensive gameplan.

**Methodology**

Metrics Analyzed

Play-by-play data: quarter, down, yards to first down, time remaining (in seconds), distance from scoring a touchdown, score difference

Play-action factor: opponent's defensive alignment, total yards gained in first half, total touchdowns in first half, total yards gained in second half, total touchdowns in second half

**Model Development**

The logit model builds upon Stephen Hill's logistic equation in "Building a Basic, In-Game Win Probability Model for the NFL" (2017) by adding a new factor "play-action impact" based on an offensive coaching decision at halftime.

**Limitations and Future Work**

Limited access to data: pre-game rankings of each team's offense and defense, home field advantage factor, momentum factor.

Future considerations: time remaining factor should be more heavily weighted, making outputs interactive, analyzing offenses employing play-action vs non-play-action for a more accurate "play-action impact" factor.

**Author**

Patrick Holsey

**Acknowledgments**

Hill, Stephen. Building a Basic, In-Game Win Probability Model for the NFL. Medium.com, 2017. 
ESPN.com NFL Gamecast and Play-by-Play. Five-Thirty-Eight NFL Win Probability Pre-Game and In-Game. https://www.espn.com/nfl/game/_/gameId/401547421/giants-cardinals
Haddad, Chris. Difference Between Play Action & RPO In Football. vIQtorysports.com, 2024. https://www.viqtorysports.com/play-action-rpo-read-option/#:~:text=The%20difference%20between%20the%20play,confusing%20to%20the%20naked%20eye

**License**
This project is licensed under the MIT License - see the LICENSE file for details
