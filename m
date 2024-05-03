Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 005CFC4345F
	for <cocci@archiver.kernel.org>; Fri,  3 May 2024 11:15:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=QI3JXK0u5uIHryoW3k+Oy6o/UervxSxNHKGQ4zl7+Io=;
  b=VagbK5y/IDhFrEcXN8MJpqIID+MKHl+Z/YI8wCyDdbd8jRpbhKUPucFm
   7C63snffzY+j01Q1e3gMjf91OO/N1/xmzKt2IXwP/e5TiVuLzR9KF0vAC
   4Bk+Uw8QCKF8IxLrP/JOyDctw1fXFEnptvhzpczjcRtEH/0ksFEJSjNin
   Q=;
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
X-IronPort-AV: E=Sophos;i="6.07,251,1708383600"; 
   d="scan'208";a="164380203"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 03 May 2024 13:15:46 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 6F436E0133; Fri,  3 May 2024 13:15:46 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 9A4F1E0035
	for <cocci@sympa.inria.fr>; Fri,  3 May 2024 13:15:45 +0200 (CEST)
IronPort-SDR: 6634c761_hZkhfX20MK6y79xwhBeHghTqoJCxNp3HeQqRJ82UFquKx54
 H+I7ZT+Dv3rIolAoM1Bl647px49y2mVgfSc4hoQ==
X-IPAS-Result: =?us-ascii?q?A0EWCAADxzRmh07ASNlagQmBT4JEfANUMwQLSAiETo9Gg?=
 =?us-ascii?q?XUtA4Q7jwiIcYMWFigPAQMBDTkIAQIEAQEDBIILgnQCiC4CHgcBBDMGDgECB?=
 =?us-ascii?q?AEBAQEDAgMBAQEBAQEIAQEFAQEBAgEBAgQGAQIQAQEBIxcHDhAnhXQNgmcRg?=
 =?us-ascii?q?Q6BJgEBAQEBAQEBAQEBAQEBAQEBARcCDQ4sQgEBAQIBIx0BAREnDwsaAiYCA?=
 =?us-ascii?q?lYGARQBAYJ8AYIvAQMOIwcNBrNVgTKBAYIMAQEG2lkfLCJXgWIDBoEaLoguA?=
 =?us-ascii?q?YV8hEAnD4FVRIE8gwM+gmEBA4Feg1uCaYUSlHQGBAUWhUiHKFR9HANZIRMBV?=
 =?us-ascii?q?RMXCz4JFgIWAxsUBDAPCQsmAyoGNgISDAYGBlkgFgkEIwMIBANEAyBvEQMEG?=
 =?us-ascii?q?gQLB3WBfIE1BBNEA4E4iX0MgzGBdymEIQhDbBWDdoF4DmKDYYJbHUACAQttP?=
 =?us-ascii?q?TUJCxsGIgEdoGuERioCgUUIAwEbxhE0B4I2gWCBYQyKIZUjBhMvlzgOBpJom?=
 =?us-ascii?q?GIgjVSbE4F7JIFcMxokgzZPAxkPjjmEFIIxgXWVQkE1AjkCBwEKAQEDCYVGA?=
 =?us-ascii?q?QGDWoFIAQE?=
IronPort-PHdr: A9a23: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
 Q==
IronPort-Data: A9a23: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
 Yl2x0Ac9SRdDn2kqSj/KxB7bSpaKivm+081
IronPort-HdrOrdr: A9a23:kPOB6qsBe/a0xo3OSEp4JNQF7skDqNV00zEX/kB9WHVpm7+j5q
 WTdZMgpGbJYVcqKRcdcLW7U5VoLkmyyXcY2/h0AV7mZniAhILKFu9fBOnZrwEIcheWnoNgPO
 VbAspD4bbLbWSS4/yKgzWQL/Zl5sWb+6a1gurkw25qVhwCUdAb0+40MGem+lYdfng/OXPVLu
 vm2iLNygDLRUgq
X-Talos-CUID: =?us-ascii?q?9a23=3Aa+P0sWsdO7OdlMp6uvSahe0q6IsYYH3h60jRCHW?=
 =?us-ascii?q?hMkZmS5G4DgXBxLFNxp8=3D?=
X-Talos-MUID: 9a23:2rJEEwnXv2CO6frqF2EhdnpbKcQyoJTpDHoOmKs9le2jLhFPHSyS2WE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.07,251,1708383600"; 
   d="scan'208";a="86308649"
X-MGA-submission: =?us-ascii?q?MDEj+jInCRjB1CBet6OwW+FrEn/Pd+6wMDdXzc?=
 =?us-ascii?q?aPZF51T4YwxNuzyUOtejaNq46qu3gUm5INdDZeqXs0Tpq256lG+VZfx2?=
 =?us-ascii?q?8FHhlIc14xCdeMkSRLNl38t5FN9IiVT36c6gKVq6R/tiXeCpd4EgtNmp?=
 =?us-ascii?q?kPYeXcABeyEQ/xeWKZkhwPUQ=3D=3D?=
Received: from mout.web.de ([217.72.192.78])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2024 13:15:45 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1714734941; x=1715339741; i=markus.elfring@web.de;
	bh=QI3JXK0u5uIHryoW3k+Oy6o/UervxSxNHKGQ4zl7+Io=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Ncb1pMtsIYjiI+HvXg1cRBCnO3ltNjUv3ILEnbdkuwzOfFRhSvVZDQVMksE7CwE2
	 ccQPV1/5eiiKzGBM2k1vuLFRw0r940Zn4e5pjcTcu1NlSoEGAaegavl1HdBgQTi/K
	 W7wajZO8yCuDy6Vn4C+XlwbHgBg9HXXhB3O6MWjRl6QJ5CI7ErYxazCrgDYYdg80/
	 94kpOD34IXiefFBGqg+PL1c8Cfg6XHXiRjOKAe1jhEgQ64zfOZj+X9H6jAXOz4jkW
	 /higsdKIwyLpXP/DP2KjueM2116wec/RpiBFSSqXzldIB094IOAtS2Yfv5EteXQq0
	 BIkjVctRii8uMYWqvQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.83.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MeDMb-1sbd8s2Ggh-00bHKZ; Fri, 03
 May 2024 13:15:41 +0200
Message-ID: <9d990a58-a5a2-4b08-8ddf-e5ffd31be678@web.de>
Date: Fri, 3 May 2024 13:15:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: "Richard W. M. Jones" <rjones@redhat.com>, cocci@inria.fr
References: <20240502163131.GC30267@redhat.com>
 <6881602e-5f8e-db48-323d-139673441398@inria.fr>
 <20240502164958.GD30267@redhat.com> <20240502171930.GE30267@redhat.com>
 <20240502173148.GF30267@redhat.com>
 <alpine.DEB.2.22.394.2405022340080.3439@hadrien>
 <20240503073135.GR7636@redhat.com>
 <f353bd20-1821-4112-b12b-bd1a111f7d20@web.de>
 <20240503102404.GG30267@redhat.com>
 <72b79221-63f7-4095-a5f9-d4502deced43@web.de>
 <20240503105915.GU7636@redhat.com>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240503105915.GU7636@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:GBGQpX5KCQioYKagNc1W5z7zQyQV9YplAGJw6Ce9SZbEjJv/BPS
 4mqIorjtZRgDT95nuRRTV+dl5SyijFyt918f/XsA59gIAmZArQNV+/LSKky6giflFkqQu/r
 fR27gVOtlN5osIisViAF6wQhqzWjLsGXQweTbI6utS8xpXit1pbVJTrW8aJ0QPeXgy2vKEr
 bPA1A0/fMUzvH90iybEow==
UI-OutboundReport: notjunk:1;M01:P0:Ld93IeHsI60=;/Y8AmAMUHEKW+iMjh5mH4A8Srxw
 eC2O2/Oq6Ko/hONxv2J0ftb82Z+WfMw7nROU4Djda/TovXJAXQnQlvwFwqMGP2Fd14Fa+IBdU
 QHF+qp9UGGDBw+w+qXaPpECbCQkn9y55EvgYtmDy+NCWbBmQxc6VFFHCoXm/dysY4Kvnl89s2
 lVCEKYIWD5Sq/iUNymLBvWysXZxJM8aseCtXQEx3v/LiGcusYagzr4UvF679BfACPyOQm/oQQ
 GXVlTnYvY8H8Ns/Hx9Z24Ow3LjzWOnJu9nF26i32OxVoBMBLe+xsGvvoLZaaZ6ztVJDjzVkXs
 1D8Ym6z68UBYjYI0HrZ7AVQJRqSwVLCdwSM3YtKQYbMq6egdmsV7eb+lN54XDOXXo4OgepkSi
 MXm5yvnn+baheXnV89TekgMdXirXzWXsrLH+1tGg+wq51oQJCoEYh8k7VAJUpA6FRJkaR9QiP
 jAsNe1nkTkDUiCK7qCXOgz4xdVcf/WIpM0UXDX0STwk8df4y63yGmzpt1mefD1TPd0zRtuF8I
 jHjZws9ZJlgFj3R5DAi3t+vlTMHM/FfFTn8pEclSy9xp+/ANeonhaDcjfRHGuoNbgf2BblTFC
 PZ94AlEo2aXyRvt50Q/QdJ3NQbl/C8Da/q9jz2igL1ycFUTlONyV13D0vAwCWWI986eQDf6Se
 2L2uv4QQ9HiT1hkFBPZz6KXA0vhR7r1+I6Zr8ewOWkVSHSWuSLrZdsHC4poiWqX3g+GHgwoyN
 Zp7SCdfkw1VWFzdSTFdD+ucQwPgyi9YCzYsHxbbYCvIBFQtTQCNV43uvxJsUe6+xp4oSllqkD
 h7DNIvnUfACK7a3GdZNQnl0Qf5tVuPXMNne1QteS+BArDfGz/ZxdsMZzbmtCWWLg2V
Subject: Re: [cocci] Analysing software build processes
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1694
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-05/9d990a58-a5a2-4b08-8ddf-e5ffd31be678%40web.de>

>> https://bashdb.sourceforge.net/remake/
>
> The problem seems to be entirely inside ocamlopt.opt, so I don't
> understand how tracing make will help.

I assume that you can benefit another bit from the Callgrind profile forma=
t.
https://remake.readthedocs.io/en/latest/features.html#profiling


>> You managed to generate a flamegraph with a special software build proc=
ess.
>> Can we benefit any more from such data representations?
>
> There's no "special software build process".  The flamegraph was
> collected by running 'perf record -a -g' on the machine while
> ocamlopt.opt was compiling a single file, =E2=80=A6

I guess that such data generation can be improved.

The compilation command (for which undesirable software run time character=
istics
were accidentally observed) can be determined.
Another command variant can be tested then with special parameters,
can't it?


>> Would you like to help to achieve out of source builds
>> for affected programs?

You might be able to compare more OCaml compiler versions.
Would you dare to fiddle with bisecting of corresponding program variation=
s?

Regards,
Markus
