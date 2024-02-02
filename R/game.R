game = function(
    num_games,
    win_probability,
    money_per_game,
    seed = sample(1:1000000,1)
    ){
  
# num_games <- 1000
# win_probability <- 0.5
# win_probability <- 0.49
# money_per_game <- 10
# seed = sample(1:1000000,1)
  
set.seed(seed)  
game_outcomes <- sample(c(0, 1), num_games, replace = TRUE, prob = c(1 - win_probability, win_probability))


# Calculate cumulative winnings and losses
cumulative_winnings <- cumsum(ifelse(game_outcomes == 1, money_per_game, 0))
cumulative_losses <- cumsum(ifelse(game_outcomes == 0, money_per_game, 0))

# Calculate total money through the night
total_money <- cumulative_winnings - cumulative_losses

# Create a data frame for ggplot
df <- data.frame(Game = 1:num_games, CumulativeWinnings = cumulative_winnings, CumulativeLosses = cumulative_losses, TotalMoney = total_money)

# Plot using ggplot
p = ggplot(df, aes(x = Game)) +
  # geom_line(aes(y = CumulativeWinnings, color = "Winnings"), size = 1) +
  # geom_line(aes(y = -CumulativeLosses, color = "Losses"), size = 1) +
  geom_hline(yintercept = 0, size = 1.1, color = "black") +
  labs(
    title = paste0("Winnings: $",df$TotalMoney[nrow(df)]),
       caption = paste("Seed:", seed),
       x = "Game Number",
       y = "Earnings",
       color = "Legend") +
  geom_line(aes(y = total_money), size = 1, color = "#2E6171") +
  scale_y_continuous(labels = scales::dollar_format(scale = 1), expand = c(0, 0)) + 
  scale_x_continuous(expand = c(0, 0)) + 
  theme(
    panel.grid.minor = element_line(colour = "gray95"),
    panel.background = element_rect(fill = NA),
    axis.ticks = element_line(colour = "gray80"),
    panel.grid.major = element_line(colour = "gray85"),
    axis.text.x = element_text(hjust = 0.75)
    )

if(df$TotalMoney[nrow(df)]<0) p + theme(plot.title = element_text(color = "red"))
else p
}