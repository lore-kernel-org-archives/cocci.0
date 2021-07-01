Return-Path: <SRS0=VPYo=LZ=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4245CC11F64
	for <cocci@archiver.kernel.org>; Thu,  1 Jul 2021 18:52:59 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D8B5613C8
	for <cocci@archiver.kernel.org>; Thu,  1 Jul 2021 18:52:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D8B5613C8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=inria.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 161IqtPZ024039;
	Thu, 1 Jul 2021 20:52:55 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 736D77610;
	Thu,  1 Jul 2021 20:52:55 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 71C874065
 for <cocci@systeme.lip6.fr>; Thu,  1 Jul 2021 20:52:53 +0200 (CEST)
Received: from shiva.jussieu.fr (shiva.jussieu.fr [134.157.0.129])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 161IqpjQ009443
 for <cocci@systeme.lip6.fr>; Thu, 1 Jul 2021 20:52:51 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr
 (mail2-relais-roc.national.inria.fr [192.134.164.83])
 by shiva.jussieu.fr (8.15.2/jtpda-5.4) with ESMTP id 161IqQsc074687
 for <cocci@systeme.lip6.fr>; Thu, 1 Jul 2021 20:52:51 +0200 (CEST)
X-Ids: 168
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3ANkdYia05nGwVoGpzqbFJhgqjBMckLtp133Aq?=
 =?us-ascii?q?2lEZdPU7SKClfqyV8cjzqyWbtN95YhhJ8uxoU5PufZqzz/RI3bU=3D?=
X-IronPort-AV: E=Sophos;i="5.83,315,1616454000"; d="scan'208";a="517823501"
Received: from 173.121.68.85.rev.sfr.net (HELO hadrien) ([85.68.121.173])
 by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 01 Jul 2021 20:50:24 +0200
Date: Thu, 1 Jul 2021 20:50:24 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Sumera Priyadarsini <sylphrenadin@gmail.com>
In-Reply-To: <CACAkLup9dzuPDxNqtyirq5K38oDAfS=VQu=5brSJvVfv-a_mZA@mail.gmail.com>
Message-ID: <alpine.DEB.2.22.394.2107012049440.19810@hadrien>
References: <cover.1622024972.git.sylphrenadin@gmail.com>
 <a205b3d2-5da2-8ed5-26a9-2103bee9a534@web.de>
 <CACAkLup9dzuPDxNqtyirq5K38oDAfS=VQu=5brSJvVfv-a_mZA@mail.gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1701301236-1625165425=:19810"
X-Miltered: at jchkmail2.reseau.jussieu.fr with ID 60DE0EEA.000 by Joe's
 j-chkmail (http : // j-chkmail dot ensmp dot fr)!
X-j-chkmail-Enveloppe: 60DE0EEA.000 from
 mail2-relais-roc.national.inria.fr/mail2-relais-roc.national.inria.fr/192.134.164.83/mail2-relais-roc.national.inria.fr/<julia.lawall@inria.fr>
X-Scores-Stats: 60DE0EEA.000 B=0.50000 L=0.19025 G=0.19025 Disagree Winner=PH
X-Label-Query: YES
X-j-chkmail-Score: MSGID : 60DE0EEA.000 on shiva.jussieu.fr : j-chkmail score
 : X : R=. U=. O=. B=0.190 -> S=0.190
X-j-chkmail-Status: Ham
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Thu, 01 Jul 2021 20:52:55 +0200 (CEST)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Thu, 01 Jul 2021 20:52:51 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Markus Elfring <Markus.Elfring@web.de>, Coccinelle <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] [PATCH 0/2] Add "use-patchdiff" option
X-BeenThere: cocci@systeme.lip6.fr
X-Mailman-Version: 2.1.13
Precedence: list
List-Id: <cocci.systeme.lip6.fr>
List-Unsubscribe: <https://systeme.lip6.fr/mailman/options/cocci>,
 <mailto:cocci-request@systeme.lip6.fr?subject=unsubscribe>
List-Archive: <https://systeme.lip6.fr/pipermail/cocci>
List-Post: <mailto:cocci@systeme.lip6.fr>
List-Help: <mailto:cocci-request@systeme.lip6.fr?subject=help>
List-Subscribe: <https://systeme.lip6.fr/mailman/listinfo/cocci>,
 <mailto:cocci-request@systeme.lip6.fr?subject=subscribe>
Sender: cocci-bounces@systeme.lip6.fr
Errors-To: cocci-bounces@systeme.lip6.fr

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1701301236-1625165425=:19810
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Fri, 2 Jul 2021, Sumera Priyadarsini wrote:

> On Wed, May 26, 2021 at 10:13 PM Markus Elfring <Markus.Elfring@web.de> wrote:
> >
> > > This patchset adds a feature to enable Coccinelle
> > > to only check all those files in a directory which were
> > > modified. It parses all the files obtained from the
> > > output of "git diff" and checks them against the specified
> > > cocci script.
> > >
> > > An example for passing the "use-patchdiff" option is:
> >
> > How do you think about to use the parameter name “use-files-from-diff”?
>
> I would prefer something shorter, like "use-filesdiff" but I am okay
> with either name as
> long as the maintainers are okay with it. :)
>
> Julia, what do you think?  I will send a v2 with any of the above name options
> (and/or any other changes that are suggested.)

I think that shorter names are better.  The current name could be ok, but
a - between patch and diff might be more natural.

julia
--8323329-1701301236-1625165425=:19810
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci

--8323329-1701301236-1625165425=:19810--
