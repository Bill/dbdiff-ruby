require 'spec_helper.rb'
require 'enumerator_comparable'
require 'dbdiff'

describe DBDiff do
  describe 'no input' do
    let(:a){ [].to_enum}
    let(:b){ [].to_enum}
    it 'produces no records' do
      DBDiff.outer_join(a,b).should == [].to_enum
    end
  end
  describe 'identical input' do
    let(:a){ ['1 2'].to_enum}
    let(:b){ ['1 2'].to_enum}
    it 'produces no records' do
      DBDiff.outer_join(a,b).should == [].to_enum
    end
  end
  describe 'old no new' do
    let(:a){ ['1 2'].to_enum}
    let(:b){ [].to_enum}
    it 'produces one removed record' do
      DBDiff.outer_join(a,b).should == ['removed: 1 2'].to_enum
    end
  end
  describe 'new no old' do
    let(:a){ [].to_enum}
    let(:b){ ['1 2'].to_enum}
    it 'produces one added record' do
      DBDiff.outer_join(a,b).should == ['added: 1 2'].to_enum
    end
  end
  describe 'one modified record' do
    let(:a){ ['1 2'].to_enum}
    let(:b){ ['1 3'].to_enum}
    it 'produces one changed record' do
      DBDiff.outer_join(a,b).should == ['changed: 1 3'].to_enum
    end
  end
  describe 'old end greater' do
    let(:a){ ['2 1'].to_enum}
    let(:b){ ['1 1'].to_enum}
    it 'produces added record then removed record' do
      DBDiff.outer_join(a,b).should == ['added: 1 1','removed: 2 1'].to_enum
    end
  end
  describe 'new end greater' do
    let(:a){ ['1 1'].to_enum}
    let(:b){ ['2 1'].to_enum}
    it 'produces removed record then added record' do
      DBDiff.outer_join(a,b).should == ['removed: 1 1','added: 2 1'].to_enum
    end
  end
end
