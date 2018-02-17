From: Robert.Larice@t-online.de (Robert Larice)
Date: Sat, 17 Feb 2018 10:06:52 +0100
Subject: [Cocci] please help me with a failing match
In-Reply-To: <alpine.DEB.2.20.1802101613320.3317@hadrien> (Julia Lawall's
 message of "Sat, 10 Feb 2018 16:15:20 +0100 (CET)")
References: <kkk1vlt55g.fsf@bora.foobar.de>
 <alpine.DEB.2.20.1802101422060.3317@hadrien>
 <87wozkkhsg.fsf@t-online.de>
 <alpine.DEB.2.20.1802101613320.3317@hadrien>
Message-ID: <kkmv08htn7.fsf@bora.foobar.de>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Julia Lawall <julia.lawall@lip6.fr> writes:

> On Sat, 10 Feb 2018, Robert Larice wrote:
>
>> Julia Lawall <julia.lawall@lip6.fr> writes:
>>
>> > On Sat, 10 Feb 2018, Robert Larice wrote:
>> >
>> >> Dear People,
>> >>
>> >>   I'm completely new here.
>> >>
>> >>   Attached is a small piece of .c and a .cocci file.
>> >>   There is a "return 41;" in both files, commented out.
>> >>   If I uncomment this "return 41;" in both files then
>> >>     spatch will not match the pieces any more.
>> >>
>> >>   Could you please help me to undertand and circumvent this issue ?
>> >
>> > I have not noticed this problem before, but I suspect that it is due to
>> > the fact that Coccinelle is matching the control-flow path and not the
>> > abstract syntax tree. In a control-flow graph, nothing follows a return.
>> >
>> > julia
>>
>> Thank You,
>> I tried to sneak around the problem with a second "rule" which
>>   translates "return 42" to "auxiliary(42)".
>> My intention was to first change the source in such a way
>>   that the "control-flow" graph does not end at the "return",
>> and then hope that the second (accordingly modified) rule would
>>   match.
>> This didn't work, I assume I would have to express the idea of
>>   first applying the first rule
>>     then to rebuild the control-flow graph
>>   then try the second rule.
>>   (and finally undo the changes of the first rule in a third rule)
>> I can not force "rebuild" without invoking spatch myself a second time.
>
> If you change all the returns to something else and then match your
> pattern, and then change them it should work.
>
>>
>> ---
>> I'm a bit of a maintainer for the "ngspice" project, which has a vast
>>   amount of very old files, and lots of semi duplicated stuff often crying
>>   for a thourough hair wash,
>> stumbled over this intresting tool, and am tying it for a certain
>>   rewrite I'm currently busy with.
>
> OK,feel free to ask more questions if you run into further issues.
>
> julia

Hello,

  Thank you for your help. I've four or five .cocci files now which
    do the job at hand for ngspice quite well. The rewrite of return
    to something else with two times invocation of spatch did work.
  Then I found another simpler way. So thats done.

  Playing around, trying to better understand what it means
    to have more than one rule, their interaction etc ..
    I came to the attached example.
  Here I have basically tried to remove the whole body of a function
    iff the function matches two other @rules@
  It seems to work if I use the '*' notation, but doesnt if I use
    '+/-'
  Can you give me a hint which helps me to understand this ?

Regards,
  Robert

-------------- next part --------------
An embedded and charset-unspecified text was scrubbed...
Name: ex4.cocci
URL: <https://systeme.lip6.fr/pipermail/cocci/attachments/20180217/12a80ed1/attachment.ksh>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: ex4.c
Type: text/x-csrc
Size: 150 bytes
Desc: not available
URL: <https://systeme.lip6.fr/pipermail/cocci/attachments/20180217/12a80ed1/attachment.bin>
