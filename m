From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Tue, 25 Feb 2014 10:10:48 +0100
Subject: [Cocci] Remove unnecessary null pointer checks?
In-Reply-To: <alpine.DEB.2.10.1402241710370.2074@hadrien>
References: <5307CAA2.8060406@users.sourceforge.net>
 <alpine.DEB.2.02.1402212321410.2043@localhost6.localdomain6>
 <530A086E.8010901@users.sourceforge.net>
 <alpine.DEB.2.02.1402231635510.1985@localhost6.localdomain6>
 <530A72AA.3000601@users.sourceforge.net>
 <alpine.DEB.2.02.1402240658210.2090@localhost6.localdomain6>
 <530B5FB6.6010207@users.sourceforge.net>
 <alpine.DEB.2.10.1402241710370.2074@hadrien>
Message-ID: <530C5E18.1020800@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

>> This example does not fit to my expectation because it seems that the function
>> implementation does not refer to the passed values.

I'm sorry that I overlooked information somehow there.

The implementations of the function "show_stack" can be nice source code
examples for further fine-tuning of proposed filter patterns.
https://git.kernel.org/cgit/linux/kernel/git/stable/linux-stable.git/tree/arch/um/kernel/sysrq.c?id=8ed12fcc194d93c6a17714120a7027ee4d76a881#n67

Its interface contains two pointer parameters.


> I'm not sure what is the point of the if (input) is else es pattern.

I can also adjust the search approach like the following.

@safety_check@
identifier work, input;
type data_type;
position pos;
statement is, es;
@@
 void work at pos(...,data_type input,...)
 {
  ...
( if (input) is
| if (likely(input)) is
)
  else es
  ...
 }


> I would think you only want to find cases where the function does nothing
> until it tests input and aborts the function is the value is 0.

I guess that the interpretation of "nothing relevant" will need further
considerations, won't it?


> So you only want the return case.

Not "only" this one ...

I have got a feeling for a need to introspect the else branch for useful
properties. I am unsure about better analysis of the metavariable "es" with the
semantic patch language.

Regards,
Markus
