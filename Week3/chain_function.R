## CHAIN FUNCTION ##

## standard way
## might be memory inefficient b/c of so many variables
by_package <- group_by(cran, package)
pack_sum <- summarize(by_package,
                      count = n(),
                      unique = n_distinct(ip_id),
                      countries = n_distinct(country),
                      avg_bytes = mean(size))

# Here's the new bit, but using the same approach we've
# been using this whole time.

top_countries <- filter(pack_sum, countries > 60)
result1 <- arrange(top_countries, desc(countries), avg_bytes)

# Print the results to the console.
print(result1)


## more memory efficient way
## terrible readability
result2 <-
        arrange(
                filter(
                        summarize(
                                group_by(cran,
                                         package
                                ),
                                count = n(),
                                unique = n_distinct(ip_id),
                                countries = n_distinct(country),
                                avg_bytes = mean(size)
                        ),
                        countries > 60
                ),
                desc(countries),
                avg_bytes
        )

print(result2)


## equivalent code to the two above but w/ chaining %>%
## much more readability
## memory efficient
result3 <-
        cran %>%
        group_by(package) %>%
        summarize(count = n(),
                  unique = n_distinct(ip_id),
                  countries = n_distinct(country),
                  avg_bytes = mean(size)
        ) %>%
        filter(countries > 60) %>%
        arrange(desc(countries), avg_bytes)

# Print result to console
print(result3)


# The call to print() at the end of the chain is optional,
# but necessary if you want your results printed to the
# console. Note that since there are no additional arguments
# to print(), you can leave off the parentheses after
# the function name. This is a convenient feature of the %>%
# operator.

cran %>%
        select(ip_id, country, package, size) %>%
        mutate(size_mb = size / 2^20) %>%
        # Your call to filter() goes here
        filter(size_mb <= 0.5) %>%
        # Your call to arrange() goes here
        arrange(desc(size_mb)) %>%
        print

students2 %>%
        gather(sex_class ,count ,-grade ) %>%
        separate(sex_class , c("sex", "class")) %>%
        print

students3 %>%
        gather(class, grade, class1:class5, na.rm = TRUE) %>%
        spread(test, grade) %>%
        ### Call to mutate() goes here %>%
        mutate(class = parse_number(class)) %>%
        print


# Like with the call to the print() function below,
# you can omit the parentheses after the function name.
# This is a nice feature of %>% that applies when
# there are no additional arguments to specify.
#
student_info <- students4 %>%
        select(id, name, sex) %>%
        ### Your code here %>%
        unique %>%
        print

gradebook <- students4 %>%
        ### Your code here %>%
        select(id, class, midterm, final) %>%
        print

sat %>%
        select(-contains("total")) %>%
        gather(part_sex, count, -score_range) %>%
        separate(part_sex, c("part", "sex")) %>%
        ### <Your call to group_by()> %>%
        group_by(part, sex) %>%
        mutate(total = sum(count),
               prop = count / total) %>% 
        print