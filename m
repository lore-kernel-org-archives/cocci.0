From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Thu, 7 Jul 2016 17:43:19 +0200
Subject: [Cocci] Adding parameter to function if missing
In-Reply-To: <a2cccefd6c0f4986a03a61edf21be6cd@vprd-opci0018.b-com.local>
References: <bda6f254dbe94ad28468d5de4b6c3a17@vprd-opci0018.b-com.local>
 <4a1dcd24-efeb-902c-f239-d620850b4dbe@users.sourceforge.net>
 <a2cccefd6c0f4986a03a61edf21be6cd@vprd-opci0018.b-com.local>
Message-ID: <58ca2593-e9d4-688f-06c2-420b665c9d75@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

>     +++ /tmp/cocci-output-7971-016dcc-test.c
>     @@ -1,9 +1,9 @@
>      void f1(void *args) {
>     -    bar(anything);
>     +    bar(foo, anything);
>      }
>     [...]
> All call are replaced and no header are modified.

Would you like to achieve such source code transformations also in header files?


>> Will it make sense to add the SmPL specification "type
>> fn_with_user.my_type;" here?
> 
> Removing typedef and using type gave me the same result.

I suggest to reconsider also the relevance of the prefix "fn_with_user.".
Will such a references to a previous SmPL rule matter in your use cases
a bit more occasionally?


> - fn(void) {
> + fn(my_type foo) {
>    <+...
> - bar(E);
> + bar(foo, E);
>   ...+>
> }

How do you think about to use a shorter change variant?

 fn(
-   void
+   my_type foo
   )
 {
 <+...
 bar(
+    foo,
     E);
 ...+>
 }

Regards,
Markus
