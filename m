From: Robert.Larice@t-online.de (Robert Larice)
Date: Sat, 10 Feb 2018 16:04:15 +0100
Subject: [Cocci] please help me with a failing match
In-Reply-To: <alpine.DEB.2.20.1802101422060.3317@hadrien> (Julia Lawall's
 message of "Sat, 10 Feb 2018 14:23:17 +0100 (CET)")
References: <kkk1vlt55g.fsf@bora.foobar.de>
 <alpine.DEB.2.20.1802101422060.3317@hadrien>
Message-ID: <87wozkkhsg.fsf@t-online.de>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Julia Lawall <julia.lawall@lip6.fr> writes:

> On Sat, 10 Feb 2018, Robert Larice wrote:
>
>> Dear People,
>>
>>   I'm completely new here.
>>
>>   Attached is a small piece of .c and a .cocci file.
>>   There is a "return 41;" in both files, commented out.
>>   If I uncomment this "return 41;" in both files then
>>     spatch will not match the pieces any more.
>>
>>   Could you please help me to undertand and circumvent this issue ?
>
> I have not noticed this problem before, but I suspect that it is due to
> the fact that Coccinelle is matching the control-flow path and not the
> abstract syntax tree. In a control-flow graph, nothing follows a return.
>
> julia

Thank You,
I tried to sneak around the problem with a second "rule" which
  translates "return 42" to "auxiliary(42)".
My intention was to first change the source in such a way
  that the "control-flow" graph does not end at the "return",
and then hope that the second (accordingly modified) rule would
  match.
This didn't work, I assume I would have to express the idea of
  first applying the first rule
    then to rebuild the control-flow graph
  then try the second rule.
  (and finally undo the changes of the first rule in a third rule)
I can not force "rebuild" without invoking spatch myself a second time.

---
I'm a bit of a maintainer for the "ngspice" project, which has a vast
  amount of very old files, and lots of semi duplicated stuff often crying
  for a thourough hair wash,
stumbled over this intresting tool, and am tying it for a certain
  rewrite I'm currently busy with.
  
