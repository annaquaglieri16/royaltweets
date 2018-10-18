library(tidyverse)
library(tidytext)


# Create all_tweets after removing duplicated tweets
all_tweets <- readRDS("data-raw/rbind_raw_tweets.rds")

# With the code below, we first create a new column `retweet_from` in the data frame `all_tweets` using `mutate(RT = str_extract(string = text,pattern = "^RT @(\\w+)"))`. In each row, this column will contain the Twitter handle of the user that was retweeted. This is accomplished by using the `str_extract` function from the `stringr` package which extract the pattern "RT @user_handle" from every retweet (in regular expression form `^RT @(\\w+)`). Finally, `mutate(RT = str_replace_all(RT,"^RT ",""))` will replace every `RT ` occurence with nothing so that only the user handle is left in the `retweet_from`column.

reg_retweets <- "^RT @(\\w+)"
all_tweets <- all_tweets %>%
  mutate(tweetID = 1:n()) %>%
  select(-X1) %>%
  mutate(retweet_from = str_extract(text, reg_retweets)) %>%
  mutate(retweet_from = str_replace_all(retweet_from, "^RT ", ""))

# Create all words - unnest token by words using tidytext

# Now let's convert everything to the one-token-per-row format `r emo::ji('star2')`!
#
# The code below will take the data frame `all_tweets` and convert it into a tidy text format. At this stage we do not filter out retweets but we will know which words come from a retweeted tweet and who was retweeted thanks to the columns `isRetweet` and `retweet_from`. The following is a breakdown of the steps performed by the chunk below:
#
# * Take the `all_tweets` data frame;
# * `filter(!duplicated(all_tweets))` to filter duplicated tweets;
# * `mutate(text = str_replace_all(text, replace_reg, ""))` will clean up the text from all unnecessary signs and language elements that are not meaningful text (summarised in the regular expression `replace_reg`);
# * `unnest_tokens(word, text, token = "regex", pattern = unnest_reg)` is the key part of this step and this is when the tidy text magic will happen!! Here we used a regular expression as our `token`. This is a very useful trick that we borrowed from [Text mining with R](https://www.tidytextmining.com/tidytext.html) `r emo::ji('closed_book')` and allows us to keep `#` and `@` from Twitter text.
# * We then remove stop words using the `stop_words` data frame provided with `tidytext` `r emo::ji('package')` and we filter out, for any retweet, any word that contains the handle of the user retweeted: `filter(!(word==retweet_from))`. Keeping these words would overestimate the number of times that a user was mentioned since the handle wasn't part of the actual tweet but is appears in retweeted tweets by default.

replace_reg <- "https://t.co/[A-Za-z\\d]+|http://[A-Za-z\\d]+|&amp;|&lt;|&gt;|RT|https"
unnest_reg <- "([^A-Za-z_\\d#@']|'(?![A-Za-z_\\d#@]))"

all_words <- all_tweets %>% #
  filter(!duplicated(all_tweets)) %>% #
  mutate(text = str_replace_all(text, replace_reg, "")) %>%
  unnest_tokens(word, text, token = "regex", pattern = unnest_reg) %>%
  filter(!word %in% stop_words$word,str_detect(word, "[a-z]")) %>%
  filter(!(word==retweet_from))

#save(all_words, file="data/royalwords.rda")
#save(all_tweets, file="data/royaltweets.rda")

royalwords <- all_words
royaltweets <- all_tweets

# For more compression
devtools::use_data(royalwords,overwrite = TRUE)
devtools::use_data(royaltweets,overwrite = TRUE)
tools::checkRdaFiles("data/")
