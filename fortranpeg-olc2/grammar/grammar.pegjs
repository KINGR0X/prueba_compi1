start
    = _ assignments _

assignments "Assignments"
    = head:assignment tail:(_ assignment)* {
        return [head, ...tail.map(t => t[1])];
    }

assignment "Assignment"
    = id:Identificador _ eq:Igual _ value:Production _ ";" {
        return { id, value };
    }

Production "Production"
    =  exp:ExpressionList tail:(_ "/" _ ExpressionList _)* {
        return [exp, ...tail.map(t => t[3])];
    }

ExpressionList "Expression_List"
    = head:Expression tail:(_ Expression)* {
        return [head, ...tail.map(t => t[1])];
    }

Expression "Expression"
    = head:(groupedExpression / string / Caracteres / Identificador) tail:(Kleene / Plus / Question)? {
        if (tail) {
            const operator = tail[1];
            let type;
            if (operator === "*") {
                type = "Kleene";
            } else if (operator === "+") {
                type = "Plus";
            } else if (operator === "?") {
                type = "Question";
            }
            return { type, value: `(${head})` + operator };
        }
        return { type: "primitive", value: head };
    }

groupedExpression "Grouped_Expression"
    = "(" _ inner:ExpressionList _ ")" {
        return { type: "group", value: inner };
    }

Kleene "Kleene"
    = _ "*"

Plus "Plus"
    = _ "+"

Question "Question"
    = _ "?"

string "String"
    = singleQuotedString / doubleQuotedString

doubleQuotedString "Double_Quotes_String"
    = "\"" chars:([^"\\] / "\\" .)* "\"" {
        return chars.join('');
    }

singleQuotedString "Single_Quotes_String"
    = "'" chars:([^'\\] / "\\" .)* "'" {
        return chars.join('');
    }

Caracteres "CHAR"
    = "[" _ head:TipoCaracter  tail:(_ TipoCaracter )* _ "]" {
        return [head, ...tail.map(t => t[1])];
    }

TipoCaracter 
    = CharRango  / AlphanumericWithSymbols

CharRango  =  start:[a-zA-Z0-9] _ "-" _ end:[a-zA-Z0-9] {
        const range = [];
        for (let i = start.charCodeAt(0); i <= end.charCodeAt(0); i++) {
            range.push(String.fromCharCode(i));
        }
        return range;
    }

AlphanumericWithSymbols
    = char:[a-zA-Z0-9!@#$%^&*_+=;':"|,.<>? \(  \) ] {
        return char;
    }

Identificador "ID"
    = first:[_a-zA-Z] rest:[_a-zA-Z0-9]* {
        return first + rest.join('');
    }

Igual "Equal_Symbol"
    = '='

Punto_coma "end_chain"
    = ';'

_ "whitespace"
    = [ \t\r\n]*
