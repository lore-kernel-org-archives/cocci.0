From: lars@metafoo.de (Lars-Peter Clausen)
Date: Thu, 02 Oct 2014 22:44:58 +0200
Subject: [Cocci] How can i rename a specific structure field?
In-Reply-To: <CAHsAT8KbZS0xb4DpdL9oSKWRCJJ4gm0DWaiHi_+KvsqnFGaBNQ@mail.gmail.com>
References: <CAHsAT8KbZS0xb4DpdL9oSKWRCJJ4gm0DWaiHi_+KvsqnFGaBNQ@mail.gmail.com>
Message-ID: <542DB94A.5030900@metafoo.de>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On 10/02/2014 10:12 PM, jmiguel hernandez wrote:
> if i have this
>
> typedef struct type1 {
>    char8 a;
>    char8 b;
>    char8 c;
> }
>
> typedef struct _interface {
>    type1 field1;
> }interface;
>
> and want to change to
>
> typedef struct type1 {
>    char8 d;
>    char8 b;
>    char8 c;
> }
>
> typedef struct _protocol {
>    type1 *field1;
> }interface;
>
> interface *p
>
> -p->field->a
> +p->field->d
>
> I have tried just changing field1 to field2. This gives parsing errors.
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

If you want to change the field from being embedded in the parent struct to 
a pointer and rename the field at the same time the way to go is

@@
typedef interface;
interface *p;
@@
p->field1
-.a
+->b

That replaces the ".a" with a "->b"

- Lars
