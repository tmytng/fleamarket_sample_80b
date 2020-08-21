require 'rails_helper'
describe Product do
    describe '#create' do

        it "全項目が入力されていれば登録できる" do
            product = build(:product)
            expect(product).to be_valid
        end

        it "商品名が空の場合登録ができない" do
            product = build(:product, name: nil)
            product.valid?
            expect(product.errors[:name]).to include("を入力してください")
        end

        it "商品価格が空の場合登録ができない" do
            product = build(:product, price: nil)
            product.valid?
            expect(product.errors[:price]).to include("を入力してください")
        end
    

        it "商品説明が空の場合登録ができない" do
            product = build(:product, description: nil)
            product.valid?
            expect(product.errors[:description]).to include("を入力してください")
        end

        it "商品状態が空の場合登録ができない" do
            product = build(:product, condition: nil)
            product.valid?
            expect(product.errors[:condition]).to include("を入力してください")
        end

        it "商品サイズが空の場合登録ができない" do
            product = build(:product, size: nil)
            product.valid?
            expect(product.errors[:size]).to include("を入力してください")
        end

        it "手数料負担が空の場合登録ができない" do
            product = build(:product, shipping_cost: nil)
            product.valid?
            expect(product.errors[:shipping_cost]).to include("を入力してください")
        end

        it "発送までの日数が空の場合登録ができない" do
            product = build(:product, shipping_days: nil)
            product.valid?
            expect(product.errors[:shipping_days]).to include("を入力してください")
        end

        it "発送元（都道府県）が空の場合登録ができない" do
            product = build(:product, prefecture: nil)
            product.valid?
            expect(product.errors[:prefecture]).to include("を入力してください")
        end

        it "nameが40文字以下なら登録できる" do
            product = build(:product, name: "やややややややややややややややややややややややややややややややややややややややや") # 40文字
            expect(product).to be_valid
        end

        it "nameが40文字超過なら不適切" do
            product = build(:product, name: "ややややややややややややややややややややややややややややややややややややややややや") # 41文字
            product.valid?
            expect(product.errors[:name]).to include("は40文字以内で入力してください")
        end

        it "descriptionが1000文字以下なら登録できる" do
            product = build(:product, description: "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa") # 1000文字
            expect(product).to be_valid
        end

        it "descriptionが1000文字超過なら不適切" do
            product = build(:product, description: "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa") # 1001文字
            product.valid?
            expect(product.errors[:description]).to include("は1000文字以内で入力してください")
        end

        it "価格設定が300未満なら不適切" do
            product = build(:product, price: "299")
            product.valid?
            expect(product.errors[:price]).to include("は300以上の値にしてください")
        end

        it "価格設定が300以上なら適切" do
            product = build(:product, price: "300")
            product.valid?
            expect(product).to be_valid
        end

        it "価格設定が9999999以下なら適切" do
            product = build(:product, price: "9999999")
            product.valid?
            expect(product).to be_valid
        end

        it "10000000以上なら不適切" do
            product = build(:product, price: "10000001")
            product.valid?
            expect(product.errors[:price]).to include("は9999999以下の値にしてください")
        end
    end
end