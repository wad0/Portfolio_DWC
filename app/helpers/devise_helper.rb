module DeviseHelper
  def bootstrap_alert(key)
    # BootstrapのAlertで使われているクラス名に置き換え
    case key
    when 'alert'
      'danger'
    when 'notice'
      'success'
    when 'error'
      'danger'
    end
  end
end
