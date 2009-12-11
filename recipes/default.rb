java_pkg = value_for_platform(
  "ubuntu" => {
    "default" => "sun-java6-jdk"
  },
  "debian" => {
    "default" => "sun-java6-jdk"
  },
  "default" => "sun-java6-jdk"
)

execute "update-java-alternatives" do
  command "update-java-alternatives -s java-6-sun"
  only_if do platform?("ubuntu", "debian") end
  ignore_failure true
  returns 1
  action :nothing
end

package java_pkg do
  response_file "java.seed"
  action :install
  notifies :run, resources(:execute => "update-java-alternatives"), :immediately
end

package "ant"



