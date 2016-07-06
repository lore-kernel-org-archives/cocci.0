From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Wed, 6 Jul 2016 18:50:42 +0200
Subject: [Cocci] Adding parameter to function if missing
In-Reply-To: <bda6f254dbe94ad28468d5de4b6c3a17@vprd-opci0018.b-com.local>
References: <bda6f254dbe94ad28468d5de4b6c3a17@vprd-opci0018.b-com.local>
Message-ID: <4a1dcd24-efeb-902c-f239-d620850b4dbe@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> I am new to coccinelle and I have trouble to use it.

Which software versions do you try out here?


> What I want to do is add a missing parameter to a function call (bar)

This is usual.


> and add this parameter to the function prototype calling it if missing.

I imagine that there are further software development challenges to consider
for such a source code transformation in header files.


> I tried several ways to do it without success. If I add a negative depends on rule, it won't work.

Do you get an error message?


> @fn_with_user@
> identifier fn, foo;
> typedef my_type;

How do you think about the SmPL specification "type my_type;" here?


> parameter list pl;
> expression E; 
> @@
> 
> fn(my_type *foo, pl) {
> <+... 
> bar(foo, E);
> ...+> 
> }
> 
> @ test depends on !fn_with_user@
> identifier fn_with_user.fn;

Will it make sense to add the SmPL specification "type fn_with_user.my_type;" here?


> parameter list pl;
> expression E;
> @@    
> 
> fn(
> + my_type *foo,
> pl) {
> <+...
> bar(foo, E);

Would you like to merge this place with your first SmPL rule?

 bar(
+    foo,
     E);


> Could you help me ?

I hope so.

Regards,
Markus
