enum  LOG_TYPE 
{
	ARARA,
	ARMADEIRA,
	CIDADE_VELHA
}

function Log (_type=LOG_TYPE.ARARA, 
			  _name = "Nome",
			  _description = "Description",
			  _disclosure_sprite = s_disclosure) constructor {

	type				= _type
	name				= _name;
	description			= _description;
	disclouse_sprite	= _disclosure_sprite;
}

function LogArara():Log(LOG_TYPE.ARARA, "Arara-canindé", "A arara-canindé (Ara ararauna) é uma ave impressionante, famosa por sua plumagem azul e amarela. Os tupinambás a adoravam, capturando-a viva para usar suas penas em rituais importantes, mas sem causar danos, soltando-a em seguida. Social e inteligente, essa arara tem um bico forte para quebrar sementes e desempenha um papel crucial na dispersão de sementes nas florestas tropicais.", s_arara) constructor{}
function LogArmadeira():Log(LOG_TYPE.ARMADEIRA, "Armadeira", "A aranha-armadeira (Phoneutria) é considerada a mais venenosa do mundo, podendo atingir até 17 cm de comprimento. Conhecida por seu comportamento agressivo, é extremamente veloz e capaz de saltar até 40 cm. Quando ameaçada, adota uma postura defensiva característica,'se armando' ao levantar as patas dianteiras em posição de ataque.", s_armadeira) constructor{}
function LogCidadeVelha():Log(LOG_TYPE.CIDADE_VELHA,"Cidade Velha", "Situada entre a Pedra da Urca e a Cara de Cão, foi escolhida em 1567 como o ponto inicial de ocupação para a retomada da Baía dos Franceses. A topografia da região, com suas colinas e enseadas, oferecia um local ideal para a construção de fortificações.", s_armadeira) constructor{}