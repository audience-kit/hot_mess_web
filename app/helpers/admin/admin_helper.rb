module Admin::AdminHelper
  def import_form(name)
    render partial: 'admin/shared/import', locals: { model: name.to_s, name: name.to_s.capitalize, controller: "admin/#{name.to_s.pluralize}" }
  end
end