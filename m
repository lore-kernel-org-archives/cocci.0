From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Thu, 18 Aug 2016 13:34:52 +0200
Subject: [Cocci]
 =?utf-8?q?=E2=80=9Ccoccicheck_failed=E2=80=9D_during_para?=
 =?utf-8?q?llel_program_runs?=
In-Reply-To: <alpine.DEB.2.10.1608180458020.3107@hadrien>
References: <2821164A880A16429BC851319A6EBBC5741D0619@ORSMSX111.amr.corp.intel.com>
 <99082e9d-8047-eee3-68dd-9849868d4a96@users.sourceforge.net>
 <alpine.DEB.2.10.1608180458020.3107@hadrien>
Message-ID: <58c55f2c-6dd3-e4df-cb87-5a2079b76917@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> It seems that make coccicheck interprets anything being written on
> standard error as a fatal error.

How do you come to this conclusion?


> This seems like a strange point of view,

I would agree ?


> as Coccinelle needs somewhere to print warnings that the user may also
> find useful.

This is usually fine.

But I am more concerned about the safe handling for the program exit status.


Excerpt from scripts/coccicheck:
?
run_cmd_parmap() {
?
	$@ 2>$DEBUG_FILE
	if [[ $? -ne 0 ]]; then
		echo "coccicheck failed"
		exit $?
	fi
}
?


Would you like to take another look at the returned exit code?


> But I have changed Coccinelle such that it prints this particular warning

Will the message reformatting around the information "? with comm_assoc iso"
be really sufficient?



> in a different way that will cause it to disappear when
> the option --very-quiet is used.

Thanks for another bit of fine-tuning in your software.

Regards,
Markus
