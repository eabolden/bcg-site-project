class TheArticleController < ApplicationController
  layout "application.rhtml"
  
  def index
    list
    render :action => 'list'
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  def list
    #@article_pages, @articles = paginate :articles, :per_page => 10
    unsorted_articles = Article.find(:all)
    
    @articles = unsorted_articles
    
    #  Sort by "page.page_title", "article_weight", "article_title"
    @articles = unsorted_articles.sort_by {|an_article| [an_article.page.page_title,an_article.article_weight,an_article.article_title]}
    
    
    #  remove sidebar items
    @newsitems = %q**
    @additional_links = %q**
    @other_info = %q**
  end
  
  def view_list
    # given this page, show me all the articles on the page
    unsorted_articles = Article.find_all_by_page_id(params[:id])
    @articles = unsorted_articles
    #  Sort by "page.page_title", "article_weight", "article_title"
    @articles = unsorted_articles.sort_by {|an_article| [an_article.article_weight]}
    
    #  Put description into the Other Information sidebar item.
     @other_info = '<p>' + Time.now.to_s(:db) + '</p>' + %q*<p>Listing Information</p>*
     
     #  remove sidebar items
     @newsitems = %q**
     @additional_links = %q**
     #  @other_info = %q**
  end

  def show
    @article = Article.find(params[:id])
    #  remove sidebar items
    @newsitems = %q**
    @additional_links = %q**
    @other_info = %q**
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(params[:article])
    if @article.save
      flash[:notice] = 'Article was successfully created.'
      redirect_to :action => 'list'
    else
      render :action => 'new'
    end
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])
    if @article.update_attributes(params[:article])
      flash[:notice] = 'Article was successfully updated.'
      redirect_to :action => 'show', :id => @article
    else
      render :action => 'edit'
    end
  end

  def destroy
    Article.find(params[:id]).destroy
    redirect_to :action => 'list'
  end
end
