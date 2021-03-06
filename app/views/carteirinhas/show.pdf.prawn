I18n.t 

	require 'prawn'

pdf = Prawn::Document.new

pdf.font "Helvetica"

# Defining the grid 
# See http://prawn.majesticseacreature.com/manual.pdf
#pdf.define_grid(:columns => 5, :rows => 8, :gutter => 10) 
pdf.stroke_axis
pdf.bounding_box([0, 700], :width => 550, :height => 200) do
	pdf.stroke_bounds
end
pdf.stroke do
	pdf.vertical_line 700, 500, :at => 275

end

require 'prawn'

pdf = Prawn::Document.new(:page_size => "A4", :page_layout => :landscape)

pdf.font "Helvetica"

# Defining the grid 
# See http://prawn.majesticseacreature.com/manual.pdf
#pdf.define_grid(:columns => 5, :rows => 8, :gutter => 10) 

#eixo de coodernadas
#pdf.stroke_axis 

#quadrado maior
pdf.bounding_box([0, 500], :width => 750, :height => 250) do 
	pdf.stroke_bounds
end

 #risco do meio
pdf.stroke do
	pdf.vertical_line 500, 250, :at => 375

end

#quadrado menor esquerda
pdf.bounding_box([40, 495], :width => 330, :height => 240) do 
	pdf.stroke_bounds
end

#preenche quadrado
pdf.fill_polygon [5, 495], [35, 495], [35, 255],[5, 255]

#quadrado menor direita
pdf.bounding_box([380, 495], :width => 365, :height => 240) do 
	pdf.stroke_bounds
end

################################################
################### FRENTE #####################
################################################

# Começa validação
@infCl = ifInfoCarteirinha()
if @infCl != nil
	@nTE = @infCl.nome_tipo_estacionamento
	@res = @infCl.resolucao
	@uf = @infCl.uf
	@muni = @infCl.municipio
	@oE = @infCl.orgao_expedidor
	@nD = @infCl.nome_diretor
	@oED = @infCl.orgao_exp_diretor
	@rU = @infCl.regras_utilizacao
else
	@nTE = "ESTACIONAMENTO VAGA ESPECIAL"
	@res = "303/08 DO CONTRAN"
	@uf = "Paraná"
	@muni = "Campo Mourão"
	@oE = "DIRETRAN - Diretoria de Trânsito
	Prefeitura Municipal de Campo Mourão"
	@nD = "ANDRÉ NASCIMENTO CASARIN"
	@oED = "Diretor de Trânsito Municipal"
	@rU = "1 - A autorização concedida por meio deste cartão somente terá validade se o mesmo for apresentado no original e preencher as seguintes condições.
		 1.1 - Estiver colocado sobre o painel do veículo, com frente voltada para cima.
		  2 - Este cartão de autorização poderá ser recolhido a o ato da autorização suspenso ou cassado, a qualquer tempo , a critério do órgão de trânsito, especialmente se verificada irregularidade em sua utilização, considerando-se como tal, dentre outros:
			 2.1 - O empréstimo do cartão a terceiros;
		  3 - A presente autorização somente é valida para estacionar nas vagas devidamente sinalizadas com o símbolo Internacional de Acesso, especialmente criadas pelo órgão de trânsito para esse fim.
		  4 - Esta autorização também permite o uso em vagas de Estacionamento Rotativo Regulamentado, gratuito ou pago, sinalizadas com o Símbolo Internacional de Acesso, sendo obrigatória a utilização do Cartão do Estacionamento, bem como a obediência às suas normas de utilização.
		  5 - O desrespeito ao disposto neste cartão de autorização, bem como as demais regras de trânsito e a sinalização local, sujeitará o infrator as medidas administrativas, penalidades e pontuações previstas em lei."
end


#nome_tipo_estacionamento:string resolucao:string uf:string municipio:string orgao_expedidor:string nome_diretor:string orgao_exp_diretor:string regras_utilizacao:string
# Termina validação 

#marca d'agua
if (Carteirinha.find(params[:id]).categoria == 'Idoso')
	logo_path =  "#{Rails.root}/app/assets/images/idoso-sombra.png"
	pdf.rotate(45, :origin => [20, 360]) do
		pdf.image logo_path, :at => [20,360], :scale => 0.5
	end
	#estacionamento escrito em branco e rotacionado
	pdf.fill_color(0,0,0,0)
	pdf.rotate(90, :origin => [35, 255]) do
		pdf.draw_text "IDOSO", :size => 18, :at => [120, 265]
	end
	pdf.fill_color(100,100,100,100)
else
	logo_path =  "#{Rails.root}/app/assets/images/simbolo_deficiente_fisico-sombra.jpg"
	pdf.image logo_path, :at => [120,440], :scale => 1.6
	#estacionamento escrito em branco e rotacionado
	pdf.fill_color(0,0,0,0)
	pdf.rotate(90, :origin => [35, 255]) do
		pdf.draw_text "DEFICIENTE FÍSICO", :size => 18, :at => [70, 265]
	end
	pdf.fill_color(100,100,100,100)
end

#brasao republica
logo_path =  "#{Rails.root}/app/assets/images/brasao_republica.png"
pdf.image logo_path, :at => [50,495], :scale => 0.50

pdf.text_box "REPÚBLICA FEDERATIVA DO BRASIL",
:at => [110, 485]

pdf.text_box "CONSELHO NACIONAL DE TRÂNSITO",
:at => [110, 470]


string = @nTE

excess_text = pdf.text_box string,
	:at => [65, 440],
	:size => 16,
	:style => :bold

string = "CONFORME RESOLUÇÃO Nº " + @res
excess_text = pdf.text_box string,
	:at => [105, 415],
	:size => 8

string = "Nº DE REGISTRO:"
excess_text = pdf.text_box string,
	:at => [125, 395],
	:size => 10

pessoa = returnPesByCar(@carteirinha)
string = @carteirinha.identificador
excess_text = pdf.text_box string.to_s,
	:at => [215, 400],
	:size => 18,
	:style => :bold

#linha que divide
pdf.stroke do
	pdf.horizontal_line 70, 340, :at => 380
end

string = "Validade:"
excess_text = pdf.text_box string,
	:at => [50, 367],
	:size => 10

data = Carteirinha.find(params[:id]).data_vencimento
#[variable].strftime("%a, %B %d %T:%s %P")
#data.strftime('%d%m%Y')
printdata = data.strftime('%d/%m/%Y')

#t=Time::parse(data)
string = printdata.to_s
#string = "30/06/2222" ############################################
#string = Carteirinha.find(params[:id]).data_vencimento
excess_text = pdf.text_box string,
	:at => [95, 369],
	:size => 14,
	:style => :bold

string = "Unidade da Federação:"
excess_text = pdf.text_box string,
	:at => [50, 352],
	:size => 10

string = @uf ################################################
excess_text = pdf.text_box string,
	:at => [158, 352],
	:size => 10

string = "Município:"
excess_text = pdf.text_box string,
	:at => [50, 337],
	:size => 10

string = @muni ##########################################
excess_text = pdf.text_box string,
	:at => [100, 337],
	:size => 10

string = "Órgão expeditor:"
excess_text = pdf.text_box string,
	:at => [50, 322],
	:size => 10

string = @oE
excess_text = pdf.text_box string,
	:at => [130, 322],
	:size => 10

#string = "Prefeitura Municipal de Campo Mourão"
#excess_text = pdf.text_box string,
#	:at => [130, 312],
#	:size => 10

string = @nD
excess_text = pdf.text_box string,
	:at => [116, 275],
	:size => 9,
	:style => :bold

string = @oED
excess_text = pdf.text_box string,
	:at => [136, 265],
	:size => 8

################################################
##################### TRÁS #####################
################################################

string = "Nome do beneficiário:"
excess_text = pdf.text_box string,
	:at => [385, 485],
	:size => 9

#string = "Maria da Silva Pereira Maria da Silva Pereira Maria da Silva Pereira Maria da Silva Pereira Maria da Silva Pereira Maria da Silva Pereira Maria da Silva Pereira Maria da Silva Pereira Maria da Silva Pereira Maria da Silva Pereira Maria da Silva Pereira 333"
#string = getPessoa().nome
string = pessoa.nome
excess_text = pdf.text_box string,
	:at => [477, 490],
	:size => 15,
	:height => 40,
	:width => 260,
	:style => :bold

string = "RG:"
excess_text = pdf.text_box string,
	:at => [390, 453],
	:size => 9

#string = "1234667891011"
#string = getPessoa().rg
string = pessoa.rg
excess_text = pdf.text_box string,
	:at => [408, 455],
	:size => 12

string = "Orgão Emissor:"
excess_text = pdf.text_box string,
	:at => [480, 453],
	:size => 9


string = pessoa.rg_orgao
#string = "SSSP"
excess_text = pdf.text_box string.to_s,
	:at => [545, 455],
	:size => 12

string = "UF:"
excess_text = pdf.text_box string,
	:at => [590, 453],
	:size => 9


string = pessoa.rg_estado
#string = "PR"
excess_text = pdf.text_box string.to_s,
	:at => [608, 455],
	:size => 12


string = "REGRAS DE UTILIZAÇÃO"
excess_text = pdf.text_box string,
	:at => [500, 443],
	:size => 9,
	:style => :bold

string = @rU
excess_text = pdf.text_box string,
	:at => [386, 435],
	:size => 9,
	:height => 180,
	:width => 354
