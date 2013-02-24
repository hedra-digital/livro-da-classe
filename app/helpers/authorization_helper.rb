module AuthorizationHelper
  def is_organizer?(book=nil, user=nil)
    book ||= @book
    user ||= @current_user
    
    if book.nil? || user.nil?
      return false
    else
      book.organizer == user
    end
  end

  def is_collaborator?(book=nil, user=nil)
    book ||= @book
    user ||= @current_user
    
    if book.nil? || user.nil?
      return false
    else
      book.users.include?(user)
    end
  end
end