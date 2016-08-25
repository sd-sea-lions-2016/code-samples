# Implement RESTful routes for contacts app
get '/search' do
  erb :'contacts/search_form'
end

get '/results' do
  params[:contact].reject!{|key,value| value.empty? }
  @contacts = Contact.where(params[:contact])
  erb :'contacts/index'
end

# index
get '/contacts' do
  @contacts = Contact.all
  erb :'contacts/index'
end

# new
get '/contacts/new' do
  @contact = Contact.new
  erb :'contacts/new'
end

# create
post '/contacts' do
  @contact = Contact.new(params[:contact])
  if @contact.save
    redirect '/contacts'
  else
    status 422
    erb :'contacts/new'
  end
end

# show
get '/contacts/:id' do
  @contact = Contact.find(params[:id])
  erb :'contacts/show'
end

# edit
get '/contacts/:id/edit' do
  @contact = Contact.find(params[:id])
  erb :'contacts/edit'
end

# update
patch '/contacts/:id' do
  @contact = Contact.find(params[:id])
  if @contact.update_attributes(params[:contact])
    redirect "/contacts/#{@contact.id}"
  else
    status 422
    erb :'contacts/edit'
  end
end

# delete confirmation
get '/contacts/:id/delete' do
  @contact = Contact.find(params[:id])
  erb :'contacts/delete'
end

# delete
delete '/contacts/:id' do
  @contact = Contact.find(params[:id])
  if @contact.destroy
    redirect '/contacts'
  else
    status 422
    erb :'contacts/delete'
  end
end

get '/' do
  redirect to '/contacts'
end
