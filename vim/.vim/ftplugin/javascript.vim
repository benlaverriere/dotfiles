let b:ale_fixers = ['eslint', 'prettier']
let g:javascript_conceal_function             = "ƒ"
map <buffer> <leader>l :exec &conceallevel ? "set conceallevel=0" : "set conceallevel=1"<CR>
