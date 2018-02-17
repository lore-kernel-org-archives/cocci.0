From: Robert.Larice@t-online.de (Robert Larice)
Date: Sat, 17 Feb 2018 23:06:43 +0100
Subject: [Cocci] might be bug report, breaking up of a comment
In-Reply-To: <alpine.DEB.2.20.1802172243470.12418@hadrien> (Julia Lawall's
 message of "Sat, 17 Feb 2018 22:44:13 +0100 (CET)")
References: <kkd113ibim.fsf@bora.foobar.de>
 <alpine.DEB.2.20.1802172243470.12418@hadrien>
Message-ID: <kky3jrgtjg.fsf@bora.foobar.de>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Julia Lawall <julia.lawall@lip6.fr> writes:

> On Sat, 17 Feb 2018, Robert Larice wrote:
>
>> Hello,
>>
>>   attached is a small example which seems to
>>     break up a comment line,
>>     thus commenting out following lines.
>>
>>   Please look at the "long reuse" line
>>     which will have an open comment when spatch is run,
>>     thus commenting out the following "struct line *options"
>
> I also see this undesriable behavior.  Thanks for the report.
>
> julia

grepping a bit in the source code I found this:
  cpp_eat_until_nl
perhaps in the vicinity of the issue.

and there is this comment somewhere:

(* cpp recognize C comments, so when #define xx (yy) /* comment \n ... */
 * then he has already erased the /* comment. So:
 * - dont eat the start of the comment otherwise afterwards we are in the middle
 *   of a comment and so will problably get a parse error somewhere.
 * - have to recognize comments in cpp_eat_until_nl.
 *)
