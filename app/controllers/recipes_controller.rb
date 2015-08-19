class RecipesController < ApplicationController
    before_action :find_recipe, only: [:show, :edit, :update, :destroy]
    before_action :authenticate_user!, except: [:index, :show]
    
    def index
        @recipe = Recipe.all.order("created_at DESC")
    end
    
    
    def show
        
    end
    
    
    def new
        @recipe = current_user.recipes.build
    end
    
    # make a new recipe and pass it white listed params
    # this requires a 'Recipe' model to work. Otherwise it doesn't know what 'Recipe' is.
    def create
        @recipe = current_user.recipes.build(recipe_params)
        
        # if the new recipe saves OK, go to that recipe
        if @recipe.save
            redirect_to @recipe, notice: "Successfully created new recipe"
        # otherwise, go to the new page (which would just be going 'back')
        else
            render 'new'
        end
    end
    
    def edit
        
    end
    
    def update
        # if updating the recipe was successfull, go to that recipe
        if @recipe.update(recipe_params)
            redirect_to @recipe
        # otherwise, go to the edit page again (essentailly, going 'back')
        else
            render 'edit'
        end
    end
    
    def destroy
        #destroy the recipe, then goes back to the root
        @recipe.destroy
        redirect_to root_path, notice: "Successfully deleted recipe"
    end
    
    
    
    private
    
    def find_recipe
        @recipe = Recipe.find(params[:id])
    end
    
    # when creating a new recipe, it looks for these params, they are white listed.
    def recipe_params
        params.require(:recipe).permit(:title, :description, :image, ingredients_attributes: [:id, :name, :_destroy],
        directions_attributes: [:id, :step, :_destroy])
    end
    
end
