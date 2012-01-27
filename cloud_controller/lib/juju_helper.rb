class JujuHelper

  def create_service framework, app_name
    begin
      Kernel.exec("juju deploy --repository=/home/charms local:oneiric/#{framework} #{app_name}")
    rescue => e
      return e
    end
    true
  end

  def upload_code file_path, app_name
    begin
      Kernel.exec("juju scp #{file_path} #{app_name}/0:/home/application/")
    rescue => e
      return e
    end
    true
  end

  def destroy_service app_name
    begin
      Kernel.exec("juju destroy-service #{app_name}")
    rescue => e
      return e
    end
    true
  end

end
