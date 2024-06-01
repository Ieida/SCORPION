extends Node


func uncapitalize(s: String) -> String:
	var ns: String = ""
	for i in s.length():
		var c = s[i]
		if i != 0 and c == c.to_upper():
			ns += "_"
		ns += c.to_lower()
	return ns
