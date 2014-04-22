From: marcel.a@redhat.com (Marcel Apfelbaum)
Date: Tue, 22 Apr 2014 11:21:43 +0300
Subject: [Cocci] spatch issue with C struct initialization
In-Reply-To: <alpine.DEB.2.02.1404202223470.2204@localhost6.localdomain6>
References: <1396513844.24348.13.camel@localhost.localdomain>
 <alpine.DEB.2.10.1404031216060.2090@hadrien>
 <1396531867.24348.27.camel@localhost.localdomain>
 <alpine.DEB.2.10.1404031618260.2090@hadrien>
 <1396535383.24348.38.camel@localhost.localdomain>
 <alpine.DEB.2.10.1404041317240.2088@hadrien> <53401ACD.8010004@redhat.com>
 <alpine.DEB.2.02.1404051717280.2029@localhost6.localdomain6>
 <1396770309.2151.4.camel@localhost.localdomain>
 <alpine.DEB.2.02.1404202223470.2204@localhost6.localdomain6>
Message-ID: <1398154903.30055.1.camel@localhost.localdomain>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Sun, 2014-04-20 at 22:29 +0200, Julia Lawall wrote:
> 
> 
> On Sun, 6 Apr 2014, Marcel Apfelbaum wrote:
> 
> > On Sat, 2014-04-05 at 17:17 +0200, Julia Lawall wrote:
> > > 
> > > 
> > > On Sat, 5 Apr 2014, Michael Stefaniuc wrote:
> > > 
> > > > On 04/04/2014 01:21 PM, Julia Lawall wrote:
> > > > >> bad: static const VMStateDescription vmstate_stellaris_gptm = {
> > > > >> bad:     .name = "stellaris_gptm",
> > > > >> bad:     .version_id = 1,
> > > > >> bad:     .minimum_version_id = 1,
> > > > >> bad:     .minimum_version_id_old = 1,
> > > > >> BAD:!!!!!     .fields      = (VMStateField[]) {
> > > > >> bad:         VMSTATE_UINT32(config, gptm_state),
> > > > >> bad:         VMSTATE_UINT32_ARRAY(mode, gptm_state, 2),
> > > > >> bad:         VMSTATE_UINT32(control, gptm_state),
> > > > >> bad:         VMSTATE_UINT32(state, gptm_state),
> > > > >> bad:         VMSTATE_UINT32(mask, gptm_state),
> > > > >> bad:         VMSTATE_UNUSED(8),
> > > > >> bad:         VMSTATE_UINT32_ARRAY(load, gptm_state, 2),
> > > > >> bad:         VMSTATE_UINT32_ARRAY(match, gptm_state, 2),
> > > > >> bad:         VMSTATE_UINT32_ARRAY(prescale, gptm_state, 2),
> > > > >> bad:         VMSTATE_UINT32_ARRAY(match_prescale, gptm_state, 2),
> > > > >> bad:         VMSTATE_UINT32(rtc, gptm_state),
> > > > >> bad:         VMSTATE_INT64_ARRAY(tick, gptm_state, 2),
> > > > >> bad:         VMSTATE_TIMER_ARRAY(timer, gptm_state, 2),
> > > > >> bad:         VMSTATE_END_OF_LIST()
> > > > >> bad:     }
> > > > >> bad: };
> > > > >>
> > > > >> Judging by the capital "BAD", the ".fields" field is making
> > > > >> the problem. Any way around it?
> 
> In the end, the problem turned out to be not all what I thought.  
> Actually, the Coccinelle C parser already accepts constructor expressions.  
> The problem is that VMStateField is not recognized as a type.  One 
> approach is to find the header file that defines this type and then give 
> Coccinelle enough information to find it.  There are various options for 
> that:
> 
> --all-includes: include all header files that are mentioned in the C file
> --recursive-includes: include also header files that are included from 
> other header files
> --relax-include-path: include a header file that has a unique name, no 
> matter where it is defined in the source tree
> -I path: give the name of a directory in which to search for header files.  
> It is possilble to have more than one -I argument.
> 
> If none of this works, then you can also cause it to consider VMStateField 
> to be a macro by adding eg #define VMStateField int to the macro 
> file standard.h.

Hi Julia,

Thanks again for the detailed analysis. I will try the options you mentioned.
Marcel
 
> 
> julia
