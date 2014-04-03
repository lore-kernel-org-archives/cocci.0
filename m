From: marcel.a@redhat.com (Marcel Apfelbaum)
Date: Thu, 03 Apr 2014 17:29:43 +0300
Subject: [Cocci] spatch issue with C struct initialization
In-Reply-To: <alpine.DEB.2.10.1404031618260.2090@hadrien>
References: <1396513844.24348.13.camel@localhost.localdomain>
 <alpine.DEB.2.10.1404031216060.2090@hadrien>
 <1396531867.24348.27.camel@localhost.localdomain>
 <alpine.DEB.2.10.1404031618260.2090@hadrien>
Message-ID: <1396535383.24348.38.camel@localhost.localdomain>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Thu, 2014-04-03 at 16:19 +0200, Julia Lawall wrote:
> 
> 
> On Thu, 3 Apr 2014, Marcel Apfelbaum wrote:
> 
> > On Thu, 2014-04-03 at 12:16 +0200, Julia Lawall wrote:
> > > On Thu, 3 Apr 2014, Marcel Apfelbaum wrote:
> > >
> > > > Hi,
> > > > I tried to use the coccinellery/doubleinit/doubleinit.cocci script
> > > > using the latest spatch version (1.0.0-rc20, I tried prev versions too).
> > > >
> > > > I received the following error:
> > > > init_defs_builtins: /usr/local/share/coccinelle/standard.h
> > > > 400 401
> > > > Fatal error: exception Failure("minus: parse error:
> > > >  = File "coccinellery/doubleinit/doubleinit.cocci", line 17, column 22,  charpos = 400
> > > >     around = '.', whole content = struct I s =@p0 { ... .fld at p = E, ...};
> > > > ")
> > > >
> > > > Am I missing something, am I doing something wrong?
> > > >
> > > > I need the following construct to work:
> > > > struct I s =
> > > > {
> > > > ...
> > > > .fld = E,
> > > > ...
> > > > };
> > >
> > > Sorry, coccinellery versions may be out of date.  You need to put a comma
> > > after the first ...
> > Hi Julia,
> > Thank you for your fast response.
> >
> > I could compile after adding a comma(thanks!), but it still doesn't work.
> > For example, I am not able to delete a field which is not the first one
> > in the initialization list.
> >
> > Ex:
> > c file:
> > struct my_struct {
> >  int fld1;
> >  int fld2;
> >  int fld3;
> > };
> >
> > static const my_struct m1 = {
> >  .fld1 = 1,
> >  .fld2 = 2,
> >  .fld3 = 3,
> > }
> 
> Is this your exact program?  Because I think there should be the word
> "struct" somewhere?  If code doesn't compile, Coccinelle just ignores it
> silently, unless you use the --verbose-parsing option.
> 
> I'll double check whether that is the only problem.

Hi Julia,
No, this is not "a real" code, only a pseudo code. Indeed, struct is missing :)

However, using your verbose flag (thanks!!! I was looking for it) I got:

bad: static const VMStateDescription vmstate_stellaris_gptm = {
bad:     .name = "stellaris_gptm",
bad:     .version_id = 1,
bad:     .minimum_version_id = 1,
bad:     .minimum_version_id_old = 1,
BAD:!!!!!     .fields      = (VMStateField[]) {
bad:         VMSTATE_UINT32(config, gptm_state),
bad:         VMSTATE_UINT32_ARRAY(mode, gptm_state, 2),
bad:         VMSTATE_UINT32(control, gptm_state),
bad:         VMSTATE_UINT32(state, gptm_state),
bad:         VMSTATE_UINT32(mask, gptm_state),
bad:         VMSTATE_UNUSED(8),
bad:         VMSTATE_UINT32_ARRAY(load, gptm_state, 2),
bad:         VMSTATE_UINT32_ARRAY(match, gptm_state, 2),
bad:         VMSTATE_UINT32_ARRAY(prescale, gptm_state, 2),
bad:         VMSTATE_UINT32_ARRAY(match_prescale, gptm_state, 2),
bad:         VMSTATE_UINT32(rtc, gptm_state),
bad:         VMSTATE_INT64_ARRAY(tick, gptm_state, 2),
bad:         VMSTATE_TIMER_ARRAY(timer, gptm_state, 2),
bad:         VMSTATE_END_OF_LIST()
bad:     }
bad: };

Judging by the capital "BAD", the ".fields" field is making
the problem. Any way around it?

Appreciate your involvement,
Marcel

> 
> julia
> 
> > cocci:
> > @@
> > identifier I;
> > expression E,
> > @@
> > struct my_struct I = {
> >  ...,
> >  - .fld2 = E,
> >  ...
> > };
> >
> > The above compiles fine but does not remove the field.
> > I think it should work, any idea why is not working?
> >
> > Thank you,
> > Marcel
> >
> > >
> > > julia
> >
> >
> >
> >
