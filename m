From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Tue, 15 Aug 2017 21:04:30 +0200
Subject: [Cocci] Comparing statement lists with SmPL
In-Reply-To: <alpine.DEB.2.20.1708151930140.4600@hadrien>
References: <aff3ee47-e4cd-af52-1a66-304f36ddc1ed@users.sourceforge.net>
 <alpine.DEB.2.20.1708151930140.4600@hadrien>
Message-ID: <69d615e4-0f62-2289-dd59-97c625ba47e8@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

>> Is this programming interface usable to determine if any code could be combined
>> to some degree?
> 
> I don't really understand the questions.

I try again to describe the use case I became interested in a bit more.


> Statement list metavariables can be used once they are bound like any other metavariables.

Can it be that they will need any special computing power occasionally?


I have tried the following small SmPL script out.

@duplicated_code@
identifier work;
statement list sl;
type T;
@@
 T work(...)
 {
 ... when any
*if ((...) < 0) {
*   sl
*}
 ...
*if ((...) < 0) {
*   sl
*}
 ...
 }


The source code analysis results look promising by this command.

elfring@Sonne:~/Projekte/Linux/next-patched> git checkout next-20170803 && spatch.opt ~/Projekte/Coccinelle/janitor/show_same_statements1.cocci sound/pci/rme9652/hdsp.c
?
@@ -793,11 +793,6 @@ static int hdsp_get_iobox_version (struc
?
@@ -5382,19 +5372,11 @@ static int snd_hdsp_probe(struct pci_dev
?


How should such update candidates be transformed further?


> However they can only be bound to the complete sequence of statements in a block.  So
> 
> @@
> statement list sl;
> @@
> if (x) {
>   sl
> }
> 
> is ok, but
> 
> @@
> statement list sl;
> @@
> if (x) {
>   one();
>   sl
>   two();
> }
> 
> is not.

Thanks for your example.

* I do not like the mentioned software restriction at the moment.

* How can be determined how many code is equivalent between two statement list variables?

Regards,
Markus
