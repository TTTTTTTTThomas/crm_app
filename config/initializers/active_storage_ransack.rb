# config/initializers/active_storage_ransack.rb

# Comprehensive fix for ActiveStorage Ransack compatibility
Rails.application.config.to_prepare do
  # Fix for ActiveStorage::Attachment
  ActiveStorage::Attachment.class_eval do
    def self.ransackable_attributes(auth_object = nil)
      ["blob_id", "created_at", "id", "name", "record_id", "record_type"]
    end

    def self.ransackable_associations(auth_object = nil)
      ["blob", "record"]
    end
  end

  # Fix for ActiveStorage::Blob
  ActiveStorage::Blob.class_eval do
    def self.ransackable_attributes(auth_object = nil)
      ["byte_size", "checksum", "content_type", "created_at", "filename", "id", "key", "metadata", "service_name"]
    end

    def self.ransackable_associations(auth_object = nil)
      ["attachments", "variant_records"]
    end
  end

  # Fix for ActiveStorage::VariantRecord if it exists
  if defined?(ActiveStorage::VariantRecord)
    ActiveStorage::VariantRecord.class_eval do
      def self.ransackable_attributes(auth_object = nil)
        ["blob_id", "created_at", "id", "variation_digest"]
      end

      def self.ransackable_associations(auth_object = nil)
        ["blob"]
      end
    end
  end
end
