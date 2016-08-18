From: julia.lawall@lip6.fr (Julia Lawall)
Date: Thu, 18 Aug 2016 08:26:54 -0400 (EDT)
Subject: [Cocci]
	=?utf-8?q?=E2=80=9Ccoccicheck_failed=E2=80=9D_during_para?=
	=?utf-8?q?llel_program_runs?=
In-Reply-To: <58c55f2c-6dd3-e4df-cb87-5a2079b76917@users.sourceforge.net>
References: <2821164A880A16429BC851319A6EBBC5741D0619@ORSMSX111.amr.corp.intel.com>
 <99082e9d-8047-eee3-68dd-9849868d4a96@users.sourceforge.net>
 <alpine.DEB.2.10.1608180458020.3107@hadrien>
 <58c55f2c-6dd3-e4df-cb87-5a2079b76917@users.sourceforge.net>
Message-ID: <alpine.DEB.2.10.1608180823510.2985@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Thu, 18 Aug 2016, SF Markus Elfring wrote:

> > It seems that make coccicheck interprets anything being written on
> > standard error as a fatal error.
>
> How do you come to this conclusion?

Because the message in question used to be sent to standard output, for
many years, and no one was complaining.

> > This seems like a strange point of view,
>
> I would agree ?
>
>
> > as Coccinelle needs somewhere to print warnings that the user may also
> > find useful.
>
> This is usually fine.
>
> But I am more concerned about the safe handling for the program exit status.
>
>
> Excerpt from scripts/coccicheck:
> ?
> run_cmd_parmap() {
> ?
> 	$@ 2>$DEBUG_FILE
> 	if [[ $? -ne 0 ]]; then
> 		echo "coccicheck failed"
> 		exit $?
> 	fi
> }
> ?

I don't see why printing a warning message to stderr would change the
return code only in the parallel case.

>
>
> Would you like to take another look at the returned exit code?
>
>
> > But I have changed Coccinelle such that it prints this particular warning
>
> Will the message reformatting around the information "? with comm_assoc iso"
> be really sufficient?

There is more information that is printed to standard output.  It should
go to standard error also, but this is not likely to be what is causing
the problem, and for technical reasons, it is not a competely trivial
change.

julia

>
>
> > in a different way that will cause it to disappear when
> > the option --very-quiet is used.
>
> Thanks for another bit of fine-tuning in your software.
>
> Regards,
> Markus
>
