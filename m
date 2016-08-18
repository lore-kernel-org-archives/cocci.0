From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Thu, 18 Aug 2016 15:13:09 +0200
Subject: [Cocci]
 =?utf-8?q?=E2=80=9Ccoccicheck_failed=E2=80=9D_during_para?=
 =?utf-8?q?llel_program_runs?=
In-Reply-To: <alpine.DEB.2.10.1608180823510.2985@hadrien>
References: <2821164A880A16429BC851319A6EBBC5741D0619@ORSMSX111.amr.corp.intel.com>
 <99082e9d-8047-eee3-68dd-9849868d4a96@users.sourceforge.net>
 <alpine.DEB.2.10.1608180458020.3107@hadrien>
 <58c55f2c-6dd3-e4df-cb87-5a2079b76917@users.sourceforge.net>
 <alpine.DEB.2.10.1608180823510.2985@hadrien>
Message-ID: <31c3215d-ce79-a19a-53b4-2869ca1b708b@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

>>> It seems that make coccicheck interprets anything being written on
>>> standard error as a fatal error.
>>
>> How do you come to this conclusion?
> 
> Because the message in question used to be sent to standard output,
> for many years, and no one was complaining.

Is it interesting to look on circumstances and why it was tolerated?

Did the expectations evolve a bit more for this software in the meantime?


> I don't see why printing a warning message to stderr would change the
> return code only in the parallel case.

I would also wonder about such a side effect.

Can a failed call of a function like "printf" in the OCaml source code
result in a questionable return value which will become the discussed
program exit status?


By the way:
This observation depends on the result from the following statements.

?
SPATCH="`which ${SPATCH:=spatch}`"
?
$SPATCH --help | grep "\-\-jobs" > /dev/null && USE_JOBS="yes"
?


Would an approach like the following help here?


Update candidate "scripts/coccicheck":
?
run_cmd_parmap() {
?
	$@ 2>$DEBUG_FILE
	if [[ $? -ne 0 ]]; then
		COMMAND_RESULT=$?
		echo "coccicheck failed"
		exit $COMMAND_RESULT
	fi
}
?

Regards,
Markus
