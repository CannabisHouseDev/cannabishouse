require "rails_helper"

RSpec.describe QuestionTypesController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/question_types").to route_to("question_types#index")
    end

    it "routes to #new" do
      expect(get: "/question_types/new").to route_to("question_types#new")
    end

    it "routes to #show" do
      expect(get: "/question_types/1").to route_to("question_types#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/question_types/1/edit").to route_to("question_types#edit", id: "1")
    end


    it "routes to #create" do
      expect(post: "/question_types").to route_to("question_types#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/question_types/1").to route_to("question_types#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/question_types/1").to route_to("question_types#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/question_types/1").to route_to("question_types#destroy", id: "1")
    end
  end
end
