From: jean-sebastien.pedron@dumbbell.fr (=?windows-1252?Q?Jean-S=E9bastien_P=E9dron?=)
Date: Wed, 29 Oct 2014 09:35:55 +0100
Subject: [Cocci] Parsing errors in several headers
In-Reply-To: <5450A587.1080709@users.sourceforge.net>
References: <544FDF5C.6040009@dumbbell.fr>
 <alpine.DEB.2.10.1410281930130.2567@hadrien> <544FE5AD.60208@dumbbell.fr>
 <544FEA20.4030400@users.sourceforge.net> <544FED2B.2030305@dumbbell.fr>
 <5450A587.1080709@users.sourceforge.net>
Message-ID: <5450A6EB.6050803@dumbbell.fr>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On 29.10.2014 09:29, SF Markus Elfring wrote:
>> I wanted to add a #define just above a function prototype or the
>> function itself.
> [...]
>> @rule1@
>> identifier func;
>> @@
>>
>> -#define        func    BAR(func)
> 
> I find this SmPL approach strange according to your description.
> - Would you really like to delete the definition for a preprocessor symbol here?
> - Should this semantic patch express the change to move the position of such a
> statement to other source code places?

I wanted to be able to re-run spatch on an already patched content. The
use case is to add new function prototypes manually and run spatch to
handle the associated #define automatically.

-- 
Jean-S?bastien P?dron

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 949 bytes
Desc: OpenPGP digital signature
URL: <https://systeme.lip6.fr/pipermail/cocci/attachments/20141029/6bcfa88d/attachment.asc>
