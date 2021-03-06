require File.dirname(__FILE__) + '/../test_helper'
require 'the_article_controller'

# Re-raise errors caught by the controller.
class TheArticleController; def rescue_action(e) raise e end; end

class TheArticleControllerTest < Test::Unit::TestCase
  fixtures :articles

  def setup
    @controller = TheArticleController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new

    @first_id = articles(:one).id
  end

  def test_index
    get :index
    assert_response :success
    assert_template 'list'
  end

  def test_list
    get :list

    assert_response :success
    assert_template 'list'

    assert_not_nil assigns(:articles)
  end

  def test_show
    get :show, :id => @first_id

    assert_response :success
    assert_template 'show'

    assert_not_nil assigns(:article)
    assert assigns(:article).valid?
  end

  def test_new
    get :new

    assert_response :success
    assert_template 'new'

    assert_not_nil assigns(:article)
  end

  def test_create
    num_articles = Article.count

    post :create, :article => {}
# this isn't the create used???
    #assert_response :redirect
    #assert_redirected_to :action => 'list'

#    assert_equal num_articles + 1, Article.count
  end

  def test_edit
    get :edit, :id => @first_id

    assert_response :success
    assert_template 'edit'

    assert_not_nil assigns(:article)
    assert assigns(:article).valid?
  end

  def test_update
    post :update, :id => @first_id
    assert_response :redirect
    assert_redirected_to :action => 'show', :id => @first_id
  end

  def test_destroy
    assert_nothing_raised {
      Article.find(@first_id)
    }

    post :destroy, :id => @first_id
    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_raise(ActiveRecord::RecordNotFound) {
      Article.find(@first_id)
    }
  end
end
