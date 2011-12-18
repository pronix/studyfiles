# -*- coding: utf-8 -*-
class AccountsController < ApplicationController
  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if params[:user][:password]
      if @user.update_with_password(params[:user])
        sign_in(@user, bypass: true)
        redirect_to edit_account_path, notice: "Пароль изменен"
      else
        render :edit
      end
    else
      @user.update_attributes(params[:user])
      redirect_to edit_account_path, notice: "Изменения сохранены"
    end
  end

end
