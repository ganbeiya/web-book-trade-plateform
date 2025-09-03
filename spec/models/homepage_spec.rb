# spec/models/book_spec.rb
require 'rails_helper'

RSpec.describe Book, type: :model do
  describe 'scopes for homepage filtering' do
    let!(:cat1) { create(:category, name: 'Cat A') }
    let!(:cat2) { create(:category, name: 'Cat B') }

    let!(:book1) { create(:book,  title: 'Foo',    author: 'Alice', price: 5.0,  category: cat1, condition: 'New',        status: 'available', isbn: '1111') }
    let!(:book2) { create(:book,  title: 'Bar',    author: 'Bob',   price: 20.0, category: cat1, condition: 'Like New',  status: 'reserved',  isbn: '2222') }
    let!(:book3) { create(:book,  title: 'Baz',    author: 'Carol', price: 100.0,category: cat2, condition: 'Acceptable',status: 'available', isbn: '3333') }
    let!(:book4) { create(:book,  title: 'QuxFoo', author: 'Dave',  price: 15.0, category: cat2, condition: 'Good',       status: 'available', isbn: '4444') }

    context '.by_category' do
      it 'returns only books in the given category' do
        expect(Book.by_category(cat1.id)).to match_array([book1, book2])
      end

      it 'returns all when id is blank' do
        expect(Book.by_category(nil)).to match_array(Book.all)
      end
    end

    context 'price scopes' do
      it '.price_under_10 returns books cheaper than $10' do
        expect(Book.price_under_10).to eq([book1])
      end

      it '.price_between_10_and_50 returns books $10–50' do
        expect(Book.price_between_10_and_50).to match_array([book2, book4])
      end

      it '.price_over_50 returns books over $50' do
        expect(Book.price_over_50).to eq([book3])
      end
    end

    context '.by_condition' do
      it 'filters by exact condition' do
        expect(Book.by_condition('Like New')).to eq([book2])
      end

      it 'returns all when blank' do
        expect(Book.by_condition(nil)).to match_array(Book.all)
      end
    end

    context '.by_status' do
      it 'filters by exact status' do
        expect(Book.by_status('reserved')).to eq([book2])
      end

      it 'returns all when blank' do
        expect(Book.by_status('')).to match_array(Book.all)
      end
    end

    context '.search_q' do
      it 'finds by title substring' do
        expect(Book.search_q('Foo')).to match_array([book1, book4])
      end

      it 'finds by author substring' do
        expect(Book.search_q('ar')).to match_array([book2, book3]) # "Bar","Carol"
      end

      it 'finds by isbn' do
        expect(Book.search_q('333')).to eq([book3])
      end

      it 'returns all when blank' do
        expect(Book.search_q(nil)).to match_array(Book.all)
      end
    end
  end
end
