# Implement RESTful routes for contacts app

get '/search' do
  # Return a search form
  erb :'contacts/search_form'
end

get '/results' do
  # Display results from search
  puts params
  cleansed_search_attributes = params[:contact].select {|key, value| !value.empty? }
  @contacts = Contact.where(cleansed_search_attributes)
  erb :'contacts/index'
end

# index
get '/contacts' do
  # Return all contacts
  @contacts = Contact.all.order(:last_name)
  puts @contacts
  erb :'contacts/index'
end

# new
get '/contacts/new' do
  # Return form for a new contact
  @contact = Contact.new
  erb :'contacts/new'
end

# create
post '/contacts' do
  # Create a new contact
  puts params[:contact]
  contact = Contact.create(params[:contact])
  redirect to "/contacts/#{contact.id}"
end

# show
get '/contacts/:id' do
  # Get a contact with specified id
  @contact = Contact.find(params[:id])
  erb :'contacts/show'
end

# edit
get '/contacts/:id/edit' do
  # Return form for editing an existing contact
  @contact = Contact.find(params[:id])
  erb :'contacts/edit'
end

# update
patch '/contacts/:id' do
  # Update a contact
  contact = Contact.find(params[:id])
  contact.update_attributes(params[:contact])
  redirect to "/contacts/#{contact.id}"
end

# delete confirmation
get '/contacts/:id/delete' do
  @contact = Contact.find(params[:id])
  erb :'contacts/delete'
end

# delete
delete '/contacts/:id' do
  # Delete a contact
  puts "I am in the delete action"
  puts params
  Contact.find(params[:id]).destroy!
  redirect to '/contacts'
end


get '/' do
  redirect to '/contacts'
end
