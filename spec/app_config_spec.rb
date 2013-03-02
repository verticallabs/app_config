require 'spec_helper'
require 'app_config'

describe AppConfig do
  it 'should load a yml file and parse it' do
    AppConfig.load(:settings)
    AppConfig.settings.category.setting.should == 'very yes'
  end

  it 'should override in development mode' do
    Rails.stub(:env).and_return('development')
    AppConfig.load(:settings)
    AppConfig.settings.category.setting.should == 'very no'
  end
end

