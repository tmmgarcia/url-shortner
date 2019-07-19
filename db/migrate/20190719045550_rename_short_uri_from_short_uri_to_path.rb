class RenameShortUriFromShortUriToPath < ActiveRecord::Migration[5.2]
  def change
    rename_column :short_uris, :short_uri, :path
  end
end
