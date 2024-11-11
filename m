Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0619DD3ABD6
	for <cocci@archiver.kernel.org>; Mon, 11 Nov 2024 17:36:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=vpRMhuQZHNGpvyfzFC+BXGIU/xy1gzX0OsZu7MA6AAc=;
  b=u9W8phQLzXfFpTuQTcv7RaiE0mzi2M+d8EYGZOQQ9OZa2wm3Ux2QW9Qv
   TEBSUkMfhjdFt84grl/zTRL5ZFEUBjTSMcSOaF7wYUAPhsHpOl9wfyWq4
   gnihIkhm32oJqsJhFg8B5/Ug1uEfgEGihZuoSGksvFffu1FyGB2JWtWKn
   M=;
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.160 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.160;
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
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.12,145,1728943200"; 
   d="scan'208";a="193203708"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 11 Nov 2024 18:36:42 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 7FA91E0D1D; Mon, 11 Nov 2024 18:36:42 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 6858DE00B7
	for <cocci@sympa.inria.fr>; Mon, 11 Nov 2024 18:36:37 +0100 (CET)
IronPort-SDR: 673240a5_B2oyfB7CH0fgQLb0a7TG86wvB5PNG/VDaCyvlHbRE3WEhyj
 PIQ4dLy1jen8hdA8JIsFuYjec9rIgZJI4oBw5LQ==
X-IPAS-Result: =?us-ascii?q?A0GlAAD/PzJngAMP49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?UIEAQELAYJDYiFUMwQLSIRWkUEwhDuHOodViHWDVA8BAwENQQECBAEBAwSCD?=
 =?us-ascii?q?IJ0Aoo7Ah4HAQQzBg4BAgQBAQEBAwIDAQEBAQEBEAEBBQEBAQIBAQIEBgECE?=
 =?us-ascii?q?AEBOwcOCjGFew2CYgGBJIEmAQEBAQEBAQEBAQEBHQJHRAEBAQIBIx0BAREnD?=
 =?us-ascii?q?wsaAiYCAlYGARQBAYJ9gjABAw4jB7BlgTKBAYIMAQEG2lsfLCJXgWQJgRouA?=
 =?us-ascii?q?YVpgmIBhiSEPCcPgVVEgRUngwM+iB6CRyKCR3yEICWILWiYWVJ7HANZMgFVE?=
 =?us-ascii?q?xcLBwWBKSIsA4F6V3+BOYFRAUKCXUqDPIFeBTdJgkppTTcCDQI2giQkWYJPg?=
 =?us-ascii?q?SUEBYNvgQuDZIRngiMdQAIBC209NQkLGwY9n3SEPAGBcMZ8NAeCOIFlgWMMn?=
 =?us-ascii?q?1UGEy+DcQGTTQ4GknqYdyKpAYF9JIFcMxokgzZPAxkPjiGELcUsQjU7AgcBC?=
 =?us-ascii?q?gEBAwmFRgEBiW+BSwEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 VUIeA==
IronPort-HdrOrdr: A9a23:TOiLkKOI4zyTgMBcTh+jsMiBIKoaSvp037BZ7TEVdfUzSL3gqy
 nOpoV86faQsl0ssR4b9uxoVJPwJU80sKQFhrX5Xo3NYOCFggeVxehZhOOO/9SjIVydygc378
 ddmsZFeb7NJGRbyeDn/QK/D9Es+9Wf9ru07N2utUuFATsKV0l6hT0Jcjpz/3cGPzWvjvcCfq
 ah2g==
X-Talos-CUID: 9a23:FTz4Rm4CkwmMVKLoU9ss0glNRZ8DLXvkxkiXAxG3GE90GJKIVgrF
X-Talos-MUID: 9a23:v9z37AXukuqzuPnq/GL9qxVJNtxz2PSzARkni7Ul/Me8ajMlbg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.12,145,1728943200"; 
   d="scan'208";a="193203697"
X-MGA-submission: =?us-ascii?q?MDFpcXtywow6nKODohHqY5VuOE0MA6/QBFKrmo?=
 =?us-ascii?q?jIfHZw1vHDxSvZDsMnhLYScUP7YQwfha+yTi0ftbE+NZsoO4YL8TBs7r?=
 =?us-ascii?q?wngHpkYxiR9yk3jFYvu/KHlxu5C1fvUTlU4Wezei3p+JZ6dlVut2O78N?=
 =?us-ascii?q?a920tBbgbPLyy8NhkAFD5lMw=3D=3D?=
Received: from mout.web.de ([212.227.15.3])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2024 18:36:36 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1731346596; x=1731951396; i=markus.elfring@web.de;
	bh=vpRMhuQZHNGpvyfzFC+BXGIU/xy1gzX0OsZu7MA6AAc=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=MQiRLa68utP9kkiYPnTY3dUPF0DrzHZtK0AGAh2EY6reTq7kOOWIAyW3lxH2leZD
	 9vY25bIUjvxy2G46P1LywY6JIM8chxj6NlWPPuOo3u1sKO6djf5vGtLc+U4gZ5o4f
	 iolR0zomCsXHY0Xwp3Kklj87dJABzYlEIfwPx6oAELb8DlZAVRUE5bn9qtcV1W+Go
	 TbGC7gHyoksodB7mbqhsWszQW5E/5vm0VovcxSAD0REL3kAC2Ws0SLArrUjcc/gM5
	 suvEpFrTcjVb8X3HQrU5ftzu2srDgQn5caBGUDINjuiRGutgmw2vjBThbIJuFWqk/
	 B8vSE97CV5pz7K23VQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.89.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N5ljL-1tqCtj1hcZ-00sCJl; Mon, 11
 Nov 2024 18:36:36 +0100
Message-ID: <3e4d1941-40c5-43f6-aba3-c400b0828ae7@web.de>
Date: Mon, 11 Nov 2024 18:36:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Michele Martone <michelemartone@users.sourceforge.net>, cocci@inria.fr
References: <2406a49d-1609-4af1-9af9-ee3496e48606@web.de>
 <20241111162413.GD10291@localhost>
 <1ecbac88-9afe-42a4-bb46-de3abe59b500@web.de>
 <20241111171232.GE10291@localhost>
 <a03b096b-8815-430e-bceb-9e04248c1831@web.de>
 <20241111173137.GB32356@localhost>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20241111173137.GB32356@localhost>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:vi/4iCjZJATg/0weaXDDgnj1zto9yy9Agm4qjeOQgXPBpDL30qS
 GgZgmpCCoicClMvkQRe5c5VNBS85h3jnCexBNiPLAWQ1mPiIT59lkIWkM3X4h4mcTFVlSCo
 SkAZ64M+TKsl1HHHbtaUPWWZ8T3oeMfKRqrmpMq27DJUgb1yDnjQ7k1J9l1Cu4+UVloJ1KR
 h1M6Z4fQ85KmY2SpZE8vw==
UI-OutboundReport: notjunk:1;M01:P0:0cBDDVMgAKs=;RJjQ0lAvoa8CNwIjNggD+TnQZiN
 yg0kz+t8Co8t9y7rEhwEUx3utCu9hXj4sGkpe4up73c5Z/m+0Y5LSy1Axgi7HPu4+OUsLMuHU
 e7OWhvUYdBtJuzzsM2eO7LE4XxaOzbVRw9T0H/IgQfffKU0IR049xMqq2qcBabF2sKO6QZOSu
 QFeEsWpAIpnDqAAGbEtFaHWU7tWDlkuibRnvnESnxDAO6ipbggnt0hTjo+526Lo1k7dGQwc6n
 6/qnDcRP5ORaohNsEWKpfTP5KDDH7lZ3xwRZmRvjWvKstOhMB5w7QoVrlCPJx8niAUjLOJCvJ
 gkIaqn13MCmyLXqta4hJVEbEZto1Bwm2M+qNSoBkN6sIPfLKFZ0bEFzn/4SRXRBYMucB3nyED
 qc5TdICApxZFZ8BkbiCcsNTjsBn9/cyO2fXVw8WVx888MaT8CSEq4+jfgP8y1UqCFtgz2cpMB
 Z5aM3MNgVbpFenNg78UKg+M9LMNPxmgRqIn4e4AavAtXEPZ0p3muiLX0tlMCd5Q5PG5ZfA+yG
 IGlXDAOg4VQ4y/BJMtmHwLFW7GC/wv1WUdYce2FBPHQEP9FdKnwshLijL9BGlDhOmHExgrAJE
 PaxStZqohi8Hwa3eZ0sFXSueHqnJtiQN9l8hNFF9Ty/4cBFraekpoEQfWXIfVYhi8dYzzQ0if
 oyp5i/hpd0QkHFWvj2VsXJ/dyc0TeH0kcTRRJTGcNRyCXvCac3V7l8iSXpReOnQL897ddJOq6
 kBlH0a7ILnfFgMnHaqgFWnf911EK4iQg8UWUTjd7s8qphGvNxbmyx4Jk5c3bLh/123n4qMhxX
 tQQ2V1j3V5nj2vwklGhnICMw==
Subject: Re: [cocci] EBNF for Coccinelle file formats?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1992
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-11/3e4d1941-40c5-43f6-aba3-c400b0828ae7%40web.de>

>>> If you
>>>  grep '^[a-z_]*:'
>>> through the *.mly files you get a few hundred non-terminals,
>>> each with a handful of production rules.
>>>
>>> In a few words: LOTS of rules.
>>
>> Is such a software situation influenced because of the usage
>> of the tools =E2=80=9Cocamlyacc=E2=80=9D?
> No -- you'd have the same problem with any tool I'd say.

Has EBNF the potential for more succinct grammar descriptions
in comparison to ocamlyacc?

Regards,
Markus
