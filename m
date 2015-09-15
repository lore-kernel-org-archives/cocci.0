From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Tue, 15 Sep 2015 15:16:33 +0200
Subject: [Cocci] [PATCH] coccinelle: tests: unsigned value cannot be
 lesser than zero
In-Reply-To: <alpine.DEB.2.10.1509151505240.2537@hadrien>
References: <1442309232-5902-1-git-send-email-a.hajda@samsung.com>
 <55F816BC.5050407@users.sourceforge.net>
 <alpine.DEB.2.10.1509151505240.2537@hadrien>
Message-ID: <55F81A31.3040808@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

>>  v at p
>> (
>> *< 0
>> |
>> *<= 0
>> )
> 
> It does not, and is not intended to, work.  The branches of a disjunction
> should be complete expressions.

Will the following SmPL approach be more appropriate then?

(
*v at p < 0
|
*v@p <= 0
)

Regards,
Markus
