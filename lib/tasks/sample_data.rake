require "tasks/sample_data/customer_factory"
require "tasks/sample_data/enterprise_factory"
require "tasks/sample_data/fee_factory"
require "tasks/sample_data/group_factory"
require "tasks/sample_data/inventory_factory"
require "tasks/sample_data/order_cycle_factory"
require "tasks/sample_data/payment_method_factory"
require "tasks/sample_data/permission_factory"
require "tasks/sample_data/product_factory"
require "tasks/sample_data/shipping_method_factory"
require "tasks/sample_data/taxon_factory"
require "tasks/sample_data/user_factory"
require "tasks/sample_data/order_factory"

# The sample data generated by this task is supposed to save some time during
# manual testing. It is not meant to be complete, but we try to improve it
# over time. How much is hardcoded here is a trade off between developer time
# and tester time. We also can't include secrets like payment gateway
# configurations in the code since it's public. We have been discussing this for
# a while:
#
# - https://community.openfoodnetwork.org/t/seed-data-development-provisioning-deployment/910
# - https://github.com/openfoodfoundation/openfoodnetwork/issues/2072
#
namespace :ofn do
  desc 'load sample data for development or staging'
  task sample_data: :environment do
    raise "Please run `rake db:seed` first." unless seeded?

    users = SampleData::UserFactory.new.create_samples

    enterprises = SampleData::EnterpriseFactory.new.create_samples(users)

    SampleData::PermissionFactory.new.create_samples(enterprises)

    SampleData::FeeFactory.new.create_samples(enterprises)

    SampleData::ShippingMethodFactory.new.create_samples(enterprises)

    SampleData::PaymentMethodFactory.new.create_samples(enterprises)

    SampleData::TaxonFactory.new.create_samples

    products = SampleData::ProductFactory.new.create_samples(enterprises)

    SampleData::InventoryFactory.new.create_samples(products)

    SampleData::OrderCycleFactory.new.create_samples

    SampleData::CustomerFactory.new.create_samples(users)

    SampleData::GroupFactory.new.create_samples

    SampleData::OrderFactory.new.create_samples
  end

  def seeded?
    Spree::User.count > 0 &&
      Spree::Country.count > 0 &&
      Spree::State.count > 0
  end
end
