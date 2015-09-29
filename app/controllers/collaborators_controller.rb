class CollaboratorsController < ApplicationController
  def create
    @wiki = Wiki.friendly.find(params[:wiki_id])


    @collaborator = Collaborator.create(wiki_id: @wiki.id, user_id: params[:user_id])
    respond_to do |format|
      format.html
      format.js
    end
  end

  def destroy
    @wiki = Wiki.friendly.find(params[:wiki_id])
    @collab = Collaborator.find(params[:id])
    @user_id = @collab.user_id
    @collab.destroy

    respond_to do |format|
      format.html
      format.js
    end
  end
end