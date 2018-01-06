From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Sat, 6 Jan 2018 18:45:05 +0100
Subject: [Cocci] Automatic generation of SmPL rules by a script rule
In-Reply-To: <alpine.DEB.2.20.1801061822290.2579@hadrien>
References: <c1e3f44c-63ca-3306-840b-77d677e7e91f@users.sourceforge.net>
 <alpine.DEB.2.20.1801061800370.2579@hadrien>
 <5fb3bd3a-d78d-7d2c-050f-146887838d95@users.sourceforge.net>
 <alpine.DEB.2.20.1801061822290.2579@hadrien>
Message-ID: <e6fec4c0-eec1-d6cd-4928-7ad785be7ba4@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> Well, I was thinking that you could eg make a script like:
> 
> @script:ocaml@
> e << r.e;
> @@
> 
> Printf.printf "@@\n";
> Printf.printf "expression f;\n";
> Printf.printf "@@\n\n";
> Printf.printf "-f(%s);\n" e

I would prefer to use the available programming languages directly
instead of starting the spatch program for such file generation.


> But I'm not sure that the parser of script code would be happy with a @ in
> the script code, so you would have to do some trick to get around that.

Would you like to continue the clarification for the topic ?Configuration
or escaping of @ characters for embedded programming language scripts??
https://github.com/coccinelle/coccinelle/issues/36


> I'm not interested in spending time on it in the foreseeable future.

But I imagine that I would like to show related update suggestions
around SmPL scripts because of other approaches then.
Will alternatives become useful?


> If anyone else wants to, the code is there...

Would you like to point any specific source files out for the current
intermediate development status?

Regards,
Markus
