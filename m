From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Sun, 18 Dec 2016 19:40:00 +0100
Subject: [Cocci] Checking incidence for SmPL initialisation rules after
 parallel script execution
In-Reply-To: <alpine.DEB.2.20.1612181659510.1965@hadrien>
References: <da6cd1b6-17a0-d5e9-3ba6-7565cc80ce39@users.sourceforge.net>
 <alpine.DEB.2.20.1612181659510.1965@hadrien>
Message-ID: <4a2af4ea-01ab-3e47-845e-15dae185791f@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

>> Is it really appropriate that this header appears so often in the shown output file?
> 
> Without having the semantic patch and the .c file, ideally with both
> cut down to a minimal version that shows the problem,
> I can't answer this question.

Does the follow display look a bit better?

elfring at Sonne:~/Projekte/Coccinelle/janitor> grep 'function|"data type"|"source file"|line|column' ~/Projekte/Bau/NetBSD/Coccinelle/functions1/API2.txt | wc -l
5

(Four jobs plus one)


I am looking for another update on the consequences from the parallel execution
of scripts for the semantic patch language.
How often should the specified initialisation be performed for the embedded
programming language scripts?

Regards,
Markus
