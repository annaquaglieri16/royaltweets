#' @importFrom tibble tibble
#'
NULL

#' All royal tweets .
#'
# ' Collection of weets relating to the Royal Wedding of Meghan Markle and Prince Harry, held on the 19th of May 2018 in Windsor Castle, UK. In order to obtain representative tweets from before, around, and after the time of the wedding we collected 3,000 tweets every week beginning at the 15th of March to the 31st of May (Thursday mornings, Australian time). We also collected 3,000 tweet every day for 12 days beginning from the 17th of May and ending on the 28th of May. We only collected tweets containing any of the following hashtags: #MeghanMarkle, #TheRoyalWedding, #PrinceHarry, #HarryAndMeghan, #MeghanAndHarry, #RoyalWedding
#'
#' @format A data frame with 18 variables:
#' \describe{
#'   \item{\code{text}}{Text of the tweet},
#'   \code{favorited},
#'   \code{favoriteCount}, \code{replyToSN}, \code{created},  \code{truncated},  \code{replyToSID},\code{id},\code{replyToUID},
#'   \code{statusSource}, \code{screenName}, \code{retweetCount} (\code{isRetweet}, \code{retweeted}, \code{longitude}, \code{latitude}, \code{tweetID} and \code{retweet_from}
#'
"royaltweets"

#' @format A data frame with 53940 rows and 10 variables:
#' \describe{
#'   \item{price}{price, in US dollars}
#'   \item{carat}{weight of the diamond, in carats}


#' @importFrom tibble tibble
#'
NULL

#' All royal tweets further cleaned and tokenized by words
#'
#' @format A data frame with 18 variables: \code{word}, \code{favorited},
#'   \code{favoriteCount}, \code{replyToSN}, \code{created},  \code{truncated},  \code{replyToSID},\code{id},\code{replyToUID},
#'   \code{statusSource}, \code{screenName}, \code{retweetCount} (\code{isRetweet}, \code{retweeted}, \code{longitude}, \code{latitude}, \code{tweetID} and \code{retweet_from}
#'
"royalwords"
