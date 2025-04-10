# Créer des villes
10.times do
  City.create(name: Faker::Address.city, zip_code: Faker::Address.zip_code)
end

# Créer des utilisateurs et les lier à une ville
10.times do
  user = User.create(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    description: Faker::Lorem.sentence,
    email: Faker::Internet.email,
    age: rand(18..60),
    city_id: rand(1..10)  # Assigner un utilisateur à une ville
  )
end

# Créer des gossips
20.times do
  Gossip.create(
    title: Faker::Lorem.sentence,
    content: Faker::Lorem.paragraph,
    user_id: rand(1..10)  # Assigner un gossip à un utilisateur
  )
end

# Créer des tags
10.times do
  Tag.create(title: Faker::Lorem.word)
end

# Assigner des tags aux gossips
Gossip.all.each do |gossip|
  gossip.tags << Tag.all.sample(rand(1..3))  # Assigner entre 1 et 3 tags
end

# Créer des messages privés
5.times do
  pm = PrivateMessage.create(content: Faker::Lorem.sentence, sender_id: rand(1..10))
  pm.recipients = User.where.not(id: pm.sender_id).sample(rand(1..3))  # Assigner des destinataires
end

# Créer des commentaires et des likes
20.times do
  comment = Comment.create(content: Faker::Lorem.sentence, gossip_id: rand(1..20), user_id: rand(1..10))
  Like.create(user_id: rand(1..10), likable: comment)
  Like.create(user_id: rand(1..10), likable: Gossip.find(rand(1..20)))
end

Supposons que nous ayons déjà des gossips et des commentaires en base

# Récupère tous les utilisateurs, gossips et commentaires pour pouvoir leur attribuer des likes
users = User.all
gossips = Gossip.all
comments = Comment.all

# Crée 20 likes au hasard
20.times do
  # Choisis un utilisateur au hasard
  user = users.sample
  likable = [gossips, comments].sample.sample  # Choisit aléatoirement un gossip ou un commentaire

  # Créer un like pour cet utilisateur et cet objet
  Like.create!(
    user: user,
    likable: likable
  )
end
puts "20 likes ont été ajoutés avec succès."