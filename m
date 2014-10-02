From: julia.lawall@lip6.fr (Julia Lawall)
Date: Thu, 2 Oct 2014 22:22:44 +0200 (CEST)
Subject: [Cocci] How can i rename a specific structure field?
In-Reply-To: <CAHsAT8KbZS0xb4DpdL9oSKWRCJJ4gm0DWaiHi_+KvsqnFGaBNQ@mail.gmail.com>
References: <CAHsAT8KbZS0xb4DpdL9oSKWRCJJ4gm0DWaiHi_+KvsqnFGaBNQ@mail.gmail.com>
Message-ID: <alpine.DEB.2.02.1410022220240.2013@localhost6.localdomain6>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Thu, 2 Oct 2014, jmiguel hernandez wrote:

> if i have this?
> 
> typedef struct type1 {
> ? char8 a;
> ? char8 b;
> ? char8 c;
> }
> 
> typedef struct _interface?{
> ? type1 field1;
> }interface;
> 
> and want to change to?
> 
> typedef struct type1 {
> ? char8 d;
> ? char8 b;
> ? char8 c;
> }
> 
> typedef struct _protocol {
> ? type1 *field1;
> }interface;
> 
> interface *p
> 
> -p->field->a
> +p->field->d
> 
> I have tried just changing field1 to field2. This gives parsing errors.?
> 
> @@
> typedef interface;
> interface *p;
> typedef type1;
> type1 field1;
> @@
> <...
> -p->field1
> +p->fieldnew
> ...>

Drop the <... ...>.  You can think of it as being implicit when the patter 
is at top level.

The problem is that you have declared field1 to be an expression of type 
type1.  field1 is not that.  It is just the name of a field in a 
structure.  It should be declared as an identifier.  Once you know that p 
has type interface*, field1 should be unambiguous.  You don't have to 
specify the type of the field.

> also, similar question. What if i want to change the type.?
> 
> typedef struct _interface?{
> ? type2 *field1;
> }interface;

Not sure to understand what is wanted here.  Perhaps if you get the right 
answer for the previous question, this one will also be clear.

julia
