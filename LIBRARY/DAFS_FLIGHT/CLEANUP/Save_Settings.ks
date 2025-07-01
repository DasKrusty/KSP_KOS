function saveSettings {
		local lex is lexicon(
			"stallSpeed", stallSpeed,
			"maxBankSpeed",maxBankSpeed,
			"bankFactor",bankFactor,
			"maxBank",maxBank
		).
		
		local filePath is path("0:/json/" + ship:name + "/autopilot.json").
		writejson(lex, filePath).
	}

	function loadSettings {
		local filePath is path("0:/json/" + ship:name + "/autopilot.json").
		
		if exists(filePath) {
			local lex is readjson(filePath).
			
			set stallSpeed to lex["stallSpeed"].
			set maxBankSpeed to lex["maxBankSpeed"].
			set bankFactor to lex["bankFactor"].
			set maxBank to lex["maxBank"].
			return true.
		}
		else return false.
	}
	
	loadSettings().