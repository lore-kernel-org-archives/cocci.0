From: julia.lawall@lip6.fr (Julia Lawall)
Date: Fri, 4 Apr 2014 13:21:42 +0200 (CEST)
Subject: [Cocci] spatch issue with C struct initialization
In-Reply-To: <1396535383.24348.38.camel@localhost.localdomain>
References: <1396513844.24348.13.camel@localhost.localdomain>
 <alpine.DEB.2.10.1404031216060.2090@hadrien>
 <1396531867.24348.27.camel@localhost.localdomain>
 <alpine.DEB.2.10.1404031618260.2090@hadrien>
 <1396535383.24348.38.camel@localhost.localdomain>
Message-ID: <alpine.DEB.2.10.1404041317240.2088@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> bad: static const VMStateDescription vmstate_stellaris_gptm = {
> bad:     .name = "stellaris_gptm",
> bad:     .version_id = 1,
> bad:     .minimum_version_id = 1,
> bad:     .minimum_version_id_old = 1,
> BAD:!!!!!     .fields      = (VMStateField[]) {
> bad:         VMSTATE_UINT32(config, gptm_state),
> bad:         VMSTATE_UINT32_ARRAY(mode, gptm_state, 2),
> bad:         VMSTATE_UINT32(control, gptm_state),
> bad:         VMSTATE_UINT32(state, gptm_state),
> bad:         VMSTATE_UINT32(mask, gptm_state),
> bad:         VMSTATE_UNUSED(8),
> bad:         VMSTATE_UINT32_ARRAY(load, gptm_state, 2),
> bad:         VMSTATE_UINT32_ARRAY(match, gptm_state, 2),
> bad:         VMSTATE_UINT32_ARRAY(prescale, gptm_state, 2),
> bad:         VMSTATE_UINT32_ARRAY(match_prescale, gptm_state, 2),
> bad:         VMSTATE_UINT32(rtc, gptm_state),
> bad:         VMSTATE_INT64_ARRAY(tick, gptm_state, 2),
> bad:         VMSTATE_TIMER_ARRAY(timer, gptm_state, 2),
> bad:         VMSTATE_END_OF_LIST()
> bad:     }
> bad: };
>
> Judging by the capital "BAD", the ".fields" field is making
> the problem. Any way around it?

Unfortunately, I'm not sure how to do this without introducing conflicts
in the grammar.  Currently the grammar is roughly of the following form
(copied from http://www.lysator.liu.se/c/ANSI-C-grammar-y.html):

initializer
	: assignment_expression
	| '{' initializer_list '}'
	| '{' initializer_list ',' '}'
	;

A cast on an ordinary expression is a bit deep in assignment_expression.
So the parser is not happy to have the possibility of a cast on { ... } as
well.

The cast seems to be allowed in C99, but I don't know what the grammar
looks like to allow that.

Any suggestions are welcome.

julia
