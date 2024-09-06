enum  LOG_TYPE 
{
	ARARA,
	ARMADEIRA
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

function LogArara():Log(LOG_TYPE.ARARA, "Arara", "Descrição da arara canindé: foda", s_arara) constructor{}
function LogArmadeira():Log(LOG_TYPE.ARMADEIRA, "ARANHA", "ARANHA BRABA: foda", s_armadeira) constructor{}