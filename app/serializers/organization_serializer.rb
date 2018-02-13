class OrganizationSerializer < ActiveModel::Serializer
  attributes :id, :name, :manager_id, :manager_name

  def manager_name
    manager = object.manager
    return nil unless manager.present?
    first_name = manager.first_name.nil? ? 'Nada' : manager.first_name
    last_name  = manager.last_name.nil? ? 'sin apellido' : manager.last_name
    first_name + ' ' + last_name
  end
end
