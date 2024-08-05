Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02E71C3DA4A
	for <cocci@archiver.kernel.org>; Mon,  5 Aug 2024 16:15:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=l00Fvbp+xlnwwhQ8xa+DKQqH5Ga0Qe75zxE82k2/9EI=;
  b=itoUMFgLY31rgQDOalSEuwaIskddxPCt59n8vYwKFMQMYfrR+bFG7Uuq
   gpDVXIYnFoTDWc3CPgBRC8wcdOxIz6Ou93Tcuub7ZjGvwkzUHYmufQenp
   i/wTTWeuCLrNWtW+6c7nRYSQv4a3nbDMfIyWHJAhv52QPq4fgSZprFR2V
   4=;
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
  ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.09,265,1716242400"; 
   d="scan'208";a="178171240"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 05 Aug 2024 18:15:52 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 1DDB3E0145; Mon,  5 Aug 2024 18:15:52 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id A842FE0035
	for <cocci@sympa.inria.fr>; Mon,  5 Aug 2024 18:15:46 +0200 (CEST)
IronPort-SDR: 66b0fab2_PA+cs2zRwpfOVvePRfQ3KuuSQhqZCEHl8IbAOOK0luptAH8
 9lj2EQyfH5wXMgKA2SIVINmNtzqLWEqil+jrzyQ==
X-IPAS-Result: =?us-ascii?q?A0EgAAA8+bBmhwwR49RaHQEBAQEJARIBBQUBQIE7CAELA?=
 =?us-ascii?q?YJDYiFUMwQLSIRWiB2HL4F1MIQ7hzqHUYh1gVaBQD4PAQMBDUEBAgQBAQMEh?=
 =?us-ascii?q?H8CiUoCHgcBBDAJDgECBAEBAQEDAgMBAQEBAQEIAQEFAQEBAgEBAgQGAQIQA?=
 =?us-ascii?q?QEBOgcOO4V1DYJnARCBEoEmAQEBAQEBAQEBAQEBAQEBAQEBFwJHRAEBAQIBI?=
 =?us-ascii?q?x0BAREmAQQLCxoCJgICVgYBFAEBgnyCMAEDDiMHrVSBMoEBggwBAQbaWR8sI?=
 =?us-ascii?q?leBYwmBGi4BiEkBhh6DQXonD4FVRIE8gwM+iB6CaZImi3smgSSPF1J7HANZI?=
 =?us-ascii?q?RMBVRMXCwkFiUsKgyMpgUsmhBgIgS0Vg2UNgV4MYYdyYoEOgT44gScBSYJ3S?=
 =?us-ascii?q?oNnHIFjgQOCY1cdQAIBC209NQkLGwY9q0+BBcVZNAeCNoFigWMMn08GEy+Dc?=
 =?us-ascii?q?gGTSQ4Gkm4smEQiqHSBZzqBXDMaJIM2TwMZD44hGYQUxy9BNTsCBwsBAQMJh?=
 =?us-ascii?q?UYBAYZcgUsBAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 aUIqbh4fXyG
IronPort-HdrOrdr: A9a23:2LMpya5CFfUUAU6LyQPXwBzXdLJyesId70hD6qm+c202TiXqrb
 HLoB19726NtN9xYgBYpTnkAsK9qBznmqKdjbNhWotKGTOW3ldAT7sN0WKB+VHd8kTFn4Yx6U
 4jSdkaNDSaNzhHZKjBkWqFOuoBhP+a7auvmeDS9Ht1Sxp2ApsQkjuRRjz7LqVsLjM2fqbR+a
 DsnPauLFebE0gqUg==
X-Talos-CUID: 9a23:PMqneGx4A0InGr24aqk0BgU6B+90W0/HkUyNCFbiA3x2dKTNZ125rfY=
X-Talos-MUID: 9a23:d9oexQVKfmqqBP7q/DXzgC0+b5dG2ISFGmlctrkZvdeuFiMlbg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.09,265,1716242400"; 
   d="scan'208";a="178171233"
X-MGA-submission: =?us-ascii?q?MDGKigB2xgM/Rk/59q/+V/eKzgKpDjPz9EHw9S?=
 =?us-ascii?q?hZB4MjuzYBj846vzjW1yrrpiUT9paEGsKdCBFV02939xBJH76jF3Tpdk?=
 =?us-ascii?q?tiQ55HjFsdJBJbIwK0vACTbWGGWkClN+QsxTEYZW/Q/nEERmHYXzJMSq?=
 =?us-ascii?q?gBvYuoryBU4lf5X5zA7nJP9g=3D=3D?=
Received: from mout.web.de ([212.227.17.12])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2024 18:15:46 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1722874545; x=1723479345; i=markus.elfring@web.de;
	bh=l00Fvbp+xlnwwhQ8xa+DKQqH5Ga0Qe75zxE82k2/9EI=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=no2pF4fW285eHO8/0ymj0+UJv4jV0QoqZxl/lpz4kGYmashbJhQw8aLcDRJ8+CE6
	 +6zmmKJBskfmKWffPNmTeZtS8qVN/yYSHLmSsjH2g4Yeu820wLZFlqFOnI8TL9vii
	 YaPfxQHMgYpn3lYG4sWnnUTllrScRMVaffuAlCZSwRfY0HDZ4gVG4qB5MLiH/jqUP
	 0XLZmnt2aZVqXMM59gauLHzw+DIfNpvxFeGl8+WRIa6QHeBPI9v5CjRBp2G8usFHX
	 RKvaXYJA0Jw8mtCQIR00ziMdp+FMkUW69iBIxq1/R+ESmNXG64vLgHe65ba8PJO47
	 BKspCaRwv7sih168Lg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.90.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MpCmT-1rsXOw0HMd-00mud1; Mon, 05
 Aug 2024 18:15:45 +0200
Message-ID: <21d8ddc7-e8ad-4a72-a245-2df98d87dc3a@web.de>
Date: Mon, 5 Aug 2024 18:15:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
Cc: Ricardo Ribalda <ribalda@chromium.org>
References: <CANiDSCvmboKBK=Z7uS9tnN_LcPA16rx0j_iWeEoQ=jO+pEgLiA@mail.gmail.com>
 <98a94966-14c6-45c4-99d8-471f65b292ea@web.de>
 <CANiDSCuJHTsHsFLbMGC1S47myfReZX7JBfGZFVknj8y=4-QLCA@mail.gmail.com>
 <fdc397c4-8823-46c3-b471-382ebb483900@web.de>
 <CANiDSCuqX7yRyJfvEJeV99fr1wEwANtg2Ak7MNogfYNEqMJ6Hg@mail.gmail.com>
 <c05b066f-af9b-49c1-9bdb-9167d24e3d3b@web.de>
 <c48956e7-f98f-407b-a4c1-29aa417c7474@web.de>
 <acb79b2d-a040-bdc4-9d5a-faafc3fc7d66@inria.fr>
 <583a6ed8-16db-4a5d-8a07-3f8b7c2c752b@web.de>
 <a3eef460-b292-bbac-417e-a8bee451c38b@inria.fr>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <a3eef460-b292-bbac-417e-a8bee451c38b@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:BXbDYV9DO99AyUPkO3nQeL0yDXyuZAycF2GrvNppla6l0+/4k3G
 2P5NdnoZZTbrxC59Hp+Y9icbTflkcYsO56DNEWYoxkRIP4X4NlK2mfhpGnIq0bPdE048Ch9
 S3LSkhFL6b5FLknnNUy4FTrbDvA6eSuKFUoGoFVy94VHuFQl4YOE2r8RKutQ5hugh3wzZ7f
 oTmpeEstmuhdMwR2Hj9Og==
UI-OutboundReport: notjunk:1;M01:P0:HVUoW+9bY98=;VTo4CALV4uHyJrA7hHLM/24O4gG
 lQzlOgL7hftzu1MfQXZKzJa6XlQzDWvZVe1bKOfV+4tmPcokki9Nt52ii+5H+MioKNPTLzuBS
 L/9ccsJZ8VgMRexs52hYDNxeCCKRi509oaNTl1N3FK7hKLxUTE2jL7DxW6e9PPrZmalocqPQh
 CA3HFAUGQDp/MjCwVZiQo7dQO7N/5Xlv4tf6d5PZ0jGn3uDZoUSSiYbiXKuu75A5jC1uy+W0J
 Yo7skPnkdxvUTnmWEuPkBymPTvD3bcWOO/duzYfx1hzemV1JGIupWFVC5rAsfhRNE55ZaylE7
 omlOs87gqiBdIYF9LjRtGZ0HMwtssl759SJbrSPccJp0X/JNUy/2pwBlAEQXE5SIBe5Xy62B4
 mLB06uceRYmQRBB4unpVIqpy/g7WanoTl6d7wTy8YGSgEgXXiL+l4QBssci872IBCOx+YSdbI
 9nda/UTeH4YMb/ihD1M1pqZP1tjvoKcJZJpS74mwRSS8J6+FfQm6umpZfuZ8GMS72Nvo9Vtqa
 AWWvd8QYPd/ZgyNCxlPPHGdUc54Sl2iy2cmYUUs2me7zbKocMOVrg3OczaPrwUCWSJ7ncHGo8
 0BfH8oGiZsQUUXTlh84WZlShZ6sRA0ghkxroObVYXMPnc5vjDm4yU1dgc4M+4qff5kZgKA2sJ
 QdgjqbbccZwnT+x9xY8eXc8ABJHR1yWnKtrMl5Fx4/5UiZv/xHIPo7+1aDODpFqlyJMaHF2l9
 3gSd2JWx+3ZWCmGuP+Ce4NdgPeQOAEJtKFY+cMMi4BaxYsIhYuNs2uy3jGpFn0nfJB+fBTLUJ
 UE1abQ+1v+PwYgr2tFQYZssQ==
Subject: Re: [cocci] Questionable run time characteristics for SmPL scripts?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1843
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-08/21d8ddc7-e8ad-4a72-a245-2df98d87dc3a%40web.de>

>> Would you like to determine which SmPL scripts contribute the most
>> according to observed run times?
>
> It was already clear from the provided information.

I became curious how further users will be enlightened.


> I know what the problem is.

How could you determine desirable improvement possibilities already
for this clarification approach?

Regards,
Markus
