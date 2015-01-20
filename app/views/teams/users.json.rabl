collection @activities, :root => "members", :object_root => false
attributes :distance
child :user, :object_root => false do
  attributes :id, :name, :last_sync_date
end


