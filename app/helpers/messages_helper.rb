module MessagesHelper
  def recipients_options
    options_from_collection_for_select(current_company.users, :id, :email)
  end
end
