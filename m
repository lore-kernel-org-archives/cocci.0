Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 416A9C433EF
	for <cocci@archiver.kernel.org>; Wed,  9 Mar 2022 20:51:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=cU5AUm42Whbx1VMDqompNnc9aNhdeqSVfN2oC8J2Hl8=;
  b=OAhw5IcBMX/5lt++/M/GnPNoLYcxxtcEk6dmnF2JN9w0p+v0BFvQUUmz
   d0HqLpqsyUwm20mDxCeWlGkk2I2fYBB0Iqgf8BUItVsAff/nYH5CyZkfr
   JiHMIRATK33uChWu17gDYPFe//BjkPOtv7t7vBMw5XEKvbkx+2eiLx3uL
   s=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr
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
X-IronPort-AV: E=Sophos;i="5.90,168,1643670000"; 
   d="scan'208";a="25325956"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 09 Mar 2022 21:51:29 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 70D3AE0362; Wed,  9 Mar 2022 21:51:29 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id C575CE004D
	for <cocci@sympa.inria.fr>; Wed,  9 Mar 2022 21:51:26 +0100 (CET)
IronPort-SDR: aRy/ZNs2xaq58VyDvj0aLNQR10CG6nhdfHUZ+OkB9NlLR4t91ahPGCJ7pgdFSsElMW82TdL2xD
 vpV+Z+lxYpBzk0KsVauXHEKUaKrKJaU7+WL0nRkGy4s4aOFx3ECBzMfsPwM2A8v7w3trxVDwJx
 VQ2/6jCBmiDG+aXdmCS6Xe9jrL0SJV1pYM7oSprRRML0XSuk4M0lA8L49Fv2UaGQAKxfWbxWXd
 6RLs8mARrecjybKPE0DL9zVfHcTfyh9Ytb6FdEFwVlV/qpB5KuDDSHkA7iFgf2jA4OV6+riVUA
 kYuRUJlSYcNuRf8lIA+odd+Q
X-IPAS-Result: =?us-ascii?q?A0BVBQBREili/0Xcza1ahQsHd1YBAQEpBAtEhFSOc4IlA?=
 =?us-ascii?q?55bCwEDAQ05CAQBAYISgjBFAoQiAh0GBjQTAQIEAQEBAQMCAwEBAQEBAQMBA?=
 =?us-ascii?q?QUBAQECAQECAwQBgQgsAWMBZwGBTgGBeQYEMA2CNSkBg2MBAQEBAgEjVhALG?=
 =?us-ascii?q?CoCAlcGgxcBgnUhD61BeoExgQGDTwETQYVRBoE8jkgnHECBTYQ/PoJjAQECh?=
 =?us-ascii?q?HiCZQSXTS0sIn6BHaA0gUFUiyeSa4NTiwqNZYcBLoQ6kguRbZZVjROURAp1h?=
 =?us-ascii?q?COBPzklgVkfFBoIJgo7gmpNAQIBAgEMAQICAQIBAgECAQgBAQIBkg6BPolBI?=
 =?us-ascii?q?AEBATECCS0CBgEKAQEDCZFvAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23:iy5GDq2STht72k9axPbD5fZ3kn2cJEfYwER7XKvMYLTBsI5bp2ZUy
 GEYCDyFaffeMTGmf911bo+w904P6pfdyoIxSANp3Hw8FHgiRejtVY3IdB+oV8+xBpSeFxw/t
 512hv3odp1coqr0/0/1WlTZhSAgk/nOH9IQMcacUsxLbVYMpBwJ1FQyw4bVvqYy2YLjW1jV6
 IupyyHiEAbNNwBcYjp8B52r80sHUMTa4Fv0aXRjDRzjlAa2e0g9VPrzF4npR5fLatU88tqBe
 gr25OrRElU1UPsaIojNfr7TKiXmS1NJVOSEoiI+t6OK2nCuqsGuu0o2HKJ0VKtZt9mGt99g0
 /Z2uczsczhqGO7UqaMBVzVJSwgraMWq+JefSZS+mcmDiUDZc3bhx/h0Skc7IeX0+M4uXjoIr
 6RFbmpXNlbd1opaw5rjIgVors8kJ8LqFIceoW17izzGDfsrRZ3ZBaPH+be02R9q25sUQKeDP
 6L1bxJCZU6QSDB0fWweN7s+pPqr3yHyfTlx/Qf9Sa0fuDSNl10ugNABKuH9cduBTsR9hVedv
 muA/mLjAxhcOsb39Nae2ne8wOLQnS72XI8IUru16paGnWF/2EQcGQY1blfr/cOGyWj9Q+MYN
 0g463IH+P1aGFOQcvHxWBixoXihtxEaWsZNH+BS1Dxh2pY48C7CWTdZFm8phMgO8Z5pFWZzh
 zdlivuwXWQ32IB5X05x4Vt9kN9fES0Fa2IdZSIJSQYfpd/uvOnfby4jrP44T8ZZbfWvRVkcJ
 gxmSwBn290uYTYjjfnTwLw+q2vES1igZlddCv/rdmyk9BhlQ4Wuepal71PWhd4ZctrHHgTY5
 SFdxpjAhAzrMX1rvHbSKAnqNOr2j8tpzRWG3AAH82cJqFxBBEJPjagLvG8ldRg5Wir1UTL2Y
 ELevQ5L5ZlYeSPzBZKbkKrqY/nHDMHIS7zYaxwjRoEXM8YrK1Pfon0GiIz59zmFrXXAWJoXY
 f+zGftAx15AYUi+5DbpFeobz5ExwSUymTHaSZzhlkT11buFeGXTRKgFPVaKY/p/6q6Y+V2H/
 9FaPsqM6hNeTOynOHWMq9ZOdAxTIChpH43ypuxWavWHfFhsFlYhPOCNk7kvTIpowvZOneDS8
 3DgBEIBkAjjhWfKIBmhY2x4bO+9Ro52qH82ZHR+PVuh13U5T5yo6aMTK8k+cbU9rbwxyf9vU
 +JDdtqAD/lLRy6B/TkBNMGvoItnfRWtpASPIyv8OmRkJcY9HlCQ94a9LAX19SQIAi6mjucEo
 uWthlHBXJ4OZwV+F8KIOvih+FOGoiRPkuxFWUaVcMJYf1/h8dU0JnWp3OM3OcwFNT7K2iCei
 1SNGR4dqOTA/901/d3OifzWpoulCbIjTE9KWWTE7bu7MSTAuGyu3dYYAuqPeDncUkLy+bmjP
 L8JlKukbaRbxVsa4ZBhF7tLzL4l44W9rbFtzjN7QCfBYWOtB+4yOXKBx8RO6/NAn+cLpQusV
 0uT0dBGIrHVatj9GVscKVZ3dOiFzv1IyDDe4e5sfRf/9Gl647qKXEFfJV+KhTAEdOl5N4Ysw
 OEAvs8K6lXl1kFwaovf0nlZpzaWM3gNc6Q7rZVEUoXlvQoc1Q0Qa5LrDCKrsoqEbM9BMxR0L
 2bM1rbCnblV2mHLb2E3SSrWxeNYiJkD0PyQIITu+7hddhv5av4LMNl59CRxQxtVwxhD3vg1P
 GV3X6GwyWNi4B8w7PWvnUj1c+2COPFd0kjw0EcS0mDGT0SlUmHXamswJY5hOazfH310JlBmE
 XLx9IoheTLrZ93qmCYtWUNor/H5C9p86mUuXSxh89utR/EHXNYuvkNiiafkZfcq7QPdSXArf
 dVXwds=
IronPort-HdrOrdr: A9a23:omIMPK+NDFWGcmd+h7Nuk+A8I+orL9Y04lQ7vn2ZbSYlFvBw8P
 re7MjztCWE+wr5N0tPpTnrAsS9qE3nhOxICOUqXYtLsmHdyReVxK8L1/qd/9TLIVyFygZlvZ
 0QDJSX4rXLfClHZL/BkXSF+rUbsby6GcKT5Ns2lE0dNj2CApsIh2wUZTpzPXcGMTWubqBJcq
 Z0iPA3xAZINU5nDPhSxxE+LpH+juyOsJrnZBoPAFoO8RCUiyyl5frTDnGjr3Aju7wm+8ZbzY
 GpqWbE2pk=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.90,168,1643670000"; 
   d="scan'208";a="25325950"
X-MGA-submission: =?us-ascii?q?MDGrXMrGHTWS0p+OdMVUWxc0z/6Kc3BcdjmEv8?=
 =?us-ascii?q?ZnhrThcpBwEbnwbRNPQ8MlaJK8vo0cp/J81UBWn4xRTRGhU/fLqM2VFN?=
 =?us-ascii?q?Xn4EOHTPxBdI+54dL40YlbZvqIeYDve4g/oVqn0ri3SzGW11NRXbDfrK?=
 =?us-ascii?q?aP8H8tccilRMr3EI4UdbziqA=3D=3D?=
Received: from mx.ewheeler.net ([173.205.220.69])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2022 21:51:25 +0100
Received: from localhost (localhost [127.0.0.1])
	by mx.ewheeler.net (Postfix) with ESMTP id 6EEA485;
	Wed,  9 Mar 2022 12:51:23 -0800 (PST)
X-Virus-Scanned: amavisd-new at ewheeler.net
Received: from mx.ewheeler.net ([127.0.0.1])
	by localhost (mx.ewheeler.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id Q6xqetUgZmPt; Wed,  9 Mar 2022 12:51:19 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx.ewheeler.net (Postfix) with ESMTPSA id 193C884;
	Wed,  9 Mar 2022 12:51:19 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx.ewheeler.net 193C884
Date: Wed, 9 Mar 2022 12:51:17 -0800 (PST)
From: Eric Wheeler <cocci@lists.ewheeler.net>
To: Markus Elfring <Markus.Elfring@web.de>
cc: cocci@inria.fr
In-Reply-To: <f79b9c33-f5d0-7d38-06bd-fde9f9e089d1@web.de>
Message-ID: <997d4c43-9ee0-1fe0-a6b-1946b918ea3@ewheeler.net>
References: <4fc9237-ca2-518a-3221-9770f6112c6@ewheeler.net> <f79b9c33-f5d0-7d38-06bd-fde9f9e089d1@web.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1625480220-1646859079=:1906"
Subject: Re: [cocci] Does SmPL support regex groups?
Reply-To: Eric Wheeler <cocci@lists.ewheeler.net>
X-Loop: cocci@inria.fr
X-Sequence: 194
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
List-Archive: <http://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-03/997d4c43-9ee0-1fe0-a6b-1946b918ea3%40ewheeler.net>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1625480220-1646859079=:1906
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Wed, 9 Mar 2022, Markus Elfring wrote:
> > And extract the extension ".gplot" as an identifier
> 
> 
> It seems that you are looking for a string literal
> (which would contain a file name).
> 
> 
> 
> > and pass it to the function get_nec_filename_stem, like so:
> 
> Literals can be found with the means of the semantic patch language
> by the metavariable type “constant”.
> 
> https://gitlab.inria.fr/coccinelle/coccinelle/-/blob/5479fc964d209209e84ddd5caf3f395667721e7c/docs/manual/cocci_syntax.tex#L216
> https://github.com/coccinelle/coccinelle/blob/ae337fce1512ff15aabc3ad5b6d2e537f97ab62a/docs/manual/cocci_syntax.tex#L216

Can literals match substrings like ".gplot" for cut-and-splice?

> > The SmPL patch below works for what I want statically, but notice the
> > commented `expression E`:
> >
> > Is there a way to regex-group `expression E =~` with a parenthesis and then specify
> > something like E[0] to pick up the grouped regex match?
> 
> 
> Would you like to achieve any further software evolution also according to
> my feature request “Reuse of content from capturing groups in regular expressions”
> from 2015-08-27?
> https://github.com/coccinelle/coccinelle/issues/46

Github says 404 not found.

-Eric

> 
> 
> 
> > 	@ replace_untitled @
> > 	identifier F;
> > 	parameter list PL;
> > 	expression list EL1, EL2;
> > 	//expression E =~ "\"untitled\.(.*)\"";
> > 	@@
> >
> > 	F(PL)
> > 	{
> > 	+   char newfn[PATH_MAX];
> > 	    ...
> > 	    file_chooser = Open_Filechooser(EL1,
> > 	-       "untitled.gplot",
> > 	+       get_nec_filename_stem(newfn, ".gplot", PATH_MAX),
> > 		EL2);
> > 	    ...
> > 	}
> 
> 
> I would like to point the possibility out that SmPL ellipses
> can be used instead of the metavariables “PL”, “EL1” and “EL2”.
> 
> 
> 
> > Ideas?
> 
> 
> Would you get any further ideas from the clarification approach for the topic
> “Development challenges around using the function “make_expr” for expression
> construction by SmPL” (from 2016-10-27)?
> https://github.com/coccinelle/coccinelle/issues/88
> 
> Excerpt from my script:
> 
> @initialize:python@
> @@
> import re
> 
> @find_update_candidate@
> constant input_string;
> expression input_context;
> position pos;
> @@
>  seq_printf@pos(input_context, input_string);
> 
> @script:python selection@
> call;
> param << find_update_candidate.input_string;
> pos << find_update_candidate.pos;
> text;
> @@
> match = re.match('"([^"]+)"', param)
> if match:
> …
> 
> 
> Regards,
> Markus
> 
> 
--8323328-1625480220-1646859079=:1906--
