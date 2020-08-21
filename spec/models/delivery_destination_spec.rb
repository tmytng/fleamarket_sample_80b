require 'rails_helper'
describe DeliveryDestination do
    describe '#create' do

    it "全項目が入力されていれば登録できる" do
        delivery_destination = build(:delivery_destination)
        expect(delivery_destination).to be_valid
    end

    it "苗字が空の場合登録ができない" do
        delivery_destination = build(:delivery_destination, family_name: nil)

        delivery_destination.valid?
        expect(delivery_destination.errors[:family_name]).to include("を入力してください")
    end

    it "名前が空の場合登録ができない" do
        delivery_destination = build(:delivery_destination, first_name: nil)
        delivery_destination.valid?
        expect(delivery_destination.errors[:first_name]).to include("を入力してください")
    end

    it "苗字（カナ）が空の場合登録ができない" do
        delivery_destination = build(:delivery_destination, family_name_kana: nil)
        delivery_destination.valid?
        expect(delivery_destination.errors[:family_name_kana]).to include("を入力してください")
    end

    it "名前（カナ）が空の場合登録ができない" do
        delivery_destination = build(:delivery_destination, first_name_kana: nil)
        delivery_destination.valid?
        expect(delivery_destination.errors[:first_name_kana]).to include("を入力してください")
    end

    it "住所（prefecture）が空の場合登録ができない" do
        delivery_destination = build(:delivery_destination, prefecture: nil)
        delivery_destination.valid?
        expect(delivery_destination.errors[:prefecture]).to include("を入力してください")
    end

    it "住所（city）が空の場合登録ができない" do
        delivery_destination = build(:delivery_destination, city: nil)
        delivery_destination.valid?
        expect(delivery_destination.errors[:city]).to include("を入力してください")
    end

    it "住所（address）が空の場合登録ができない" do
        delivery_destination = build(:delivery_destination, address: nil)
        delivery_destination.valid?
        expect(delivery_destination.errors[:address]).to include("を入力してください")
    end

    it "電話番号の形式が不適切でないか " do
        delivery_destination = build(:delivery_destination, phone_number: "a8012345678")
        delivery_destination.valid?
        expect(delivery_destination).to be_invalid
    end

    end
end