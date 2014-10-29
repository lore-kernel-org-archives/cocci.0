From: jean-sebastien.pedron@dumbbell.fr (=?windows-1252?Q?Jean-S=E9bastien_P=E9dron?=)
Date: Wed, 29 Oct 2014 13:26:14 +0100
Subject: [Cocci] Addition of preprocessor statements with SmPL
In-Reply-To: <5450CE8E.1040902@dumbbell.fr>
References: <544FDF5C.6040009@dumbbell.fr>
 <alpine.DEB.2.10.1410281930130.2567@hadrien> <544FE5AD.60208@dumbbell.fr>
 <544FEA20.4030400@users.sourceforge.net> <544FED2B.2030305@dumbbell.fr>
 <5450A587.1080709@users.sourceforge.net> <5450A6EB.6050803@dumbbell.fr>
 <alpine.DEB.2.10.1410291123540.26234@hadrien> <5450C832.3030501@dumbbell.fr>
 <alpine.DEB.2.10.1410291205580.26234@hadrien> <5450CE8E.1040902@dumbbell.fr>
Message-ID: <5450DCE6.4030403@dumbbell.fr>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On 29.10.2014 12:25, Jean-S?bastien P?dron wrote:
>> Sorry, typo here.  It should be func at p(...) { ... }
> 
> You're right, it's working now! Thank you :)

Here's the complete working semantic patch:

---8<---
@r@
identifier func;
@@

#define func    BAR(func)

@s1@
identifier r.func;
position p;
@@

func at p(...) {...}

@@
identifier func;
position p != s1.p;
@@

+#define        func    BAR(func)
func at p(...) { ... }

@s2@
type ret;
identifier r.func;
position p;
@@

ret func at p(...);

@@
type ret;
identifier func;
position p != s2.p;
@@

+#define        func    BAR(func)
ret func@p(...);
---8<---

Thank you very much for your help!

-- 
Jean-S?bastien P?dron

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 949 bytes
Desc: OpenPGP digital signature
URL: <https://systeme.lip6.fr/pipermail/cocci/attachments/20141029/05a643e5/attachment.asc>
