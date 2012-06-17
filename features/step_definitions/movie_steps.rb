# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
    movie[:description] = ''
    Movie.create!(movie)
  end
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.content  is the entire content of the page as a string.
  i1 = page.body.index(e1)
  i2 = page.body.index(e2)
  assert i1 and i2 and i1 < i2
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
  if uncheck then
    c = "uncheck"
  else
    c = "check"
  end
  rating_list.split(',').each do |r|
    step "I #{c} \"ratings[#{r.strip}]\""
  end
end

Then /I should see all of the movies/ do
  Movie.all.each do |m|
    step "I should see \"#{m.title}\""
  end
end

Then /I should( not)? see movies with rating "(.*)"/ do |shouldnt_see, rate|
  @movies = Movie.find_all_by_rating(rate)
  @movies.each do |m|
    i = page.body.index(m.title)
    if shouldnt_see then
      assert i.nil?
    else
      assert i
    end
  end
end

Then /the director of "(.*)" should be "(.*)"/i do |title, director|
  m = Movie.find_by_title(title)
  assert m
  assert m.director == director
end