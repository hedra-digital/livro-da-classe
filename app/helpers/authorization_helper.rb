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

  def can_read?(book=nil, user=nil)
    book ||= @book
    user ||= @current_user

    if book.nil? || user.nil?
      return false
    else
      Permission.get_permissions_for(book.project.status, user.profile.id).read
    end
  end

  def can_write?(book=nil, user=nil)
    book ||= @book
    user ||= @current_user

    if book.nil? || user.nil?
      return false
    else
      Permission.get_permissions_for(book.project.status, user.profile.id).write
    end
  end

  def can_execute?(book=nil, user=nil)
    book ||= @book
    user ||= @current_user

    if book.nil? || user.nil?
      return false
    else
      Permission.get_permissions_for(book.project.status, user.profile.id).execute
    end
  end

  def can_review?(book=nil, user=nil)
    book ||= @book
    user ||= @current_user

    if book.nil? || user.nil?
      return false
    else
      Permission.get_permissions_for(book.project.status, user.profile.id).review
    end
  end

  def can_git?(book=nil, user=nil)
    book ||= @book
    user ||= @current_user

    if book.nil? || user.nil?
      return false
    else
      Permission.get_permissions_for(book.project.status, user.profile.id).git
    end
  end
end