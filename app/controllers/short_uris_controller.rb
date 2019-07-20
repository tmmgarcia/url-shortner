class ShortUrisController < ApplicationController
  def index
    @host_name = host_name
  end

  def new
    @short_uri = ShortUri.new
  end

  def create
    service = ShortUris::Creator.new(original_uri: permitted_params[:original_uri]).()
    if service.success?
      redirect_to short_uri_url(service.short_uri)
    else
      @short_uri = service.short_uri
      render 'new'
    end
  end

  def show
    @short_uri = ShortUri.find(params[:id])
  end

  def path
    service          = ShortUris::Searcher.new(path: params[:path])
    destination_path = service.call ? ShortUris::Redirecter.new(short_uri: service.short_uri).() : root_path
    redirect_to destination_path
  end

  private

  def permitted_params
    params.require(:short_uri).permit(:original_uri)
  end

  private

  def host_name
    ENV['RESOLVER_HOSTNAME']
  end
end
