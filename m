Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7B6DC77B7C
	for <cocci@archiver.kernel.org>; Thu,  4 May 2023 05:38:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:from:to:cc:references:mime-version:
   in-reply-to:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=omOFhqfHjeRfjmBSrlLm29tLnknHpqNjO3K2D7l7cag=;
  b=mAMff+SzInUBj3qymleuNYcuaR2TYB8tCQKC2rKYTANJo9H6svOWlEM5
   /nXcRo6wFJ658BU2tB6wZkq2yAljqnynI7lZkKBsVyKw9x/QksYB6C3Zv
   YUqkEW8FkRjiakHlgETEpUQH75LrF7wMep6m3a6R86c+0aSynnkV/y7+R
   U=;
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.160 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:128.93.142.0/24 ip4:192.134.164.0/24 ip4:128.93.162.160
  ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=temperror (key query timeout) header.i=@chromium.org
X-IronPort-AV: E=Sophos;i="5.99,249,1677538800"; 
   d="scan'208";a="106162130"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 04 May 2023 07:38:33 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 886D0E0D49; Thu,  4 May 2023 07:38:33 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id F3A55E0D40
	for <cocci@sympa.inria.fr>; Mon,  1 May 2023 22:54:06 +0200 (CEST)
IronPort-SDR: 645026ed_x3UgLB5ytHgsu6W8uGy6kONAubp0gcQm/iNa1cNpoMB1otY
 J+dPT9OqVrw98ENTIe1Kn07kBmOMGLbHGG6gvOw==
X-IPAS-Result: =?us-ascii?q?A0EKAADHJVBkf7PSVdFaGwEBAQEBAQEBBQEBARIBAQEDA?=
 =?us-ascii?q?wEBAUCBOwYBAQELAYItgUskCwRRjHBfiDydXYF+DwEDAQwBRAQBAQMEhH8Ch?=
 =?us-ascii?q?UACHQcBBDAJDgECBAEBAQEDAgMBAQEBAQEDAQEFAQEBAgEBAgQFAQIQAQEZC?=
 =?us-ascii?q?RkHDg4FJIVoDYI3KQF1gQgBAQEBAQEBAQEBAQEBAQEBAQEBFgINeAEBAQMSK?=
 =?us-ascii?q?AYBATcBDwsYHBI0AQUBHAY1hTkDo0+BBEKLMYE0gQGCCAEBBp1OgV4JCQEIg?=
 =?us-ascii?q?S8BkFp6JxuBSUSBS4J1PohSgjSXVYExdIEngS+BBAIJAhFrgRAIZYF0QAINZ?=
 =?us-ascii?q?AsLbYFEgxIEAhE0DgwUXQKBCQgUARgDBwcCAYEANwNEHQY6Aws7Oj01FB91g?=
 =?us-ascii?q?VkEL4FVBgElJJlNAXsTAYFwolyCGqAOhAiBWQyfIDSXCpI5l3uicoUHAgoHB?=
 =?us-ascii?q?hAjgUA6gVwzGggoCIMiTwMZD44giQaLBSE0PQIHCwEBAwmLRQEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:m1jMKaFlnsN6X7WxpLqEJ8eALOsnbusQ8zAXPo5KOHpom+ij5r
 2TdZUgpGXJYVMqMk3I9urwXZVoLUmskaKdpLNhQYtKPzOWw1dATrsSjrcKqgeIc0afygce79
 YZT0EXMrzN5DNB/L/HCWeDYrEdKRq8nJxAR92y815dCS9tba9k40NeEQaUEkp/QU1jCYAiHJ
 SRouprzgDQG0j/ov7VOpDNZYb+m+E=
X-Talos-CUID: 9a23:3gph82HAasG40HcPqmJe+284AuMsfUSF1XrdO1G8WE9AGLyKHAo=
X-Talos-MUID: 9a23:BXjOfQkQpAo3e1CAlVtxdno4PepM05uxWHoOrrFX5O/aLhx9Ojak2WE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.99,242,1677538800"; 
   d="scan'208";a="54793964"
X-MGA-submission: =?us-ascii?q?MDGHFJGwIrLEXHeF0AnJdryztafAYJbWM55PA7?=
 =?us-ascii?q?sc19Kj+p2bCCyS6db+FYMN0ZzMCKLoRQfQeM3d4CIDlxeN3QYtDSMhnt?=
 =?us-ascii?q?t1EJ4dOPts/gzaBoeMD7DBMg8Pjd2AFc1qr40fbwv3w6tfAmWfrbbCI3?=
 =?us-ascii?q?l3nQPOtTmbUfvzBaVAaA7G3w=3D=3D?=
Received: from mail-pf1-f179.google.com ([209.85.210.179])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2023 22:54:06 +0200
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-63b4e5fdb1eso3466611b3a.1
        for <cocci@inria.fr>; Mon, 01 May 2023 13:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1682974443; x=1685566443;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=omOFhqfHjeRfjmBSrlLm29tLnknHpqNjO3K2D7l7cag=;
        b=dy6NArLWzjJMPbIc3aOszM0NF4eNK0/4apngtNmyidQAKpkT1x2407H0lQ6HIFDJ56
         BkVP367fs3v4OceU3GP21W0N3XWmz9WEYWG52MMX9vPAzOlFou2zW8SROeg9TCEmhPqE
         zH68l68v5gXul/ynrpHrp1jtnfbJxqFzvI1AE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682974443; x=1685566443;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=omOFhqfHjeRfjmBSrlLm29tLnknHpqNjO3K2D7l7cag=;
        b=MV/BNT5k0CkoYb7I5fO41/61VjX2YW63WuhtQI0X4TPewfw7vf74MiAaV0+4EMcYBG
         SOiHD5+RJ2JG4H5Bqzoo3vtjwYR4VYpHPtaAI7MujK5kusqEuyKvfs8fFEy5o8TxqLvU
         sen7x0zV3o6EpfcN2UGJkaSa+1dtxG10oXSnVv5LtUo7WKviRpZ/NXtqiBFKH5r1F3Bg
         oQn6H9BVQcIELYpWKJV+curuJ0PF7CU57uuEiK+M1yjNoDJ5Kn0hfl0yC6gIfWt3IUMo
         4qboZIj+AuUodBKtaaxESwTJhH7dcMFdpSpK/eR5523d4U71FsR2g0HB4fkb6QySti4J
         GYyg==
X-Gm-Message-State: AC+VfDyiavuN1vSGB9/UvXRWhibB8XAl/yBUzUzJ3tqkJnhb7JNqOYrJ
	FikED8YJzlKITRczPARChe/DIRgL5xF+WtuvRnU=
X-Google-Smtp-Source: ACHHUZ7zcwR/jv2IE8Y9GorMl+AE7frPp3LqkQxRYTfXRWEZzjysCjKw7fheWsBGl7DbjQsLW+QvIA==
X-Received: by 2002:a05:6a00:1583:b0:63b:599b:a2ec with SMTP id u3-20020a056a00158300b0063b599ba2ecmr22053767pfk.27.1682974443553;
        Mon, 01 May 2023 13:54:03 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id p8-20020a62ab08000000b0062e0010c6c1sm20205156pff.164.2023.05.01.13.54.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 May 2023 13:54:02 -0700 (PDT)
Message-ID: <645026ea.620a0220.f1a4f.8a79@mx.google.com>
X-Google-Original-Message-ID: <202305011352.@keescook>
Date: Mon, 1 May 2023 13:54:02 -0700
From: Kees Cook <keescook@chromium.org>
To: Julia Lawall <julia.lawall@inria.fr>
Cc: cocci@inria.fr
References: <644ae01c.170a0220.77675.8ed2@mx.google.com>
 <alpine.DEB.2.22.394.2304291516550.2899@hadrien>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.22.394.2304291516550.2899@hadrien>
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] metavariables in added attribute arguments
Reply-To: Kees Cook <keescook@chromium.org>
X-Loop: cocci@inria.fr
X-Sequence: 1140
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-05/645026ea.620a0220.f1a4f.8a79%40mx.google.com>

On Sat, Apr 29, 2023 at 03:17:40PM +0200, Julia Lawall wrote:
> > [...]
> > @annotate@
> > type COUNTER_TYPE, ARRAY_TYPE;
> > identifier allocated.STRUCT;
> > identifier allocated.ARRAY;
> > identifier allocated.COUNTER;
> > attribute name __counted_by;
> > @@
> >
> >  struct STRUCT {
> >         ...
> >         COUNTER_TYPE COUNTER;
> >         ...
> >         ARRAY_TYPE ARRAY[]
> > +       __counted_by(COUNTER)
> >         ;
> >  };
> >
> > This fails like so:
> >
> > $ cocci element_count.cocci net/packet/af_packet.c
> > plus: parse error:
> >   File "element_count.cocci", line 33, column 15, charpos = 593
> >   around = 'COUNTER',
> >   whole content = +     __counted_by(COUNTER)
> >
> > But I can produce (nonsense) output if I change the replacement to:
> >
> > 	ARRAY_TYPE ARRAY[
> > +	COUNTER
> > 	]
> > +	__counted_by
> > 	;
> >
> > Explicitly using "attribute name __counted_by;" didn't seem to help.
> > What am I missing?
> 
> The problem is fixed.  Actually, attributes in this position were just not
> supported at all.  Thanks very much for the report.

Hurray! Thank you; the latest git works as I'd expect now. :) Now to get
my patch for the Linux kernel split up...

 153 files changed, 157 insertions(+), 157 deletions(-)

-- 
Kees Cook
