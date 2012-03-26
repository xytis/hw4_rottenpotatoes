# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    Movie.create movie
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
  end
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.content  is the entire content of the page as a string.
  assert (page.body.match(/(#{e1}){1}.*(#{e2}){1}/))
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  rating_list.split(',').each do |rating|
    step %{I #{'un' if uncheck}check "ratings[#{rating.strip}]"}
  end
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
end

Then /I should see (all|none)+ of the movies/ do |selector|
  assert_equal( ((selector == 'all' and 11) or 1), page.all("table#movies tr").count )
end

Then /The (.*) of "(.*)" should be "(.*)"/ do |field, title, value|
  assert_equal(Movie.find_by_title(title).(send field), value)
end

