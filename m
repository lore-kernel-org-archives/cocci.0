From: marcel.a@redhat.com (Marcel Apfelbaum)
Date: Thu, 03 Apr 2014 16:31:07 +0300
Subject: [Cocci] spatch issue with C struct initialization
In-Reply-To: <alpine.DEB.2.10.1404031216060.2090@hadrien>
References: <1396513844.24348.13.camel@localhost.localdomain>
 <alpine.DEB.2.10.1404031216060.2090@hadrien>
Message-ID: <1396531867.24348.27.camel@localhost.localdomain>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Thu, 2014-04-03 at 12:16 +0200, Julia Lawall wrote:
> On Thu, 3 Apr 2014, Marcel Apfelbaum wrote:
> 
> > Hi,
> > I tried to use the coccinellery/doubleinit/doubleinit.cocci script
> > using the latest spatch version (1.0.0-rc20, I tried prev versions too).
> >
> > I received the following error:
> > init_defs_builtins: /usr/local/share/coccinelle/standard.h
> > 400 401
> > Fatal error: exception Failure("minus: parse error:
> >  = File "coccinellery/doubleinit/doubleinit.cocci", line 17, column 22,  charpos = 400
> >     around = '.', whole content = struct I s =@p0 { ... .fld at p = E, ...};
> > ")
> >
> > Am I missing something, am I doing something wrong?
> >
> > I need the following construct to work:
> > struct I s =
> > {
> > ...
> > .fld = E,
> > ...
> > };
> 
> Sorry, coccinellery versions may be out of date.  You need to put a comma
> after the first ...
Hi Julia,
Thank you for your fast response.

I could compile after adding a comma(thanks!), but it still doesn't work.
For example, I am not able to delete a field which is not the first one
in the initialization list.

Ex:
c file:
struct my_struct {
 int fld1;
 int fld2;
 int fld3;
};

static const my_struct m1 = {
 .fld1 = 1,
 .fld2 = 2,
 .fld3 = 3,
}

cocci:
@@
identifier I;
expression E,
@@
struct my_struct I = {
 ...,
 - .fld2 = E,
 ...
};

The above compiles fine but does not remove the field.
I think it should work, any idea why is not working?

Thank you,
Marcel

> 
> julia
