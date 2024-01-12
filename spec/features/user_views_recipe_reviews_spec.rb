require 'rails_helper'

describe 'Usuário vê avaliações de receitas' do
  it 'a partir da home' do
    owner = create(:user)
    user_1 = create(:user, email: 'user1@email.com')
    user_2 = create(:user, email: 'user2@email.com')
    user_3 = create(:user, email: 'user3@email.com')

    recipe = create(:recipe, title: 'Brigadeiro', user: owner)

    review_1 = create(:review, recipe:, user: user_1, text: 'Receita muito boa!', grade: 5)
    review_2 = create(:review, recipe:, user: user_2, text: 'Receita muito ruim', grade: 0)
    review_3 = create(:review, recipe:, user: user_3, text: 'Gostei da receita, parabéns!', grade: 4)

    visit root_path
    click_on 'Brigadeiro'

    expect(page).to have_content 'Avaliações'
    expect(page).to have_content 'Nota Média: 3/5'
    expect(page).to have_content 'Usuário: user1@email.com'
    expect(page).to have_content 'Usuário: user2@email.com'
    expect(page).to have_content 'Usuário: user3@email.com'
    expect(page).to have_content 'Receita muito boa!'
    expect(page).to have_content 'Receita muito ruim'
    expect(page).to have_content 'Gostei da receita, parabéns!'
  end

  it 'e não encontra avaliações existentes' do
    owner = create(:user)
    recipe = create(:recipe, title: 'Brigadeiro', user: owner)

    visit root_path

    click_on 'Brigadeiro'

    expect(page).to have_content 'Nenhuma avaliação encontrada'
  end
end
