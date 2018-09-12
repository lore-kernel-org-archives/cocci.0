From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Wed, 12 Sep 2018 20:33:26 +0200
Subject: [Cocci] Checking patches for questionable comma expressions in
 if conditions
In-Reply-To: <20180912123304.GA18497@osadl.at>
References: <20180912123304.GA18497@osadl.at>
Message-ID: <d16d096c-2598-32c3-e489-d7f00b2aec51@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> The below spatch works for me - and finds the cases I was looking
> for in report mode.

This is nice.


> In patch mode it fixes some in a bad way though due to some additional "bugs"
> in the if statement like:
?
> -       if ((notify->event = event), event->refs) {
> +       (notify->event = event);
> +       if (event->refs) {

I am curious on how software development considerations will evolve further
for such generated patches.

Will the shown script for the semantic patch language need any more fine-tuning?

Would the following transformation variant result in desirable differences
(after the specification of extra parentheses)?


@badif@
position P;
statement S;
expression E1,E2;
@@
 if at P ((E1),E2) S

?

@fixbadif depends on patch && badif@
position badif.P;
statement S;
expression badif.E1,badif.E2;
@@
+E1;
 if at P (
-      (E1),
       E2)
      S


> -       if (mask = 0, data = 0, ram->diff.rammap_11_0a_03fe) {
> +       mask = 0, data = 0;
> +       if (ram->diff.rammap_11_0a_03fe) {
>
> In futher cases it is not clear if the unconditional part really was
> intended to take effect outside the conditional code so it is not
> clear if the placement before the if () is technically correct

How do you think about to convert such a development concern into a more
advanced source code search pattern?

Regards,
Markus
