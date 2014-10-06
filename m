From: julia.lawall@lip6.fr (Julia Lawall)
Date: Mon, 6 Oct 2014 19:32:13 +0200 (CEST)
Subject: [Cocci] Fwd:  How can i rename a specific structure field?
In-Reply-To: <CAHsAT8KNyuRryt3PVSMQf8d=RJ7FRsZj6TCBVMG=4kx40OcYAQ@mail.gmail.com>
References: <CAHsAT8KbZS0xb4DpdL9oSKWRCJJ4gm0DWaiHi_+KvsqnFGaBNQ@mail.gmail.com>
 <542DB94A.5030900@metafoo.de>
 <CAHsAT8Knor4wG+398-BZ15Upwv1PWz=6VOGQvEXcHSGzimkD9Q@mail.gmail.com>
 <CAHsAT8KNyuRryt3PVSMQf8d=RJ7FRsZj6TCBVMG=4kx40OcYAQ@mail.gmail.com>
Message-ID: <alpine.DEB.2.10.1410061931460.2354@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Mon, 6 Oct 2014, jmiguel hernandez wrote:

>
> ?Forgot to reply to the list :S?
>
>
> Thank you,
> i was trying to Move a any field from a structure inside a data structure
> a.?
>
> @@
> typedef interface;
> interface *p;
> identifier fld;
> @@
> p->field1
> -.fld
> +.a.fld?
>
> But it looks like it is not matching anything. The type for p must match,
> and also the name of field1.?
> i am moving some elements from field1 into "struct a" which is on field1. So
> ideally, i was thinking on using a dependencylike?https://github.com/coccinelle/coccinellery/blob/master/iserr/patch1.co
> cci for the exceptions. ?

Could you send a small example of C code before and after the expected
transformation?

thanks,
julia


> but at this point i will be satified if i can just move everything from
> field1 into a.
> I also tried this, and defining fld as field instead of identifier.?
>
> @@
> typedef interface;
> interface *p;
> identifier fld;
> @@
> -p->field1.fld
> +p->field1.a.fld
>
> i am sorry i am just getting to understand the grammar. I wonder if there is
> an example slightly similar about structure transformations i could read.
> Thanks?
>
>
> On Thu, Oct 2, 2014 at 3:44 PM, Lars-Peter Clausen <lars@metafoo.de> wrote:
>       On 10/02/2014 10:12 PM, jmiguel hernandez wrote:
>             if i have this
>
>             typedef struct type1 {
>             ? ?char8 a;
>             ? ?char8 b;
>             ? ?char8 c;
>             }
>
>             typedef struct _interface {
>             ? ?type1 field1;
>             }interface;
>
>             and want to change to
>
>             typedef struct type1 {
>             ? ?char8 d;
>             ? ?char8 b;
>             ? ?char8 c;
>             }
>
>             typedef struct _protocol {
>             ? ?type1 *field1;
>             }interface;
>
>             interface *p
>
>             -p->field->a
>             +p->field->d
>
>             I have tried just changing field1 to field2. This
>             gives parsing errors.
>
>             @@
>             typedef interface;
>             interface *p;
>             typedef type1;
>             type1 field1;
>             @@
>             <...
>             -p->field1
>             +p->fieldnew
>             ...>
>
>
> If you want to change the field from being embedded in the parent
> struct to a pointer and rename the field at the same time the way to
> go is
>
> @@
> typedef interface;
> interface *p;
> @@
> p->field1
> -.a
> +->b
>
> That replaces the ".a" with a "->b"
>
> - Lars
>
>
>
>
>
>
