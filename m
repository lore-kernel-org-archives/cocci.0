From: jean-sebastien.pedron@dumbbell.fr (=?windows-1252?Q?Jean-S=E9bastien_P=E9dron?=)
Date: Wed, 29 Oct 2014 11:57:54 +0100
Subject: [Cocci] Addition of preprocessor statements with SmPL
In-Reply-To: <alpine.DEB.2.10.1410291123540.26234@hadrien>
References: <544FDF5C.6040009@dumbbell.fr>
 <alpine.DEB.2.10.1410281930130.2567@hadrien> <544FE5AD.60208@dumbbell.fr>
 <544FEA20.4030400@users.sourceforge.net> <544FED2B.2030305@dumbbell.fr>
 <5450A587.1080709@users.sourceforge.net> <5450A6EB.6050803@dumbbell.fr>
 <alpine.DEB.2.10.1410291123540.26234@hadrien>
Message-ID: <5450C832.3030501@dumbbell.fr>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On 29.10.2014 11:26, Julia Lawall wrote:
>> I wanted to be able to re-run spatch on an already patched content. The
>> use case is to add new function prototypes manually and run spatch to
>> handle the associated #define automatically.
> 
> I think that you could do the following:
> 
> @r@
> identifier func;
> @@
> #define        func    BAR(func)
> 
> @s@
> identifier r.func;
> position p;
> @@
> 
> func at p(...) {...}
> 
> @@
> identifier func;
> position p != s.p;
> @@
> 
> +#define        func    BAR(func)
> func(...) { ... }

I tried this semantic patch and it doesn't work: more #define are added
with each run.

FWIW, the "BAR" identifier is unique in my use case: I'm sure the
original headers won't have it. That's why I took a simple approach in
removing all previous #define. However, I'm willing to learn the correct
way to handle this for a future usage :)

I have an additional question: If there's a comment just above the
function declaration/implementation, the #define is added above the
comment. Is there a way to put it between the comment and the function?

-- 
Jean-S?bastien P?dron

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 949 bytes
Desc: OpenPGP digital signature
URL: <https://systeme.lip6.fr/pipermail/cocci/attachments/20141029/ccdb8366/attachment-0001.asc>
