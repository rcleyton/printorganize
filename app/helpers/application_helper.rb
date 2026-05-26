module ApplicationHelper
  def flash_class_for(type)
    {
      notice:  "border-indigo-100 bg-white/90 dark:bg-slate-900/90 text-indigo-600 dark:text-indigo-400 shadow-indigo-500/10",
      alert:   "border-amber-100 bg-white/90 dark:bg-slate-900/90 text-amber-600 dark:text-amber-400 shadow-amber-500/10",
      error:   "border-red-100 bg-white/90 dark:bg-slate-900/90 text-red-600 dark:text-red-400 shadow-red-500/10",
      success: "border-emerald-100 bg-white/90 dark:bg-slate-900/90 text-[#60c2a6] dark:text-emerald-400 shadow-emerald-500/10"
    }.fetch(type.to_sym, "border-slate-100 bg-white/90 text-slate-600")
  end

  def flash_icon_for(type)
    {
      notice:  "info",
      alert:   "warning",
      error:   "dangerous",
      success: "check_circle"
    }.fetch(type.to_sym, "notifications")
  end
end
