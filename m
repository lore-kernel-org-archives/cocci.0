Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F794C433F5
	for <cocci@archiver.kernel.org>; Tue,  8 Mar 2022 21:25:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=ERsYTqZniNlbhiHCtbURoGetD3xLorgtCqSLIIX+5Cw=;
  b=NLJ9U88wv7AS/CAvMAIosjDMa2zGs+C/TMgp4ouyVUYKPzZPFtQzmP9Z
   AKL2ZeOaeYoRGWDon5SL3ETvlVwJkrZmLHnxTkNR0ZHVTNGCrEATAV+Sj
   ZM2kC4YiXKb4uCF8GEhROBX/HMyQkbTQmhiYLdbMzdfjmaY4gLFpTtbR0
   Q=;
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
X-IronPort-AV: E=Sophos;i="5.90,165,1643670000"; 
   d="scan'208";a="25111088"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 08 Mar 2022 22:25:21 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id DD93AE09B6; Tue,  8 Mar 2022 22:25:20 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id C5F20E004D
	for <cocci@sympa.inria.fr>; Tue,  8 Mar 2022 22:25:15 +0100 (CET)
IronPort-SDR: M57KgBuoouP+9+g5IIQVMOhYWJSSK5W8f/mnDtSPyzu8H7sAWV724aMOueBSDSfnLKEUzToesd
 7AhWtbvOs29jQaHddLpQdPlOg7a0/BEqRR4KQ8+GPHi21PYPAtewvp8/NUgHCN+Z+NOVa0h9n7
 Sis8YKcnXqisknKLN0Oez1YLI1086T8iwKQo9cIlHRf8wHTTdL6zd1nE4Mi70bqVB4ITwPWjD7
 g59C0jS4GjO+YfzubiH4q9rFE0QlY6WobcT6sxGkE8rr8V/FQvCbN0Ihz6BLLeX73lsU1Iu0tj
 j3pT8OMvGdBsgh21BB8Tmzbj
X-IPAS-Result: =?us-ascii?q?A0CbBQBkyCdi/0Xcza1ahQsHgU0BAQEpBAuFGI5zgiieW?=
 =?us-ascii?q?wsBAwENQQQBAYUHAoQfAh0GBkcBAgQBAQEBAwIDAQEBAQEBAwEBBQEBAQIBA?=
 =?us-ascii?q?QIDBAGBCCwBYwFnAYFOAYF5BgQ9gjUpAYNjAQEBAQIBI1YQCxgqAgJXBoMXg?=
 =?us-ascii?q?nYhrWV6gTGBAYl7kAQnHECBTYQPMD6HX4JlBJZslXyPWlSeEoNTn1YaLoNhk?=
 =?us-ascii?q?mORZpZVpnmBP16BWR8UGggmCoMlTQECAQIBDAECAgECAQIBAgEIAQECAY5Tj?=
 =?us-ascii?q?jogAQEBaQIGAQoBAQMJkW8BAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23:o3j1I6LzGCJ1Jf9CFE+R8ZMlxSXFcZb7ZxGr2PjKsXjdYENS1DUHn
 2QZCDuCaPfZYzf9fI9+OYy/p0kOupSAyYJmTAMd+CA2RRqmi+KVXIXDdh+Y0wC6d5CYEho/t
 63yTvGacajYm1eF/k/F3oDJ9CU6jefRLlbFILas1hpZHGeIcw98z0M78wIFqtQw24LhWFvd4
 YmaT/D3YTdJ5RYkagr41IrY8HuDjNyq0N/PlgFWiVhj5TcyplFNZH4tDfnZw0jQHuG4KtWHq
 9Prl9lVyI92EyAFUbtJmp6jGqEDryW70QKm0hK6UID66vROS7BbPqsTbJIhhUlrZzqhxulW2
 thW9oWJeFk5NaDIh/8sDwdEHHQrVUFG0OevzXmXtNzVwlLGfnbozu8oCkwqVWEa0r8oWicUr
 aFecmpVKE7S7w616OrTpu1EjcMoJ8jDOIIEpmomwC7ZAPsiTIqFRajWjTNd9Ghh1pEWQai2i
 8wxRwhmQRv5MgN1GFIpEY55mtWNo3ugWmgNwL6SjfFrvTOCk1wZPKLWGNHScdeLbd5Em16R4
 GPA5WXwRB8AXOFz0hKA4jShme/CkCf2QsQUGaHQGuNWbEO7n1U0GhANFkKCkKepgUO6RMlud
 1II9X97xUQtz3CDQt74Vhy+hXeLuB8ARtZde9EHBBGxJrn8uFnGWzBVJtJVQJl3659sHG1CO
 kqhxouxXVRSXKuppWVxH4p4QBu3KW4YMm8PaCsJV00D7sWLTGAPYvDnFYgL/E2d1IGd9dTML
 9ai9XlWa1I71JVj6klD1Qqb6w9AX7CQJuP1jy2ONo5f0it3ZZS+e6uj4kXB4PBLIe6xFwfd4
 idax5fOsb5QUvlhcRBhps1WRtlFAN7eb1XhbaNHRcR/n9hT0yHLkX9sDMFWfxs3aZdbKVcFk
 WfepgNc6ZteJnqsZuovOuqM5zcClsDd+BWMfq68U+eilbAtLF/Xpn8/PxXMt40v+WB1+ZwC1
 V6gWZ7EJR4n5W5PllJans8Rju0mwD4Q32TWScypxhiry+PONnqUUqsedlaRbu006K6e5gPY7
 48HZceNzhxeVsz4YzXWqNRPdgpScCFnXJ2m+dZKcuOjIxZ9HD9zAfHmwYQ+J95vkZNTm7qa5
 Xq6QEJZlQTy3CWVNQWQZ3l/Q7rzRpIj/2kjNCkhMA/wiXguaIqi9okFcJ4zceV1/eBv16ckH
 f0EYNmbRPlQSjnK/zkHK5/wsNU6JhisgAuPOQujYSQ+JsQ8HFaRp4a4Jwa2rXsAFCu6s8c6s
 oaM7AKDTMpRXRlmAebXdOmrkQG7s08dr/0uDUHGFd9eJRf3+49wJi2s0PJue5MQKQ/Ozyex3
 hqNBUtKvvHEpoI4/YWbha2AqIv1QeJyElADQjve/fC7KinX826u28lGXfrRJWLRU2b9+aODY
 +RJzqimbKZdxAsT79NxQ+Rx0KYzx9rzvLsEnA5qK3X8cAj5AL1XJHTbj9JEsbdAx+IHtFLuC
 F6P4NRTJZ6AJNjhTAwKPAMgY+nfh+sYnCLesaY8LEngvXIl+arBXFpSMhSIhTYbKrZpadt3z
 eAksc8Qygq+lhtzaIrd1HgJrjjVIyxSSbgju7EbHJTv1FghxGZCVoOAWCX415eCNodXOU4wL
 z7J2qeb3+ZAxlDPemYYHGTW2bYPnowHvR1HwTfu/bhSdgYpUhP24PFQzdjzZgFFiBhY0+9+P
 mVxcUt4Oc1iOtuuaNdrBwiR98NpXXV1OXAdD3MNlXbFVA+lSWzAIWkwI6CL8VxxH6ewuNRE1
 Onw9YsmOAoGuOn13zAuQghotPzuQNh87EvEldzP8wFp2XUlSWKNv5JCrlbkZ/cq7Q3dSaEHS
 SRXED5MVJDG
IronPort-HdrOrdr: A9a23:a+Vo46mfEZiju4TnLp8HNnr77mzpDfLY3DAbv31ZSRFFG/FwWf
 re5cjzsiWE8Ar5OUtQ+uxpWsG7LU80kKQb3WB/B8bFYOCLghrNEGgm1/qE/9SfIVyEygct79
 YDT0EWMrSZZjIW7KbHCUuDYqwdKbK8gcWVbInlvgpQpHlRGt1dxjY8MQqdGlB7X01+GJQ0UK
 CE7s58rTy6dR0sH7qGL0hAZOTFr8DGj9befBALQyQ/4A21kDu05NfBYmelN8glPQ9y/Q==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.90,165,1643670000"; 
   d="scan'208";a="7989046"
X-MGA-submission: =?us-ascii?q?MDFTWXWFp/6KTzP1g3uiGO2Qa/hqYQCvXrmN4c?=
 =?us-ascii?q?yywPwkigU4GU7FTJ6yO25EcRou6dpfVnpuoYz52RhGa6UL0EcasY8KBY?=
 =?us-ascii?q?vO0+ozdTZotbeZQpRDrZQcri4pWkEBrgYKcw1mFpj+SzLpNimu+jJ/og?=
 =?us-ascii?q?JuOje3E1SkV/l3GcNjdu/6Qg=3D=3D?=
Received: from mx.ewheeler.net ([173.205.220.69])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2022 22:25:14 +0100
Received: from localhost (localhost [127.0.0.1])
	by mx.ewheeler.net (Postfix) with ESMTP id EA7294A;
	Tue,  8 Mar 2022 13:25:09 -0800 (PST)
X-Virus-Scanned: amavisd-new at ewheeler.net
Received: from mx.ewheeler.net ([127.0.0.1])
	by localhost (mx.ewheeler.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id iEGoEdACRZ7n; Tue,  8 Mar 2022 13:25:09 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx.ewheeler.net (Postfix) with ESMTPSA id 156CD39;
	Tue,  8 Mar 2022 13:25:09 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx.ewheeler.net 156CD39
Date: Tue, 8 Mar 2022 13:25:07 -0800 (PST)
From: Eric Wheeler <cocci@lists.ewheeler.net>
To: Markus Elfring <Markus.Elfring@web.de>
cc: cocci@inria.fr
In-Reply-To: <d17e4bc6-f4aa-8bfd-505c-893fc364dfb1@web.de>
Message-ID: <b8437f4a-7e8f-d0c-3ed5-7a92cf7c9988@ewheeler.net>
References: <ed1d7d30-461-8822-7fd2-e1701534c29b@ewheeler.net> <alpine.DEB.2.22.394.2203072147580.3091@hadrien> <73ca810a-98bc-25db-5202-2ae7305b83fc@web.de> <923a1086-8eae-46d-54fa-27b8fff1e@ewheeler.net> <d17e4bc6-f4aa-8bfd-505c-893fc364dfb1@web.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-2071366500-1646774709=:1906"
Subject: Re: [cocci] Does SmPL for functions with prototype disjunctions
 need to be complete?
Reply-To: Eric Wheeler <cocci@lists.ewheeler.net>
X-Loop: cocci@inria.fr
X-Sequence: 189
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-03/b8437f4a-7e8f-d0c-3ed5-7a92cf7c9988%40ewheeler.net>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-2071366500-1646774709=:1906
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Tue, 8 Mar 2022, Markus Elfring wrote: 
> > It just makes it more readable.  I always try to avoid duplicate code no
> > matter what language I'm writing for.
> 
> 
> How do you think about “code” which you would not need to specify at all?

At the moment my needs are met, but if you think an SmPL notation for this 
would benefit others then of course that would be great.

--
Eric Wheeler



> 
> Regards,
> Markus
> 
> 
> 
--8323328-2071366500-1646774709=:1906--
