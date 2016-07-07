From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Thu, 7 Jul 2016 18:14:43 +0200
Subject: [Cocci] Adding parameter to function if missing
In-Reply-To: <924f7230d5074b14b8658f65e00de85a@vprd-opci0018.b-com.local>
References: <bda6f254dbe94ad28468d5de4b6c3a17@vprd-opci0018.b-com.local>
 <alpine.DEB.2.10.1607061819400.3168@hadrien>
 <924f7230d5074b14b8658f65e00de85a@vprd-opci0018.b-com.local>
Message-ID: <66d3ac21-174b-dbf1-7c92-6b1f4f691968@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> I was confusing between the type name 'my_type' and type value 'my_type'.
> 
> What I would to do is something like that :
> 
> @fn_with_user@
> identifier fn, foo;
> typedef T = "my_type"; // '= ...' is not correct

Does such a specification indicate that you want to make a detail
better configurable?


> parameter list pl;
> @@
> 
> fn(T *foo, pl) {
> <+...
> bar(...);
> ...+>
> }
> 
> But I don't know how to link 'my_type' value to type T ...

Do you imagine to apply another parameter?

Is the functionality around "virtual" in the semantic patch language
relevant here?
http://coccinelle.lip6.fr/docs/main_grammar001.html


> I am sure that I am missing something obvious there :(

I hope that a better understanding can be achieved for special aspects
of your use case.

Regards,
Markus
