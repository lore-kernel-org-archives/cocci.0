From: jean-sebastien.pedron@dumbbell.fr (=?windows-1252?Q?Jean-S=E9bastien_P=E9dron?=)
Date: Tue, 28 Oct 2014 20:23:23 +0100
Subject: [Cocci] Parsing errors in several headers
In-Reply-To: <544FEA20.4030400@users.sourceforge.net>
References: <544FDF5C.6040009@dumbbell.fr>
 <alpine.DEB.2.10.1410281930130.2567@hadrien> <544FE5AD.60208@dumbbell.fr>
 <544FEA20.4030400@users.sourceforge.net>
Message-ID: <544FED2B.2030305@dumbbell.fr>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On 28.10.2014 20:10, SF Markus Elfring wrote:
>> Ok, then I must have a problem with my semantic patch, because it
>> doesn't change anything :) I thought it was because of the parsing error.
> 
> Would you like to show your SmPL approach here so that we could help you more
> eventually?

Sure! I wanted to add a #define just above a function prototype or the
function itself.

Example #1:
  int foo();

should become:
  #define foo BAR(foo)
  int foo();

Example #2:
  int foo() { /* ... */ }

should become:
  #define foo BAR(foo)
  int foo() { /* ... */ }

Here's the script I used, which worked with example #1:

---8<---
@rule1@
identifier func;
@@

-#define        func    BAR(func)

@rule2@
identifier func;
type ret;
@@

+#define        func    BAR(func)
ret func(...);
---8<---

I can handle example #2 with this one:

---8<---
@rule1@
identifier func;
@@

-#define        func    BAR(func)

@rule2@
identifier func;
type ret;
@@

+#define        func    BAR(func)
ret func(...) { ... }
---8<---

However, I fail to assemble those two patches in a single concise one.

Thank you for offering your help :)

-- 
Jean-S?bastien P?dron

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 949 bytes
Desc: OpenPGP digital signature
URL: <https://systeme.lip6.fr/pipermail/cocci/attachments/20141028/09605fdc/attachment.asc>
