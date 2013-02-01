# Crape

Craigslist Scrape (Crape) will search Craigslist for a set of keywords, print out the results and optionally send an email or text message for each item found.

It is meant to be run on a cron job and to send only newly found items every 'n' minutes.

## Installation

    $ gem install crape

## Usage

    $ crape <category> <query> [--in=place] [--color=true|false] [--verbose] [--notify]

The first run will dump all of the findings to the terminal.  Thereafter each run will only list the findings published since the last run.

### Example

Let's find all blue ford cars in kansas:

    $ crape cars_and_trucks 'blue ford' --in=kansas

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
