From: bp@alien8.de (Borislav Petkov)
Date: Sat, 22 Jul 2017 08:36:02 +0200
Subject: [Cocci] [PATCH] EDAC: remove unnecessary static in
 edac_fake_inject_write()
In-Reply-To: <alpine.DEB.2.20.1707212205410.2232@hadrien>
References: <20170704214440.GA9462@embeddedgus>
 <20170717083946.GB23129@nazgul.tnic>
 <alpine.DEB.2.20.1707212205410.2232@hadrien>
Message-ID: <20170722063602.GB2050@nazgul.tnic>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Fri, Jul 21, 2017 at 10:08:12PM +0200, Julia Lawall wrote:
> Someone pointed out that the rule is probably not OK when the address of
> the static variable is taken, because then it is likely being used as
> permanent storage.

Makes sense to me.

> An improved rule is:

Do you think it is worth having it in scripts/coccinelle/ ?

I don't think Gustavo would mind putting it there :)

Thanks.

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--
