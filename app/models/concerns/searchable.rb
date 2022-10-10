module Searchable extend ActiveSupport::Concern
  included do
    include Elasticsearch::Model
    include Elasticsearch::Model::Callbacks

    mapping do
      indexes :number, type: :integer
      indexes :body, type: :text
      indexes :chat_id, type: :integer
    end

    def self.search(query)
      # build and run search
      params = {
        query: {
          match: {
              body: { query: query, fuzziness: "AUTO"}
          }
        },
        "_source":{
          "includes":["number", "body", "chat_id"]
        }
      }
      self.__elasticsearch__.search(params)
    end
  end
end