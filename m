From: garsilva@embeddedor.com (Gustavo A. R. Silva)
Date: Sat, 22 Jul 2017 11:22:13 -0500
Subject: [Cocci] [PATCH] EDAC: remove unnecessary static in
 edac_fake_inject_write()
In-Reply-To: <20170722063602.GB2050@nazgul.tnic>
References: <20170704214440.GA9462@embeddedgus>
 <20170717083946.GB23129@nazgul.tnic>
 <alpine.DEB.2.20.1707212205410.2232@hadrien>
 <20170722063602.GB2050@nazgul.tnic>
Message-ID: <638a94de-5eb4-eba4-7c28-4b4eb4bf8dbf@embeddedor.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hi all,

On 07/22/2017 01:36 AM, Borislav Petkov wrote:
> On Fri, Jul 21, 2017 at 10:08:12PM +0200, Julia Lawall wrote:
>> Someone pointed out that the rule is probably not OK when the address of
>> the static variable is taken, because then it is likely being used as
>> permanent storage.
>
> Makes sense to me.
>
>> An improved rule is:
>
> Do you think it is worth having it in scripts/coccinelle/ ?
>
> I don't think Gustavo would mind putting it there :)
>

Absolutely, I'd be glad to help out. :)

-- 
Gustavo A. R. Silva
