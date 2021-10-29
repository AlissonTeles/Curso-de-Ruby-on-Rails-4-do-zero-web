class ProdutosController < ApplicationController
  before_action :set_produto, only: %i[edit update destroy]

  def index
    @produtos_por_nome = Produto.all.order(:nome).limit 5
    @produtos_por_preco = Produto.all.order(:preco).limit 2
    @produtos_por_descricao = Produto.all.order(:descricao).limit 3
  end

  def create
    produto_params
    nome = params['nome']
    descricao = params['descricao']
    quantidade = params['quantidade']
    preco = params['preco']
    valores = produto_params
    @produto = Produto.new valores
    if @produto.save
      flash[:notice] = 'Produto salvo' # flash dura mais de uma requisição na Web#
      redirect_to root_url
    else
      renderiza :new
    end
    # produto = Produto.create valores#
  end

  def edit
    renderiza :edit
  end

  def update
    produto_params
    valores = produto_params
    if @produto.update valores
      flash[:notice] = 'Produto Atualizado com Sucesso'
      redirect_to root_url
    else
      renderiza :edit
    end
  end

  def new
    @produto = Produto.new
    renderiza :new
  end

  def busca
    @buscar_nome = params[:nome]
    @produtos = Produto.where 'nome like ?', "%#{@buscar_nome}%"
  end

  def destroy
    if @produto.destroy
      flash[:notice1] = 'Produto Excluido'
      redirect_to root_url
    else
      redirect_to root_url
    end
  end

  private

  def renderiza(view)
    @departamentos = Departamento.all
    render view
  end

  def set_produto
    id = params[:id]
    @produto = Produto.find(id)
  end

  def produto_params
    params.require(:produto).permit :nome, :descricao, :quantidade, :preco, :departamento_id
  end
end

%( Aqui onde fazemos as mudanças em nosso controller, que antes estava no nosso HTML, agora nossa lógica está aqui e o HTML realmente no HTML views )
