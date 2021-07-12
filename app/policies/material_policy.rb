class MaterialPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def initialize(user, material)
    @user = user
    @material = material
  end

  def create?
    @user.profile.role == 'admin'
  end

  def update?
    @user.profile.role == 'admin'
  end

  def destroy?
    @user.profile.role == 'admin'
  end
end
