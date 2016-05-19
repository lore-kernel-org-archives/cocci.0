From: mcgrof@suse.com (Luis R. Rodriguez)
Date: Fri, 20 May 2016 00:46:54 +0200
Subject: [Cocci] [RFC 1/3] tests: add test to remove single statement
 from branch
In-Reply-To: <alpine.DEB.2.10.1605191233010.2865@hadrien>
References: <1463607743-11947-1-git-send-email-mcgrof@kernel.org>
 <1463607743-11947-2-git-send-email-mcgrof@kernel.org>
 <alpine.DEB.2.10.1605191233010.2865@hadrien>
Message-ID: <20160519224654.GH11948@wotan.suse.de>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Thu, May 19, 2016 at 12:34:09PM +0200, Julia Lawall wrote:
> On Wed, 18 May 2016, Luis R. Rodriguez wrote:
> 
> > At leaset with coccinelle 1.0.4 this test fails with
> > two issues, one is the return statement is shifted,
> > another is debatable -- an empty branch statement is
> > left. This is funtional however its debatable if this
> > is desirable by default.
> 
> The return statement should not move,

Great!
> but the if should not be removed either. 

Agreed now..


> Please send a second version.

Will do!

> Note the type mentioned by Markus as well (leaset, funtional)

Sure thing.

  Luis
