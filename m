From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Sun, 15 Feb 2015 18:13:53 +0100
Subject: [Cocci] remove typedefs from struct
In-Reply-To: <2bb2afa2a75f464b900af8506ddc84dd@BN1BFFO11FD029.protection.gbl>
References: <2bb2afa2a75f464b900af8506ddc84dd@BN1BFFO11FD029.protection.gbl>
Message-ID: <54E0D3D1.9070608@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

>   /// Convert typdefed structs to structs
>   
>   @ rule1 @
>   identifier i;
>   type t;
>   @@
>   -typedef struct i {
>   +struct i {
>   	...
>   - }t;
>   + };

How do you think about a bit more fine-tuning for your SmPL approach?

 ...
 }
-t
 ;

Is it sufficient to express the desired deletion at this place?

Regards,
Markus
