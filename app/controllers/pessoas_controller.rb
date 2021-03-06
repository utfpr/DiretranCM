class PessoasController < ApplicationController
  before_action :set_pessoa, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_usuario!, only: [:show, :new, :edit]
  before_action :authFuncOrAdmin, only: [:index, :destroy]
  #before_action :authFuncionario, only: [:index, :show]
  #before_action :isActualUser, only: [:edit]



  # GET /pessoas
  # GET /pessoas.json
  def index
    @pessoas = Pessoa.all
  end

  # GET /pessoas/1
  # GET /pessoas/1.json
  def show
  end

  # GET /pessoas/new
  def new
    @pessoa = Pessoa.new
  end

  # GET /pessoas/1/edit
  def edit
  end

  # POST /pessoas
  # POST /pessoas.json
  def create
    @pessoa = Pessoa.new(pessoa_params)
    @pessoa.usuario_id=current_usuario.id
    @pessoa.cpf = current_usuario.cpf

    #alterPessoa(@pessoa)

    respond_to do |format|
      if @pessoa.save
        format.html { redirect_to new_endereco_path, notice: 'Pessoa foi criada com sucesso' }
        #format.html { redirect_to @pessoa, notice: 'Pessoa criada com sucesso.' }
        #format.json { render :show, status: :created, location: @pessoa }
      else
        format.html { render :new }
        format.json { render json: @pessoa.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pessoas/1
  # PATCH/PUT /pessoas/1.json
  def update
    respond_to do |format|
      if @pessoa.update(pessoa_params)
        #format.html { render :edit, notice: 'Atualizado com sucesso.' }
        #format.html {redirect_to new_endereco_path, notice: 'Dados pessoais atualizados com sucesso'}
        format.html {redirect_to returnEndIf(), notice: 'Dados pessoais atualizados com sucesso'}

        #format.html { redirect_to @pessoa, notice: 'Atualizado com sucesso.' }
        #format.json { render :show, status: :ok, location: @pessoa }
      else
        format.html { render :edit }
        format.json { render json: @pessoa.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pessoas/1
  # DELETE /pessoas/1.json
  def destroy
    @pessoa.destroy
    respond_to do |format|
      format.html { redirect_to pessoas_url, notice: 'Pessoa removida com sucesso.' }
      format.json { head :no_content }
    end
  end

  def retNome
    return @pessoa.nome
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pessoa
      @pessoa = Pessoa.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def pessoa_params
      params.require(:pessoa).permit(:nome, :sexo, :rg, :cpf, :data_nascimento, :telefone, :celular, :usuario_id, :email, :rg_orgao, :rg_estado)
    end
end
