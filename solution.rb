User.select("*, (select count(*) from posts where posts.user_id=users.id) as post_count")
    .order("post_count desc")

# The query above is very low and bad:
# We in select query , we have subquery filter users => we call select user 2 times
# And we using query list post with user_id, so query have N+1 query 

# I suggest code like that:
# I think we join to the table posts
# then we using select not subquery get users.* and count post
# then group by with users.id
# then order by with post_count desc
User.joins(:posts)
    .select("users.*, count(posts.id) as post_count")
    .group("users.id")
    .order("post_count desc")
