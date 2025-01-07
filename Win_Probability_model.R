#Win Probability Model
#(Holsey, Patrick)

#install packages
install.packages("nflfastR")
install.packages("caTools")

#load packages
library(tidyverse)
library(nflfastR)
library(readr)
library(caTools)
library(plotly)

#read 2023 play-by-play data
season23 <- read_csv("~Northwestern/MSDS 456 - Sports Performance Analytics/Win Probability Model/play_by_play_2023.csv")
View(season23)

#filter by NYG pbp
NYGfiltered <- filter(season23, home_team == "NYG" | away_team=="NYG") 
View(NYGfiltered)

#view structure of dataset
str(NYGfiltered)

#team in possession wins game

NYGfiltered <- mutate(NYGfiltered, winner = ifelse(home_score > away_score, home_team, away_team))
NYGfiltered = NYGfiltered %>% mutate(poswins = ifelse(winner == posteam, "Yes","No"))
NYGfiltered$qtr = as.factor(NYGfiltered$qtr) 
NYGfiltered$down = as.factor(NYGfiltered$down)
NYGfiltered$poswins = as.factor(NYGfiltered$poswins)

#creating data subset removing "No Play" plays and OT plays
NYGreg = NYGfiltered %>% filter(play_type != "NA" & qtr != 5 & down != "NA" & poswins != "NA") %>% select(game_id, game_date, posteam, home_team, away_team, winner, qtr, down, ydstogo, game_seconds_remaining, yardline_100, score_differential, poswins)

#creating train and test datasets. set seed for reproducible results.
set.seed(123)
split = sample.split(NYGreg$poswins, SplitRatio = 0.8)
train = NYGreg %>% filter(split == TRUE)
test = NYGreg %>% filter(split == FALSE)

#win probability model 1
model1 = glm(poswins ~ qtr + down + ydstogo + game_seconds_remaining + yardline_100 + score_differential, train, family = "binomial")
summary(model1)

#prediction model 1
predict1 = predict(model1, train, type = "response")
train = mutate(train, predict1home = ifelse(posteam == home_team, predict1, 1 - predict1))
train2 = mutate(train, predictNYG = ifelse(posteam == "NYG", predict1, 1 - predict1))

#create win probability visual
ggplot(filter(train2, game_id == "2023_02_NYG_ARI"),aes(x=game_seconds_remaining,y=predictNYG)) + 
  geom_line(linewidth=1, color="blue") + 
  geom_point(size = 0.9, color = "red") +
  scale_x_reverse() + 
  ylim(c(0,1)) + 
  theme_minimal() + 
  xlab("Time Remaining (in seconds)") + 
  ylab("NYG Win Probability") + 
  ggtitle("NYG Win Probability | Time Remaining")

#adding PAI factor
PAI = 15.948

#team in possession wins game
NYGfiltered2 <- mutate(NYGfiltered, winner = ifelse(home_score > away_score, home_team, away_team))
NYGfiltered2 = NYGfiltered2 %>% mutate(poswins2 = ifelse(winner == posteam, "Yes","No"))
NYGfiltered2$qtr = as.factor(NYGfiltered$qtr) 
NYGfiltered2$down = as.factor(NYGfiltered$down)
NYGfiltered2$poswins2 = as.factor(NYGfiltered2$poswins2)
NYGfiltered2$yardline_PAI = NYGfiltered$yardline_100-PAI

#creating data subset removing "No Play" plays and OT plays
NYGreg2 = NYGfiltered2 %>% filter(play_type != "NA" & qtr != 5 & down != "NA" & poswins2 != "NA") %>% select(game_id, game_date, posteam, home_team, away_team, winner, qtr, down, ydstogo, game_seconds_remaining, yardline_PAI, score_differential, poswins2)

#creating train and test datasets. set seed for reproducible results.
set.seed(123)
split2 = sample.split(NYGreg2$poswins2, SplitRatio = 0.8)
train2 = NYGreg2 %>% filter(split == TRUE)
test2 = NYGreg2 %>% filter(split == FALSE)

#win probability model 2 with PAI
model2 = glm(poswins2 ~ qtr + down + ydstogo + game_seconds_remaining + yardline_PAI + score_differential, train2, family = "binomial")
summary(model2)

#prediction model 2
predict2 = predict(model2, train2, type = "response")
train2 = mutate(train2, predict2home = ifelse(posteam == home_team, predict2, 1 - predict2))
train3 = mutate(train2, predictNYG2 = ifelse(posteam == "NYG", predict2, 1 - predict2))

#create win probability visual
ggplot(filter(train3, game_id == "2023_02_NYG_ARI"),aes(x=game_seconds_remaining,y=predictNYG2)) + 
  geom_line(linewidth=1, color="blue") + 
  geom_point(size = 0.9, color = "red") +
  scale_x_reverse() + 
  ylim(c(0,1)) + 
  theme_minimal() + 
  xlab("Time Remaining (in seconds)") + 
  ylab("NYG Win Probability") + 
  ggtitle("NYG Win Probability + PAI | Time Remaining")

