Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73648EA855E
	for <cocci@archiver.kernel.org>; Mon,  9 Mar 2026 06:05:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:cc:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=qexly3oaTKYt+aKQRWBLmo4ApBbBxhk9Ls1sE9v4Xjo=;
  b=Juw1eMLwfsP9lh+zBTnjuibimTw/7ZqhMRNsxhlGTAzORSsMEYZuto3i
   HSYWsajzznv9evSW4ZQQqxqfVq+pea0WaL9Fl3E0icRhpKVZULV7+sFFM
   1FEWjZG7N0pj1VgPT2Zp41GRgsu2n5tXsk3iAPd5ciKL5dRn0OHCjFUYR
   4=;
X-CSE-ConnectionGUID: ZLUAzsw3QVyq46tkx8pLzQ==
X-CSE-MsgGUID: Qnjxp8S4T321ay3h/tK99Q==
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
X-IronPort-AV: E=Sophos;i="6.23,109,1770591600"; 
   d="scan'208";a="266778004"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 09 Mar 2026 07:05:51 +0100
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id D386380613; Mon,  9 Mar 2026 07:05:50 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 20FDF80540
	for <cocci@sympa.inria.fr>; Mon,  9 Mar 2026 07:05:48 +0100 (CET)
X-CSE-ConnectionGUID: pwh4alc9QI2TQ8oocdErDQ==
X-CSE-MsgGUID: 9JsGNqPLTiGs2W726p7fMQ==
IronPort-SDR: 69ae633c_qcOQxESXnbWQMpNr+dP6bzpsd3PEW25VEHXxM1kQ8VLgsQY
 OkG1vue5/HT/Z/6AAsVn7VmYMKyEZJs/i7P5Cmg==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0H0AwBRYq5pg07ASNlagQmBUoI/aB9eNAQLSYRYj1OCJ?=
 =?us-ascii?q?IQ7jxGMSwIPAQMBDT0RAQIEAQEDAwGEOkYCjSECHgcBBDUFDQECBAEBAQEDA?=
 =?us-ascii?q?gMBAQEBAQEBAQENAQEFAQEBAgEBAgQGAQIQAQEBIRkHDjuGTw2CYgGBJIEmA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQECDTpEA?=
 =?us-ascii?q?QEBAgEjHQEBESYBBAsLGgIIEA4CAlYGFQEBgn4BgiIBBhABAw8nBw2qYYEyg?=
 =?us-ascii?q?QGCDAEBBoJp13sfLCJZgWcDBoEfL4VugmUBhg+EXycPgVVEgTyDAz6CYQKFO?=
 =?us-ascii?q?4JpgiaBDodLBotaUngcA1ksAVUTFwsHBYEjQwOBBiNLBS0dgSMhHRcUH1gbB?=
 =?us-ascii?q?wUSISqBaXiCAQ+GaHkDLl4aDiICOlxKPgoBWgWCJQIBC209NwkLGwQ9jnI+g?=
 =?us-ascii?q?24gAoIbpHihRTQHgjiBZ4FkDIoulT8GEy+DcQGTYA6TC5kGjgmVaIVQggAig?=
 =?us-ascii?q?VwzGiSDNk8DGQ+OOoNnM4ELx2tFMjwCBwsBAQMJhUYBAYxWgUsBAQ?=
IronPort-PHdr: A9a23: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
 J8JV6MdS1E/UP8XWBwN9DkqP5p9GD8pw+bzsQ==
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:noMCTKzIJS22n0/bmw2pKrPw+L1zdoMgy1knxilNoNJuA6mlfr
 OV7ZMmPHjP+U4ssRAb6Km90cy7Kk80mqQb3WB8B9eftUzdyQ2VxeJZg7cKoQeNJ8SWzIc0uJ
 uIMZIObOEYZmIK7voSjjPIceoI/PnC1ry0juHDyHpXQRhtcLwI1XYFNu/WKCxLrBItP+tDKH
 Nw3Ls8m9IqFE58UviG
X-Talos-CUID: 9a23:B/BdzW1EAge4Nwf8IPpmh7xfAt8lLnTZxybpAhWEMDZuT7aZZEW8wfYx
X-Talos-MUID: 9a23:Fu630wSkLmLB0YsNRXS9pipNEt5Qx5ivJ1tXrspc5dHbOwlJbmI=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.23,109,1770591600"; 
   d="scan'208";a="266777991"
X-MGA-submission: =?us-ascii?q?MDHvYd/g9Y9KO+EWM/Gi4AEyIAVWdzKwJ1lHZC?=
 =?us-ascii?q?evlDKogCQzzr0fP3FGBJZ88K6KBEy5yBXAoSnI6DfkhEAmrQN5N5Xo90?=
 =?us-ascii?q?+icr0OIOw/pN3ZVbCvDJeIAGZcsZdGxuDo/nym6SH/YDUFkYfHlz3F37?=
 =?us-ascii?q?FslLbVJRgXDAkbYniy1v1D1w=3D=3D?=
Received: from mout.web.de ([217.72.192.78])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2026 07:05:48 +0100
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MI3p7-1vtgi53APP-00Adp1; Mon, 09
 Mar 2026 07:05:46 +0100
Message-ID: <e394643e-d2e1-476a-bfcb-c25244c60dae@web.de>
Date: Mon, 9 Mar 2026 07:05:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Markus Elfring <Markus.Elfring@web.de>
To: Sam Tygier <samtygier@mailo.com>
Cc: cocci@inria.fr
References: <fc5aa4f0-0134-475a-9220-dedc71955fe7@mailo.com>
 <6b795826-177a-4bef-81cd-1b783815114@inria.fr>
 <155c7bec-41ef-4985-bb06-f8315d91e42a@mailo.com>
Content-Language: en-GB, de-DE
In-Reply-To: <155c7bec-41ef-4985-bb06-f8315d91e42a@mailo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:ID7IAj7hs7t/zJvLP5z3jvzFZzh2wtnNwQusoZc7MX6vlfpBxPq
 3tuOyGABjQ/dvoaRYJ82HkcIK4lM1y6C/hKJQEw8yOkU/tVpwoNTh79OxAuz/7XWC2X9QBb
 kXUKZN9Z60JR+2sKg+gmDKyOQkQ2zJIffkOHf2/D5RrV9cTVW/doJZVOBPWWWCvmfkUlqw4
 630667mLHRpGb585feGzA==
UI-OutboundReport: notjunk:1;M01:P0:Z7nhSrT5WZA=;Oc1ghYA96UEMrNCc2pFqeT8wHU/
 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
 koO7G8mohrB5ksNBM=
Subject: Re: [cocci] Support for C++ scope resolution operator?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 3346
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-03/ju7YK0tJ5VFdZz8yLIueMg>

> Thanks, I'll keep an eye out for updates. Is there a github issue for this that I could subscribe to?

Not directly for the mentioned functionality so far.

See also:
* Support C++ codebases
  2010-12-05
  https://github.com/coccinelle/coccinelle/issues/1

* C++
  2021-04-15
  https://gitlab.inria.fr/coccinelle/coccinelle/-/issues/22


Regards,
Markus
