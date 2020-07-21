Vagrant.configure("2") do |config|
  config.vm.box = "bento/centos-8"
  config.vm.provider "virtualbox" do |v|
    v.customize ["setextradata", :id, "VBoxInternal2/SharedFoldersEnableSymlinksCreate/v-root", "1"]
        v.customize ["setextradata", :id, "VBoxInternal2/SharedFoldersEnableSymlinksCreate//vagrant", "1"]
        v.customize ["setextradata", :id, "VBoxInternal2/SharedFoldersEnableSymlinksCreate/vagrant", "1"]
       v.memory = 4096
  end
  # this is to fix fork/exec errors in Terraform
  config.vm.synced_folder ".", "/vagrant", mount_options: ['dmode=0755', 'fmode=0774']
end
