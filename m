From: julia.lawall@lip6.fr (Julia Lawall)
Date: Tue, 7 Oct 2014 09:27:20 +0200 (CEST)
Subject: [Cocci] Fwd: How can i rename a specific structure field?
In-Reply-To: <CAHsAT8+sOxOH-a7vYTnHuMPhgUuuZ8zSSQJXxfiSDFka1noG7g@mail.gmail.com>
References: <CAHsAT8KbZS0xb4DpdL9oSKWRCJJ4gm0DWaiHi_+KvsqnFGaBNQ@mail.gmail.com>
 <542DB94A.5030900@metafoo.de>
 <CAHsAT8Knor4wG+398-BZ15Upwv1PWz=6VOGQvEXcHSGzimkD9Q@mail.gmail.com>
 <CAHsAT8KNyuRryt3PVSMQf8d=RJ7FRsZj6TCBVMG=4kx40OcYAQ@mail.gmail.com>
 <alpine.DEB.2.10.1410061931460.2354@hadrien>
 <CAHsAT8+sOxOH-a7vYTnHuMPhgUuuZ8zSSQJXxfiSDFka1noG7g@mail.gmail.com>
Message-ID: <alpine.DEB.2.10.1410070924110.2345@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

I'm sorry, but this is not helpful enough.  For example, your semantic
patch contains the type interface, but the code contains INTERFACES and
INTERFACE2.  Without having an exact semantic patch that you want to run
and an exact C file on which you expect an exact result, all I can do is
make something that does something, but I can't tell if it does what you
actually want to do.

I don't actually need the typedefs.  Coccinelle doesn't care about why you
want to make the transformation, only about the code that you want to
transform.

For example, I made the following semantic patch:

@@
typedef interface;
interface *p;
identifier field1,fld;
@@
  p->field1
- ->fld
+ ->a.fld

and the following C program:

int main () {
  interface *a;
  a->Configuration->field1;
  a->Configuration->field2.boolean;
  a->Configuration->field3;
}

This works fine, but I don't know if it is what you want to do.

julia

On Mon, 6 Oct 2014, jmiguel hernandez wrote:

>
> //I had something similar to this?
>
> typedef struct {
> ? unsigned char ? ? ? ? ? ? ? field1;
> ? TYPE3 ? ? ? ? ? ? ? ? ? ? ? field2;
> ? unsigned char ? ? ? ? ? ? ? field3;
> } CONFIGURATION;
>
> typedef struct _INTERFACE {
> ? CONFIGURATION ? ? ? ?*Configuration;
> ? TYPE2 ? ? ? ? ? ? ? ?*Interface2;
> } INTERFACES;
>
>
> //I need to regroup the fields.
>
>
> typedef struct {
> ? unsigned char ? ? ? ? ? ? ? field3;
> } GROUP2;
>
> typedef struct {
> ? unsigned char ? ? ? ? ? ? ? field1;
> ? TYPE3 ? ? ? ? ? ? ? ? ? ? ? field2;
> } GROUP;
>
> typedef struct {
> ? GROUP ? ? ? ? ? ? ? ? ? ? ? *fieldnew1;
> ? GROUP2 ? ? ? ? ? ? ? ? ? ? ?*fieldnew2;
> } CONFIGURATION2;
>
>
> typedef struct _INTERFACE {
> ? CONFIGURATION ? ? ? ?Configuration;
> ? TYPE2 ? ? ? ? ? ? ? ?Interface2;
> } INTERFACE2;
>
> So, i need to replace the references.?
> ?
> INTERFACE2 *a;?
>
> a->Configuration->field1 ?<==> a->Configuration.fieldnew1.field1
> a->Configuration->field2.boolean ?<==>
> a->Configuration.fieldnew1.field2.boolean
> a->Configuration->field3 <==> a->Configuration.fieldnew2.field3
>
>
>
> On Mon, Oct 6, 2014 at 12:32 PM, Julia Lawall <julia.lawall@lip6.fr> wrote:
>       On Mon, 6 Oct 2014, jmiguel hernandez wrote:
>
>       >
>       > ?Forgot to reply to the list :S?
>       >
>       >
>       > Thank you,
>       > i was trying to Move a any field from a structure inside a
>       data structure
>       > a.?
>       >
>       > @@
>       > typedef interface;
>       > interface *p;
>       > identifier fld;
>       > @@
>       > p->field1
>       > -.fld
>       > +.a.fld?
>       >
>       > But it looks like it is not matching anything. The type for p
>       must match,
>       > and also the name of field1.?
>       > i am moving some elements from field1 into "struct a" which is
>       on field1. So
>       > ideally, i was thinking on using adependencylike?https://github.com/coccinelle/coccinellery/blob/master/iserr
>       /patch1.co
>       > cci for the exceptions. ?
>
>       Could you send a small example of C code before and after the
>       expected
>       transformation?
>
>       thanks,
>       julia
>
>
>       > but at this point i will be satified if i can just move
>       everything from
>       > field1 into a.
>       > I also tried this, and defining fld as field instead of
>       identifier.?
>       >
>       > @@
>       > typedef interface;
>       > interface *p;
>       > identifier fld;
>       > @@
>       > -p->field1.fld
>       > +p->field1.a.fld
>       >
>       > i am sorry i am just getting to understand the grammar. I
>       wonder if there is
>       > an example slightly similar about structure transformations i
>       could read.
>       > Thanks?
>       >
>       >
>       > On Thu, Oct 2, 2014 at 3:44 PM, Lars-Peter Clausen
>       <lars@metafoo.de> wrote:
>       >? ? ? ?On 10/02/2014 10:12 PM, jmiguel hernandez wrote:
>       >? ? ? ? ? ? ?if i have this
>       >
>       >? ? ? ? ? ? ?typedef struct type1 {
>       >? ? ? ? ? ? ?? ?char8 a;
>       >? ? ? ? ? ? ?? ?char8 b;
>       >? ? ? ? ? ? ?? ?char8 c;
>       >? ? ? ? ? ? ?}
>       >
>       >? ? ? ? ? ? ?typedef struct _interface {
>       >? ? ? ? ? ? ?? ?type1 field1;
>       >? ? ? ? ? ? ?}interface;
>       >
>       >? ? ? ? ? ? ?and want to change to
>       >
>       >? ? ? ? ? ? ?typedef struct type1 {
>       >? ? ? ? ? ? ?? ?char8 d;
>       >? ? ? ? ? ? ?? ?char8 b;
>       >? ? ? ? ? ? ?? ?char8 c;
>       >? ? ? ? ? ? ?}
>       >
>       >? ? ? ? ? ? ?typedef struct _protocol {
>       >? ? ? ? ? ? ?? ?type1 *field1;
>       >? ? ? ? ? ? ?}interface;
>       >
>       >? ? ? ? ? ? ?interface *p
>       >
>       >? ? ? ? ? ? ?-p->field->a
>       >? ? ? ? ? ? ?+p->field->d
>       >
>       >? ? ? ? ? ? ?I have tried just changing field1 to field2. This
>       >? ? ? ? ? ? ?gives parsing errors.
>       >
>       >? ? ? ? ? ? ?@@
>       >? ? ? ? ? ? ?typedef interface;
>       >? ? ? ? ? ? ?interface *p;
>       >? ? ? ? ? ? ?typedef type1;
>       >? ? ? ? ? ? ?type1 field1;
>       >? ? ? ? ? ? ?@@
>       >? ? ? ? ? ? ?<...
>       >? ? ? ? ? ? ?-p->field1
>       >? ? ? ? ? ? ?+p->fieldnew
>       >? ? ? ? ? ? ?...>
>       >
>       >
>       > If you want to change the field from being embedded in the
>       parent
>       > struct to a pointer and rename the field at the same time the
>       way to
>       > go is
>       >
>       > @@
>       > typedef interface;
>       > interface *p;
>       > @@
>       > p->field1
>       > -.a
>       > +->b
>       >
>       > That replaces the ".a" with a "->b"
>       >
>       > - Lars
>       >
>       >
>       >
>       >
>       >
>       >
>
>
>
>
