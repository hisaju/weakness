module ApplicationHelper
  def flash_class(key)
    {
      info: 'info',
      alert: 'danger',
      notice: 'success',
      warning: 'warning'
    }.fetch(key.to_sym) { 'danger' }
  end

end
