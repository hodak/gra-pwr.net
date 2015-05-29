# # Create users
# jon   = User.create! email: 'jon.snow@winterfell.com'
# hodor = User.create! email: 'hodor@hodor.com'
# arya  = User.create! email: 'arya.stark@winterfell.com'

# # Create digs from the context of users
# jon.digs.create!    title: "First Jon's digg"
# arya.digs.create!   title: "First Arya's digg"
# hodor.digs.create!  title: "HODOR", body: "Hodor HODOR Hodor"
# arya.digs.create!   title: "Second Arya's digg"
# jon.digs.create!    title: "Second Jon's digg", body: "Digg's body"

# digs  = Dig.all

# # Create comments from the context of digs
# digs.each do |dig|
#   dig.comments.create! body: "Jon's comment", owner: jon
#   dig.comments.create! body: "HODOR", owner: hodor
#   dig.comments.create! body: "Arya's comment", owner: arya
# end

# users          = User.all
# comments       = Comment.all
# possible_votes = [-1, 1]

# # Let's vote on digs & comments
# users.each do |user|
#   digs.each do |dig|
#     dig.votes.create! amount: possible_votes.sample, voter: user
#   end

#   comments.each do |comment|
#     comment.votes.create! amount: possible_votes.sample, voter: user
#   end
# end

