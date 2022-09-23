Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18270C6FA82
	for <cocci@archiver.kernel.org>; Fri, 23 Sep 2022 14:21:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=wodYgcViYlNEgjnvpJ9FEVllkDja6PndBTGivvzh83U=;
  b=giq/8l5H7VVEPmSbeTy792BePD7PpBKVzLVQi6Z+GIeN2+SJgyi87qpv
   rV4BqIJCg463ugrEp6LgUIDcVcSWRDSVVO9qPEs6N7QAli2yXIG+Gvvui
   n1gkkKNa5DIrhrWp3zEeT5FkTZxoOpCxdienEmCJVBHr4Q96XBqM56BL+
   U=;
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.160 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:192.134.164.0/24 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@inria.fr
X-IronPort-AV: E=Sophos;i="5.93,339,1654552800"; 
   d="scan'208";a="54257633"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 23 Sep 2022 16:21:55 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 06035E0130; Fri, 23 Sep 2022 16:21:55 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 8B33DE0130
	for <cocci@sympa.inria.fr>; Fri, 23 Sep 2022 16:21:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=wodYgcViYlNEgjnvpJ9FEVllkDja6PndBTGivvzh83U=;
  b=ZJWaTX8FIaZqvknaADtCKqnzHU+oxGlk9I4Sr09hZA/rHb0+/1AnXAqs
   gNtnNyWrCCn12PrvJRplVYKbPSjpvfG1uU3EZZliW0F+6ToHhMHQnzDgu
   ydZM5ykvrVohU2f28g1AzCDV2lKPlt2s30EQlRhkDbc7X6O+XlttHV68h
   A=;
X-IronPort-AV: E=Sophos;i="5.93,339,1654552800"; 
   d="scan'208";a="24536317"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2022 16:21:49 +0200
Date: Fri, 23 Sep 2022 16:21:49 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
To: Markus Elfring <Markus.Elfring@web.de>
cc: Yuan Can <yuancan@huawei.com>, cocci@inria.fr, 
    Nicolas Palix <nicolas.palix@imag.fr>, kernel-janitors@vger.kernel.org
In-Reply-To: <3351dd3d-f55a-10b0-6b35-d5206570e687@web.de>
Message-ID: <2274a1a9-4b13-7677-9cf7-55ea960d8be@inria.fr>
References: <20220922115535.44132-1-yuancan@huawei.com> <20220922115535.44132-2-yuancan@huawei.com> <3351dd3d-f55a-10b0-6b35-d5206570e687@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] [PATCH v3 1/2] coccinelle: locks: add
 missing_mutex_init.cocci script
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 575
Errors-To: cocci-owner@inria.fr
Precedence: list
Precedence: bulk
Sender: cocci-request@inria.fr
X-no-archive: yes
List-Id: <cocci.inria.fr>
List-Help: <mailto:sympa_inria@inria.fr?subject=help>
List-Subscribe: <mailto:sympa_inria@inria.fr?subject=subscribe%20cocci>
List-Unsubscribe: <mailto:sympa_inria@inria.fr?subject=unsubscribe%20cocci>
List-Post: <mailto:cocci@inria.fr>
List-Owner: <mailto:cocci-request@inria.fr>
List-Archive: <https://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-09/2274a1a9-4b13-7677-9cf7-55ea960d8be%40inria.fr>

> > +@r3@
> > +identifier s, fld;
> > +position p != {r2.p};
> > +@@
> > +
> > +struct s {
> > +  ...
> > +  struct mutex fld@p;
> > +  ...
> > +};
>
>
> How many mutexes (or spin locks) should be initialised before further data
> processing can be safely performed with corresponding structures?

I tried the semantic patch on this file:

struct s {
  struct mutex fld;
};

int main () {
  struct s *mm;
  mm = kmalloc();
  mutex_lock(&mm->fld);
}

and it reported the expected error message.  So what exactly is the
concern, Markus?

julia
