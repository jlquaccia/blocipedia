class CollaboratorsController < ApplicationController
  def create
    @wiki = Wiki.find(params[:wiki_id])
    @collaborator = Collaborator.create(wiki_id: params[:wiki_id], user_id: params[:user_id])

    respond_to do |format|
      format.html
      format.js
    end

    # Collaborator.create(wiki_id: params[:wiki_id], user_id: params[:user_id])

    # render js: "$('#"+params[:user_id]+"').text('Remove');"
    #            "$('.js-collaborators-count').html('<%= escape_html(pluralize(@wiki.collaborators.count, 'collaborator')) %>');"
  end

  def destroy
    @wiki = Wiki.find(params[:wiki_id])
    @collab = Collaborator.find(params[:id])
    @user_id = @collab.user_id
    @collab.destroy

    respond_to do |format|
      format.html
      format.js
    end
  end
end