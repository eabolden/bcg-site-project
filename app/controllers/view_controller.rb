class ViewController < ApplicationController

  def index
  end
  
  def list
    # given this page, show me all the articles on the page
    unsorted_articles = Article.find_all_by_page_id(params[:id])
    @articles = unsorted_articles
    #  Sort by "page.page_title", "article_weight", "article_title"
    @articles = unsorted_articles.sort_by {|an_article| [an_article.article_weight]}
    
    #  Put description into the Other Information sidebar item.
     @other_info = '<p>' + Time.now.to_s(:db) + '</p>' + %q*<p>Listing Information</p>*
  end
end
