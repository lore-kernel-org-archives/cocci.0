From: Thierry.Martinez@inria.fr (Thierry Martinez)
Date: Mon, 16 Jan 2017 20:02:51 +0100
Subject: [Cocci] Checking incidence for SmPL initialisation rules after
	parallel script execution
In-Reply-To: <alpine.DEB.2.20.1612190750450.1922@hadrien>
References: <da6cd1b6-17a0-d5e9-3ba6-7565cc80ce39@users.sourceforge.net>
 <alpine.DEB.2.20.1612181659510.1965@hadrien>
 <4a2af4ea-01ab-3e47-845e-15dae185791f@users.sourceforge.net>
 <alpine.DEB.2.20.1612182004360.2075@hadrien>
 <e5afa762-47cd-8473-4912-dd10aefc6e1f@users.sourceforge.net>
 <alpine.DEB.2.20.1612182142260.2075@hadrien>
 <351861e0-cd00-1a63-6f74-b2682c41f22b@users.sourceforge.net>
 <alpine.DEB.2.20.1612190750450.1922@hadrien>
Message-ID: <ow4inpehlpg.fsf@inria.fr>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Julia:
> @initialize:python@
> @@
>
> print "hello"
>
> @@
> @@
>
> - of_node_put(...);

This is now fixed: the initialization code was executed once, but the
output was not flushed before the fork, leading the buffered output to
be duplicated among all the child processes. Thanks for reporting this.

--
Thierry.

Julia Lawall (2016/12/19, 06:54 UTC)?:
> On Sun, 18 Dec 2016, SF Markus Elfring wrote:
>
>> >> Can you generally clarify current consequences from usage of a SmPL rule ?initialize:??
>> >> together with the parameter ?--jobs? for the program ?spatch??
>> >
>> > It should happen only once.
>>
>> Thanks for this information.
>>
>> I would like to know if the script initialisation should happen for each
>> background process and/or after the start of the program ?spatch?.
>>
>>
>> > Thus without your semantic patch and your .c file, I can't tell
>> > why it doesn't behave as expected.
>>
>> You got the corresponding data from my source code analysis try for NetBSD.
>> How often do you observe a simple text line output from initialisation code
>> after parallel execution of one from your test scripts?
>
> It seems to be a problem with python initialization only.  Here is my
> example script:
>
> @initialize:python@
> @@
>
> print "hello"
>
> @@
> @@
>
> - of_node_put(...);
>
> Note how few lines it contains, how it is designed to illustrate the
> specific problem, how easy it is to adapt to any software project one has
> handy, how it is included in the email for easy reference etc.  Please do
> the same.
>
> julia_______________________________________________
> Cocci mailing list
> Cocci at systeme.lip6.fr
> https://systeme.lip6.fr/mailman/listinfo/cocci
