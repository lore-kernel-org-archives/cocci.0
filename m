Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8A0DCD98F2
	for <cocci@archiver.kernel.org>; Fri, 19 Jun 2026 16:58:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=7gE3ezuV72hcrbbpUDZrpYYVkh9w14/nQHNX000SLcE=;
  b=h3Nt+9A+aVilJytd5jFL8O7dDLEa6ziORZj26TkPkcvwaNVK3c9yeAde
   YxUnyRnRXg3/yCJ/Tqjs6eKTTW7ux0zhySN3eg+pM1U4Jz/lcmQGjCzlD
   iImnWAZ2fDNlir2lrL0B/+dZdGG07NOrDrmKWHrnMMFW39vMYmxMM8hjo
   g=;
X-CSE-ConnectionGUID: sT/ElBxITZW8bPJO6Okotg==
X-CSE-MsgGUID: IwpvVo/2Q3eEJRE+OV79Qg==
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@prod-sympa-app.inria.fr
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.27 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
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
X-IronPort-AV: E=Sophos;i="6.24,213,1774306800"; 
   d="scan'208";a="282477691"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 19 Jun 2026 18:58:04 +0200
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id B8F9F819DE; Fri, 19 Jun 2026 18:58:03 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 80C10819CF
	for <cocci@sympa.inria.fr>; Fri, 19 Jun 2026 18:57:59 +0200 (CEST)
X-CSE-ConnectionGUID: C/oN/WjDSHqWuRpH31Dmlg==
X-CSE-MsgGUID: gD7VnaQzST2SSr8YyPw6yg==
X-IronPort-AV: E=Sophos;i="6.24,213,1774306800"; 
   d="scan'208";a="149946279"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2026 18:58:00 +0200
Date: Fri, 19 Jun 2026 18:57:59 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
To: Markus Elfring <Markus.Elfring@web.de>
cc: cocci@inria.fr
In-Reply-To: <d6f13137-9943-4177-8895-7f6ff5bc606c@web.de>
Message-ID: <d0d84e61-741d-64a8-e4a8-db1bfdba3d@inria.fr>
References: <c7c745e9-a593-4cca-8569-7dfe684dbce9@web.de> <0118baac-8e3e-48ac-ab6b-b326492627bb@web.de> <713ccb5e-331a-4e65-b91a-b6a6198c96e2@web.de> <ab663a12-5993-48c2-aa0f-c093724cf930@web.de> <c0702aae-dc4b-8ed8-11ab-107d6c523d74@inria.fr>
 <f059e31d-25d1-4ccc-b77d-07c4ff9d5d1e@web.de> <eb219668-8de8-a61-f852-4f16328e1832@inria.fr> <6a2de44c-b762-4f92-a5b7-661ac5214de2@web.de> <bd197670-dc1f-5c82-2bf-9e6316b29da8@inria.fr> <fe461478-4479-4384-a6fc-bce86f338707@web.de> <df229e71-6f2b-46e8-88b8-e5cdb321b2fb@web.de>
 <ab10711d-81ae-9254-215d-3676c361fde@inria.fr> <180730f8-bf12-4898-97d3-d209aac45e32@web.de> <308db487-90df-8ad9-4160-be6efd1bdf28@inria.fr> <e0f44b96-0509-4094-817a-7c28ac57db3c@web.de> <42bf9713-9c39-4163-98e5-bf92a4d97ef6@web.de>
 <d6f13137-9943-4177-8895-7f6ff5bc606c@web.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-885796785-1781888279=:2629565"
Subject: Re: [cocci] Searching for duplicate exception handling code with
 SmPL?
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 3581
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-06/UOY6_RMcw30ZQj61zoPiwQ>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-885796785-1781888279=:2629565
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Fri, 19 Jun 2026, Markus Elfring wrote:

> > > file|function name|incidence
> > > fs/hpfs/dnode.c|map_fnode_dirent|40
> …
>
> > How will the software run time characteristics evolve further?
>
> I hope again that this information can trigger more constructive clarifications
> also with the help of the following SmPL script variant.
>
>
> @initialize:python@
> @@
> import sys, time
> delimiter = "|"
>
> def convert_to_seconds(x):
>     return x / (10 ** 9)
>
> def get_seconds():
>     return convert_to_seconds(time.time_ns())
>
> def display_data(source1, source2):
>     x = time.time_ns()
>     sys.stderr.write(f"display_data() was called after {x - init_time} ns from initialisation.\n")
>
>     place1 = source1[0]
>     place2 = source2[0]
>     if (place1.line == place2.line) and (place1.column == place2.column):
>        sys.stdout.write(delimiter.join(('"same position"',
>                                         place1.current_element,
>                                         place1.file,
>                                         place1.line,
>                                         str(int(place1.column) + 1),
>                                         '"-"',
>                                         '"-"'
>                                        ))
>                         + "\n")
>
>     else:
>        sys.stdout.write(delimiter.join(('"update candidate"',
>                                         place1.current_element,
>                                         place1.file,
>                                         place1.line,
>                                         str(int(place1.column) + 1),
>                                         place2.line,
>                                         str(int(place2.column) + 1)))
>                         + "\n")
>
>     sys.stderr.write(f"display_data() was finished after {time.time_ns() - x} ns.\n")
>
> init_time = time.time_ns()
> sys.stderr.write(f"{convert_to_seconds(init_time)}: Initialisation was finished.\n")
>
> @searching exists@
> expression e, x;
> identifier item, rc;
> position p1, p2;
> @@
>  if (...)
>  {
>  ... when != rc = e
>      when != item = x
>  kfree@p1(item);
>  return rc;
>  }
>  ... when any
>  if (...)
>  {
>  ... when != rc = e
>      when != item = x

Do you really require that e and x bind to the same things at the two
occurrences?  If the running time is slow, that is probably why?

julia


>  kfree@p2(item);
>  return rc;
>  }
>
> @script:python collection@
> p1 << searching.p1;
> p2 << searching.p2;
> @@
> display_data(p1, p2)
>
>
>
> Function implementation example:
> https://elixir.bootlin.com/linux/v7.1/source/fs/hpfs/dnode.c#L994-L1095
>
>
> Test result:
> Markus_Elfring@Sonne:…/Projekte/Coccinelle/Probe> time /usr/bin/spatch --no-loops ../janitor/list_selected_duplicate_statements_in_if_branches9.cocci map_fnode_dirent-excerpt-20260618.c
> …
> 1781883816.6302867: Initialisation was finished.
> HANDLING: map_fnode_dirent-excerpt-20260618.c
> display_data() was called after 3163180203 ns from initialisation.
> "update candidate"|map_fnode_dirent|map_fnode_dirent-excerpt-20260618.c|31|3|37|3
> display_data() was finished after 108330 ns.
> display_data() was called after 3163385848 ns from initialisation.
> "update candidate"|map_fnode_dirent|map_fnode_dirent-excerpt-20260618.c|31|3|46|3
> display_data() was finished after 33643 ns.
> display_data() was called after 3163493101 ns from initialisation.
> "update candidate"|map_fnode_dirent|map_fnode_dirent-excerpt-20260618.c|31|3|58|3
> display_data() was finished after 25862 ns.
> display_data() was called after 3163597031 ns from initialisation.
> "update candidate"|map_fnode_dirent|map_fnode_dirent-excerpt-20260618.c|31|3|72|5
> display_data() was finished after 23952 ns.
> …
> real    0m3,433s
> user    0m3,321s
> sys     0m0,107s
>
>
> Can such measurements influence any development approaches?
>
> Would you occasionally observe also in your test environments that data processing
> durations would look prohibitive?
>
>
> Markus_Elfring@Sonne:…/Projekte/Coccinelle/Probe> time /usr/bin/spatch --no-loops ../janitor/list_selected_duplicate_statements_in_if_branches8.cocci map_fnode_dirent-excerpt-20260618.c
> …
> Using SQLAlchemy version:
> 2.0.50
> 1781884889.1493413: Initialisation was finished.
> HANDLING: map_fnode_dirent-excerpt-20260618.c
> ^C     C-c intercepted, will do some cleaning before exiting
>
> real    22m54,500s
> user    22m47,974s
> sys     0m2,294s
>
>
> How can the software situation be improved further here?
>
> Regards,
> Markus
>
--8323329-885796785-1781888279=:2629565--
