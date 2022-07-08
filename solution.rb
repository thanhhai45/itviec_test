User.select("*, (select count(*) from posts where posts.user_id=users.id) as post_count")
    .order("post_count desc")

# The query above is very low and bad:
# We in select query , we have subquery filter users => we call select user 2 times
# And we using query list post with user_id, so query have N+1 query 

# I suggest code like that:
User.joins(:posts)
    .select("users.*, count(posts.id) as post_count")
    .group_by("users.id")
    .order_by("post_count desc")
