def make_loots
  random_name = (1..10).to_a.map{ ('a'..'z').to_a.sample }.join

  workspace = FactoryGirl.create :mdm_workspace,
                                  name:     random_name, # don't get name already taken
                                  owner_id: nil          # don't get exceeded users

  host      = FactoryGirl.create :mdm_host,    workspace_id: workspace.id
  service   = FactoryGirl.create :mdm_service, host_id:      host.id

  FactoryGirl.create_list(:mdm_loot, 3,
                           workspace_id: workspace.id,
                           host_id:      host.id,
                           service_id:   service.id,
                           ltype:        'pirate booty')
end


def validate
  loot_ids = make_loots.map { |e| e.id }
  loots    = ::Mdm::Loot.where(id: loot_ids)

  loots_where_last = loots.where(ltype: 'pirate booty').last
  loots_find_last  = loots.find_last_by_ltype('pirate booty')

  puts
  puts '*** loots_where_last ***'
  ap loots_where_last
  puts '************************'
  puts

  puts '*** loots_find_last ***'
  ap loots_find_last
  puts '***********************'
  puts

  puts 'loots_where_last == loots_find_last'
  print '==> '
  ap loots_where_last == loots_find_last
  "should be true"
end
