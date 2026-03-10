Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D46BFCC9D4
	for <cocci@archiver.kernel.org>; Tue, 10 Mar 2026 07:39:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=4mfDL0FzHrPi+ovP2EoBEIFIrlJiuL7mmRGIUBNqTUE=;
  b=vUD2/hzjEnyr74Pg3ztUAjf4Pjp/HXddeKDaMKWVO3B3VpIYkQdzqViD
   R6Kzq491FPPWv9R5e1xTx4WQG9ItYZcV16xIMRNziydBTlRL+i1YmOJxa
   k4WVJf1AFTysUXDsUdTGrSI3erXUmKurrS9+t458Fi2bSVPj/gZKJz73f
   w=;
X-CSE-ConnectionGUID: 5XoqAkTfRGOL/TSG6JRVrQ==
X-CSE-MsgGUID: C5W+Kdk8RiqpzgYn1ie8MQ==
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@prod-sympa-app.inria.fr
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.27 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  include:mailout.safebrands.com a:basic-mail.safebrands.com
  a:basic-mail01.safebrands.com a:basic-mail02.safebrands.com
  ip4:128.93.142.0/24 ip4:192.134.164.0/24 ip4:128.93.162.160
  ip4:128.93.162.3 ip4:128.93.162.88 ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@prod-sympa-app.inria.fr) identity=helo;
  client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@prod-sympa-app.inria.fr";
  x-conformance=spf_only
X-IronPort-AV: E=Sophos;i="6.23,111,1770591600"; 
   d="scan'208";a="267009216"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 10 Mar 2026 08:39:17 +0100
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id D807E812EA; Tue, 10 Mar 2026 08:39:16 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 70F538178D
	for <cocci@sympa.inria.fr>; Tue, 10 Mar 2026 08:39:12 +0100 (CET)
X-CSE-ConnectionGUID: B5Dhr2BaRGmtitjvQW+Vsw==
X-CSE-MsgGUID: qw+9Q1VzToKCiY4/rmZcBg==
X-IronPort-AV: E=Sophos;i="6.23,111,1770591600"; 
   d="scan'208";a="267009203"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2026 08:39:12 +0100
Date: Tue, 10 Mar 2026 08:39:12 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
To: Nicolas Palix <nicolas.palix@imag.fr>
cc: Haoyang Liu <tttturtleruss@gmail.com>, Jonathan Corbet <corbet@lwn.net>, 
    Shuah Khan <skhan@linuxfoundation.org>, cocci@inria.fr, 
    workflows@vger.kernel.org, linux-doc@vger.kernel.org, 
    linux-kernel@vger.kernel.org
In-Reply-To: <1c546ad7-14f8-4695-9754-32a020f8a082@imag.fr>
Message-ID: <4c157be7-7673-c513-65f0-f0222cf8d117@inria.fr>
References: <20260308100851.341-1-tttturtleruss@gmail.com> <87v7f5vv9x.fsf@trenco.lwn.net> <ae8dda71-9e25-4f3b-ab95-1b00809ade37@gmail.com> <1c546ad7-14f8-4695-9754-32a020f8a082@imag.fr>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-918604625-1773128352=:23815"
Subject: Re: [cocci] [PATCH] docs/dev-tools: fix a broken URL in
 dev-tools/coccinelle.rst
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 3362
Errors-To: cocci-owner@inria.fr
Precedence: list
Precedence: bulk
Sender: cocci-request@inria.fr
X-no-archive: yes
List-Id: <cocci.inria.fr>
List-Help: <https://sympa.inria.fr/sympa/help>, <mailto:sympa_inria@inria.fr?subject=HELP>
List-Subscribe: <https://sympa.inria.fr/sympa/subscribe/cocci>, <mailto:sympa_inria@inria.fr?subject=SUB%20cocci>
List-Unsubscribe: <https://sympa.inria.fr/sympa/signoff/cocci>, <mailto:sympa_inria@inria.fr?subject=SIG%20cocci>
List-Post: <mailto:cocci@inria.fr>
List-Owner: <mailto:cocci-request@inria.fr>
List-Archive: <https://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-03/fAP25gVQtKbvcEezC-OZww>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-918604625-1773128352=:23815
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Tue, 10 Mar 2026, Nicolas Palix wrote:

> Hi,
>
> Maybe we can just throw away that section of "Supplemental documentation" and
> its link ?
>
> Nowadays, there is much more SmPL provided, and the rst file
> describes better and up-to-date information.
>
> Would a link to
> https://www.kernel.org/doc/html/latest/dev-tools/coccinelle.html
> be useful to point to latest version ?

OK, thanks.

There is also an out of date URL in that page.  I will send a patch.

julia

>
> Sincerely,
>
> Le 09/03/2026 à 17:28, Haoyang Liu a écrit :
> >
> > On 3/10/2026 12:10 AM, Jonathan Corbet wrote:
> > > LIU Haoyang <tttturtleruss@gmail.com> writes:
> > >
> > > > The original supplemental documentation for coccicheck is
> > > > https://bottest.wiki.kernel.org/coccicheck, which redirects to a not
> > > > found page,
> > > > thus change it to https://bottest.wiki.kernel.org/coccicheck.html,
> > > > which adds a suffix to original URL to make it direct to the right page.
> > > >
> > > > Signed-off-by: LIU Haoyang <tttturtleruss@gmail.com>
> > > > ---
> > > >   Documentation/dev-tools/coccinelle.rst | 2 +-
> > > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > diff --git a/Documentation/dev-tools/coccinelle.rst b/Documentation/
> > > > dev-tools/coccinelle.rst
> > > > index 2b942e3c8049..f73ccf5397f3 100644
> > > > --- a/Documentation/dev-tools/coccinelle.rst
> > > > +++ b/Documentation/dev-tools/coccinelle.rst
> > > > @@ -61,7 +61,7 @@ Supplemental documentation
> > > >   For supplemental documentation refer to the wiki:
> > > > -https://bottest.wiki.kernel.org/coccicheck
> > > > +https://bottest.wiki.kernel.org/coccicheck.html
> > > >   The wiki documentation always refers to the linux-next version of the
> > > > script.
> > > I'll apply this - a working URL is better than a broken one.  But is
> > > there really nothing better to link to than a page that warns "OBSOLETE
> > > CONTENT" at the top?
> >
> > Dear Jon,
> >
> > Unfortunately, I do not find any other documents about this script, so I
> > have to use it even though it's obsolete.
> >
> > Sincerely,
> > Haoyang
> >
> > >
> > > Thanks,
> > >
> > > jon
> >
> >
> >
> >
>
>
--8323329-918604625-1773128352=:23815--
