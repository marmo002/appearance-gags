class GeoApiController < ApplicationController

  def states
    country_id = params[:countryId]

    criteria = {
      geonameId: country_id
    }

    results = GeoNames::Children.search(criteria)

    states = results['geonames'].map { |state|
      {
        geo_id: state['geonameId'],
        name: state['adminName1']
      }
    }

    respond_to do |format|
      format.json {
        render json: states
      }
    end

  end
end
