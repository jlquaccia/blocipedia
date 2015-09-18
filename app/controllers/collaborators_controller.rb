class CollaboratorsController < ApplicationController
  def create
    Collaborator.create(wiki_id: params[:wiki_id], user_id: params[:user_id])

    render js: "$('#"+params[:user_id]+"').text('Remove');"
               "$('.js-collaborators-count').html('<%= escape_javascript(render partial: 'wikis/count')) %>');"
  end
  end

  def destroy
    collab = Collaborator.find(params[:id])
    user_id = collab.user_id
    collab.destroy

    render js: "$('#"+user_id.to_s+"').text('Add');"
               "$('.js-collaborators-count').html('<%= escape_javascript(render partial: 'wikis/count')) %>');"
  end
  end
end