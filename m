From: marcel.a@redhat.com (Marcel Apfelbaum)
Date: Sun, 06 Apr 2014 10:45:09 +0300
Subject: [Cocci] spatch issue with C struct initialization
In-Reply-To: <alpine.DEB.2.02.1404051717280.2029@localhost6.localdomain6>
References: <1396513844.24348.13.camel@localhost.localdomain>
 <alpine.DEB.2.10.1404031216060.2090@hadrien>
 <1396531867.24348.27.camel@localhost.localdomain>
 <alpine.DEB.2.10.1404031618260.2090@hadrien>
 <1396535383.24348.38.camel@localhost.localdomain>
 <alpine.DEB.2.10.1404041317240.2088@hadrien> <53401ACD.8010004@redhat.com>
 <alpine.DEB.2.02.1404051717280.2029@localhost6.localdomain6>
Message-ID: <1396770309.2151.4.camel@localhost.localdomain>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Sat, 2014-04-05 at 17:17 +0200, Julia Lawall wrote:
> 
> 
> On Sat, 5 Apr 2014, Michael Stefaniuc wrote:
> 
> > On 04/04/2014 01:21 PM, Julia Lawall wrote:
> > >> bad: static const VMStateDescription vmstate_stellaris_gptm = {
> > >> bad:     .name = "stellaris_gptm",
> > >> bad:     .version_id = 1,
> > >> bad:     .minimum_version_id = 1,
> > >> bad:     .minimum_version_id_old = 1,
> > >> BAD:!!!!!     .fields      = (VMStateField[]) {
> > >> bad:         VMSTATE_UINT32(config, gptm_state),
> > >> bad:         VMSTATE_UINT32_ARRAY(mode, gptm_state, 2),
> > >> bad:         VMSTATE_UINT32(control, gptm_state),
> > >> bad:         VMSTATE_UINT32(state, gptm_state),
> > >> bad:         VMSTATE_UINT32(mask, gptm_state),
> > >> bad:         VMSTATE_UNUSED(8),
> > >> bad:         VMSTATE_UINT32_ARRAY(load, gptm_state, 2),
> > >> bad:         VMSTATE_UINT32_ARRAY(match, gptm_state, 2),
> > >> bad:         VMSTATE_UINT32_ARRAY(prescale, gptm_state, 2),
> > >> bad:         VMSTATE_UINT32_ARRAY(match_prescale, gptm_state, 2),
> > >> bad:         VMSTATE_UINT32(rtc, gptm_state),
> > >> bad:         VMSTATE_INT64_ARRAY(tick, gptm_state, 2),
> > >> bad:         VMSTATE_TIMER_ARRAY(timer, gptm_state, 2),
> > >> bad:         VMSTATE_END_OF_LIST()
> > >> bad:     }
> > >> bad: };
> > >>
> > >> Judging by the capital "BAD", the ".fields" field is making
> > >> the problem. Any way around it?
> > > 
> > > Unfortunately, I'm not sure how to do this without introducing conflicts
> > > in the grammar.  Currently the grammar is roughly of the following form
> > > (copied from http://www.lysator.liu.se/c/ANSI-C-grammar-y.html):
> > > 
> > > initializer
> > >     : assignment_expression
> > >     | '{' initializer_list '}'
> > >     | '{' initializer_list ',' '}'
> > >     ;
> > > 
> > > A cast on an ordinary expression is a bit deep in assignment_expression.
> > > So the parser is not happy to have the possibility of a cast on { ... } as
> > > well.
> > > 
> > > The cast seems to be allowed in C99, but I don't know what the grammar
> > > looks like to allow that.
> > That's actually not a cast but a compound literal
> > http://gcc.gnu.org/onlinedocs/gcc/Compound-Literals.html
> 
> Thanks for the pointer.  I'm still not sure to see how to solve the 
> ambiguity problem.

Not being an expert on grammar, there is a chance this will work ?

 initializer
    : assignment_expression
       | '{' initializer_list '}'
       | '{' initializer_list ',' '}'
       | ( type-name ) { initializer-list }
       | ( type-name ) { initializer-list , }

If you can point me to the code dealing with it, I can try to play with
it a little bit.

Thanks,
Marcel

> 
> julia
