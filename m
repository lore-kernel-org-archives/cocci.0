From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Mon, 1 Aug 2016 13:56:58 +0200
Subject: [Cocci] [PATCH v3] Coccinelle: Script to replace allocate and
 memset with zalloc functions
In-Reply-To: <alpine.DEB.2.10.1608011336590.3188@hadrien>
References: <20160801070233.GA19102@amitoj-Inspiron-3542>
 <d3dde65e-a1d5-54ba-d65f-9e996bb4f8f5@users.sourceforge.net>
 <alpine.DEB.2.10.1608011336590.3188@hadrien>
Message-ID: <0dbd2dd6-4c68-1f7c-1500-9e5d40047813@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

>> 1. Would it make sense to merge such SmPL rules into one
>>    so that code duplication could be reduced a bit
>>    in such a script?
> 
> I think it would suffer in readability.

How do you think about the following SmPL script example?

@vz_combined
 depends on patch && !context && !org && !report@
type T;
T* pointer;
+statement S;
expression express;
@@
 pointer =
-          vmalloc
+          vzalloc
           (...);
 if (!d)
    S
-memset(d, 0, sizeof(
(
-T
|
-*(express)
)
-));


> Perhaps in performance as well.

I admit that I am unsure about the run-time characteristics
for my suggestion.

Regards,
Markus
