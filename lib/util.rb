module Util
  module UpdaterUtils
  def delete_all
    solr.delete_by_query '*:*'
    solr.commit
  end

  def update_all
    delete_all
    add_all
  end

  def delete id
    solr.delete_by_id id
    solr.commit
  end

  def update id
    delete id
    add id
  end
end
end