
# # En chef-repo/nodes/*.json se guardar los ::facts
log 'System Info' do
  message "Memory total: #{node['memory']['total']}
CPU cores: #{node['cpu']['total']}
CPU model: #{node['cpu']['0']['model_name']}"
  level :info
end
