library(tidyverse)
library(cowplot)

args <- commandArgs(trailingOnly = TRUE)

if (length(args) < 0) {
  stop("Insufficient arguments provided")
} else if (length(args) > 3) {
  stop("Too many arguments provided")
}

workpath <- args[1]
filepath <- args[2]
inputfile <- args[3]

data <- read_csv(paste(filepath, inputfile, sep = ""))
data <- rename_with(data, tolower)

# Replaces spaces in headers with underscores
colnames(data) <- gsub(" ", "_", colnames(data))

sum_by_category <- data %>%
  group_by(category) %>%
  summarise(amount = sum(amount))

sum_by_category <- sum_by_category %>%
  mutate(percentage = amount / sum(amount) * 100)

sum_by_payment <- data %>%
  group_by(payment_method) %>%
  summarise(amount = sum(amount))

sum_by_payment <- sum_by_payment %>%
  mutate(percentage = amount / sum(amount) * 100)

#Creates a bar chart
bar_chart <- ggplot(data,
                    aes(x = expence, y = amount, fill = expence)) +
  geom_bar(stat = "identity") +
  ggtitle("Expences") +
  theme(plot.title = element_text(hjust = 0.5))

# Creates a pie charts
#for category
category_chart <- ggplot(sum_by_category,
                         aes(x = "", y = amount, fill = category)) +
  geom_bar(stat = "identity", width = 1, colour = "black", linewidth = 0.20) +
  coord_polar("y", start = 20) +
  ggtitle("Category Distribution") +
  theme_void() +
  theme(plot.title = element_text(hjust = 0.5)) +
  scale_fill_manual(values = rainbow(nrow(sum_by_category)),
                    labels = paste0(sum_by_category$category, " (",
                                    round(sum_by_category$percentage, 1), "%)"))

# for payment method
payment_chart <- ggplot(sum_by_payment,
                        aes(x = "", y = amount, fill = payment_method)) +
  geom_bar(stat = "identity", width = 1, colour = "black", linewidth = 0.20) +
  coord_polar("y", start = 20) +
  ggtitle("Payment Method Distribution") +
  theme_void() +
  theme(plot.title = element_text(hjust = 0.5)) +
  scale_fill_manual(values = rainbow(nrow(sum_by_payment)),
                    labels = paste0(sum_by_payment$payment_method, " (",
                                    round(sum_by_payment$percentage, 1), "%)"))

plots <- plot_grid(bar_chart,
                   plot_grid(category_chart, payment_chart),
                   ncol = 1, nrow = 2,
                   align = "v")

# Saves the pie chart as a PDF
graphname <- paste(strsplit(inputfile, split = "[.]")[[1]][1], "pdf", sep = ".")

ggsave(graphname,
       plot = plots,
       width = 30, height = 20, units = "cm",
       path = paste(workpath, filepath, sep = ""))
